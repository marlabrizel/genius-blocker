require 'spec_helper'

describe Genius::Blocker do
  it 'has a version number' do
    expect(Genius::Blocker::VERSION).not_to be nil
  end

  let(:app) do
    Rack::Builder.new do
      use Genius::Blocker
      run  lambda { |env| [301, {}, [<<-EOT]] }
        <html>
          <head>
          </head>
        </html>
      EOT
    end
  end

  let(:url) { "www.google.com" }
  let(:request) { Rack::MockRequest.new(app) }
  let(:response) { request.get(url) }

  it 'adds a script tag to redirect' do
    document = Oga.parse_html(response.body)
    expect(document.css('head > script').size).to eq 1
  end
end
