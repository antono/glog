Glog - simplier than toto
=========================

Glog is Rack Middleware to serve directory of files as blog or site.

Glog inspired by [toto](http://github.com/cloudhead/toto) and based on
[JADOF](http://github.com/remi/jadof).

Glog makes less assumptions about your urls.
**J**ust **a** **D**irectory **o**f **F**iles.


TODO


Plugins
-------

Use rack middleware as plugins:

    require 'rack/noie'
    use Rack::NoIE, :redirect => '/noie.html'

    require 'rack/google\_analytics'
    use Rack::GoogleAnalytics, 'UA-1234567-0'


Note on Patches/Pull Requests
-----------------------------

- Fork the project.
- Make your feature addition or bug fix.
- Add tests for it. This is important so I don't break it in a
  future version unintentionally.
- Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
- Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2010 Antono Vasiljev. See LICENSE for details.
