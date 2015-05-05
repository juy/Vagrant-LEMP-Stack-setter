## Vagrant LEMP Stack - setter

A development platform in a box, with everything you would need to develop PHP websites.

> Used "chef/ubuntu-14.10" vagrant box *(virtualbox provider)* with ansible provision. Modified it for our own use, especially for Laravel projects. Tested only windows host.

#### Help support this project
If you'd like to support this and other our creations projects, donate via [PayPal][paypal-donate-url].

[![Support via PayPal][paypal-donate-img]][paypal-donate-url]


----------


### Provision Content
Provision with ansible.

- **Global**
	- [x] Ubuntu 14.10 (utopic), x64 - [chef/ubuntu-14.10](https://atlas.hashicorp.com/chef/boxes/ubuntu-14.10)
	- [x] Ansible 1.7.2
	- [x] Nginx 1.8.0
	- [x] PHP 5.6
	- [x] HHVM
	- [x] Git 2.4.0, git-flow, git-extras
	- [x] Composer
	- [x] Mailcatcher
	- [x] Ruby 2.1.2p95
	- [x] Beanstalkd
	- [x] Supervisord
	- [x] Blackfire
- **Database & Cache**
	- [x] MySQL 5.6.19
	- [x] PostgreSQL 9.4.1
	- [x] SQLite
	- [x] Redis 3.0.0
	- [x] Memcached
- **Asset tools**
	- [x] node.js
	- [x] bower
	- [x] gulp
	- [x] grunt
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
