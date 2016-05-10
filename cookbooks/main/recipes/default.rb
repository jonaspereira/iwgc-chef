#case node['platform'] 
#	when 'centos'
#		package 'epel-release'
#end 	

#package 'nginx'
#package 'mysql-server' do
#	action :install
#end

users_manage 'devops' do
        action [:create]
        data_bag 'user'
end

template '/home/devops/ahoi.sh' do
	source 'test.sh'
	owner 'devops'
	group 'devops'
	mode '0755'
end

bash 'testScriptRun' do
	user 'root'
	cwd '/home/devops'
	code <<-EOH
	     ./ahoi.sh
	 EOH
end


