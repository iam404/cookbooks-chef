name             "unattended-upgrades"
maintainer       "Prabuddha"
maintainer_email "mail@prabuddha.me"
license          "MIT"
description      "Installs/Configures unattended-upgrades"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

supports "ubuntu"

depends "apt"

provides "unattended-upgrades"
