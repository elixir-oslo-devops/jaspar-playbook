*According to memory and history.*

Mainly followed: https://bitbucket.org/CBGR/jaspar2020/src/20211214-buildah-deployment/docs/Deployment.rst

### To do before running deploy.sh script.

Set up volumes as desired and clone jaspar from bitbucket.
When installing outside `/var/www`, add in the selinux script in this repo.

Register certbot and start apache:

    sudo yum install httpd certbot git wget
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
NB: must run as user, but uses sudo internally for some commands (like yum, selinux etc):

    ./deploy.sh -- -s test.jaspar.uiocloud.no -d /data/JASPAR_RELEASES_2022-02-11 -S
    sudo systemctl restart httpd

### Run tests:

    tests/test_website.py --url https://test.jaspar.uiocloud.no
    tests/test_api.py --url https://test.jaspar.uiocloud.no/api/v1
    
