# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "virb"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.0'

  s.authors     = ["Daniel Choi"]
  s.email       = ["dhchoi@gmail.com"]
  s.homepage    = "http://danielchoi.com/software/virb.html"
  s.summary     = %q{A Vim shell for irb and rails console}
  s.description = %q{A Vim shell for irb and rails console}

  s.rubyforge_project = "virb"

  s.files         = ['bin/virb', 'lib/virb.rb', 'lib/virb.vim', 'lib/virb/railtie.rb', 'virb.gemspec', 'README.md'] 
  s.executables   = ['virb']
  # s.require_paths = ["lib"]
end
