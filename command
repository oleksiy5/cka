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


RESTORE ETCD
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save etcd-b.db
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
$ sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
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


To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

https://medium.com/karlmax-berlin/how-to-install-kubernetes-on-raspberry-pi-53b4ce300b58
https://alexsniffin.medium.com/a-guide-to-building-a-kubernetes-cluster-with-raspberry-pis-23fa4938d420

-- TRUBLE ANALYSE --
 kubectl get componentstatuses
