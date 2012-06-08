# edit dn365

require 'rbconfig'

default["chef_client"]["interval"]    = "1800"
default["chef_client"]["splay"]       = "20"
default["chef_client"]["log_dir"]     = "/var/log/chef"
default["chef_client"]["log_file"]    = nil
default["chef_client"]["log_level"]   = :info
default["chef_client"]["conf_dir"]    = "/etc/chef"
default["chef_client"]["bin"]         = "/usr/bin/chef-client"
default["chef_client"]["server_url"]  = "http://pc-mon02:4000"
default["chef_client"]["validation_client_name"] = "chef-validator"
default["chef_client"]["cron"] = { "minute" => "*/5", "hour" => "*", "path" => nil}
default["chef_client"]["environment"] = nil
default["chef_client"]["hp_cron"] = { "minute" => "0,5,10,15,20,25,30,35,40,45,50,55", "hour" => "*" }

case platform
when "arch"
  default["chef_client"]["init_style"]  = "arch"
  default["chef_client"]["run_path"]    = "/var/run/chef"
  default["chef_client"]["cache_path"]  = "/var/cache/chef"
  default["chef_client"]["backup_path"] = "/var/lib/chef"
when "debian","ubuntu","redhat","centos","fedora"
  default["chef_client"]["init_style"]  = "init"
  default["chef_client"]["run_path"]    = "/var/run/chef"
  default["chef_client"]["cache_path"]  = "/var/chef/cache"
  default["chef_client"]["backup_path"] = "/var/chef/backup"
when "openbsd","freebsd","mac_os_x","mac_os_x_server"
  default["chef_client"]["init_style"]  = "bsd"
  default["chef_client"]["run_path"]    = "/var/run"
  default["chef_client"]["cache_path"]  = "/var/chef/cache"
  default["chef_client"]["backup_path"] = "/var/chef/backup"
when "hpux"
  default["chef_client"]["init_style"] = "hpux"
  default["chef_client"]["run_path"]   = "/var/run"
  default["chef_client"]["cache_path"] = "/var/chef/cache"
  default["chef_client"]["backup_path"] = "/var/chef/backup"
when "openindiana","opensolaris","nexentacore","solaris2"
  default["chef_client"]["init_style"]  = "smf"
  default["chef_client"]["run_path"]    = "/var/run/chef"
  default["chef_client"]["cache_path"]  = "/var/chef/cache"
  default["chef_client"]["backup_path"] = "/var/chef/backup"
when "windows"
  default["chef_client"]["init_style"]  = "winsw"
  default["chef_client"]["run_path"]    = "C:/var/run/chef"
  default["chef_client"]["cache_path"]  = "C:/var/chef/cache"
  default["chef_client"]["backup_path"] = "C:/var/chef/backup"
  default["chef_client"]["conf_dir"]    = "C:/chef"
  default["chef_client"]["bin"]         = File.join(Gem.bindir, "chef-client")
  #Required for minsw wrapper
  default["chef_client"]["ruby_bin"]    = File.join(RbConfig::CONFIG['bindir'], "ruby.exe")
  default["chef_client"]["winsw_url"]   = "http://maven.dyndns.org/2/com/sun/winsw/winsw/1.8/winsw-1.8-bin.exe"
  default["chef_client"]["winsw_dir"]   = "C:/chef/bin"
  default["chef_client"]["winsw_exe"]   = "chef-client.exe"
else
  default["chef_client"]["init_style"]  = "none"
  default["chef_client"]["run_path"]    = "/var/run"
  default["chef_client"]["cache_path"]  = "/var/chef/cache"
  default["chef_client"]["backup_path"] = "/var/chef/backup"
end
