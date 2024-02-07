--Networking
https://www.youtube.com/watch?v=cUGXu2tiZMc
https://github.com/RX-M/kubecon-eu-2022/blob/main/rx-m-net-101-kubecon-eu-2022.md
todo: migrate to cilium https://isovalent.com/blog/post/tutorial-migrating-to-cilium-part-1/


--CMD
--Networking
sudo iptables -n -t nat -L KUBE-SERVICES
nc -zv master-node 6443
telnet master-node 6443
ufw allow 6443
ip link
ip addr
ip route
arp
nslookup
dig
ps -aux | grep <service-name>


https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf

--docker for k8s
crictl ps


--kube init 
sudo kubeadm init --control-plane-endpoint=master.olo --pod-network-cidr=10.244.0.0/16 #--ignore-preflight-errors=Mem
https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/?utm_content=cmp-true

--SET UP CLUSTER ON VirtualBox, full cmd
apt install openssh-server
ufw ssh
ufw 22

master:
Set hostname on Each Node
$ sudo hostnamectl set-hostname "k8smaster.example.net"
$ exec bash
On the worker nodes, run
$ sudo hostnamectl set-hostname "k8sworker1.example.net"   // 1st worker node
$ sudo hostnamectl set-hostname "k8sworker2.example.net"   // 2nd worker node
$ exec bash
Add the following entries in /etc/hosts file on each node
192.168.1.173   k8smaster.example.net k8smaster
192.168.1.174   k8sworker1.example.net k8sworker1
192.168.1.175   k8sworker2.example.net k8sworker2

Disable swap & Add kernel Parameters
$ sudo swapoff -a
$ sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

$ sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
$ sudo modprobe overlay
$ sudo modprobe br_netfilter

$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOT
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOT

$ sudo sysctl --system

3) Install Containerd Runtime

$ sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

$ sudo apt update
$ sudo apt install -y containerd.io

$ containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
$ sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

$ sudo systemctl restart containerd
$ sudo systemctl enable containerd

 Add Apt Repository for Kubernetes

$ curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
$ echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

Install Kubectl, Kubeadm and Kubelet
$ sudo apt update
$ sudo apt install -y kubelet kubeadm kubectl
$ sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --control-plane-endpoint=k8smaster.example.net --pod-network-cidr=10.244.0.0/16

$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

$ kubectl cluster-info
$ kubectl get nodes

Join Worker Nodes to the Cluster

sudo kubeadm join k8smaster.example.net:6443 --token vt4ua6.wcma2y8pl4menxh2 \
   --discovery-token-ca-cert-hash sha256:0494aa7fc6ced8f8e7b20137ec0c5d2699dc5f8e616656932ff9173c94962a36

 Install Calico Network Plugin

$ kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

$ kubectl get pods -n kube-system





--https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/?utm_content=cmp-true


-- RASP PI 3 FULL SETUP K8S --
--- FILE ---
OS should be 64bit
ssh : empty
userconf : user:$6$TBxbQapIUak2cqA4$n4G6Oh7eZeelVJD.Llv.kYZsQlm.wBRgzqX5EozwmErMan2paTxqlYAPg6uGino6xcCzThj0fyJl7dDM7gFyM0
--- HOSTS ---
ssh-keygen -R <ip>
ssh master@192.168.43.131
ssh node1@192.168.43.159
ssh node2@192.168.43.120

--FOR MASTER & NODE'S
sudo apt update && sudo apt upgrade -y
echo " cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1" | sudo tee -a  /boot/cmdline.txt
sudo reboot

--FOR MASTER
RANCHO !!! https://www.youtube.com/watch?v=rOXkutK8ANc&t=1341s
https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | sh -
get token:
sudo cat /var/lib/rancher/k3s/server/node-token
K10e2c66ec5b1280ad87d516f3a1bb0a0b8e9bc613650a31a701fd974559aabf267::server:a61213aadc28b630c196e8b89ab8fbf1

--FOR NODE'S
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.43.131:6443 K3S_TOKEN=K10e2c66ec5b1280ad87d516f3a1bb0a0b8e9bc613650a31a701fd974559aabf267::server:a61213aadc28b630c196e8b89ab8fbf1 sh -

