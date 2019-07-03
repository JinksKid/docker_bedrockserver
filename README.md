# Minecraft Server (Bedrock) for Docker

A Docker image and docker-compose file to run one or more instances of a native Minecraft Bedrock server using codehz/mcpeserver in an ArchLinux environment wth systemd.


## Prerequisites

- Docker
- docker-compose (if you want to use the instructions for  multiple servers)

## Instructions

### Single-server / New world

*To build/run a single server with a new world on the host:*

1. Pull the docker image.

```
docker pull jinkskid/docker_bedrockserver
```

2. Start the docker container.

```
docker run -d --network="host" jinkskid/docker_bedrockserver
```

```
docker run -d --network="host" -v worlds:/srv/bedrockserver/worlds karlrees/docker_bedrockserver
```


```
docker run -d --network="host" -v /path/to/worlds/folder:/srv/bedrockserver/worlds karlrees/docker_bedrockserver
```


### Single-server / Existing world

*To build/run a single server using a pre-existing Bedrock world folder:*

1. Create (or locate) a parent folder to store (or that already stores) your Minecraft worlds.  We'll refer this folder subsequently as the parent "worlds" folder.
2. Locate the "world" folder that stores the existing Minecraft world data for the world you wish to serve.  This may or may not be named "world", but we'll refer to it subsequently as the "world" folder.
3. Save the "world" under the parent "worlds" folder (if needed, using a different name to your liking).
4. Create or locate a server.properties file for your world (see the example server.properties.template if you don't have one).
5. Save the server.properties file as "worldname.properties" in the *"worlds"* folder, where worldname is the name of your "world" folder.
6. Change the level-name attribute value from "world" to "worldname" (or whatever your "world" folder is named)
7. Start docker container as shown below, replacing "worldname" with whatever your "world" folder is named, and "/path/to/world/folder" with the absolute path to your parent worlds folder:

```
docker run -e WORLD=worldname -v /path/to/worlds/folder:/srv/mcpeserver/worlds -d --network="host" jinkskid/docker_bedrockserver
```

### Multiple existing worlds / docker-compose

*To run multiple servers using multiple pre-existing Bedrock worlds, each running at a separate IP address:*

1. Download the source code from git

```
git clone https://github.com/jinkskid/docker_bedrockserver
```

2. Complete steps 1-6 above, using the worlds folder in the source code as the parent "worlds" folder.  Repeat steps 3-6 for each world you wish to serve.
3. Edit the ENV file as needed (e.g. change the IP Prefix to match your subnet, eth0 to match your network interface, etc.)
4. Edit the docker-compose file to include a separate section for each server.  Be sure to change the name for each server to match what you used in step 2.  Be sure to use a different IP address or each server as well.
5. Run docker-compose

```
docker-compose up -d
```



## Known Issues

Because of Windows permission difficulties, mounting external volumes for Minecraft worlds does not appear to work when using a Windows host.
