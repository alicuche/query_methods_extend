# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'query_methods_extend/version'

Gem::Specification.new do |spec|
  spec.name          = "query_methods_extend"
  spec.version       = QueryMethodsExtend::VERSION
  spec.authors       = 'Alicuche'
  spec.email         = 'alicuche@gmail.com'
  spec.summary       = 'Query methods extend in rails 4: Asscociation has_many, union, or, like, operators...'
  spec.description   = ''
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord", ">= 3.0"
  spec.add_development_dependency 'rails', '~> 4.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency 'sqlite3'
end
