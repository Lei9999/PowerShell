# 通过Powershell Send-MailMessage 模块进行邮件发送，且需要密码，密码采用明文的方式进行发送
# 使用SSL没成功

$EmailCreID = 'shilei@ttc-cn.com'
$EmailCrepwd = 'Sl@0611'

$SecurePassword = $EmailCrepwd | ConvertTo-SecureString -AsPlainText -Force

$EmailFrom = 'TTL-Lei.S <shilei@ttc-cn.com>'
$EmailTo = 'SL.126 <shilei66491@126.com>'
$EmailCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $EmailCreID, $SecurePassword
$SMTP_SVR = 'smtp.exmail.qq.com'
$SMTP_Port = 25
$EmailSubject = 'Test Mail'
$EmailBoy = "Test"

# Send-MailMessage 模块
Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Priority High -Body $EmailBoy -SmtpServer $SMTP_SVR -Port $SMTP_Port -Credential $EmailCredential
