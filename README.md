Terraform
=========

Ansible
=======

To install the k8s cluster run:

```
# ANSIBLE_HOST_KEY_CHECKING=false e "scaleway_token=SCW_TOKEN" ansible-playbook -i inventories/scaleway.inv k8s.yml
```

Replace:
  - SCW_TOKEN by your scaleway token

These extra vars are only needed if you want an HA ingress. The allow keepalive to move your scaleway floating ip on a running proxy if one of the proxy fails.
