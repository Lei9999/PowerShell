Import-Module ActiveDirectory

Get-ADUser -Filter * -Properties pwdLastSet,PasswordLastset,EmailAddress | Where-Object Enable -Like true | Select-Object Name,SamAccountName,pwdLastSet,PasswordLastSet,EmailAddress | Format-Table
# 查询账户"u1"的Propertices的所有值
Get-ADUser u1 -Propertices *