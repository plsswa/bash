#!/bin/bash
#This script is to check whether /tmp directory is cleared after QA ENV work
#Auther: lsegliveops@lseg.com
#version 0.1

#USER CONFIG
MAIL_RECP="praneeth.samarasinghe@lseg.com"
USER_LST=("cssncdexrep" "praneeths" "dba")
SITE="PDC"
SCRIPT_PATH="/x01/cssncdexrep/praneeth/NCDEX/tmp_file_check"
script_name="${0##*/}"
#END_USER_CONFIG

send_mail()
{
	success_msg="Hi All,\n\nNo additional files for user $user were found..\n\nRegards,\nLSEG LiveOps Team.\n\n"
	fail_msg=" Hi All, \n\nAddtional files found for user $user. Please check\n\nRegards,\nLSEG LiveOps Team.\n\n"
	if [ $1 = 0 ]
	then
		echo -e $success_msg | mailx -s "[NCDEX][$SITE]TMP DIRECTORY FILE STATUS FOR USER $user - OK" $MAIL_RECP
	else
		echo -e $fail_msg | mailx -s "[NCDEX][$SITE]TMP DIRECTORY FILE STATUS FOR USER $user - ERROR" $MAIL_RECP
	fi	
}

check_files()
{
	for user in "${USER_LST[@]}";
	do
		RESULT=$(grep $user TMP_* | cut -d " " -f 3 | head -n 1)
		COUNT=$(grep $user TMP_* | cut -d " " -f 3 | head -n 1 | wc -l)
		if [ $COUNT -ne 0 ] && [ $RESULT=$user ]
		then
			send_mail 1
		else
			send_mail 0
		fi
	done

}

clear_tmp_file()
{
	cd $SCRIPT_PATH
	rm -f TMP_*
	echo "$(date) TMP files are removed" >> ${script_name}.log
}

for ip in `cat ~/machines.txt`;do ssh $ip ls -ltrh /tmp >> TMP_$ip;done;
check_files
clear_tmp_file
