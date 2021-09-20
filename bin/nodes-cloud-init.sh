#! /bin/bash
# Cloud Init Script: Django 
# Objective:
# Install a master node of k3s

# Vars
DOCKER_USER=ubuntu
DOCKER_APPS_DIR=/apps/
DOCKER_LIST_OF_APPS=['wordpress']

# OS Updates
sudo apt update
sudo apt upgrade -y


# Docker
#
# Install dependencies
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Install k3s
curl -sfL https://get.k3s.io | sh -
