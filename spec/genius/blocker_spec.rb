require 'spec_helper'

describe Genius::Blocker do
  it 'has a version number' do
    expect(Genius::Blocker::VERSION).not_to be nil
  end

  let(:app) do
    Rack::Builder.new do
      use Genius::Blocker
      run  lambda { |env| [301, {"Location" => desired_url}, ["Moved Permanently"]] } 
    end
  end

  let(:desired_url) { "www.google.com" }
  let(:request) { Rack::MockRequest.new(app) }
  let(:response) { request.get(url) }

  context 'when the uri is prepended with genius.it' do
    let(:url) { "genius.it/www.google.com" }

    it 'redirects when the uri is prepended with genius.it' do
      expect(response.status).to eq(301)
      expect(response.headers["Location"]).to eq(desired_url)
    end
  end

  context 'when the uri is not prepended with genius.it' do
    let(:url) { "www.google.com" }
    it 'passes through without a genius uri' do
      expect(response.status).to eq(200)
      expect(response.headers["Location"]).to be_nil
    end
  end
end
