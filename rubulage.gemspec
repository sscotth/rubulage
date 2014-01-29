lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubulage/version'

Gem::Specification.new do |s|
  s.name = 'rubulage'
  s.version = '0.0.1' # RUBULAGE::VERSION
  s.author = 'Scott'
  s.email = 'sscotth@gmail.com'
  s.homepage = 'http://github.com/sscotth/rubulage'
  s.summary = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "sqlite3"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
end
