include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "1.9.3-p194"


rbenv_gem "bundler" do
  ruby_version "1.9.3-p194"
end

rbenv_gem "rake" do
  ruby_version "1.9.3-p194"
end



git "#{Chef::Config[:file_cache_path]}/balanced-ruby" do
   repository "https://github.com/balanced/balanced-ruby.git"
   reference "master"
   action :sync
 end

bash "run_rake_spec" do
   cwd "#{Chef::Config[:file_cache_path]}/balanced-ruby"
   user "root"
   code <<-EOH
    bundle install
    rake spec
     EOH
   environment 'PREFIX' => "/usr/local"
end

