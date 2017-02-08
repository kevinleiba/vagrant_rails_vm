# Rails VM
---

## Description

### Features

This __Virtual Machine__ *(vm)* is used to work on rails project on any computer.
It uses __rvm__ as it's package manager.
 * __Rails 5__ ready
 * __ruby__ version __2.3.0__
 * __mysql__ database

This vm also has __node.js__ installed with __npm__ and __bower__

### Basic usage

You'll want to connect the vm in ssh to access a virtual linux machine that runs __rails__ applications

```bash
cd path/to/vm_directory
vagrant up
vagrant ssh
```
and voila, you're inside the machine !

---

## Installation

### Downloads

You need to download and install [Vagrant] and [VirtualBox].

Then, you will need to download this [vagrant box] by running this command:

`vagrant box add https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box --name trusty64`

### Provision

Create a vm directory: `mkdir vm_directory`

Go to this directory: `cd vm_directory`

Lunch install: `vagrant up --provision`

### Good to know

Every steps of provision when completed are stocked as a file in current directory at `.exists/`.
If you need to only re-run one of installation steps, just `rm .exists/.stepOK`

---

## Useful infos

### Create Rails app from scratch
As you may know, rvm is a solution to manage ruby versions and it's gems. So in this vm, nothing is installed globally.
So, running `rails` won't work if not pre-installed.
So follow those next steps to create a rails app

```bash
rvm use ruby-2.3.0@global --install --create
gem install bundler # if not done yet
gem install rails # the version you want
rails new my_app
cd my_app
echo "rvm use ruby-2.3.0@my_app --install --create" > .rvmrc
cd .. && cd -
gem install bundler
bundle install
```

That's it ! You now have a working rails app !

### Use existing rails app

Check if rail app has a `.rvmrc` file in it's root.
If not, run those commands:
```bash
echo "rvm use ruby-2.3.0@app_name --install --create" > ./app/name/.rvmrc
cd app_name
gem install bundle
bundle install
```

You should now be able to lunch app. If not, maybe it's a ruby version problem.


### Database

__mysql__ is already installed

* Username: __root__
* Password: __rootpass__

### Installed solutions

 * __zsh__ shell (used by default)
 * __emacs__ editor
 * __git__ versioning solution
 * __nodejs__ with an alias set to `node`
 * __npm__ -> a node package manager
 * __bower__ -> a node package manager
 * __couchbase__ -> a database
 * __redis__ -> to manage queued actions
 * __elasticsearch__ -> to index database entries
 * __mysql__ -> a database
 * __rvm__ -> ruby version manager


### Shared folder

You'll want to put every working folder in this repertory. Then you'll access them here `/vagrant`
You can now work from your local machine with your favourite text editor and changes will be instant in the vm.

### Bundle issue

```bash
Gem bundler is not installed, run `gem install bundler` first
```
It's ok, juste run `gem install bundler` and bundler will be installed.

---

### Vagrant Commands

 * `vagrant up` => Lunches vm
 * `vagrant provision` => Lunches script
 * `vagrant halt` => Turns of vm
 * `vagrant ssh` => Connects to vm in ssh


<!-- Links -->
[Vagrant]: https://www.vagrantup.com/downloads.html
[VirtualBox]: https://www.virtualbox.org/wiki/Downloads
[vagrant box]: https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box
