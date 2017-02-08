#!/usr/bin/env bash

# Intended for Ubuntu 14.04 (Trusty)

# You need to install Vagrant and VirtualBox.
# This vagrantbox was used (Ubuntu 14.04 for VirtualBox) -> https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box
# Run `vagrant box add https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box --name trusty64`

#MySQL username -> root
#MySQL password -> rootpass

printf '\E[37;44m'"\033[1m _____ Creating VM's environment _____ \033[0m\n"

if ! ( [ -e /vagrant/.exists ] ); then
    sudo apt-get update
    printf '\E[37;44m'"\033[1m _____ Preparing conf _____ \033[0m\n"
    mkdir /vagrant/.exists
    sudo apt-get -y install software-properties-common

    printf '\E[37;44m'"\033[1m _____ Adjust timezone to be Paris _____ \033[0m\n"
    echo "Europe/Paris" > /etc/timezone
    sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

    printf '\E[37;44m'"\033[1m _____ Adjust sudo path _____ \033[0m\n"
    echo "alias sudo='sudo env PATH=\$PATH'" >> /home/vagrant/.bashrc
    echo "alias sudo='sudo env PATH=\$PATH'" >> /home/vagrant/.zshrc
fi

if ! ( [ -e /vagrant/.exists/.zshOK ] ); then
    sudo apt-get install -y zsh
    echo "autoload -U promptinit" >> /home/vagrant/.zshrc
    echo "promptinit" >> /home/vagrant/.zshrc
    echo "autoload -U colors && colors" >> /home/vagrant/.zshrc
    echo "setopt prompt_subst" >> /home/vagrant/.zshrc
    echo ". ~/.git-prompt.sh" >> /home/vagrant/.zshrc
    echo "export RPROMPT=\$'\$(__git_ps1 \"%s\")'" >> /home/vagrant/.zshrc
    echo "PROMPT=\"%{\$fg[cyan]%}kleiba%{\$reset_color%}:%1~\\$ \"" >> /home/vagrant/.zshrc
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh > /home/vagrant/.git-completion.zsh
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > /home/vagrant/.git-prompt.sh
    sudo chsh -s /bin/zsh vagrant
    /bin/zsh
    touch /vagrant/.exists/.zshOK
fi

