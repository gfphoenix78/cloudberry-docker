#!/bin/bash

# Generate RSA host key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""

# Generate ECDSA host key
ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""

# Generate ED25519 host key
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

# Start sshd service
#/usr/sbin/sshd

# Step 1: Create gpadmin user and set password
useradd -m -s /bin/bash -r gpadmin

# Step 2: Configure sudo without password for gpadmin
echo "gpadmin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Step 3: Switch to gpadmin user
su - gpadmin << 'EOF'

# Step 4: Generate SSH key
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" -C "gpadmin@localhost"

# Step 5: Add SSH key to authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

# Step 6: Get local IP addresses and add them to known_hosts
# LOCAL_IPS=$(hostname -I)
# for IP in $LOCAL_IPS
# do
#     ssh-keyscan -H $IP >> ~/.ssh/known_hosts
# done

# Step 7: Test SSH connection (optional)
# ssh gpadmin@localhost
# for IP in $LOCAL_IPS
# do
#     ssh gpadmin@$IP
# done

EOF
