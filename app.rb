require 'sinatra'
require 'mini_magick'
require 'json'
require 'securerandom'

class ImagesApp < Sinatra::Base
  ALLOWED = %w(image/png image/bmp image/gif image/jpeg)

  def generate_name
    SecureRandom.hex
  end

  def valid?(image)
    image.valid? && ALLOWED.include?(image.mime_type)
  end

  def valid_request? params
    params['media'].is_a?(Hash) && File.exists?(params['media'][:tempfile])
  end

  post '/upload' do
    halt 415, 'Invalid request.' unless valid_request? params

    tempfile = params['media'][:tempfile]

    begin
      image = MiniMagick::Image.read(tempfile.read)
    rescue MiniMagick::Invalid
      halt 415, 'The wrong image.'
    end

    filename = "#{generate_name}.#{image['format'].downcase}"
    fullpath = "#{settings.root}/images/#{filename}"
    image.write fullpath
    File.chmod(0755, fullpath)

    { url: "http://i.anakros.me/" + filename }.to_json
  end

  error do
    'Something bad happened...'
  end

  run! if __FILE__ == $PROGRAM_NAME
end
