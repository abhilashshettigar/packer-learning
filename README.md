# Format packer files 
packer fmt .

# Validate packer file
packer validate .

# Build packer image
packer build <filename>




# What blocks we need to add and how it works 


packer {
    # we are using aws & need to provide provider for mutiple which cloud we are using like aws,GCP and azure or even docker
}

source {
    # which ami to use as the base
    # where to save the ami 
    # basically it will create ec2 to build a ami 
}

build {
    # everything in between once ami is creating 
    # like what things need to install in ami
    # what things to configure 
    # need to copy anything or automate using provisioner  with ansible ,puppet and chef
}