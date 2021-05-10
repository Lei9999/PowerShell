# 通过Powershell Send-MailMessage 模块进行邮件发送
# 使用SSL方式未成功

# Send-MailMessage 参数说明
# [-Attachments <String[]>]
# [-Bcc <String[]>]
# [[-Body] <String>]
# [-BodyAsHtml]
# [-Encoding <Encoding>]
# [-Cc <String[]>]
# [-DeliveryNotificationOption <DeliveryNotificationOptions>]
# -From <String>
# [[-SmtpServer] <String>]
# [-Priority <MailPriority>]
# [-ReplyTo <String[]>]
# [[-Subject] <String>]
# [-To] <String[]>
# [-Credential <PSCredential>]
# [-UseSsl]
# [-Port <Int32>]
# [<CommonParameters>]

# 如果没有内部的邮件服务器，则公网的邮件服务器需要用户名和密码认证
# 认证调用的模块是 "PSCredential"

# 生成密码的安全字符串文件，文件存储位置取决于 '-FilePath' 参数
# 该命令使用一次即可
Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath shilei@ttc-cn.com.securestring
# 通过文件获取密码
$EncryptedPasswordFile = 'shilei@ttc-cn.com.securestring'
$SecureStringPassword = Get-Content -Path $EncryptedPasswordFile | ConvertTo-SecureString

$EmailFrom = 'TTL-Lei.S <shilei@ttc-cn.com>'
$EmailTo = 'SL.126 <shilei66491@126.com>'
$EmailCreID = 'shilei@ttc-cn.com'
$EmailCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $EmailCreID, $SecureStringPassword
$SMTP_SVR = 'smtp.exmail.qq.com'
$SMTP_Port = 25
$EmailSubject = 'Test Mail'
$EmailBoy = "Test"

# Send-MailMessage 模块
Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Priority High -Body $EmailBoy -SmtpServer $SMTP_SVR -Port $SMTP_Port -Credential $EmailCredential
