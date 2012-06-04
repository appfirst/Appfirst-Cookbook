Description
===========

Configures an appfirst collector for a given account id.  This will also set up a LWRP for creating Nagios checks via Appfirst.


Requirements
============

Chef 0.10.8 or higher due to using some new syntax.

Recipes
=======

default
-------

This recipe installs and updates the Appfirst client for a given account ID.

Attributes
==========

This recipe will attempt to download the collector if one does not exist locally.  It will continue on failure in case the appfirst front end is not responding.

`"appfirst_account_id" => "1234"`

The ID should be a string since it is used when fetching a URL


Resources/Providers
===================

Appfirst Check
--------------

This LWRP provides an easy way to manage Nagios Checks via Appfirst.

# Actions

- `:create` Templates the specified shell script and updates the NRPE config
- `:remove` removes the Nagios Check (not implemented)

# Attribute Parameters

- `script_name` The name of the script being templated
- `command` The name of the check, this should be a human readable description, only Alphanumerics and `'-"_`
- `warning` Warning Level for the Nagios Check (Integer)
- `critical` Critical Level for the Nagios Check (Integer)
- `options` Any additional options to be added to the command in the NRPE config

# Examples

```ruby
appfirst_check "Check_Redis_Memory_Usage" do
  action :create
  command "Check_Redis_Memory_Usage"
  script_name "check_redis_memory_usage.sh"
  warning 50
  critical 75
end
```

License and Author
==================

Author:: Andrew Gross (<andrew@yipit.com>)

Licensed under the Buy Me a Beer License


"THE BEER-WARE LICENSE" (Revision 42):
As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return

    http://en.wikipedia.org/wiki/Beerware