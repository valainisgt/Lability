function Import-BitsTransferModule {
<#
    .SYNOPSIS
        Imports the required BIts module.
#>
    [CmdletBinding()]
    param ( )
    process {

        Remove-Module -Name 'BitsTransfer' -ErrorAction SilentlyContinue;
        $bitsTransferModule = Import-Module -Name 'BitsTransfer' -Force -Scope Global -PassThru -Verbose:$false;
        Write-Verbose -Message ($localized.LoadedModuleVersion -f 'BitsTransfer', $bitsTransferModule.Version);

    } #end process
} #end function
