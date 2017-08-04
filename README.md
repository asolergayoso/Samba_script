# Samba_script
This bash script allows to quickly set up a netwrok drive (wiht the name Courses) on a Debian system

## User Setup
It is important to mention that the script will set the current user as the valid user for Samba, once it runs. For that reason, it is very important to mention that the user should not be logged in as root when running the script.
it is suggested that a new user is created and logged into, before running the script. In fact, multiple users could be created and assigned different access priviledges.
For instance, the command "sudo useradd -m student"  will create a new user called student and the command "su - student" will log into this new user.

## Running the script
Running the script is fairly simple (type "bash /path/to/network_drive.sh on _terminal).
Right after the script is run, it will ask for the number of courses that will be shared. If the number is less than 1 or greater than 20, it will ask again. Once the proper number is submitted it will ask for the name of each specific class. Once the course names have been entered, the program will proceed to download samba, modify the config file (/etc/samba/smb.conf) and restart the service. It will also ask the user to enteer a password, this password will only be used for Samba, and it will be used by clients when accessing the server. 
Finally, the sript will run the command " smbclient -L //localhost" which will basically list all the files that are being shared with samba. The Courses folders with all the newly created courses will be places on the 'Public' directory of the user that the script was run on. At this point, it will be possible to connect to the network drive drom another computer.

## How to connect to server
Now that the server is up and running we need to connect clients to it.

### MacOS
If the client runs on MacOS, we wil need to press "Command + K" and type smb://serverIP/Courses/specifiCourse. When logging in, we will need to type in the user that we created earlier, and the samba  password that we  made when running the script. 

### Windows
On this operating system, we just need to Files, right click on 'This PC' and click 'Map network drive...", then type "\\serverIP\Courses\specificCourse", and again, log in with the allowed user and its respective samba passsword.

### Ubuntu/Debian
On linux, we can go to Files >> + other locations >> type "smb://serverIP/Courses/specifiCourse" on the bar and hit 'Connect'. Another way would be to install smclient ("sudo apt-get install smclient") and use the command "smbclient //serverIP/Courses -U username". 

## Changing spcific passwords
To change a specific samba password we use the command "smbpasswd -a username". For instance, if we want to change the samba password of the student account, we type 'sudo smbpasswd -a student'.

## Further Configuration
Configuring the config file smb.conf will allow for further confiduration of the system, such as allowing only certain IP's, groups, establishing domain names and more.


