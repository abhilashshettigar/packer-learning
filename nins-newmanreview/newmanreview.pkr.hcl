packer {
  required_plugins {
    amazon = {
      version = "1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "nodeDocker" {
  ami_name = "newmanreview-${local.timestamp}"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  instance_type = "t3.small"
  region        = "ap-south-1"
  ssh_username  = "ubuntu"
}

build {
  sources = [
    "source.amazon-ebs.nodeDocker"
  ]

  provisioner "shell" {
    script = "../scripts/installDockerNginx.sh"
  }
  

}