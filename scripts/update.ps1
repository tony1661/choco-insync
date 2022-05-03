# This script is used to update my packages with a few input parameters
#
# Usage: update.ps1 packageName newVersionNum downloadLink
# Example: .\update.ps1 insync 3.7.6.50356 "https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.6.50356.exe"

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
#Start-BitsTransfer -Source $downloadLink -Destination $downloadedFile

# get setup file SHA256 hash
$fileHash = (Get-FileHash $downloadedFile -Algorithm SHA256).Hash
Write-Output $fileHash
Write-Output $installFile

#update the install script
(Get-Content $installFile) -Replace "https://.*", "$downloadLink'" | Set-Content $installFile
(Get-Content $installFile) -Replace '[A-Fa-f0-9]{64}', $fileHash | Set-Content $installFile

#Create the nupkg file
Compress-Archive -Path $packageFolder -DestinationPath $zipFile -Force
Remove-Item -Path $zipFileFull
Rename-Item -Path  $zipFile -NewName $nupkgFile