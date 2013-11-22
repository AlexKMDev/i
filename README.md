Small image upload service
============

Demo: http://i.anakros.me/upload

1. clone repository
2. ```$ bundle install && unicorn -D -p 3000```
3. change custom upload endpoint to 'http://localhost:3000/upload' in Tweetbot
4. or ```curl --form "media=@test.gif" http://localhost:3000/upload```
