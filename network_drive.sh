#!bin/bash

echo "Initializing script"

echo "Current user:" $(whoami)

echo "Creating /Courses/ directory..."
$(mkdir ~/Public/Courses)

echo "Courses directory sucessfully created"

echo "Type the number of courses [ENTER]:" 
read numCourses
while :
do
	if (("$numCourses" > 20)) || (("$numCourses" < 1)); then   
		echo "Please enter an acceptable number of courses [ENTER]: "
		read numCourses
	else
		break
	fi
done

for ((counter = 1; counter <= numCourses; counter++))
do
	echo "Enter name of course $counter [ENTER]:" 
	read course_name
	$(mkdir ~/Public/Courses/"$course_name")
	echo "Preparing Session Folders..."
	$(mkdir ~/Public/Courses/"$course_name"/Session1)
	$(mkdir ~/Public/Courses/"$course_name"/Session2)
	echo "Preparing Session Folders...done"
	echo "Folder for $course_name sucessfully created"
done

echo "All directories have been created"

echo "Updating apt-get..."
sudo apt-get update --assume-yes

echo "Installing Samba..."
sudo apt-get install samba --assume-yes
echo "Samba has been sucessfully installed"

echo "Create a new password for Samaba"
sudo smbpasswd -a $(whoami)

echo "Backing up smb.conf"
sudo cp /etc/samba/smb.conf ~

CONFIG_FILE = /etc/samba/smb.conf

sudo chown $(whoami): /etc/samba/smb.conf
echo "Adding Courses to smb.conf..."
echo -e "[Courses]\npath=/home/"$(whoami)"/Public/Courses\nvalid users = "$(whoami)"\nbrowseable = yes\nread only = no" >> /etc/samba/smb.conf


echo "Restaring samba..."
sudo service smbd restart

smbclient -L //localhost -U $(whoami)

##echo "Checking for any syntax errors in smb.conf."
##$(testparm)