if ! ( [ -e /vagrant/.exists/.emacsOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing emacs _____ \033[0m\n"
    sudo apt-get -y install emacs
    touch /vagrant/.exists/.emacsOK
fi

if ! ( [ -e /vagrant/.exists/.gitOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing git _____ \033[0m\n"
    sudo apt-get -y install git
    touch /vagrant/.exists/.gitOK
fi

if ! ( [ -e /vagrant/.exists/.nodejsOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing nodejs _____ \033[0m\n"
    sudo apt-get -y install nodejs
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    touch /vagrant/.exists/.nodejsOK
fi

if ! ( [ -e /vagrant/.exists/.npmOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing npm _____ \033[0m\n"
    sudo apt-get -y install npm
    touch /vagrant/.exists/.npmOK
fi

if ! ( [ -e /vagrant/.exists/.bowerOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing bower _____ \033[0m\n"
    npm install -g bower
    touch /vagrant/.exists/.bowerOK
fi

if ! ( [ -e /vagrant/.exists/.couchbaseOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing couchbase _____ \033[0m\n"
    sudo apt-get -y install openssl
    sudo apt-get -y install libssl1.0.0
    sudo wget http://packages.couchbase.com/releases/4.1.0/couchbase-server-enterprise_4.1.0-ubuntu14.04_amd64.deb
    sudo dpkg -i couchbase-server-enterprise_4.1.0-ubuntu14.04_amd64.deb
    sudo wget -O/etc/apt/sources.list.d/couchbase.list http://packages.couchbase.com/ubuntu/couchbase-ubuntu1404.list
    sudo wget -O- http://packages.couchbase.com/ubuntu/couchbase.key | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y install libcouchbase2-libevent libcouchbase-dev
    /opt/couchbase/bin/couchbase-cli cluster-init --cluster-username=root --cluster-password=rootpass --cluster-port=8091 --cluster-ramsize=800 -c localhost:8091 -u root -p rootpass
    export CB_REST_USERNAME=root
    export CB_REST_PASSWORD=rootpass
    /opt/couchbase/bin/couchbase-cli bucket-create --bucket=myBucket --bucket-ramsize=400 --bucket-replica=0 --bucket-type=couchbase --bucket-password=rootpass --enable-flush=1 --enable-index-replica=0 -c localhost:8091
    touch /vagrant/.exists/.couchbaseOK
fi

if ! ( [ -e /vagrant/.exists/.bindOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Setting alias for rails s to bind automaticly _____ \033[0m\n"
    echo "rails() { if [[ \$@ == \"s\" ]]; then command rails s -b 0.0.0.0; else command rails \"\$@\"; fi; }" >> /home/vagrant/.bashrc
    echo "rails() { if [[ \$@ == \"s\" ]]; then command rails s -b 0.0.0.0; else command rails \"\$@\"; fi; }" >> /home/vagrant/.zshrc
    touch /vagrant/.exists/.bindOK
fi

if ! ( [ -e /vagrant/.exists/.rvmOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing rvm _____ \033[0m\n"
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.0
    source /usr/local/rvm/scripts/rvm
    echo "source /usr/local/rvm/scripts/rvm" >> /home/vagrant/.zshrc
    touch /vagrant/.exists/.rvmOK
fi

if ! ( [ -e /vagrant/.exists/.rvminstallsOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Removing rvm flag warning _____ \033[0m\n"
    touch /home/vagrant/.rvmrc
    echo "export rvm_trust_rvmrcs_flag=1" > /home/vagrant/.rvmrc
    touch /vagrant/.exists/.rvminstallsOK
fi

if ! ( [ -e /vagrant/.exists/.bundlerOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing bundler _____ \033[0m\n"
    rvm use ruby-2.3.0@global --install --create
    gem install bundler --no-ri --no-rdoc
    touch /vagrant/.exists/.bundlerOK
fi

if ! ( [ -e /vagrant/.exists/.mysqlOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing MySQL _____ \033[0m\n"
    sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password rootpass'
    sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password rootpass'
    sudo apt-get -y install mysql-server-5.5
    touch /vagrant/.exists/.mysqlOK
fi

if ! ( [ -e /vagrant/.exists/.redisOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing redis and lunching it _____ \033[0m\n"
    sudo apt-get -y install redis-server
    redis-benchmark -q -n 1000 -c 10 -P 5
    sudo sh -c "echo 'tcp-keepalive 60' >> /etc/redis/redis.conf"
    sudo service redis-server restart
    touch /vagrant/.exists/.redisOK
fi

if ! ( [ -e /vagrant/.exists/.libsOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing Libraries _____ \033[0m\n"
    sudo apt-get -y install liblzma-dev zlib1g-dev
    sudo apt-get -y install libxslt-dev
    sudo apt-get -y install libxml2-dev
    sudo apt-get -y install libruby
    sudo apt-get -y install libmysqld-dev
    sudo apt-get -y install libcurl4-openssl-dev
    sudo apt-get -y install libcurl4-gnutls-dev
    sudo apt-get -y install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
    sudo apt-get -y install libcurl4-gnutls-dev
    sudo apt-get -y install libmagickwand-dev
    sudo apt-get -y install libgmp-dev
    sudo apt-get -y install graphicsmagick-libmagick-dev-compat
    sudo apt-get -y install imagemagick
    sudo apt-get -y install libmagickcore-dev
    sudo apt-get -y install libmagickwand5
    sudo apt-get -y install libmagickwand-dev
    sudo apt-get -y install libpq-dev
    touch /vagrant/.exists/.libsOK
fi

if ! ( [ -e /vagrant/.exists/.elasticsearchOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing Java and Elasticsearch _____ \033[0m\n"
    sudo apt-get -y install openjdk-7-jre
    sudo wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb
    sudo dpkg -i elasticsearch-1.7.2.deb
    sudo update-rc.d elasticsearch defaults
    sudo rm ./elasticsearch-1.7.2.deb
    touch /vagrant/.exists/.elasticsearchOK
fi

if ! ( [ -e /vagrant/.exists/.npmInstallOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing js packages with dependencies _____ \033[0m\n"
    npm install -g node-gyp
    npm install -g couchbase
    npm install -g readable-stream
    npm install -g lodash
    npm install -g lazystream
    npm install -g zip-stream
    npm install -g tar-stream
    npm install -g buffer-crc32
    npm install -g unpipe
    touch /vagrant/.exists/.npmInstallOK
fi

if ! ( [ -e /vagrant/.exists/.railsOK ] ); then
    printf '\E[37;44m'"\033[1m _____ Installing rails _____ \033[0m\n"
    rvm use ruby-2.3.0@global --install --create
    gem install rails --version=5.0.0.1
    touch /vagrant/.exists/.railsOK
fi

printf '\E[47;32m'"\033[1m You're ready to work ! vm provided by Kevin Leiba kleiba@student.42.fr :) \033[0m\n"
tput sgr0

# Cleanup
sudo apt-get -y autoremove
