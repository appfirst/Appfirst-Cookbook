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

This recipe installs and updates the AppFirst client for a given account ID.

Attributes
==========

This recipe will attempt to download the collector if one does not exist locally, or if the current local one is out-of-date.  It will continue 
on failure in case the AppFirst front end is not responding.

Open Appfirst-Cookbook/attributes/default.rb, and edit the variable shown below to reflect your AppFirst account ID.  This can be located in
the appfirst.com WebUI by navigating to the Administration tab, and then clicking 'Setup'.  Click the 'Add More Collectors' link and retrieve the
Account ID from the Collector download URL.  This should look something like  'http://wwws.appfirst.com/packages/initial/xxxx/'

`default['appfirst']['appfirst_account_id'] = 'xxxx'`

The second noteworthy attribute allows the end user to specify where the
Collector installation package should be stored locally after it is
retrieved from appfirst.com:

`default['appfirst']['tmp_file_location'] ='/tmp'`

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

Licensed under [Apache License 2.0](http://apache.org/licenses/LICENSE-2.0.html) 
