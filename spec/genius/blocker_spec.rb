require 'spec_helper'

describe Genius::Blocker do
  it 'has a version number' do
    expect(Genius::Blocker::VERSION).not_to be nil
  end

  let(:app) do
    Rack::Builder.new do
      use Genius::Blocker
      run lambda { |env| [200, {'Content-Type' => 'text/html'}, [<<-EOT]] }
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

  context 'for an html page' do
    it 'adds a script tag to redirect' do
      document = Oga.parse_html(response.body)
      expect(document.css('head > script').size).to eq 1
    end
  end

  context 'for non-html content' do
    let(:app) do
      Rack::Builder.new do
        use Genius::Blocker
        run lambda { |env| [200, {'Content-Type' => 'application/json'}, []] }
      end
    end

    it 'does not redirect' do
      document = Oga.parse_html(response.body)
      expect(document.css('head > script').size).to eq 0
    end
  end
end