sudo curl -fsSLo /usr/share/keyrings/kubernetes.gpg https://dl.k8s.io/apt/doc/apt-key.gpg 
echo "deb [signed-by=/usr/share/keyrings/kubernetes.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

--- MASTER ---

https://www.youtube.com/watch?v=C-KpunFLMcc

-- K8S UPGRADE VERSION --
apt-get update

sudo apt update

k drain controlplane --ignore-daemonsets 

apt-cache madison kubeadm |head

sudo apt install kubeadm=1.28.2-*

sudo kubeadm upgrade apply v1.28.2

sudo apt install kubelet=1.28.2-00

sudo systemctl restart kubelet

k uncordon controlplane 


-- RESTORE ETCD --
-- backu
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save etcd-b.db
-- restore
ETCDCTL_API=3 etcdctl --data-dir /var/lib/etcd2 snapshot restore etcd-b.db
sudo systemctl restart kubelet

RASBERY-PI
ssh node1@ip
find ip in win: arp -a 
C:\Users\onekrasov\.ssh\known_hosts
 ssh node1@192.168.43.159
 ssh node2@192.168.43.120
ssh master@192.168.43.131
PAS: 12345 ;)

--to do Node IsNOT READY

UPGRADE VERSION 
apt-get update
sudo apt update
k drain controlplane --ignore-daemonsets 
apt-cache madison kubeadm |head
sudo apt install kubeadm=1.28.2-*
sudo kubeadm upgrade apply v1.28.2
sudo apt install kubelet=1.28.2-00
sudo systemctl restart kubelet
k uncordon controlplane 

RESTORE ETCD
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save etcd-b.db
ETCDCTL_API=3 etcdctl --data-dir /var/lib/etcd2 snapshot restore etcd-b.db
sudo systemctl restart kubelet

RASBERY-PI
ssh-keygen -R <host>
ssh node1@ip
find ip in win: arp -a 
C:\Users\onekrasov\.ssh\known_hosts
 ssh node1@192.168.43.159
 ssh node2@192.168.43.120
ssh master@192.168.43.131
PAS: 12345 ;)

set ip hostname in /etc/hosts

--install https://www.youtube.com/watch?v=C-KpunFLMcc 2:09:41

--PROBLEM SLN
// Download the Google Cloud public signing key:

sudo curl -fsSLo /usr/share/keyrings/kubernetes.gpg https://dl.k8s.io/apt/doc/apt-key.gpg <<!!! TO !! ;))
echo "deb [signed-by=/usr/share/keyrings/kubernetes.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 234654DA9A296436
https://itsfoss.com/solve-gpg-error-signatures-verified-ubuntu/ <<!!!

https://dl.k8s.io/apt/doc/apt-key.gpg
https://dl.k8s.io/apt/doc/apt-key.gpg

 sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=Mem

systemctl restart docker
Let’s check the docker service status:
systemctl status docker -l



apt update

apt install containerd.io

sudo rm /etc/containerd/config.toml

systemctl restart containerd

 sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=Mem

--for my nodes will needed
kubeadm join 192.168.43.131:6443 --token cvwuen.ie6344crspcjbnz2 \
        --discovery-token-ca-cert-hash sha256:7fa1de54fcda013431c3eaa528351c58dc08a592bda371ec1bc7f9b7aec5c39b
 kubeadm token create --print-join-command --ttl=0
kubeadm join 192.168.43.131:6443 --token 9nyfoa.su1i44grrifaivx5 --discovery-token-ca-cert-hash sha256:7fa1de54fcda013431c3eaa528351c58dc08a592bda371ec1bc7f9b7aec5c39b

dziala:trzeba dokonca przejc https://medium.com/karlmax-berlin/how-to-install-kubernetes-on-raspberry-pi-53b4ce300b58
TODO: od nowa jeszcze raz zrob ... i spisz

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

https://medium.com/karlmax-berlin/how-to-install-kubernetes-on-raspberry-pi-53b4ce300b58
https://alexsniffin.medium.com/a-guide-to-building-a-kubernetes-cluster-with-raspberry-pis-23fa4938d420

-- TRUBLE ANALYSE --
 kubectl get componentstatuses
