# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marktag/version'

Gem::Specification.new do |gem|
  gem.name          = "marktag"
  gem.version       = Marktag::VERSION
  gem.authors       = ["Taku Okawa"]
  gem.email         = ["taku.okawa@gmail.com"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = ""

  gem.add_dependency('redcarpet','~>3.1.2')

  gem.add_development_dependency('guard')
  gem.add_development_dependency('guard-minitest')
  gem.add_development_dependency('guard-shell')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
