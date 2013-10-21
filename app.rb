require 'sinatra'
require 'mini_magick'
require 'json'

class ImagesApp < Sinatra::Base
  ALLOWED = %w(image/png image/bmp image/gif image/jpeg)

  def image_name
    ('a'..'j').to_a.shuffle.join
  end

  def valid?(image)
    image.valid? && ALLOWED.include?(image.mime_type)
  end

  post '/' do
    status 415 unless params['media'].is_a? Hash

    tempfile = params['media'][:tempfile]
    image = MiniMagick::Image.read(tempfile.read)

    status 415 unless valid? image

    filename = image_name << '.' + image['format'].downcase
    fullpath = "#{settings.root}/images/#{filename}"
    image.write fullpath
    File.chmod(0755, fullpath)

    { url: "http://i.anakros.me/" + filename }.to_json
  end

  error do
    'Somethind bad happened'
  end

  run! if __FILE__ == $PROGRAM_NAME
end
