Example cs cluster scripts for incomming MSc students.

## Prerequisites:
- Access to a cluster account through https://hpc.cs.ucl.ac.uk/account-form/
- Optionally, storage through: https://hpc.cs.ucl.ac.uk/storage-form/
- If you don't want to jumphost, access to a VPN.

## SSHing to the Cluster
Jumping through knuckles:
```
ssh -J csuname@knuckles.cs.ucl.ac.uk csuname@beaker.cs.ucl.ac.uk
```
Or though VPN:
```
ssh csuname@beaker.cs.ucl.ac.uk
```

All commands below are run on a login node, in this case it's ```beaker```. You can't (an you wouldn't want to) run computation on these nodes, but you can schedule jobs.

## Installing Miniconda

You have limited space in your home directory, both in size and quantity of files. Full fat anaconda will be too expensive (loads of potentially useless packages), install miniconda instead:

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh;
chmod +x Miniconda3-latest-Linux-x86_64.sh;
./Miniconda3-latest-Linux-x86_64.sh;
```

## Your First Script

Let's run a simple script that will run a python file in your code directory. First make a directory in your home called ```runLog```.

The python script, let's call it ```mscPythonTestScript.py```, is just a simple hello-world: 

```print("Hello from beyond!")```

See the included qsub file, ```mscTuturialTestScript.qsub.sh```. It has comments for what every line means.

Schedule the script via: 

```qsub mscTuturialTestScript.qsub.sh```

See an output file in ```~/runLog```!

```Copying Data```
Storing data in your home directory is a nono. Accessing data in your home directory from a node is a bigger nono. You'll get mad emails asking why you did that. Instead, copy any data you need to the node where the processing happens. Here's a handy script:

```
#!/bin/bash

UNIQUEID=$(uuidgen)
UNIQUEID=${UNIQUEID:0:13}

mkdir /scratch0/YOUCLUSTERNAME/
BASEDIR="/scratch0/YOUCLUSTERNAME/"

COPYDIR="${BASEDIR}${UNIQUEID}/"
mkdir $COPYDIR

rsync -ar --info=progress2 /home/YOUCLUSTERNAME/datasets/testData.zip $COPYDIR

cd $COPYDIR

unzip -q testData.zip
rm testData.zip
```

Your python script should read from this directory. Here's an example of what that looks like in ```mscPythonReadTestScript.py```

```
import sys

print("Hello from beyond!")


print("Here's your data:")
file = open(sys.argv[1] + '/testData.txt', 'r')
Lines = file.readlines()
print(Lines[0]) 
```

Your qsub file should now call the script to copy your data and launch your python script with the correct directory where your data is copied. See ```mscTuturialCopyDataTestScript.qsub.sh``` for what this looks like.

## Misc
Handy tool for pretty printing status:

```qstat -ext -xml | tr '\n' ' ' | sed 's#<job_list[^>]*>#\n#g'   | sed 's#<[^>]*>##g' | grep " " | column -t```

Interactive Session with one GPU:

```qrsh -l tmem=2G,gpu=true,h_rt=00:05:00,tscratch=70G -pe gpu 1```


### References
https://hpc.cs.ucl.ac.uk/quickstart/
https://hpc.cs.ucl.ac.uk/full-guide/
https://hpc.cs.ucl.ac.uk/data-storage/ 



