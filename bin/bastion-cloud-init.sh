#!/bin/sh

#! /bin/bash
# Cloud Init Script: Bastion box 
# Objective:
# Connecto to machines internally for debugging purposes

cat << EOF > /home/ubuntu/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
Why should you care about what's in here
-----END RSA PRIVATE KEY-----
EOF

sudo chmod 400 /home/ubuntu/.ssh/id_rsa
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
