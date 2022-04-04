$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName  = 'insync'
$url32        = 'https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.4.50336.exe'
$checksum32   = 'fd21d2b34ec583bf36f96c9e01a1be7be20b21b2d284f0cb97f5e86584c19c77'

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
