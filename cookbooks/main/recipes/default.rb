#case node[:layer]
#	when 'phpwebserver'
#		include_recipe 'nginx::default' 
#	else 
#		log 'No layer prescribed'
#end


#Install necessary packages 
include_recipe 'main::packageList'
#Install and configure AWS monitoring Scripts for custom Metrics in AWSCloudwatch
include_recipe 'main::monScripts'

case node[:layer]
       when 'phpwebserver'
               include_recipe 'iwgcstagingdeployer::configure' 
       else 
               log 'No layer prescribed'
end

#include_recipe 'main::curtains'
#############################################################################################
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
