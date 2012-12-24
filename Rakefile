require 'rake'
require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks

desc "release and build and push new website"
task :push => [:release, :web]

desc "build and push website"
task :web => :build_webpage do
  puts "Building and pushing website"
  Dir.chdir "../project-webpages" do
    `scp out/virb.html zoe2@instantwatcher.com:~/danielchoi.com/public/software/`
    `rsync -avz out/images-virb zoe2@instantwatcher.com:~/danielchoi.com/public/software/`
    `rsync -avz out/stylesheets zoe2@instantwatcher.com:~/danielchoi.com/public/software/`
    `rsync -avz out/lightbox2 zoe2@instantwatcher.com:~/danielchoi.com/public/software/`
  end
  `open http://danielchoi.com/software/virb.html`
end

desc "build webpage"
task :build_webpage do
  `cp README.md ../project-webpages/src/virb.README.markdown`

  version = File.read("virb.gemspec")[/s\.version\D+(\d\.\d\.\d)/, 1]
  puts "Version detected: #{version}"
  Dir.chdir "../project-webpages" do
    puts `ruby gen.rb virb #{version}`
    `open out/virb.html`
  end
end

task :default => :test

