# Genius::Blocker
Genius Blocker is a piece of Rack Middleware designed to prevent unwanted
annotations by [News Genius](http://news.genius.com/).

The middleware injects a small bit of JavaScript code into the
`<head></head>` of a website in order to force a redirect to the original
website whenever anyone attempts to prepend `genius.it/` onto a website's URL
for annotation purposes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'genius-blocker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install genius-blocker

## Usage

For most applications, you can insert middleware into the config.ru file in the root of the application.

A simple `config.ru` in a Rails application might look
like this after adding Genius::Blocker:

```ruby
require ::File.expand_path('../config/environment',  __FILE__)

use Genius::Blocker
run MyRailsApp::Application
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/marlabrizel/genius-blocker). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct. Any pull requests or issues that do not adhere to these guidelines will be ignored and/or deleted.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

