$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName  = 'insync'
$url32        = 'https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.9.50368.exe'
$checksum32   = '977E179FAB9B236349E85021DE8DE31979C035D0C1335A052672A99EE117E1BE'

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
