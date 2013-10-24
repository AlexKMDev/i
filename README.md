Small image upload service
============

Demo: http://i.anakros.me/upload

1. clone repository
2. ```$ bundle install && thin start```
3. change custom upload endpoint to 'http://yourserver:3000/upload' in Tweetbot
4. or ```curl --form "media=@test.gif" http://yourserver:3000/upload```
