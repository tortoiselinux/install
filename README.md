# Tortoise install Script

The goal of this project is to create a flexible installer
for Tortoise purposes. The current implementation of the 
installer is done in Shell script and has several features 
to speed up the installation process.

The process is divided into two steps: 
configuration and installation.

Rationale:

Dividing the process into separate steps is good, in the sense 
that you can, if you wish, extract the configurator from the 
installer structure. All that is needed is to supply its 
dependencies, which so far only exist internally, such as the 
<lib.sh> file, and then the installation configuration can be 
done even before obtaining an ISO of the system. This ready-made 
file can then be inserted into the ISO by modifying the profile, 
generating a new ISO by the user or simply using a USB stick.

## The installation process

To start the configuration, simply type with sudo permissions:

configure

If you already have a file ready, simply use the <file> flag

configure -f ./<path/to/configuration/file>

If you do not provide a configuration file, the installer will 
ask questions about the aspects of the desired system and will 
generate the `install.conf` file in the HOME directory

After that, simply run the installer and all the work will be done.

Also with sudo permissions, run:

egginstall

After that, if no errors are displayed, you will be asked if 
you want to restart and the installation will be complete.


## deploying on a archiso profile

The installer implements the FHS, so all files related to the 
installer must be in the respective locations specified by the 
standard. To do this easily, there is already a section in the 
`Makefile` that automates this task.

First, copy the installer into the directory where your profile 
is located, following the same directory pattern used in `mkiso.sh`

Now run:

make prepare

WARNING: always check if everything was generated correctly, no 
one deserves to have to generate an ISO over and over again 
(personal experience).
