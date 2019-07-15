<!-- Docker - tutorial  -->

## Pre-requirement 
#### Install Docker + Nvidia Docker 2

  - [Ubuntu [.sh]](https://raw.githubusercontent.com/royinx/setting/master/ubuntu/docker.sh)

  - [Mac [.dmg]](https://docs.docker.com/docker-for-mac/install/)

  - [Other OS](https://docs.docker.com/install/)

~~Windows doesnt support nvidia docker~~ 😎

---
#### Shortcut for container status
```bash
watch -n 0.5 docker ps
watch -n 0.5 docker ps -a 
watch -n 0.5 docker images

docker logs <CONTAINER>
```

---
#### Pull image from online repository
<!-- PULL (online hub:img -> local registry:img) -->

`docker pull ubuntu:18.04`  

**Shortcut**: One line PULL and RUN (using RUN) <!-- (online hub:img -> local registry:img -> container) -->

`docker run --rm ubuntu:18.04`

---
## Build Container
#### Dockerfile 
##### Basic knowledge 
The docker image will be built by multiple layer which wrote in the dockerfile. (Using keywords `ARG, ENV, RUN, CMD, ENTRYPOINT, etc`)

The progress inside building an image as follow: 

  - Start a temporary container
  - Run command to add layer
  - Commit image
  - Destroy

Keep looping the cycle until the image built, and all the temp containers would be auto-destroied.

Write the command like bash

```dockerfile 
# 1/6
FROM ubuntu:18.04 

# 2/6 Install sudo
RUN apt-get install sudo

# 3/6 add user and switch user (user: docker , pw: docker)
RUN useradd -m docker && \
    echo "docker:docker" | chpasswd && \
    adduser docker sudo

# 4/6 change USER
USER docker

# 5/6 set the working directory of new bash
WORKDIR /this_is_the_WORKDIR_i_made_in_dockerfile

# 6/6 expose the port 1111
EXPOSE 1111
```

#### Build Command 
```bash 
docker build -t <IMAGE_NAME>  <DOCKERFILE_DIR>
docker build -t docker_demo ~/Desktop/github/docker_demo/
```


---
## Run Container

Arguments | Usage
----------|--------
`--runtime=nvidia` | load nvidia docker2 from docker
`--name=<CONTAINER_NAME>` | naming container
`--rm` | remove the container when exit
`--shm-size` | limitise the VRAM to container
`--privileged` | access all the infrastructure from host OS
`-m` | limitise memory `100M`: means 100MB. 
`--memory-swap` | limitise a swap space, `-1` means unlimited
`-d` | run in background
`-it` | interactive tty
`-v` | mount container folder to host folder using the seperator `:`*
`-e` | ENV variable initializing


Remarks:

  - *thats why network drive hard to mount with smb path
  - *VOLUME cannot init in Dockerfile since the container build cycle with create temp container for VOLUME



#### Example:
```
docker run --runtime=nvidia \
           --name=general_devel \
           --shm-size 8G \
           --privileged \
           -m 100M \ 
           --memory-swap -1 \
           -dit \
           -v ~/Desktop/python:/py/ \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -e DISPLAY=unix$DISPLAY \
           -e CUDA_VISIBLE_DEVICES=1,2,3,4 \ 
           -v /dev/video0:/dev/video0 \
           -v /dev/video1:/dev/video1 \
           ufoym/deepo:pytorch bash
```

##### Argument for Video X11 showing on Host
```
-v /tmp/.X11-unix:/tmp/.X11-unix
-e DISPLAY=unix$DISPLAY
```

##### Argument for mounting webcamera to container
```
-v /dev/video0:/dev/video0
-v /dev/video1:/dev/video1
```

Running the following command Display show to GUI
`xhost +local:docker`


---

## SSH into bash

`docker exec -it \
             --user=root \
             <CONTAINER> \ 
             bash`



## Pushing IMAGE

#### Rename 
  - container : `docker rename <CONTAINER> <NEW_NAME>`
  - image : `docker tag <SOURCE_IMAGE>[:TAG] <TARGET_IMAGE>[:TAG]`

#### Push to Repo
```
docker login
docker tag  <SOURCE_IMAGE>[:TAG] <DOCKER_ID>/<TARGET_IMAGE>[:TAG]
docker push <DOCKER_ID>/<TARGET_IMAGE>[:TAG]
docker logout
```


---
#### Hacker Tips😎
  - Set the ENTRYPOINT using 

    `jupyter notebook --ip=0.0.0.0 --port=$PORT`

  - the container block the task , so you can do pkill !!!

    `pkill python inside container`


---

#### Further Study: 
Minimize the docker image: [Multiple Stage Builds](https://docs.docker.com/develop/develop-images/multistage-build/)

Hosting Multiple containers: [docker-compose](https://docs.docker.com/compose/)

