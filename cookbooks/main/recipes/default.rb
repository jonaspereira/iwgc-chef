include_recipe 'nginx::default' 
include_recipe 'main::packageList'
include_recipe 'main::monScripts'
#template '/home/jonaspereira/ahoi.sh' do
#	source 'test.sh.erb'
#	owner 'jonaspereira'
#	group 'opsworks'
#	mode '0755'
#	variables(:test => node[:main][:test])
#end

#bash 'testScriptRun' do
#	user 'root'
#	cwd '/home/jonaspereira'
#	code <<-EOH
#	     ./ahoi.sh
#	 EOH
#end
