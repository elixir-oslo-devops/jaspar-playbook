# ansible-playbook-jaspar
## Requirement installation
To install requirements :

- A GitHub account
- Access to the following repo:
  - https://github.com/elixir-oslo-devops/ansible-role-setup-nrec
  - https://github.com/elixir-oslo-devops/ansible-role-certification
- A SSH access to GitHub (follow GitHub official [documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh))

Hint: Don't forget to configure your local `~/.ssh/config` files:

    Host github.com
        User git
        Port 22
        IdentityFile ~/.ssh/id_rsa


## Set up Jenkins: manual steps

### Set up agent

https://www.jenkins.io/doc/book/security/controller-isolation/

1. Disable running jons on built-in nodes.
  


    To prevent builds from running on the built-in node directly, navigate to Manage Jenkins » Nodes and Clouds. 
    Select Built-In Node in the list, then select Configure in the menu. Set the number of executors to 0 and save. 
    Make sure to also set up clouds or build agents to run builds on, otherwise builds won’t be able to start.
