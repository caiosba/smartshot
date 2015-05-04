# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartshot/version'

Gem::Specification.new do |spec|
  spec.name          = 'smartshot'
  spec.version       = Smartshot::VERSION
  spec.authors       = ['Caio Almeida']
  spec.email         = ['caiosba@gmail.com']
  spec.description   = %q{Captures a web page as a screenshot using Poltergeist, Capybara and PhantomJS,
                          optionally waiting for elements (defined by CSS selectors) that can be inside iframes}
  spec.summary       = %q{Captures a web page as a screenshot using Poltergeist, Capybara and PhantomJS,
                          optionally waiting for elements (defined by CSS selectors) that can be inside iframes}
  spec.homepage      = 'https://github.com/caiosba/smartshot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'gem-release'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'poltergeist', '~> 1.5.0'
  spec.add_dependency 'faye-websocket', '~> 0.7.3'
end
