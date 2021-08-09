#!/bin/bash
function grpmgmt()
{
	echo " welcome to the group management console"
	opt=""
	select opt in grpadd grpdl grpmodi
	do
	case $opt in
	grpadd) grp_add
				  ;;
	grpdl)  grp_del
					;;
	grpmodi) grp_modif
					;;
	*) echo " you didnt enter any option"
					;;
	esac
	done
}
function grp_modif()
{
		read -p " enter the groupname :" gname
		echo -e "\n-----------------------------------\n modification of group attributes\n-----------------------------------"
		echo -e "1. renaming the group\n2. password\n3. gid\n4. adding user to the group\n5. deleting single user from the group\n6. deleting all the users from the group\n7. listing users from the group"
		echo -e "-----------------------------------"
		echo -n "enter your option:" ;read n
		  case $n in
			    1)  read -p " enter the new groupname :  " ngname
					    groupmod -n $ngname $gname
							echo "the group name has been changed to $ngname"
							;;
					2)  gpasswd $gname
							echo " password is updated"
							;;
			    3)  read -p " enter the gid :" gpid
			        groupmod -g $gpid $gname
			        echo " the gid of the group $gname is changed to $gpid"
				      ;;
				  4)  read -p " enter the user name to add to the group:  " name
				      groupmems -a $name -g $gname
				      echo " the user $name is add to the group $gname"
				      ;;
				  5)  read -p " enter the user name to delete from the group: " dname
				      usermod -d $dname -g $gname
				      echo " the user $dname id deleted from the group $gname"
				      ;;
				  6)  groupmems -p -g $gname
				      echo "all the users in the group $gname are deleted successfully"
				      ;;
				  7)  echo " the list of users in the group $gname are `groupmems -g $gname -l` "
					    ;;
					*)  echo " sorry $n is invalid option..select from [ 1 to 6]"
							;;                                                                                                                 esac	
}
function usermgmt()
{
 echo " welcome to the user management console"
 opt=""
 select opt in usradd usrdl usrmodi
 do
 case $opt in 
 usradd) user_add
 				 ;;
 usrdl)  user_del
 				 ;;
 usrmodi)user_modif
 				 ;;
	*) echo " you didnt enter any option"
				 ;;
	esac
	done
}
function user_add()
{
	read -p "enter the username you want to create:  " uname
	 if [ $uname > /dev/null ]
	 then
			grep -w "^$uname" /etc/passwd > /dev/null
			if [ $? -eq 0 ]
			then
				echo -e " \n the username $uname is already exists"
			else
				pas=`python -c 'import crypt;print(crypt.crypt("'$uname'","$6$kjdhfihf"))'`
				useradd -p $pas $uname
				if [ $? -eq 0 ]
				then
					echo -e " \n username $uname added successfully"
				else
					echo -e " \n failed to create the $uname user"
				fi
			fi
			else
			 echo " you have not entered any username"
	 fi
}
function user_del()
{
		read -p " enter the user name:" uname
		echo " do you want to delete the user account only or the user with home directory"
		select opt in del recurdel
		do 
		case $opt in
		del) userdel $uname
				 echo " the user account is deleted "
				 ;;
		recurdel) userdel -r $uname
							echo " the user account and its home directory is deleted"
		;;
		esac
		done
}
function user_modif()
{
		read -p " enter the username :" uname
		echo -e "-----------------------------------\n modification of user attributes\n-----------------------------------"
		echo "
					1. username
					2. password
					3. uid
					4. gid
					5. comment/gecos
					6. homedirectory
					7. shell
					8. locking the user account
					9. unlocking the user account
				 "
		echo -e "-----------------------------------"
		echo -n "enter your option:" ;read n
		case $n in
		1)  read -p " enter the new username :" nuname
    		usermod -l $nuname $uname
				echo "the user loginname has been changed to $nuname"
				;;
		2)  read -p " enter the new password:  " psw
				echo "$uname:$psw" | chpasswd
				echo " password is updated"
				;;
		3)  read -p " enter the uid :" urid
				usermod -u $urid $uname
				echo " the uid of the user $uname is changed to $urid"
				;;
		4)  read -p " enter the group id :" grpid
				usermod -g $grpid $uname
				echo " the gid of the user $uname is changed to $grid"
				;;
	 	5)  read -p " enter the home directory: " hdd
				usermod -d "$hdd" $uname
				echo " the home director of the user $uname is changed to $hdd"
				;;
		6)	read -p " enter the comment here:  " cmt
		   	usermod -c "$cmt" $uname
				echo "the gecos for the user $uname is updated"
				;;
		7)	read -p " enter the name of the shell: " shl
				usermod -s "$shl" $uname
				echo " shell is allocated to the user $uname"
				;;
		8)	usermod -L $uname
				echo -e "\n the user account $uname is locked successfully"
				;;
		9)	usermod -U $uname
				echo -e "\n the user account $uname is unlocked successfully"
				;;
		*)	echo " sorry $n is invalid option..select from [ 1 to 9]"
				;;																																																										esac				
}
function menu()
{
if [ $(id -u) -eq 0 ]
then
	echo -e "---------------------------------------------------\nwelcome to the user and group management console\n---------------------------------------------------\n"	
echo -e "\tenter 1 for usermanagement\n\tenter 2 for groupmanagement\n\tenter q for exit..."
read val
case $val in 
1) usrmgmt
;;
2) grpmgmt
;;
*) echo "exiting form the menu"
   exit
	 ;;
	 esac
