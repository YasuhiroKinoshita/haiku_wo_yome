# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/haiku_wo_yome/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-haiku_wo_yome"
  spec.version       = Ruboty::HaikuWoYome::VERSION
  spec.authors       = ["Kinoshita.Yasuhiro"]
  spec.email         = ["WhoIsDissolvedGirl+github@gmail.com"]

  spec.summary       = %q{Haiku wo yome, kaisyaku shite yaru}
  spec.description   = %q{Search users message from Slack and find haiku}
  spec.homepage      = "https://github.com/YasuhiroKinoshita/ruboty-haiku_wo_yome"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = 'WTFPL'

  spec.add_runtime_dependency "ruboty", "~> 1.2"
  spec.add_runtime_dependency "ikku", "~> 0.1"
  spec.add_runtime_dependency "slack-api", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "wtfpl_init"
end
