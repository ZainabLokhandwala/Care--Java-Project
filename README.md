Care is a blood donation web application where, users can get it touch with each other and communicate for their needs.

Installation Instructions


Database

Create a new MySQL database under the name ‘CareZainab’,
Import the .sql file into that

Execute the following  script to reset all the passwords to any password you like.

Update USERS set u_pass =md5(‘newpassword’); 

Project

Open the project in NetBeans IDE
Open
	DB.java
	And change the mysql database credentials
Open 
	FileUploadHandler.java
	And change the value of UPLOAD_DIRECTORY with the location of the userimages folder inside your computer/server


