adhearsion-xmpp
========

adhearsion-xmpp is an Adhearsion Plugin providing XMPP connectivity.

Features
--------

* FIXME (list of features and unsolved problems)

Requirements
------------

* Adhearsion 2.0+

Install
-------

Add `adhearsion-xmpp` to your Adhearsion app's Gemfile.

Configuration
-------------

In your Adhearsion app configuration file, add the following values:

```ruby
Adhearsion.config do |config|
  config.xmpp.jid      = "valid-jid"
  config.xmpp.password = "valid-password"
  config.xmpp.host     = "valid-host"
  config.xmpp.port     = "valid-port"
end
```

Author
------

Original author: [Juan de Bravo](https://github.com/juandebravo)

Links
-----
* [Source](https://github.com/adhearsion/adhearsion-xmpp)
* [Documentation](http://rdoc.info/github/adhearsion/adhearsion-xmpp/master/frames)
* [Bug Tracker](https://github.com/adhearsion/adhearsion-xmpp/issues)

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  * If you want to have your own version, that is fine but bump version in a commit by itself so I can ignore when I pull
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (C) 2012 Adhearsion Foundation Inc.

Released under the MIT License - Check [License file](https://github.com/adhearsion/adhearsion-xmpp/blob/master/LICENSE)
