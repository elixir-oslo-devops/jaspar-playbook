## Notes about JASPAR test instance installation

Mainly followed: https://bitbucket.org/CBGR/jaspar2020/src/20211214-buildah-deployment/docs/Deployment.rst

### NREC VM
Named "Jaspar test install" in "uio-ifi-elixir-jaspar" project. Uses "UiO RHEL8" image. Flavor m1.xlarge. 500GB regular data volume and 100GB SSD volume. This may be larger than necessary for a test case. Hostname: test.jaspar.uiocloud.no


### To do before running deploy.sh script.

Set up volumes as desired and clone JASPAR from Bitbucket. This was done approximately as below:

    sudo -i
    yum install lvm2 git
    pvcreate /dev/sdb
    pvcreate /dev/sdc
    vgcreate vg-ssd /dev/sdc
    vgcreate vg-data /dev/sdb
    lvcreate -l 100%FREE -n lv-fast vg-ssd
    lvcreate -l 100%FREE -n lv-slow vg-hdd
    mkfs -t xfs /dev/vg-hdd/lv-slow 
    mkfs -t xfs /dev/vg_ssd/lv_fast 
    mkdir /data && mount /dev/vg-hdd/lv-slow /data
    mkdir /cache && mount /dev/vg_ssd/lv_fast /cache
    # add mountpoints to /etc/fstab
    mkdir /data/apps && chown cloud-user /data/apps
    exit
    
    git clone -b 20211214-buildah-deployment https://bitbucket.org/CBGR/jaspar2020.git /data/apps/jaspar2020

NB: It is unclear how much and what type of diskspace the JASPAR instance requires. SSD volume is not used currently, but may be linked to a tmp folder that JASPAR uses.


When installing outside `/var/www`, add in the extra selinux script in this repo (https://github.com/elixir-oslo/jaspar-playbook/blob/main/jaspar2020/deploy/10-root-selinux-www.sh). In an ansible playbook this could be done as a separate task, before and/or after running JASPAR's deploy.sh.

Register certbot and start apache:

    sudo yum install httpd certbot wget
    sudo systemctl start httpd
    sudo certbot register


Install conda somehow and do not be in base environment when running deploy:

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh
    
    conda config --add channels defaults
    conda config --add channels bioconda
    conda config --add channels conda-forge
    conda config --set auto_activate_base false

Fetch Jaspar data:

    wget -r -np https://frigg.uio.no/ftp/mathelier/JASPAR_RELEASES_2022-02-11/ /data/

### Run deploy:
NB: runs as user, but uses sudo internally for some commands (like yum, selinux etc), so user must have sudo nopasswd rights.

    ./deploy.sh -- -s test.jaspar.uiocloud.no -d /data/JASPAR_RELEASES_2022-02-11 -S
    sudo systemctl restart httpd

### Run tests:

    tests/test_website.py --url https://test.jaspar.uiocloud.no
    tests/test_api.py --url https://test.jaspar.uiocloud.no/api/v1
    

### PS:
Mail sending is not properly set up or tested. Branding, logos, twitter, analysis etc is not set up.
