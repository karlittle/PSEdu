# Import Active Directory Module
Import-Module ActiveDirectory

# Path to adusers spreadsheet
$csvfile = 'C:Users\k.tinio\Documents\adusers.csv'

# Import User Data
$csv = Import-CSV -Path $csvfile

# Path to the Security Groups OU
$groupOU = "OU=Groups,OU=Corp,DC=acme,DC=local"

# Import unique department names
$groups = $csv.Department | Select-Object -Unique

# Loop through each group name
foreach ($group in $groups) {
    
    # Info for Global Group Creation
    $GlobalGroupInfo = @{
        Name            = "$group Users"
        SamAccountName  = $group.ToLower().Replace(' ', '') + "_users"
        Path            = $groupOU
        GroupScope      = "Global"
        GroupCategory   = "Security"
        Description     = "Members of this group work in the $group Department"
    }

    # Info for Domain Local Group Creation
    $DomainLocalGroupInfo = @{
        Name            = "$group Resources"
        SamAccountName  = $group.ToLower().Replace(' ', '') + "_resources"
        Path            = $groupOU
        GroupScope      = "DomainLocal"
        GroupCategory   = "Security"
        Description     = "Security Group used to manage access to the $group Department's Resources"
    }

    # Create the Global Group
    New-ADGroup @GlobalGroupInfo
    
    # Create the Domain Local Group
    New-ADGroup @DomainLocalGroupInfo
}