else
	echo -e "you are not authorised....\nplease contact your admin...."
fi
}
menu

#!/bin/bash
function grpmgmt()
{
echo " group management "
return
}
function usermgmt()
{
 while true
 do
 echo " "
 echo -e "\n____________________________________________________\nwelcome to the user management console\n____________________________________________________"
 echo "[1] usercreation"
 echo "[2] userdeletion"
 echo "[3] modification of user account"
 echo "[4] back to the main menu
 echo "[5] exit"
 echo "______________________________________________________"
 echo " enter your choice [1 to 5] : "
 read ch
 case $ch in
 1) user_add ;;
 2) user-del ;;
 3) user_modif ;;
 4) main_menu ;;
 5) exit 2 ;;
 *) echo " please enter the correct choice " ; echo " press enter to continue..." ; read ;;
 esac
 done
 return
 }
 function user_add()
 {
   if [ $# -eq 0 ]
	   then
		     echo " you have not entered the user name"
				     echo " usage is $0 user1 user2..."
						   else
							     for i in $@
									     do
											       grep -w "^$i" /etc/passwd > /dev/null
														       if [ $? -eq 0 ]
																	       then
																				         echo -e " \n the username $i is already exists"
																								       else
																											         pas=`python -c 'import crypt;print(crypt.crypt("'$i'","$6$kjdhfihf"))'`
																															         useradd -p $pas $i
																																			         if [ $? -eq 0 ]
																																							         then
																																											           echo -e " \n username $i added successfully"
																																																         else
																																																				           echo -e " \n failed to create the $i user"
																																																									         fi
																																																													       fi
																																																																     done
																																																																		   fi
																																																																			 return
																																																																			   }
																																																																				   function user_del()
																																																																					   {
																																																																						     read -p " enter the user name:" uname
																																																																								     echo " do you want to delete the user account only or the user with home directory"
																																																																										     select opt in del recurdel
																																																																												     do
																																																																														     case $opt in
																																																																																     del) userdel $uname
																																																																																		          echo " the user account is deleted "
																																																																																							         ;;
																																																																																											     recurdel) userdel -r $uname
																																																																																													               echo " the user account and its home directory is deleted"
																																																																																																				     ;;
																																																																																																						     esac
																																																																																																								     done
																																																																																																										 return
																																																																																																										   }
																																																																																																											   function user_modif()
																																																																																																												   {
																																																																																																													 read -p " enter the username :" uname
																																																																																																													     echo -e "-----------------------------------\n modification of user attributes\n-----------------------------------"
																																																																																																															     echo "
																																																																																																																	           1. username
																																																																																																																						           2. password
																																																																																																																											           3. uid
																																																																																																																																           4. gid
																																																																																																																																					           5. comment/gecos
																																																																																																																																										           6. homedirectory
																																																																																																																																															           7. shell
																																																																																																																																																				           8. locking the user account
																																																																																																																																																									           9. unlocking the user account
																																																																																																																																																														          "
																																																																																																																																																																			    echo -e "-----------------------------------"
																																																																																																																																																																					    echo -n "enter your option:" ;read n
																																																																																																																																																																							    case $n in
																																																																																																																																																																									    1)  read -p " enter the new username :" nuname
																																																																																																																																																																											        usermod -l $nuname $uname
																																																																																																																																																																															        echo "the user loginname has been changed to $nuname"
																																																																																																																																																																																			        ;;
																																																																																																																																																																																							    2)  echo "$uname:$uname" | chpasswd
																																																																																																																																																																																									        echo " password is updated"
																																																																																																																																																																																													        ;;
																																																																																																																																																																																																	    3)  read -p " enter the uid :" urid
																																																																																																																																																																																																			        usermod -u $urid $uname
																																																																																																																																																																																																							        echo " the uid of the user $uname is changed to $urid"
																																																																																																																																																																																																											        ;;
																																																																																																																																																																																																															    4)  read -p " enter the group id :" grpid
																																																																																																																																																																																																																	        usermod -g $grpid $uname
																																																																																																																																																																																																																					        echo " the gid of the user $uname is changed to $grid"
																																																																																																																																																																																																																									        ;;
																																																																																																																																																																																																																													    5)  usermod -d /home/$uname
																																																																																																																																																																																																																															        echo " the home director of the user $uname is changed to "
																																																																																																																																																																																																																																			        ;;
																																																																																																																																																																																																																																							    6)  usermod -c "comment"
																																																																																																																																																																																																																																									        echo "the gecos for the user $uname is updated"
																																																																																																																																																																																																																																													        ;;
																																																																																																																																																																																																																																																	    7)  usermod -s /bin/bash $uname
																																																																																																																																																																																																																																																			        echo " shell is allocated to the user $uname"
																																																																																																																																																																																																																																																							        ;;
																																																																																																																																																																																																																																																											    8)  usermod -L $uname
																																																																																																																																																																																																																																																													        echo -e "\n the user account $uname is locked successfully"
																																																																																																																																																																																																																																																																	        ;;
																																																																																																																																																																																																																																																																					    9)  usermod -U $uname
																																																																																																																																																																																																																																																																							        echo -e "\n the user account $uname is unlocked successfully"
																																																																																																																																																																																																																																																																											        ;;
																																																																																																																																																																																																																																																																															    *)  echo " sorry $n is invalid option..select from [ 1 to 9]"
																																																																																																																																																																																																																																																																																	        ;;
																																																																																																																																																																																																																																																																																					 esac
																																																																																																																																																																																																																																																																																					 return
																																																																																																																																																																																																																																																																																					  }
																																																																																																																																																																																							function main_menu()																																																		
{
while true
do
clear
echo " "
echo -e "---------------------------------------------------\nwelcome to the user and group management console\n---------------------------------------------------"
echo "[1] usermanagement"
echo "[2] groupmanagement"
echo "[3] exit"
echo "=================================================="
echo " enter your choice [1 to 3] : "
read n_menu
case $n_menu in
1) usermgmt ;;
2) grpmgmt ;;
3) exit 1 ;;
*) echo " please enter the correct choice " ; echo " press enter to continue..." ; read ;;
esac
done
}
function cond()
{
if [ $(id -u) -eq 0 ]
then
main_menu
else
echo -e "you are not authorised....\nplease contact your admin...."
fi
}
cond
