## Vagrant stuff
[Vagrant](https://www.vagrantup.com) is a tool that makes it easy to work with [Virtual Machines](https://en.wikipedia.org/wiki/Virtual_machine) (often called a VM) on your laptop.

We use [Virtual Box](https://www.virtualbox.org/) to allow our laptop to emulate one (or more) VMs, and we use Vagrant to manage Virtual box.

Vagrant allows us to describe the exact environment we want in our VM: the host OS to use, software to be installed, how much memory to allocate, etc.

### Installation and learning
1. Install VirtualBox https://www.virtualbox.org/
2. Install Vagrant https://www.vagrantup.com/downloads.html
3. Work through the Vagrant tutorial https://www.vagrantup.com/docs/getting-started/
4. Read up on Vagrant https://www.vagrantup.com/docs/
5. Clone this repository
```bash
cd ~/Documents
git clone git@github.com:davidwilliamson/vagrant-files.git
```

### Usage
Open a terminal window

*NOTE* From the terminal, you can type `vagrant help` to see all available commands

*NOTE* The easiest way to use Vagrant is to send vagrant commands from the directory where the `Vagrantfile` is located.

```bash
# cd to this directory
cd ~/Documents/vagrant-files
cd ubuntu-14-04
```
Check out the `Vagrantfile` in this directory. Some things you may want to change:

The line `config.vm.synced_folder "~/Documents", "/Documents"` will make all files in your Mac's `/Users/<your-user-name>/Documents` folder available inside the VM. You may want to change this so only your programming stuff (git repos, etc.) are available inside the VM.

For example, if your programming stuff is located at `/Users/<your-user-name>/Documents/codist`,
then change the line to be: `config.vm.synced_folder "~/Documents/codist", "/codist"`

Now, checkout the `bootstrap.sh` file in this directory. We use this file to install additional
packages in our VM.

*Note*: If you just want to create a VM with nothing additional installed, comment out either or both of the lines:
```bash
config.vm.provision "docker", images: ["alpine:3.4", "ubuntu:14.04"]
config.vm.provision :shell, path: "bootstrap.sh"
```

*NOTE* The first time you start the VM, it will need to install all the packages you defined in `bootstrap.sh`. To do that, you need to have an internet connection.

```bash
# Start the VM
vagrant up
# Use SSH to log in to the VM
vagrant ssh
# Congratulations! You are now running inside a virtual Linux machine on your mac.
```
Let's send some Linux commands from inside the VM
```bash
# Get the Linux version we are running
lsb_release -a
# I can haz docker!
docker version
docker images
# Run the docker https://hub.docker.com/r/docker/whalesay/ image
docker run docker/whalesay cowsay boo
```
Create a simple web site and run it via docker from inside our VM
```bash
# cd to whatever directory we are sharing with our Mac.
cd /Documents
mkdir toy-web-site
echo '<html>Hello from Vagrant</html>' > index.html
docker run --name my-web-server -v /Documents/toy-web-site:/usr/share/nginx/html:ro -p 80:80 -d nginx
```
Point your browser to http://localhost:8080/

On the Mac, locate the `toy-web-site` folder, and modify the HTML in the `index.html` file if you want. Hit refresh in your browser and see the changes.

Then, back in the terminal window of our VM:
```bash
docker stop my-web-server
docker rm my-web-server
```
To get out of the VM and back to your Mac environment
```bash
exit
```
*Note*: The VM is still running. You can leave it running, just like any other Mac Application. It will consume battery life though.

To see if any VMs are running:
```bash
vagrant status
```
To shut down a VM
```bash
# Similar to powering off a traditional computer.
# All files, etc. in the VM are preserved
vagrant suspend
# Similar to powering off a traditional computer and wiping its hard drive.
# All files in the VM are lost.
vagrant destroy
```
If you change your `Vagrantfile` or the `bootstrap.sh` file, do this to force the VM to use the new definition:
```bash
vagrant reload
```

### Tips to keep in mind
1. The VM does not have a GUI running. So trying to run an Integrated Development Environment like [Netbeans](https://netbeans.org/) or [Eclipse](http://www.eclipse.org/) won't work.
2. Compiled programs (like a C++ program) are specific to the host OS where they were compiled. That is, compiling a C++ program in your Mac environment and trying to run it from within the VM won't work. Similarly, compiling the C++ program inside the VM and trying to run it outside the VM in your Mac environment won't work.
3. VirtualBox has its own App for managing VMs. It does not seem to play nicely with Vagrant all the time. Avoid having the VirtualBox app running while trying to work with Vagrant.
