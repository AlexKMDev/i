require 'sinatra/base'
require 'mini_magick'
require 'json'
require 'securerandom'

class ImagesApp < Sinatra::Base
  UNSUPPORTED_MEDIA_HTTP_CODE = 415
  attr_reader :image_name, :fullpath, :image

  helpers do
    def random_name
      SecureRandom.hex
    end

    def make_upload_folder
      File.mkdir settings.upload unless File.exist? settings.upload
    end

    def valid_request?(params)
      params['media'].is_a?(Hash) && File.exists?(params['media'][:tempfile])
    end

    def get_filename
      @image_name = "#{random_name}.#{@image['format'].downcase}"
    end

    def get_fullpath
      @fullpath = "#{settings.upload}/#{get_filename}"
    end

    def save
      @image.write @fullpath
      File.chmod 0755, @fullpath
    end
  end

  post '/upload' do
    halt UNSUPPORTED_MEDIA_HTTP_CODE, 'Invalid request.' unless valid_request? params

    begin
      @image = MiniMagick::Image.read(params['media'][:tempfile].read)
    rescue MiniMagick::Invalid
      halt UNSUPPORTED_MEDIA_HTTP_CODE, 'Wrong image.'
    end

    get_fullpath
    make_upload_folder
    save

    { url: "#{settings.app_url}/#{@image_name}" }.to_json
  end

  run! if __FILE__ == $PROGRAM_NAME
end
