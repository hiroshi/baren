Baren
=====
Baren generate .png images form .pjs ([Processing.js](http://processingjs.org/) script).

- A template engine implemented in [tilt](http://github.com/rtomayko/tilt) API
- Can be a part of the asset pipeline of Rails 3.1


Prerequisites
-------------
Baren requires PhantomJS as the Javascript and Canvas engine, 
and PhantomJS requires QtWebKit.

### Mac OS X
Baren use a binary package of PhantomJS for Mac OS X, so there is no need to do before installing baren.

### Ubuntu 10.04

    sudo apt-get install curl libqt4-dev qt4-qmake xvfb

For other linux distributions, please consult with [BuildInstructions - phantomjs](http://code.google.com/p/phantomjs/wiki/BuildInstructions).

### Windows
TBD


Usages
------
### With Rails 3.1 Asset pipeline
Add the line below in Gemfile of your Rails 3.1 app.

    gem "baren"

Place a .png.pjs file or two in {your app root}/app/assets/images.
This is an example of processing.js script:

     /* reddisc.png.pjs */
     /* @pjs transparent=true; */
     size(30, 30);
     background(0, 0, 0, 0);
     stroke(255, 0, 0);
     fill(255, 0, 0);
     ellipse(15, 15, 28, 28);

Access http://localhost:3000/assets/reddisc.png (tweak URL for your environment).
You will see a red circle, and please enjoy with [processing.js API reference](http://processingjs.org/reference).


Developer Notes
---------------
If you didn't install baren as a gem, you will need to install some non-gem prerequisites.

    (cd baren/opt && rake)


Misc
----
If you notice a bug, or possible enhancement, join us
[Issues - hiroshi/baren - GitHub](https://github.com/hiroshi/baren/issues).


License
-------

Copyright &copy; 2011 Hiroshi Saito.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
