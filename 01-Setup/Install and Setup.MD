## Installation and Setups

#### Configuration Instructions
* Install Virtualbox and load the VM image
* Make sure that you have a working internet connection (ideally without proxy) and the Virtualbox VM has 'NAT' an an option setup. 
* Assign ATLEAST 12070 MB RAM to the VM
* Assign ATLEAST 24 MB to the Video Memory
* Assign 2 Virtual CPU to the VM


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

There would be a few mini-labs/assignments during this workshop. These assignments would require that the following pre-requisites are met:

* Cloudera Enterprise Manager (Trial) Version setup and working
* Kakfa Installation - By default not installed. We will install this during the Kafka Lab
* Kudu Installation - By default not installed. We will install this during the Kudu Lab

### Download the configuration and sample data files
