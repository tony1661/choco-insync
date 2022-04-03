$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName  = 'insync'
$url32        = 'https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.3.50326.exe'
$checksum32   = '775692791FA971AF5E19C70E56F8FFFB4BE0F2228A568003A94817EB56FD3C27'

$packageArgs = @{
  packageName   = $packagename
  fileType      = 'exe'
  url           = $url32
  softwareName  = 'Insync'
  checksum      = $checksum32
  checksumType  = 'sha256'
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
