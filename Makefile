install_local_postgress:
	sudo apt-get install postgresql
	createdb
	which psql
	echo [-e] "Now type command: psql \n '\'q to Exit"