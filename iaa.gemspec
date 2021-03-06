# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iaa/version'

Gem::Specification.new do |spec|
  spec.name          = "iaa"
  spec.version       = IAA::VERSION
  spec.authors       = ["Alan deLevie", "V. David Zvenyach"]
  spec.email         = ["alan.delevie@gsa.gov"]
  spec.summary       = %q{Programatically fills PDF to produce Inter-Agency Agreements (IAAs)}
  spec.description   = %q{Helps you create IAAs}
  spec.homepage      = "https://github.com/18f/iaa-gem"
  spec.license       = "See LICENSE.md"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "pdf-forms"
  spec.add_runtime_dependency "cliver"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "sinatra"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "webmock"
end
