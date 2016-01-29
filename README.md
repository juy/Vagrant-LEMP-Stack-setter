## Vagrant LEMP Stack - setter/provisioner

**This part is setter/provisioner for Vagrant LEMP Stack project, for end user part please visit [Vagrant-LEMP-Stack](https://github.com/juy/Vagrant-LEMP-Stack).**

A development platform in a box, with everything you would need to develop PHP/Laravel websites.

> Used "boxcutter/ubuntu1504" vagrant box *(only virtualbox provider)* with ansible provision. Modified it for our own use, especially for Laravel projects. 

----------

### Provision Content

Provision with ansible.

### Content

- **OS**
	- [x] Ubuntu Server 15.04 Vivid Vervet (64-bit) - [boxcutter/ubuntu1504](https://atlas.hashicorp.com/boxcutter/boxes/ubuntu1504)
- **Base Packages**
	- [x] Ansible
	- [x] Nginx
	- [x] PHP 5.6.* (php-fpm)
	- [x] Git, git-flow, git-extras
	- [x] Composer
	- [x] Ruby
	- [x] HHVM (Only for composer speed up)
    - [x] VirtualBox Guest Additions
- **Databases**
	- [x] MySQL 5.6.*
	- [x] PostgreSQL 9.4.*
	- [x] SQLite
- **In-Memory Stores**
	- [x] Redis
	- [x] Memcached
- **Utility**
	- [x] Mailcatcher
	- [x] Beanstalkd
	- [x] Supervisord
	- [x] Blackfire profiler
	- [x] Ngrok
- **Asset tools**
	- [x] node.js 5.5.*, npm
	- [x] bower
	- [x] gulp
- **Composer global packages**
    - [x] Laravel installer
	- [x] Lumen installer
	- [x] Spark installer
	- [x] Laravel envoy
- **SSH tools**
	- [x] htop
	- [x] mytop
	- [x] pgtop
	- [x] ngxtop
	- [x] autojump
	- [x] screen
- **Web GUI tools**
	- [x] Beanstalkd console - https://github.com/ptrofimov/beanstalk_console
	- [x] Redis Commander - https://github.com/joeferner/redis-commander

### License

This project is open-sourced software licensed under the [MIT license][mit-url].



[mit-url]: http://opensource.org/licenses/MIT
