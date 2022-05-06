
# Import Active Directory Module
Import-Module ActiveDirectory

# Create Root OU
# New-ADorganizationalUnit 'Corp'

# Create Child OUs in Corp
$OUs = @(
    'Users'
    'Computers'
    'Servers'
    'Groups'
)
foreach ($ou in $OUs) {
    New-ADOrganizationalUnit -Path 'OU=Corp,DC=LBCC,DC=internal' -Name $ou
}
