#!/bin/sh
#script to delete the x days older objects from s3 bucket
#script will take two arguments first one is s3 bucket name and second one is number of days
#./delete_old_bkfiles.sh <s3bucketname> <number ofdays> example
#./delete_old_bkfiles.sh mys3buckettest 30
aws s3 ls s3://$1 | while read -r line;
  do
    createDate=`echo $line | awk '{print $1" " $2}'`
    createDate=`date -d "$createDate" +%s`    
    olddate=$(date --date "$2 days ago")
    olddate=`date -d "$olddate" +%s`    
     if [ $createDate -lt $olddate ]
     then
		filename=`echo $line | awk '{print $4}'`
		echo $filename
                echo $line
		aws s3 rm s3://$1/$filename 
     fi
  done;
