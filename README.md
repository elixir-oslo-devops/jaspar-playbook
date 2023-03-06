# jaspar-playbook
Repo for issues related to Jaspar

## Set up conda environment

```
conda create -n ansible python=3 python-openstackclient "openstacksdk<0.99" ansible
conda activate ansible
```

## Create a OpenStack keystone file

```
touch keystone_rc.sh
chmod 600 keystone_rc.sh
```

Contents of `keystone_rc.sh`:
- Replace `<username>` with your Feide username
- Replace `<password>` with the API password that you got when first signed up to NREC,
or create a new API passord by clicking on “Reset API password”, both accessible from 
[access.nrec.no](https://access.nrec.no/).

```
export OS_USERNAME=<username>@uio.no
export OS_PROJECT_NAME=uio-ifi-elixir-jaspar
export OS_PASSWORD=<password>
export OS_AUTH_URL=https://api.nrec.no:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_USER_DOMAIN_NAME=dataporten
export OS_PROJECT_DOMAIN_NAME=dataporten
export OS_REGION_NAME=osl
export OS_INTERFACE=public
export OS_NO_CACHE=1
```



## Installing Ansible collections

`ansible-galaxy install -r requirements.yml`

## Updating the version of a collection

E.g.: `ansible-galaxy collection install openstack.cloud --upgrade`

## Running playbook

```
source keystone_rc.sh  # run once, to set up environment variables
ansible-playbook deploy-jaspar.yml
```
