#!yaml|gpg
docker:
  containers:
    nodewatcher-fileserver:
      image: wlanslovenija/scp-server
      environment:
        - FILESERVER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdYZ2aofSRmnQnRA7BKbfezCE6Gq8sczrbyBbcqh+LACC42yDchDcTOID7WQX1gcjznv2iA1vdIPdhKQf8Ppx//RrRHkzV66z2vanGQcUAqIBFBXcAw3HcdFUrLDnvG+KsHXaMzfUZ04mW6F5T31Ex8sx+J8thJNXOBUZn8Vni3gFf3Fo5zmVN/MbdrOdbtcAKEx1BgFt1gEJdSoFIg9T27oKcnajxgB30gVCBF4/ymTR6o5WL/VgQMf/mwj+hZOhm9LuI4xxNeNFw4JnUrY3nxQuAxXSNOXv31N/26EgqhhoPNdXVGT6yN4W1Yfnj/l157RpBs0uwx9xln8R6R2qH nodeupgrade@host
      network_mode:
        type: container
        container: mesh-network
      volumes:
        /srv/storage/nodewatcher/fileserver-keys:
          bind: /etc/ssh/keys
          mode: 700
        /srv/storage/nodewatcher/media:
          type: other
          bind: /readonly/files
          readonly: true
