lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rack/active_record_reconnector/version"

Gem::Specification.new do |spec|
  spec.name          = "rack-activerecord-reconnector"
  spec.version       = Rack::ActiveRecordReconnector::VERSION
  spec.authors       = ["Colorful Company"]
  spec.email         = ["webmaster@colorfulcompany.co.jp"]

  spec.summary       = %q{A Rack middleware for cleaning ActiveRecord connection when raised Exception.}
  spec.homepage      = "https://github.com/colorfulcompany/rack-activerecord-reconnector"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/colorfulcompany/rack-activerecord-reconnector"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "activerecord"
  
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "minitest-power_assert", "0.3.0"
  spec.add_development_dependency "minitest-reporters", "~> 1"
  spec.add_development_dependency "minitest-hooks"
  spec.add_development_dependency "rr"
  spec.add_development_dependency "sqlite3"
end
