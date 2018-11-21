## Installation and Setups

#### Configuration Instructions
* Install Virtualbox and load the VM image
* Make sure that you have a working internet connection (ideally without proxy) and the Virtualbox VM has 'NAT' an an option setup. 
* Assign ATLEAST 12070 MB RAM to the VM
* Assign ATLEAST 24 MB to the Video Memory
* Assign 2 Virtual CPU/Cores to the VM

--
#### Optional - Only if you are using Virtualbox ####
--
#### Setup a Shared folder to copy files to/from the VM Instance

**Share a folder on the host OS**  
* In VirtualBox, click your OS on the left and click on Settings.  
* Click on the Shared Folders tab.  
* Click on the folder with the plus on the right.  
* Browse to a folder of your choice in the folder path.  
* Enter a folder name with no spaces e.g. “Share”.  
* Check Auto-mount and Make Permanent, if available.  
* Click on OK.  

**Mount the folder in the guest OS**  
* Create a folder in your guest OS that you want to share.  
* Open up Terminal.  
* Type in `id` and press ENTER— remember that ID.  
* Switch to the root user using `sudo su` and enter your password.  
* Browse to the etc folder using `cd /etc`.  
* Edit the `rc.local` file using `vi rc.local`.  
* Move your cursor right above exit 0 and press the letter “i” on your keyboard to insert text.  
* Type in the following: `sudo mount -t vboxsf -o uid=1000,gid=1000 Share /home/username/Documents/Share`

- 1000 should match the ID you noted down earlier.  
- Share should match the folder name from step 1.  
- username should match your Linux username.  
- /Documents/Share should be the absolute path of the new folder you created.  
* Now hit “ESC”, type :wq and hit ENTER to save and quit the file editing.  

After you restart the guest OS, your shared folder will be automatically mounted. 
Original article on how to set this up [here](https://ryansechrest.com/2012/10/permanently-share-a-folder-between-host-mac-and-guest-linux-os-using-virtualbox/)

### Using AWS Image instead of the Virtualbox Instance

* You can leverage an AMI image made available on AWS, which is a clone of the Cloudera QuickStart 5.13 VM. Please note that this may involve charges on AWS for running this instance for the duration of the workshop. 

Instructions for the AWS Setup are available [here](https://github.com/rajatrakesh/bigdatalab/blob/master/01-Setup/AWS%20Setup.MD)

### Pre-Setup for Lab

While it is preferred that there is a good internet connection available to all participants during the course of the lab, as there would be downloads required for installing various packages. If the same is not available, there is an option for pre-downloading certain packages before starting with the labs. The following steps would be required:

* Start the VM image (No other services need to be started for this exercise)
* Make sure that the VM image is able to access internet from the VM itself using the browser. We would be downloading approximately 1 GB of data
* Open a terminal window and type the following

		cd /etc/yum.repos.d
		sudo yum install kafka kafka-server --downloadonly
		sudo wget archive.cloudera.com/kudu/redhat/6/x86_64/kudu/cloudera-kudu.repo
		sudo yum install kudu kudu-master kudu-tserver --downloadonly
		sudo yum install telnet-server telnet --downloadonly
		sudo yum install python-pip --downloadonly
		
****Note: Updated 21 Nov 2018***

* There could be scenarios where you might run into issues with one/few of the downloads, esp. if there are issues with one of the repo files in the repos.d folder. Use the following instructions below, in case you experience mirror or download issues. 

Most of the times this tends to happen if any of the repo files have an issue. This can be checked by the following commands

		cd /etc/yum.repos.d
		sudo yum repolist all

		repo id                 repo name                                         status
		base                    CentOS-6 - Base                                    6713
		cloudera-cdh5           Cloudera's Distribution for Hadoop, Version 5       153
		cloudera-gplextras5     Cloudera's GPLExtras, Version 5                       0
		cloudera-kafka          Cloudera's Distribution for kafka, Version 2          4
		cloudera-kudu           Cloudera's Distribution for kudu, Version 5           6
		cloudera-manager        Cloudera Manager, Version 5                           7
		epel                    Extra Packages for Enterprise Linux               12498
		extras                  CentOS-6 - Extras                                    33
		updates                 CentOS-6 - Updates                                  233

In this case, the easiest option is to disable the repo with status 0. We can do this by enabling the following commands:

		cd /etc/yum.repos.d
		sudo mv cloudera-gplextras5.repo cloudera-gplextras5.repo.bk
		
This will renamed the gplextras file to backup. We can now execute the commands properly. 

		cd /etc/yum.repos.d
		sudo yum install kafka kafka-server --downloadonly
		sudo wget archive.cloudera.com/kudu/redhat/6/x86_64/kudu/cloudera-kudu.repo
		sudo yum install kudu kudu-master kudu-tserver --downloadonly
		sudo yum install telnet-server telnet --downloadonly
		sudo yum install python-pip --downloadonly
		
-- 

### Download the configuration and sample data files

The config and data files are available on S3. The instructions for downloading the files would be provided during the workshop. After receiving the files, upload the zip into your VM/AWS instance in the downloads directory. Then execute the following:

	** command to download the zip file would be provided during the workshop **
	unzip bigdatalab.zip

This will create the necessary directories and setup all the required scripts, data files and configuration files for our assignments.

### Start-up sequence

The instructions for the start-up sequence and final checks are available [here](https://github.com/rajatrakesh/bigdatalab/blob/master/01-Setup/Startup.MD)

### End of Setup
