#!/bin/bash

TMP_KOAPROJECT_CONNECT=/usr/local/koa_project
if [ ! -d $TMP_KOAPROJECT_CONNECT ];then
  mkdir -p $TMP_KOAPROJECT_CONNECT
fi

cd $TMP_KOAPROJECT_CONNECT
echo " "

echo -e "\033[36m--- Download config files---\033[0m"
echo " "
curl -o init.sh https://raw.githubusercontent.com/ZhongJunJimmy/github_actions/main/koa_project/auto-init.sh
curl -o docker-compose.yml https://raw.githubusercontent.com/ZhongJunJimmy/github_actions/main/koa_project/docker-compose.yml

echo -e "\033[32m--- Download Complete\033[0m"
echo " "

sudo sh init.sh