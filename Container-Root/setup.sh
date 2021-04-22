#!/bin/sh

if [ -d /etc/apt ]; then
        [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"${http_proxy}\";" > /etc/apt/apt.conf; \
        [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"${https_proxy}\";" >> /etc/apt/apt.conf; \
        [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf
fi

# Install basic tools
apt-get update
apt-get install -y curl wget vim htop jq git software-properties-common sudo

# Install kubectl
curl -L -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin
kubectl version --client

# Install kubectx
pushd /tmp
git clone https://github.com/ahmetb/kubectx
mv kubectx /opt
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
popd

# Install kubeps1 and customize .bashrc
curl -L -o /etc/kube-ps1.sh https://github.com/jonmosco/kube-ps1/raw/master/kube-ps1.sh

cat << EOF >> /etc/bash.bashrc
alias ll='ls -alh --color=auto'
alias kon='touch /tmp/.kubeon; source /etc/bash.bashrc'
alias koff='rm -f /tmp/.kubeon; source /etc/bash.bashrc'
alias k='kubectl'
alias kctl='kubectl'
alias kc='kubectx'
alias kn='kubens'
alias kt='kubetail'
if [ -f /tmp/.kubeon ]; then
        source /etc/kube-ps1.sh
        export PS1="\[\e[0;37m\]\t \[\e[0;32m\]\u\[\e[0;32m\]@\[\e[0;32m\]\h \$(kube_ps1) \[\e[0;36m\]\w \[\e[0m\]\$ "
else
        export PS1="\[\e[0;37m\]\t \[\e[0;32m\]\u\[\e[0;32m\]@\[\e[0;32m\]\h \[\e[0;36m\]\w \[\e[0m\]\$ "
	
fi
EOF

cat << EOF > /root/.bashrc
source /etc/kube-ps1.sh
source /etc/bash.bashrc
EOF

# Install kubetail
curl -L -o /tmp/kubetail https://raw.githubusercontent.com/johanhaleby/kubetail/master/kubetail
chmod +x /tmp/kubetail
mv /tmp/kubetail /usr/local/bin/kubetail

