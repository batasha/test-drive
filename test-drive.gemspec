# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test/drive/version'

Gem::Specification.new do |spec|
  spec.name          = 'test-drive'
  spec.version       = Test::Drive::VERSION
  spec.authors       = ['Natasha Badillo']
  spec.email         = ['nbadillo@amplify.com']
  spec.summary       = 'Test-Drive for Jenkins'
  spec.description   = 'A simple command-line tool for running a Jenkins test job before pushing code to the remote repo'
  spec.homepage      = 'https://github.com/amplify-education/test-drive'
  spec.license       = 'mit'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['test-drive']
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'methadone', '~> 1.9'
  spec.add_runtime_dependency 'jenkins_api_client', '~> 1.3'
  spec.add_runtime_dependency 'uuidtools', '~> 2.1'
  spec.add_runtime_dependency 'artii', '~> 2.1'
  spec.add_runtime_dependency 'rainbow', '~> 2.0'
  spec.add_runtime_dependency 'highline', '~> 1.7'
  spec.add_runtime_dependency 'terminal-notifier', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rdoc', '~> 4.2'
  spec.add_development_dependency 'aruba', '~> 0.6'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'coveralls'
end
