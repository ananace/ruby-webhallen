# frozen_string_literal: true

require_relative 'lib/webhallen/version'

Gem::Specification.new do |spec|
  spec.name          = 'webhallen'
  spec.version       = Webhallen::VERSION
  spec.authors       = ['Alexander Olofsson']
  spec.email         = ['ace@haxalot.com']

  spec.summary       = 'Access Webhallen.com public information'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ananace/ruby-webhallen'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.extra_rdoc_files = %w[README.md LICENSE.txt]
  spec.files            = Dir['lib/**/*'] + spec.extra_rdoc_files

  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'test-unit'
end
