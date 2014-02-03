SIUS — small image uploading service
============

[![Build Status](https://travis-ci.org/Anakros/i.png)](https://travis-ci.org/Anakros/i) [![Coverage Status](https://coveralls.io/repos/Anakros/i/badge.png?branch=master)](https://coveralls.io/r/Anakros/i?branch=master)

Demo: ```curl --form "media=@test.gif" http://i.anakros.me/upload```

1. clone repository
2. install imagemagick ```$ brew install imagemagick --with-libtiff```
2. ```$ bundle install && unicorn -D -p 3000```
3. change custom upload endpoint to ```http://localhost:3000/upload``` in Tweetbot
