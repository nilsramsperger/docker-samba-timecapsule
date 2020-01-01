# docker-samba-timecapsule

A Docker image to create a Samba based TimeCapsule for macOS

## Description

This image contains a Samba file server configured to act as a TimeCapsule for macOS devices.
The image is compiled to work on ARM (arm7hf) devices.

## Setup
### Creating the container

To create a container from this image, use the following command.

```docker create --init --name samba-timecapsule --restart unless-stopped -v tc-data:/var/data/timemachine -v tc-samba-users:/var/lib/samba/private -v tc-sys-users:/etc -p 139:139 -p 445:445 nilsramsperger/samba-timecapsule```

Start the container by issuing ```docker start samba-timecapsule```.

### Configuring users

Before you can use the TimeCapsule, a user has to be created for every Mac you want to connect.
First tap into the container.
```docker exec -it samba-timecapsule ash```

Then add users.
```addBackupUser username```

The script will ask you for the new user's password, which has to be entered twice.
Repeat for more users.

### Connect from a Mac

Since the container has no Avahi deamon running, you will have to connect to the server manually before you can use it as a TimeMachine target.
After that TimeMachine should reconnect by itself automatically.

## Volumes

* ```/var/data/timecapsule``` holds the user directories with backup data.
* ```/var/lib/samba/private``` contains the samba user databases.
* ```/etc``` is put into a volume to persist system users.

### Known Issues

* Quota is set to 300GB but not working
