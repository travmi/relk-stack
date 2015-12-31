Role Name
=========

Ansible Role to Install and Configure Logstash

[![Build Status](https://travis-ci.org/valentinogagliardi/logstash-role.svg?branch=master)](https://travis-ci.org/valentinogagliardi/logstash-role)

Useful Information
------------------

https://www.elastic.co/guide/en/logstash/current/advanced-pipeline.html

Requirements
------------

**Java** should be present on the nodes machines in order to run Logstash. This role does not install Java.

Example Playbooks
----------------

```yaml
- hosts: LogstashNodes
  roles:
    - role:
       - logstash

      logstash_version: "2.1.1"

      logstash_defaults: |
        LS_USER=root
        LS_HEAP_SIZE="256m"

     logstash_inputs: |
       syslog { host => "{{ ansible_eth0.ipv4.address }}"
                port => "514"
                type => "syslog_input"
              }

       syslog { host => "{{ ansible_lo.ipv4.address }}"
                port => "515"
                type => "syslog_input_local"
              }

     logstash_filters: |
       geoip { source => "ip_address"
             }

       multiline { pattern => "^No lfn2pfn"
                   what => "previous"
                 }

     logstash_outputs: |
       file { path => "/var/log/logstash/output.log"
            }

      tags: logstash
```

Role Variables
--------------

```yaml
logstash_version: "none"

logstash_conf_dir: "/etc/logstash/conf.d/"

logstash_defaults:
 - { directive: "LS_USER=logstash" }

defaults_RedHat: "/etc/sysconfig/logstash"
defaults_Debian: "/etc/default/logstash"
```

License
-------

GNU General Public License Version 2

Author Information
------------------

Valentino Gagliardi - valentino.g@servermanaged.it
Mike Travis - mike.r.travis@gmail.com
