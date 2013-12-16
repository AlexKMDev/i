SIUS — small image uploading service [![Build Status](https://travis-ci.org/Anakros/i.png)](https://travis-ci.org/Anakros/i)
============

Demo: http://i.anakros.me

1. clone repository
2. ```$ bundle install && unicorn -D -p 3000```
3. change custom upload endpoint to 'http://localhost:3000/upload' in Tweetbot
4. or ```curl --form "media=@test.gif" http://localhost:3000/upload```
