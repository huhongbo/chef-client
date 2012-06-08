#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Author:: Bryan Berry (<bryan.berry@gmail.com>)
# Cookbook Name:: chef-client
# Recipe:: cron 
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

root_group = value_for_platform(
                                ["openbsd", "freebsd", "mac_os_x"] => { "default" => "wheel" },
                                ["hpux"] => { "default" => "sys" },
				                        "default" => "root"
                                )


# COOK-635 account for alternate gem paths
# try to use the bin provided by the node attribute
if (chef_in_sane_path=Chef::Client::SANE_PATHS.map{|p| p="#{p}/chef-client";p if ::File.executable?(p)}.compact.first) && chef_in_sane_path
  client_bin = chef_in_sane_path
  # last ditch search for a bin in PATH
elsif (chef_in_path=%x{which chef-client}.chomp) && ::File.executable?(chef_in_path)
  client_bin = chef_in_path
else
  raise "Could not locate the chef-client bin in any known path. Please set the proper path by overriding node['chef_client']['bin'] in a role."
end


%w{run_path cache_path backup_path log_dir}.each do |key|
  directory node["chef_client"][key] do
    recursive true
    owner "root"
    group root_group
    mode 0755
  end
end

cron "chef-client" do
  minute node['chef_client']['cron']['minute']	
  hour	node['chef_client']['cron']['hour']
  user	"root"
  shell	"/bin/bash"
  command "#{client_bin}"
end


