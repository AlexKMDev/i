$LOAD_PATH << File.dirname(__FILE__)

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'
require 'rspec'
require 'app'

describe ImagesApp do
  include Rack::Test::Methods

  def app
    ImagesApp
  end

  ImagesApp.set :app_url, 'http://i.anakros.me'
  ImagesApp.set :upload, "#{File.dirname(__FILE__)}/images"

  it 'should invalid request when upload image with not "media" name in request' do
    file = Rack::Test::UploadedFile.new 'images/test_fail.png', 'image/png'
    post '/upload', not_media: file

    expect(last_response.status).to eql(415)
    expect(last_response.body).to eql('Invalid request.')
  end

  it 'should wrong image when upload invalid image' do
    file = Rack::Test::UploadedFile.new 'images/test_fail.png', 'image/png'
    post '/upload', media: file

    expect(last_response.status).to eql(415)
    expect(last_response.body).to eql('Wrong image.')
  end

  it 'should return url when upload test_ok.png' do
    file = Rack::Test::UploadedFile.new 'images/test_ok.png', 'image/png'
    post '/upload', media: file

    expect(last_response).to be_ok
    response = JSON.parse last_response.body

    expect(response['url']).to include app.settings.app_url
  end
end
