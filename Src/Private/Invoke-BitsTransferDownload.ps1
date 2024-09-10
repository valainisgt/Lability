function Invoke-BitsTransferDownload {
<#
    .SYNOPSIS
        Downloads a (web) resource using Bits.
    .NOTES
        This solves issue #19 when running downloading resources using BITS under alternative credentials.
#>
    [CmdletBinding()]
    [OutputType([System.IO.FileInfo])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [System.String] $DestinationPath,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [System.String] $Uri,

        [Parameter(ValueFromPipelineByPropertyName)] [AllowNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $Credential
    )
    process {

        try {
            $path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($DestinationPath);

            $transferParams = @{
                Source = $Uri
                Destination = $path
                TransferType  = 'Download'
            }

            if ($Credential) {
                $transferParams.Credentials = $Credential
            }

            $hasDynamicParameter = (Get-Command -Name Start-BitsTransfer -Module 'BitsTransfer').Parameters['Dynamic'] -ne $null
            if ($hasDynamicParameter) {
                $transferParams.Dynamic = $true
            }

            Start-BitsTransfer @transferParams

            return (Get-Item -Path $path);
        }
        catch {

            throw ($localized.WebResourceDownloadFailedError -f $Uri);
        }
    } #end process
} #end function
