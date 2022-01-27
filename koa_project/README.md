# Docker

Sharing how to build docker image

1. Edit Dockerfile


    Use `vi Dockerfile` create a Docker script file that contents like following block
    ```
    From ubuntu:20.04

    WORKDIR /app/
    COPY app-linux /app/
    RUN chmod  777 /app/app-linux
    EXPOSE 3000

    CMD ["./app-linux"]
    ```
    - From: base image
    - WORKDIR: work directory
    - COPY: copy current file into docker image specify path
    - RUN: run linux cmd
    - EXPOSE: Set the port forwarding
    - CMD: running the following command when image had been run in docker

2. run docker build command

After edit the Dockerfile and solve it. Run the following command.
`docker build -t release/koa_project:0.0.2 .`
It's will build a image in docker daemon


3. save image to .tar file

Run following command to save a image in ".tar" file
`docker save release/koa_project:0.0.2 > koa_project.tar`

4. load image into docker


Running following command to load image into docker
`docker load -i koa_project.tar`

5. run the image
    - Checking image has been load in docker successfully. Run following cmd.
        `docker images`
    - run image and specific port
        `sudo docker run -d -p 3000:3000 release/koa_project:0.0.2`