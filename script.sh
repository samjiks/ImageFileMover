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
 a=$(echo $1 |  awk -F/ '{ if ( $1 <= 31 && $1 >= 1 )  print $1    }')
 b=$(echo $1 |  awk -F/ '{ if ( $2 <= 12 && $2 >= 1 )  print $2    }')
 c=$(echo $1 |  awk -F/ '{ if ( $3 >= 1 && $3 <= 9999 )  print $3  }')
 echo $a $b $c
  
  if [[ $1 == [0-3][0-9]/[0-1][0-9]/[0-9][0-9][0-9][0-9] ]]; then
     echo "Date validates fine"
   else
     echo "Date $1 not  validated properly.  use this eg. 21/05/2015"
     exit
   fi
}

function move_pics_to_folder()
{
  
 filetype=( jpg png txt )

 for f in "${filetype[@]}"
    do
	for s in $(stat *.$f | grep -i -e 'change: ' -e 'File: ' | awk '{print $2}')
	do           
 		echo $s
	done
     done
}


#start of program

  if [ "$#" -gt "3" -o "$#" -lt "3" ]; then
   echo "Three Requirements need 'Folder Name' 'Start Time' 'Stop Time' "
   exit 
  fi
   
#If dates are not null then validated the date
  if [ -z "$2" -o -z "$3" ]; then
       echo "Empty dates"
       exit
     else 
        echo "Validating dates...."
        validate_date $2  
        validate_date $3
  fi

#create folder if required

 if [ ! -d $1 ];
  then
       echo "Creating folder $foldername in $(pwd) directory"
       mkdir $1
       move_pics_to_folder $1 $2 $3
   else 
       echo "Folder Exists"
       move_pics_to_folder $1 $2 $3
fi


