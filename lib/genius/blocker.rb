require "genius/blocker/version"

module Genius
  class Blocker
    def initialize(app)
      @app = app
    end

    REDIRECT_SCRIPT = <<-EOF
      <script>
        var annotated = window.location.href.indexOf("genius.it/") != -1;

        if (annotated) {
          window.location.href = window.location.href.replace("genius.it/", "")
        }
      </script>
    EOF

    def call(env)
      status, headers, body = @app.call(env)
      return [status, headers, body] unless html?(headers)

      response = Rack::Response.new([], status, headers)
      body.each do |fragment|
        response.write fragment.gsub(%r{</head>}, "#{REDIRECT_SCRIPT}</head>")
      end

      response.finish
    end

    private

    def html?(headers)
      headers['Content-Type'] =~ /html/
    end
  end
end
