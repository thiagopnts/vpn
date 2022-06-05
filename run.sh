#!/bin/sh
modprobe xt_mark
echo "net.ipv4.ip_forward = 1" >>/etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding = 1" >>/etc/sysctl.conf
sysctl -p /etc/sysctl.conf
ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
mkdir -p /var/lib/tailscale/
./tailscaled -verbose=2 -port=41641 &
sleep 10
/app/tailscale up \
	--authkey=${TSKEY} \
	--advertise-exit-node \
	--hostname=${TAILSCALE_HOSTNAME}
