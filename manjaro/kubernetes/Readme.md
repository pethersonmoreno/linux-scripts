# Configuring Kubernetes

Install Kubernetes:

```sh
./install-kubernetes
```

## Configure local DNS to pet-k8s-cluster and etcd-server

```sh
echo "127.0.0.1	pet-k8s-cluster" >> /etc/hosts
echo "127.0.0.1	etcd-server" >> /etc/hosts
```


## Configure Docker to use systemd

```sh
./configure-docker-to-kubernetes
```

## Install other dependencies

```sh
sudo pacman -S ebtables ethtool socat conntrack-tools
```

## Disable Swap

```sh
sudo swapoff -a
```

## Create cluster

```sh
kubeadm config images pull
# sudo kubeadm init --control-plane-endpoint=pet-k8s-cluster
sudo kubeadm init --config=kubeadm-config.yaml
```

## Configure kubectl to current user

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Configure network

```sh
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```