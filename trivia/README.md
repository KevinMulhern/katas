Legacy Code Retreat code base
======

Use this code base to run your own [Legacy Code Retreat](http://legacycoderetreat.jbrains.ca).

As of this writing, there isn't really a single place to get all the information you might want about Legacy Code Retreat. Search the web and ask your colleagues. Most importantly, don't panic! If you've been to Code Retreat even once, then you know most of what you need to run a Legacy Code Retreat. Give it a try!


Test Frameworks
===============

This repo has configuration and example files for both RSpec and minitest. The
RSpec files are in `/spec` and the minitest files are in `/test`.

First install both of the gems using Bundler (don't worry, you'll only be
using one at a time):

    bundle install

You can run the RSpec tests using:

    rake spec

And the minitest test using:

    rake minitest

Please modify any and all of these files to suit your preferences; these are
simply meant as a starting point!
