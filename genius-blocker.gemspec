# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'genius/blocker/version'

Gem::Specification.new do |spec|
  spec.name          = "genius-blocker"
  spec.version       = Genius::Blocker::VERSION
  spec.authors       = ["Marla Brizel"]
  spec.email         = ["marlabrizel@gmail.com"]

  spec.summary       = "Rack Middleware to block News Genius annotations"
  spec.description   = "Genius Blocker is a piece of Rack Middleware designed to prevent unwanted annotations by News Genius. The middleware injects a small bit of JavaScript code into the <head></head> of a website in order to force a redirect to the original website whenever anyone attempts to prepend genius.it/ onto a website's URL for annotation purposes."
  spec.homepage      = "https://github.com/marlabrizel/genius-blocker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "oga"

  spec.add_dependency "rack"
end
