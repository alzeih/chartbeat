# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chartbeat/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Al Shaw", "Alli Witheford"]
  gem.email         = ["almshaw@gmail.com"]
  gem.description   = %q{A Ruby wrapper for the Chartbeat API}
  gem.summary       = %q{A Ruby wrapper for the updated Chartbeat API}
  gem.homepage      = "http://github.com/ashaw/chartbeat"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chartbeat"
  gem.require_paths = ["lib"]
  gem.version       = Chartbeat::VERSION

  gem.add_runtime_dependency 'crack'
  gem.add_runtime_dependency 'rest-client'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
end
