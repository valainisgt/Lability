function Import-BitsTransferModule {
<#
    .SYNOPSIS
        Imports the required BIts module.
#>
    [CmdletBinding()]
    param ( )
    process {
        $bitsTransferPath = (Get-LabHostDefault).BitsTransferPath;
        Remove-Module -Name 'Microsoft.BackgroundIntelligentTransfer.Management.Interop' -ErrorAction SilentlyContinue;
        $bitsTransferModule = Import-Module -Name $bitsTransferPath -Force -Scope Global -PassThru -Verbose:$false;
        $labDefaults.BitsTransferVersion = $bitsTransferModule.Version;
        Write-Verbose -Message ($localized.LoadedModuleVersion -f 'BitsTransfer', $bitsTransferModule.Version);
    } #end process
} #end function
