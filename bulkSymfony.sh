#!/bin/bash
#Auther Praneeth
#version 0.1
Codepath="/var/www/html/OHRMStandalone/PROD/*"
TASKPATH="/home/paul/bulkWork"

copyTask()
{
	COUNT=0
	for dir in $Codepath
do
	echo "Copy the task to "$dir
	sudo cp -v detectOtherJobDetailsInLeaveRulesTask.class.php $dir/symfony/plugins/orangehrmCorePlugin/lib/task/
	echo "End copying task to "$dir
	COUNT=$((COUNT+1))
done
echo "files copied "$COUNT
}

runTask()
{
	for dir in $Codepath
	do
		echo "Change directory to "$dir
	        cd $dir/symfony
        	echo "Directory Changed to"$dir
	        echo "Start executing the symfony command"
        	sudo php symfony cc
	        sudo php symfony o:detect-other-job-details-in-leave-rules -f $TASKPATH
        	echo "End executing the symfony command"
	done

}

cleanup()
{
	for dir in $Codepath
		do
		sudo mv -f $dir/symfony/plugins/orangehrmCorePlugin/lib/task/detectOtherJobDetailsInLeaveRulesTask.class.php /var/log/BACKUP/
		done

}

echo "START BATCH COPYING"
copyTask
echo "END BATCH COPYING"
echo "START RUN TASK"
runTask
echo "END RUN TASK"
echo "START CLEANUP"
cleanup
echo "END CLEANUP"
