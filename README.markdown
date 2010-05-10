JADOF + Rack = cms/blogging engine
==================================

Glog is Rack Middleware to serve directory of files as blog or site.

Glog inspired by [toto](http://github.com/cloudhead/toto) and based on
[JADOF](http://github.com/remi/jadof).

Glog makes less assumptions about your urls.
**J**ust **a** **D**irectory **o**f **F**iles.


## Quickstart

    git clone git://github.com/antono/glog-quickstart.git
    cd glog-quickstart
    gem install bundler
    bundle install
    unicorn

Open http://localhost:8080/ in your favorite [Chromium](http://www.chromium.org/).

Tailor example code as you with until You get the site done.


Plugins
-------

Use rack middleware as plugins:

    require 'rack/noie'
    use Rack::NoIE, :redirect => '/noie.html'

    require 'rack/google_analytics'
    use Rack::GoogleAnalytics, 'UA-1234567-0'

Similar Projects
----------------

- [ruby] toto is a git-powered, minimalist blog engine for the hackers of Oz.
  http://github.com/cloudhead/toto

- [javascript] Wheat is a blogging engine that reads a git repo full of
  markdown articles and presents them as a website.
  http://github.com/creationix/wheat

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
