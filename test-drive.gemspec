# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test/drive/version'

Gem::Specification.new do |spec|
  spec.name          = "test-drive"
  spec.version       = Test::Drive::VERSION
  spec.authors       = ["Natasha Badillo"]
  spec.email         = ["nbadillo@amplify.com"]
  spec.summary       = "Test-Drive for Jenkins"
  spec.description   = "A simple command-line tool for running a Jenkins test job before pushing code to the remote repo"
  spec.homepage      = ""
  spec.license       = "mit"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['test-drive']
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('methadone', '~> 1.8.0')
  spec.add_runtime_dependency "jenkins_api_client"
  spec.add_runtime_dependency "uuidtools"
  spec.add_runtime_dependency "artii"
  spec.add_runtime_dependency "rainbow"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  spec.add_development_dependency('rspec')
end
