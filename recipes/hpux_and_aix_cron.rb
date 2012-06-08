
if (chef_in_sane_path=Chef::Client::SANE_PATHS.map{|p| p="#{p}/chef-client";p if ::File.executable?(p)}.compact.first) && chef_in_sane_path
  client_bin = chef_in_sane_path
  # last ditch search for a bin in PATH
elsif (chef_in_path=%x{which chef-client}.chomp) && ::File.executable?(chef_in_path)
  client_bin = chef_in_path
else
  raise "Could not locate the chef-client bin in any known path. Please set the proper path by overriding node['chef_client']['bin'] in a role."
end

  cron "chef-client" do
    minute node['chef_client']['hp_cron']['minute']	
    hour	node['chef_client']['hp_cron']['hour']
    user	"root"
    shell	"/usr/bin/sh"
    command "#{client_bin}"
  end