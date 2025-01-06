#!/bin/bash

sudo yum update -y
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
EOF

sudo yum install -y kubectl

sudo wget --content-disposition https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64/
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64


sudo systemctl enable --now kubelet
sudo kubeadm init --apiserver-advertise-address=10.0.1.204 --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl get nodes




#kubectl create secret generic mysql-secret --from-literal=mysql-root-password=<your-password>


#git clone
#build/get from repo
# kubectl apply -f mysql-deployment.yaml
# kubectl apply -f mysql-service.yaml
# kubectl apply -f flask-deployment.yaml
# kubectl apply -f flask-service.yaml