# This script is used to update my packages with a few input parameters
#
# Usage: update.ps1 packageName newVersionNum downloadLink
# Example: .\update.ps1 insync 3.7.6.50356 "https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.6.50356.exe"
# to allow scripting run: Set-ExecutionPolicy RemoteSigned
# to disable scripting run: Set-ExecutionPolicy Restricted
#assign input arguments to variables
$packageName = $args[0]
$version = $args[1]
$downloadLink = $args[2]

#vars
$packageFolder = "..\packages\$packageName\nupkg\*"
$nuspecFile = "..\packages\$packageName\nupkg\$packagename.nuspec"
$installFile = "..\packages\$packageName\nupkg\tools\chocolateyinstall.ps1"
$downloadedFile = "~\Downloads\$packageName-$version.exe"
$zipFile = "~\Downloads\$packageName.$version.zip"
$zipFileFull = "~\Downloads\$packageName.$version.nupkg"
$nupkgFile = "$packageName.$version.nupkg"

#overwite the version number
(Get-Content $nuspecFile) -Replace '<version>.*</version>',"<version>$version</version>" | Set-Content $nuspecFile

#Download setup file
Write-Output "Downloading newest executable"
#Start-BitsTransfer -Source $downloadLink -Destination $downloadedFile

# get setup file SHA256 hash
$fileHash = (Get-FileHash $downloadedFile -Algorithm SHA256).Hash

#update the install script
Write-Output "Updating the install script"
(Get-Content $installFile) -Replace "https://.*", "$downloadLink'" | Set-Content $installFile
(Get-Content $installFile) -Replace '[A-Fa-f0-9]{64}', $fileHash | Set-Content $installFile

#Create the nupkg file
Write-Output "Creating zip file"
Compress-Archive -Path $packageFolder -DestinationPath $zipFile -Force
Write-Output "Remove old nupkg file"
Remove-Item -Path $zipFileFull
Write-Output "Rename the zip to nupkg"
Rename-Item -Path  $zipFile -NewName $nupkgFile

#next instructions
Write-Output "When you are ready, enter the following command: "
Write-Output "choco push .\$nupkgFile --source https://push.chocolatey.org/"