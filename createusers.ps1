
# Import Active Directory Module
Import-Module ActiveDirectory

# Read in Secure Temporary Password (Note: Complexity)
$csv = Import-CSV -Path C:\Users\k.tinio\Documents\adusers.csv

$AccountPassword = Read-Host -AsSecureString -Prompt "Enter Temporary Password for New Users"

# Loop Through Users
foreach ($user in $csv) {

    # Store User Attributes for Splatting
$UserInfo = @{
    SamAccountName = $user.SamAccountName
    Name = $user.Name
    DisplayName = $user.Name
    GivenName = $user.GivenName
    Surname = $user.Surname
    Title = $user.Title
    Department = $user.Department
    Company = $user.Company
    EmailAddress = $user.EmailAddress
    AccountPassword = $AccountPassword
    ChangePasswordAtLogon = $true
    Path = $user.Path
    Enabled = $true
    }

    # Create New Users
    New-ADUser @UserInfo
}