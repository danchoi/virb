# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require 'virb/version'
Gem::Specification.new do |s|
  s.name        = "virb"
  s.version     = Virb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.0'

  s.authors     = ["Daniel Choi"]
  s.email       = ["dhchoi@gmail.com"]
  s.homepage    = "http://danielchoi.com/software/virb.html"
  s.summary     = %q{A Vim shell for irb and rails console}
  s.description = %q{A Vim shell for irb and rails console}

  s.rubyforge_project = "virb"

  s.files         = ['bin/virb', 'lib/virb.rb', 'lib/virb.vim', 'lib/virb/railtie.rb', 'virb.gemspec', 'lib/virb/version.rb', 'README.md'] 
  s.executables   = ['virb']
  # s.require_paths = ["lib"]
end
