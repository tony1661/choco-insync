$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName  = 'insync'
$url32        = 'https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.7.50360.exe'
$checksum32   = '821CDF2FE5B1EAACB16AD0E34C8AE85C6E084B99896073A08337E7EC26C6791C'

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
