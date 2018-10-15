
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bowtie/api_adapter/version"

Gem::Specification.new do |spec|
  spec.name          = "bowtie-api_adapter"
  spec.version       = Bowtie::ApiAdapter::VERSION
  spec.authors       = ["Bowtie Team"]
  spec.email         = ["brandon@bowtie.co"]

  spec.summary       = %q{Base API class to handle api calls}
  spec.description   = %q{Creates API calls GET, POST, PATCH, PUT, DELETE for Rails API calls}
  spec.homepage      = "https://www.github.com/bowtie-co/api_adapter"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_dependency "activesupport"
  spec.add_dependency "rest-client"
end
