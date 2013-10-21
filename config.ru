$: << File.dirname(__FILE__)

require 'rubygems'
require 'app'

set :root, File.dirname(__FILE__)
set :static, '/images'
set :run, false
set :env, :production
set :server, :thin
set :raise_errors, false
File.mkdir 'images' unless File.exists? 'images'

run ImagesApp
