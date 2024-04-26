##Credit https://gist.github.com/subfuzion/90e8498a26c206ae393b66804c032b79
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common git python3-pip 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88 | grep docker@docker.com || exit 1
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo docker run --rm hello-world
##Moar
DOCKER_COMPOSE_VERSION=$(curl -sL https://github.com/docker/compose/releases/ |grep -i releases/download/|cut -d"/" -f6|awk '!a[$0]++')
sudo curl -sL "https://github.com/docker/compose/releases/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
git clone https://github.com/CTFd/CTFd.git

##Still Moard
#cd ~
#https://github.com/mwilco03/docker-ddclient.git
#cd ddclient/

#sudo docker run mwilco03/ddclient
