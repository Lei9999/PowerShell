# 查询域用户密码到期时间，并输出到

Import-Module ActiveDirectory

# $SerachADUsers = Get-ADUser -Filter * -Properties pwdLastSet,PasswordLastset,EmailAddress | Where-Object Enabled -like true | Select-Object Name,SamAccountName,pwdLastSet,PasswordLastSet,EmailAddress | Format-Table
$SerachADUsers = Get-ADUser -Filter * -Properties pwdLastSet,PasswordLastset,EmailAddress,PasswordNeverExpires | Where-Object Enabled -like true | Where-Object PasswordNeverExpires -like False
$Now = Get-Date
$Changepwdnextlogon_userlist = @()
$pwdexpires_userlist = @()

ForEach ($_ in $SerachADUsers){
    If ([String]::IsNullOrEmpty($_.PasswordLastset)){
        $Changepwdnextlogon_userlist += $_.Name
    }
    else{
        $currentUserName = "用户名：" + $_.Name
        $currentUserID = "登陆ID：" + $_.SamAccountName
        $currentUserpwdlastset = "最后一次修改密码时间：" + $_.PasswordLastset
        $currentUserpwdexpires = "密码到期时间：" + $_.PasswordLastset.adddays(90)
        $currentUserpwdremaintime = $_.PasswordLastset.adddays(3) - $Now
        $currentUseremail = "用户邮箱地址：" + $_.EmailAddress
        
        $currentUserName
        $currentUserID
        $currentUserpwdlastset
        $currentUserpwdexpires
        "密码到期剩余时间：" + $currentUserpwdremaintime.Days + "天" + $currentUserpwdremaintime.Hours + "小时" + $currentUserpwdremaintime.Minutes + "分钟"
        $currentUseremail
        Write-Output "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        If($currentUserpwdremaintime.TotalHours -le 168 ){
            $pwdexpires_userlist += $_.Name
        }
    }
}

Write-Output "以下账户下次登录时需要修改密码：`n$Changepwdnextlogon_userlist`n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
Write-Output "以下账户密码即将过期，请及时修改密码：`n$pwdexpires_userlist`n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
