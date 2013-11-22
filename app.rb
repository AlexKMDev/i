require 'sinatra'
require 'mini_magick'
require 'json'
require 'securerandom'

class ImagesApp < Sinatra::Base

  helpers do
    def generate_name
      SecureRandom.hex
    end

    def valid_request?(params)
      params['media'].is_a?(Hash) && File.exists?(params['media'][:tempfile])
    end
  end

  post '/upload' do
    halt 415, 'Invalid request.' unless valid_request? params

    tempfile = params['media'][:tempfile]

    begin
      image = MiniMagick::Image.read(tempfile.read)
    rescue MiniMagick::Invalid
      halt 415, 'Wrong image.'
    end

    filename = "#{generate_name}.#{image['format'].downcase}"
    fullpath = "#{settings.root}/images/#{filename}"
    image.write fullpath
    File.chmod(0755, fullpath)

    { url: 'http://i.anakros.me/' + filename }.to_json
  end

  run! if __FILE__ == $PROGRAM_NAME
end
