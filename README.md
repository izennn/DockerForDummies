# **Getting Started with Docker**

A quick getting-started guide to incorporating docker, the **Dayta AI** way

### **For the ML team**, all you really need to know is that a program with a dockerfile can be ran on any host OS, given that Docker is installed on the host machine.

Once the program is pulled, run `docker build` to build a docker container, then `docker run` to deploy the newly made app onto docker engine

#### Quick note on `run` vs `compose`

`docker run` *runs processes in isolated containers.* When `docker run` is executed, it is *isolated* in the sense that it has its own file system, its own networking, and its own isolated process tree separate from the host. More defailed description of `docker run` can be found below

**You will *not* need to use `docker compose`, as it will be handled by Kubernetes.** 
`docker compose` is a tool for *defining and running multi-container Docker applications.* You set up the configuration for your application's services in the docker-compose yaml file.

## **Some Basics**
1. List existing docker containers<br>
    `docker ps [OPTIONS]`<br>

    OPTIONS:
    - `-all, -a`: show all containers (default only shows running containers)<br>
    - `-f or --filer [key=value]`: filter output by keys `id`, `name`, `label`, etc.

2. Manage docker containers<br>
    `docker container [COMMAND]`<br>

    COMMANDS: 
    - `ls`: list containers<br>
    - `create`: create a new container<br>
    - `port`: list port mappings or specific mapping for the container<br>
    - more commands can be found at the [official website](https://docs.docker.com/engine/reference/commandline/container/)

3. Manage docker images<br>
    `docker image [COMMAND]`<br>

    COMMANDS: 
   - `ls`: list images<br>
   - `build`: build container from dockerfile<br> 
   - `rm`: remove one or more images<br> 
   - more commands can be found at the [official website](https://docs.docker.com/engine/reference/commandline/image/)

## **docker build**
    
    docker build [OPTIONS] PATH | URL | -


## **docker run**

    docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]

1. **Running docker image using CPU**

   1. Run with `docker` (image: `okwrtdsh/anaconda3:keras-cpu`)<br>
   
        `$ docker run -v $(pwd):/src/notebooks -p 8888:8888 -td okwrtdsh/anaconda3:keras-cpu`
   2. Open `localhost:8888` in web browser

2. **Running docker image using GPU**

    1. Run with `nvidea-docker` (image: `okwrtdsh/anaconda3:keras-10.0-cudnn7`)<br>
   
        `$ nvidia-docker run -v $(pwd):/src/notebooks -p 8888:8888 -td okwrtdsh/anaconda3:keras-10.0-cudnn7`
    2. Open `http://localhost:8888` in web browser

3. **Mounting host files onto container**

    `docker run -v [field1:field2:field3]`

   - `field1`: in the case of bind mounts, the first field is the path to the file or directory on the host machine<br>
   - `field2`: path where the file or directory is mounted in the container<br>
   - `field3`: (optional) comma-separated list of options, such as `ro`, `cached`<br>

    ***NOTE: On OSX, you need to use the full absolute path for the host container***<br>
    > E.g. "/Users/name/Desktop/sites/src:target" instead of the relative path "src:target" instead of the relative path src/<br>

    Detailed documentation can be found [here](https://docs.docker.com/engine/reference/run/)

## **Accessing the shell in a running container**

   1. Use `docker exec -ti <container name> /bin/bash` to get a bash shell in the container
   2. Use `docker exec -it <container name> <command>` to execute whatever command you specify in the container

