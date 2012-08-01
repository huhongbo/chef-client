#
# Cookbook Name:: chef-client
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/etc/chef/plugins" do
  action :create
end

template "/etc/chef/client.rb" do
  source "client.rb.erb"
end

remote_directory "/var/chef/gems" do
  source "gems"
  recursive true
end

gem_package "chef" do
  source "/var/chef/gems/chef-10.12.0.gem"
  options "--no-ri --no-rdoc"
  version "10.12.0"
  action :install
end
