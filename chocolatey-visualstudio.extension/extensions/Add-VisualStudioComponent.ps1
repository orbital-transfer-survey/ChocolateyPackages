function Add-VisualStudioComponent
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)] [string] $PackageName,
        [Parameter(Mandatory = $true)] [string] $Component,
        [Parameter(Mandatory = $true)] [string] $VisualStudioYear,
        [Parameter(Mandatory = $true)] [string[]] $ApplicableProducts,
        [version] $RequiredProductVersion
    )
    if ($Env:ChocolateyPackageDebug -ne $null)
    {
        $VerbosePreference = 'Continue'
        $DebugPreference = 'Continue'
        Write-Warning "VerbosePreference and DebugPreference set to Continue due to the presence of ChocolateyPackageDebug environment variable"
    }

    Write-Debug "Running 'Add-VisualStudioComponent' with PackageName:'$PackageName' Component:'$Component' VisualStudioYear:'$VisualStudioYear' RequiredProductVersion:'$RequiredProductVersion'";
    $argumentList = @('add', "$Component")

    $channelReference = Get-VSChannelReference -VisualStudioYear $VisualStudioYear -Preview:$false
    Start-VSModifyOperation -PackageName $PackageName -ArgumentList $argumentList -ChannelReference $channelReference -ApplicableProducts $ApplicableProducts -RequiredProductVersion $RequiredProductVersion -OperationTexts @('installed', 'installing', 'installation')
}