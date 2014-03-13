# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retail_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "retail_calendar"
  spec.version       = RetailCalendar::VERSION
  spec.authors       = ["David Balatero"]
  spec.email         = ["dbalatero@gmail.com"]
  spec.summary       = %q{Allows you to get date ranges for the 4-5-4 retail calendar.}
  spec.homepage      = "https://github.com/Totokaelo/retail_calendar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
