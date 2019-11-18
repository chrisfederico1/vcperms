

<#
   Help Stuff Here 
    
#>

function create-vcpermsreport

{
    
# Parameters
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$Server,

        [Parameter(Mandatory=$false)]
        [string]$Path
    )

BEGIN {
    $permissions = @()

}
PROCESS{

    $permissions += Get-VIPermission | Select-Object @{N='VCENTER';E={$_.Uid.split('@:')[1]}},Principal,Role,@{n='Entity';E={$_.Entity.Name}},@{N='Entity Type';E={$_.Entityid.split('-')[0]}}
}

END{
    $permissions | export-csv .\vcpermsreport.csv -NoTypeInformation

}

}
