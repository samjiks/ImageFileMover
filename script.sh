#!/bin/bash

function validate_date()
{

  if [[ $1 == [0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] ]]; then

 
       a=$(echo $1 |  awk -F- '{ if ( $3 >= 1 && $3 <= 31 )  print $3    }')
       b=$(echo $1 |  awk -F- '{ if ( $2 >= 1 && $2 <= 12 )  print $2    }')
       c=$(echo $1 |  awk -F- '{ if ( $1 >= 1 && $1 <= 9999 )  print $1  }')
     
       #The below needs redoing. Not sensible programming

      if [ -z $a ]; then
        echo "$1 has an invalid day"
        exit
      elif [ -z $b ]; then
        echo "$1 has an invalid month"
        exit
      elif [ -z $c ]; then
        echo "$1 has an invalid year"     
        exit
      fi
        
     echo "Date $1 validates fine"
   else
     echo "Date $1 not validated properly.  use this eg. 2015-05-01 12:50:00"
     exit
   fi
}

function move_pics_to_folder()
{
  #Need to fix the time between search along with the date 
  a="00:00:00"
 
  for i in `find . -maxdepth 1 -type f -regextype posix-extended -regex ".*\.(jpg|png|gif)"  -newermt "$2 $a" ! -newermt "$3 $a"`; 
  do
     echo "Found this file $i to move"
     mv $i $1/
     echo "Moved this file $i to $1 folder" 
   done
}


#start of program

  if [ "$#" -gt "3" -o "$#" -lt "3" ]; then
   echo "Three Requirements needed 'FolderName' 'Start Date Time' 'End Date Time' "
   exit 
  fi
   
#If dates are not null then validated the date
  if [ -z "$2" -o -z "$3" ]; then
       echo "Need the start date and end dates for searching"
       exit
     else 
        echo "Validating dates...."
     
     for i in $2 $3; 
      do
        validate_date $i  
      done
  fi

#create folder if required

 if [ ! -d $1 ];
  then
       echo "Creating folder $1 in $(pwd) directory"
       mkdir $1
       move_pics_to_folder $1 $2 $3
   else 
       echo "$1 Folder Exists"
       move_pics_to_folder $1 $2 $3
fi


