Terraform
=========

Ansible
=======

To install the k8s cluster run:

```
# ANSIBLE_HOST_KEY_CHECKING=false e "scw_token=SCW_TOKEN scw_organization=SCW_ORGANIZATION" ansible-playbook -i inventories/scaleway.inv k8s.yml
```

Replace:
  - SCW_TOKEN by your scaleway token
  - SCW_ORGNAZATION by your scaleway organization

These extra vars are only needed if you want an HA ingress. The allow keepalive to move your scaleway floating ip on a running proxy if one of the proxy fails. You must have a DNS RR configured with all your public IPs.
