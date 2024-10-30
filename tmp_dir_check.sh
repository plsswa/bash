#!/bin/bash
#This script is to check whether /tmp directory is cleared after QA ENV work
#Auther: lsegliveops@lseg.com
#Version 0.1
#USER=cssncdexrep
#USER=regtech1
MAIL_RECP="praneeth.samarasinghe@lseg.com"
USER_LST=("cssncdexrep" "praneeths")
SITE="PDC"

check_files()
{
	RESULT=$(ls -ltrh /tmp |grep $user | cut -d " " -f 3 | head -n 1)
	FILE_COUNT=$(ls -ltrh /tmp | grep $user |wc -l)
	if [ $FILE_COUNT -ne 0 ] && [ $RESULT=$user ]
	then
		send_mail 1
	else
		send_mail 0
	fi
}	

send_mail()
{
	success_msg="Hi All,\n\nNo additional files for user $user were found..\n\nRegards,\nLSEG LiveOps Team.\n\n"
	fail_msg=" Hi All, \n\nAddtional files found for user $user. Please check\n\nRegards,\nLSEG LiveOps Team.\n\n"
	if [ $1 = 0 ]
	then
		echo -e $success_msg | mailx -s "[NCDEX][$SITE] TMP DIRECTORY FILE STATUS FOR USER $user - OK" $MAIL_RECP
	else
		echo -e $fail_msg | mailx -s "[NCDEX][$SITE] TMP DIRECTORY FILE STATUS FOR USER $user - ERROR" $MAIL_RECP
	fi	
}


for user in "${USER_LST[@]}";
do
	#loop $user
	check_files $user
done
