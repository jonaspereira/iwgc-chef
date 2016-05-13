case node['platform'] 
	when 'centos'
		package 'epel-release'
end 	

#package 'nginx'
package 'mysql-server' do
	action :install
end

include_recipe 'nginx::default' 

template '/home/jonaspereira/ahoi.sh' do
	source 'test.sh'
	owner 'jonaspereira'
	group 'jonaspereira'
	mode '0755'
end

bash 'testScriptRun' do
	user 'root'
	cwd '/home/jonaspereira'
	code <<-EOH
	     ./ahoi.sh
	 EOH
end

