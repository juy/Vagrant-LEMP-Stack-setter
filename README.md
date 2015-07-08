## Vagrant LEMP Stack - setter

A development platform in a box, with everything you would need to develop PHP websites.

**Current status:** Development, **Next:** Test, **Last:** Product

> Used "boxcutter/ubuntu1504" v1.1.0 vagrant box *(only virtualbox provider)* with ansible provision. Modified it for our own use, especially for Laravel projects. 

#### Help support this project
If you'd like to support this and other our creations projects, donate via [PayPal][paypal-donate-url].

[![Support via PayPal][paypal-donate-img]][paypal-donate-url]


----------


### Provision Content
Provision with ansible.

- **Global**
	- [x] Ubuntu Server 15.04 Vivid Vervet (64-bit) - [boxcutter/ubuntu1504](https://atlas.hashicorp.com/boxcutter/boxes/ubuntu1504) v1.1.0
	- [x] Ansible
	- [x] Nginx
	- [x] PHP
	- [x] HHVM
	- [x] Git, git-flow, git-extras
	- [x] Composer
	- [x] Mailcatcher
	- [x] Ruby
	- [x] Beanstalkd
	- [x] Supervisord
	- [x] Blackfire
- **Database & Cache**
	- [x] MySQL
	- [x] PostgreSQL
	- [x] SQLite
	- [x] Redis
	- [x] Memcached
- **Asset tools**
	- [x] node.js
	- [x] bower
	- [x] gulp
- **Composer global packages**
	- [x] Laravel Installer
	- [x] Laravel Envoy
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


### TODO
- [ ] Test ansible provision on linux/ubuntu host.
- [ ] "Web GUI tools" need more test for stability.
- [ ] Some code clean up.


### License
This project is open-sourced software licensed under the [MIT license][mit-url].



[paypal-donate-img]: https://img.shields.io/badge/PayPal-donate-brightgreen.svg?style=flat-square
[paypal-donate-url]: http://bit.ly/donateAngelside

[mit-url]: http://opensource.org/licenses/MIT
