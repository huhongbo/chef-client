# code dn365


# COOK-635 account for alternate gem paths
# try to use the bin provided by the node attribute
if ::File.executable?(node["chef_client"]["bin"])
  client_bin = node["chef_client"]["bin"]
  # search for the bin in some sane paths
#elsif (chef_in_sane_path=Chef::Client::SANE_PATHS.map{|p| p="#{p}/chef-client";p if ::File.executable?(p)}.compact.first) && chef_in_sane_path
#  client_bin = chef_in_sane_path
  # last ditch search for a bin in PATH
elsif (chef_in_path=%x{which chef-client}.chomp) && ::File.executable?(chef_in_path)
  client_bin = chef_in_path
else
  raise "Could not locate the chef-client bin in any known path. Please set the proper path by overriding node['chef_client']['bin'] in a role."
end

cron "chef-client" do
  minute node['chef_client']['cron']['minute']	
  hour	node['chef_client']['cron']['hour']
  user	"root"
  command "#{client_bin}"
end


