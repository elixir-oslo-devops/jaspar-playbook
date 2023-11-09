# ansible-playbook-jaspar
## Requirement installation
To install requirements :

- A GitHub account
- Access to the following repos:
  - https://github.com/elixir-oslo-devops/ansible-role-setup-nrec
  - https://github.com/elixir-oslo-devops/ansible-role-setup-nrec-host
  - https://github.com/elixir-oslo-devops/ansible-role-certification
- A SSH access to GitHub (follow GitHub official [documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh))

Hint: Don't forget to configure your local `~/.ssh/config` files:

    Host github.com
        User git
        Port 22
        IdentityFile ~/.ssh/id_rsa

