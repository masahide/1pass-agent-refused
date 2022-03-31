# 1pass-agent-refused
Reproduction code for 1password ssh-agent with error connecting to sshd on centos6


# Reproduction procedures

The following operation can be reproduced on MacOS.

1Password Version
```
1Password for Mac
Version 8.7.0-30.NIGHTLY
```

```bash
git clone https://github.com/masahide/1pass-agent-refused.git
# build centos6 sshd image
cd 1pass-agent-refused
docker build . -t testssh

# generate rsa 4096bit key
ssh-keygen -t rsa -b 4096 -q -C '' -N '' -f ./test.id_rsa 
chmod 600 test.id_rsa*

# Start sshd on port: 10022
docker run  --rm -p 10022:22  -v $(pwd)/test.id_rsa.pub:/root/.ssh/authorized_keys testssh /usr/sbin/sshd -d

```

Try ssh connection from another console
```bash
# Verify connection with local key
ssh -i test.id_rsa root@localhost -p10022 hostname

# Register the generated private key "test.id_rsa" to 1password

# Check if the private key is loaded by ssh-add command
ssh-add -l

# Try ssh connection using 1password and reproduce the error
ssh root@localhost -p10022 hostname
sign_and_send_pubkey: signing failed: agent refused operation
```
