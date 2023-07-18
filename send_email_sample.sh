#!/bin/bash

# SMTP server settings
SMTP_SERVER="smtp.example.com"
SMTP_PORT="587"
SMTP_USERNAME="your_username"
SMTP_PASSWORD="your_password"

# Email settings
FROM_ADDRESS="sender@example.com"
TO_ADDRESS="recipient@example.com"
SUBJECT="Test Email"
MESSAGE="This is a test email sent from a bash script."

# Construct the email content
EMAIL_CONTENT="From: $FROM_ADDRESS
To: $TO_ADDRESS
Subject: $SUBJECT
Content-Type: text/plain; charset=UTF-8

$MESSAGE"

# Send the email using the mail command
echo -e "$EMAIL_CONTENT" | \
    openssl s_client -connect "$SMTP_SERVER:$SMTP_PORT" -starttls smtp -quiet 2>/dev/null | \
    grep -q "250" && \
    echo -e "EHLO $HOSTNAME
AUTH LOGIN
$(echo -ne "$SMTP_USERNAME\\r")
$(echo -ne "$SMTP_PASSWORD\\r")
MAIL FROM: <$FROM_ADDRESS>
RCPT TO: <$TO_ADDRESS>
DATA
$EMAIL_CONTENT
QUIT" | \
    openssl s_client -connect "$SMTP_SERVER:$SMTP_PORT" -starttls smtp -quiet
