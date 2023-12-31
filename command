--Networking
https://www.youtube.com/watch?v=cUGXu2tiZMc
https://github.com/RX-M/kubecon-eu-2022/blob/main/rx-m-net-101-kubecon-eu-2022.md
todo: 
https://www.youtube.com/watch?v=vjhA9TJWw-k&list=PLSAko72nKb8QWsfPpBlsw-kOdMBD7sra-&index=5
(https://www.youtube.com/@TheLearningChannel-Tech/playlists)
--CMD
sudo iptables -n -t nat -L KUBE-SERVICES


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
