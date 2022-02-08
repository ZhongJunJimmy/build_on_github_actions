# Docker

Sharing how to build docker image

## Edit Dockerfile


    Use `vi Dockerfile` create a Docker script file that contents like following block
    ```
    From ubuntu:20.04

    WORKDIR /app/
    COPY app-linux /app/
    RUN chmod  777 /app/app
    EXPOSE 3000

    CMD ["./app"]
    ```
- From: base image
- WORKDIR: work directory
- COPY: copy current file into docker image specify path
- RUN: run linux cmd
- EXPOSE: Set the port forwarding
- CMD: running the following command when image had been run in docker

## Run docker build command

After edit the Dockerfile and solve it. Run the following command.
    `docker build -t release/koa_project:0.0.2 .`
It's will build a image in docker daemon


## Save image to .tar file

Run following command to save a image in ".tar" file
    `docker save zhongjunjimmy/koa_project:0.0.1 > koa_project.tar`

## Load image into docker


Running following command to load image into docker
    `docker load -i koa_project.tar`

## Run the image
- Checking image has been load in docker successfully. Run following cmd.
    `docker images`
- run image and specific port by following cmd
    `sudo docker run -d -p 3000:3000 zhongjunjimmy/koa_project:0.0.1`

## Push image to dockerhub
First create a dockerhub account.Then create a new repository on your dockerhub account.
For example, I create a repository named "koa_project". 
Run the following command to push the image on dockerhub repository
    `docker push NAME[:tag]`
Sqmple: 
    `docker push zhongjunjimmy/koa_project:0.0.1`

## Edit docker-compose.yml
```

koa_project:
    image: zhongjunjimmy/koa_project:0.0.2
    expose:
    - "3000"
    ports:
    - "3000:3000"

```

- image: Name of your dockerhub repository and tag
- expose: The needed port for this image
- ports: It will be exposed to the host machine to a random port or a given port.

Run the following cmd to download and run image from dockerhub and load it in docker service after save the docker-compose.yml file.
    `docker-compose up -d`

## Edit install shell script for linux OS

Please reference the file `installer.sh`. It's will check docker and docker-compose peorcess, and download `docker-compose.yml` from github.
Finally, run `docker-compose up -d` to download and run image on local side.

## Try it 
Installing this sample projrect by running following command
`curl -l https://raw.githubusercontent.com/ZhongJunJimmy/github_actions/main/koa_project/installer.sh | sudo sh -s`
