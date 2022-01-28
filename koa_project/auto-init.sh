#!/usr/bin/env bash

web_port=3000
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
                                                                                                                        
                                                                                                                        
echo "########## Welcome use koa project ###########"
echo "                     --                           "
echo "                     --                           "
echo "                     --                           "
echo -e "\033[36m(1/4)---- Check your system type ----\033[0m"
if [ "$(uname)" = "Darwin" ]
	then SYS="OS X"
	echo -e "\033[32mThe installation process is canceled because the current OS is not CentOS or Ubuntu. Remind you to use CentOS 8.3.2011 or Ubuntu 20.04.1 LTS or a later version \033[0m"	
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
	SYS="Linux"
	echo -e "\033[32mThe installation process is canceled because the current OS is not MAC OS\033[0m"
	exit 1
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
	SYS="WIN"
	echo -e "\033[32mThe installation process is canceled because the current OS is not MAC OS\033[0m"
	exit 1
fi
echo "SYSTEM：$SYS $DISTRO"
echo -e "\033[32mcheck system finished\033[0m"


######################################################################

echo -e "\033[36m(2/4)---- Check docker service ----\033[0m"


Install_docker_macos()
{
sudo brew cask install docker

check_docker=`docker -v`
if [ "$check_docker" ] 
	then 
	echo -e "\033[32mdocker installation is complete\033[0m"
	echo -e "\033[32m$check_docker\033[0m"
fi
}

Install_docker_compose()
{
sudo brew install docker-compose

check_docker_compose=`docker-compose -v`
if [ "$check_docker_compose" ]
	then 
	echo -e "\033[32mdocker-compose installation is complete\033[0m"
	echo -e "\033[32m$check_docker_compose\033[0m"
fi		
}

check_docker_service()
{
check_docker=`sudo docker -v`
if [ "$check_docker" ] 
	then 
	docker_status="found docker"
else
	docker_status="No found docker"
fi


check_docker_compose=`docker-compose -v`
if [ "$check_docker_compose" ]
	then 
	docker_compose_status="found docker-compose"
else
	docker_compose_status="No found docker-compose"
fi


check_docker_status=`ps -fe | grep docker | wc -l`
if [ $check_docker_status -eq 1 ]
	then 
	docker_service_status="docker service not running"
else
	docker_service_status="docker service is running"
fi
echo -e "$check_docker\n$docker_compose_status\n$docker_service_status."
}

Install_service()
{
if [ "$docker_status" = "No found docker" ] || [ "$docker_compose_status" = "No found docker-compose" ] || [ "$docker_service_status" = "docker service not running" ]
	then echo -e "\033[32mSome of the necessary docker service packages haven't been installed yet, the system will help you to install them, please make sure your system is connected to the internet. Would you like to continue the installation? [y/n] \033[0m"
	read k
	if [ "$k" = "y" ]
		then
		if [ "$docker_status" = "No found docker" ]
			then
			echo -e "\033[32mStart installation docker \033[0m"
			Install_docker_macos
				if [ "$docker_compose_status" = "No found docker-compose" ]
					then
					echo -e "\033[32mStart installation docker-compose \033[0m"
					Install_docker_compose
					if [ "$docker_service_status" = "docker service not running" ]
						then
						echo -e "\033[32mOpen docker service \033[0m"
						sudo systemctl start docker
					fi
				fi
		elif [ "$docker_compose_status" = "No found docker-compose" ];
			then 
			echo -e "\033[32mStart installation docker-compose \033[0m"
			Install_docker_compose
			if [ "$docker_service_status" = "docker service not running" ]
				then
				echo -e "\033[32mOpen docker service \033[0m"
				sudo systemctl start docker
			fi
		elif [ "$docker_service_status" = "docker service not running" ];
			then
			echo -e "\033[32mOpen docker service \033[0m"
			sudo systemctl start docker
		fi
	else
		echo -e "\033 [The installation process is canceled, remind you to upgrade the system to the required version and install the necessary packages before starting again. \033[0m"
		exit 1
	fi
fi
}

Judge_docker()
{
if [ "$docker_status" = "No found docker" ] || [ "$docker_compose_status" = "No found docker-compose" ] || [ "$docker_service_status" = "docker service not running" ]
	then echo "Judge_success"
fi
}


check_docker_service
while [ "$docker_status" = "No found docker" ] || [ "$docker_compose_status" = "No found docker-compose" ] || [ "$docker_service_status" = "docker service not running" ]
do
	Install_service
	check_docker_service
done


######################################################################

echo -e "\033[36m(3/4)---- Check web port ----\033[0m"
check_web_port_free=`lsof -i:$web_port | wc -l`
echo "message: $check_web_port_free"
if [ $check_web_port_free -eq 0 ]
	then echo -e "\033[32mweb port is free"
else
	echo -e "\033[31mweb port:$web_port is used\033[0m" 
	exit 1
fi

######################################################################

echo -e "\033[36m(4/4)---- check file and directory ----\033[0m"
if [ ! -f $SHELL_FOLDER"/docker-compose.yml" ]
	then echo -e "\033[31m not found app\033[0m"
	exit 1
fi

echo -e "\033[32mcheck file finished\033[0m"
echo -e "\033[32mall check job finished\033[0m"

######################################################################

docker-compose up -d
echo -e "\033[32mkoa project services are running...\033[0m"
echo ""
echo "-- commands list -----------------------"
echo "|                                       |"
echo -e "|  start: \033[32mdocker-compose up -d\033[0m          |"
echo -e "|  stop:: \033[32mdocker-compose down\033[0m           |"
echo "|                                       |"
echo " ----------------------------------------"
exit 0




