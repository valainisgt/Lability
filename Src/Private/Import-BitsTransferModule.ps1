function Import-BitsTransferModule {
<#
    .SYNOPSIS
        Imports the required BIts module.
#>
    [CmdletBinding()]
    param ( )
    process {

        $bitsTransferPath = (Get-LabHostDefault).BitsPath;
        Remove-Module -Name 'Microsoft.BackgroundIntelligentTransfer.Management.Interop' -ErrorAction SilentlyContinue;
        $bitsTransferModule = Import-Module -Name $bitsTransferPath -Force -Scope Global -PassThru -Verbose:$false;
        Write-Verbose -Message ($localized.LoadedModuleVersion -f 'Bits', $bitsTransferModule.Version);

    } #end process
} #end function
