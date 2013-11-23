$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'app'

root_dir = File.dirname(__FILE__)

ImagesApp.set :app_url, 'http://i.anakros.me'
ImagesApp.set :upload, "#{root_dir}/images"

run ImagesApp
