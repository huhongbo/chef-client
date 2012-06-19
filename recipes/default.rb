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
