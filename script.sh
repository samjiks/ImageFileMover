#!/bin/bash

#read foldername start end

#b=$(date -d "${start}"  +"%Y%m%d")
#d=$(date -d "${end}"  +"%Y%m%d")
#echo $b
#echo $d

#if [ "$b" -ge "$d" ]; then
 #  echo "$b > $d"
#else
 #  echo "$b < $d"
#fi 
function validate_date()
{
  
  echo $(date "+%d/%m/%Y" -d "$1") 2>1 > /dev/null
  is_date=$?
  echo $is_date
  if [[ "$is_date" == "0" ]]; then
     echo "Date validates fine"
  else
     echo "Date $1 not  validated properly.  use this eg. 21/05/2015"
  fi
}

function move_pics_to_folder()
{
  validate_date $2
  validate_date $3 


 filetype=( jpg png txt )

 for f in "${filetype[@]}"
    do
	for s in $(stat *.$f | grep -i -e 'change: ' -e 'File: ' | awk '{print $2}')
	do           
 		echo $s
	done
     done
}


echo "Enter folder name, Start Day, End Day ./script "'Photo Folder'" 2015-14-01 2015-14-03";
read foldername start end
 
echo $foldername $start $end
  
  if [ ! -d $foldername ];
  then
       echo "Creating folder $foldername in $(pwd) directory"
       mkdir $foldername
       move_pics_to_folder $foldername $start $end
   else 
       echo "Folder Exists"
       #_move_pics_to_folder($foldername)
fi


