case node['platform']
	when 'centos'
		package 'epel-release'
end
yum_package 'nginx'
yum_package 'mysql-server' do
	action :install
end

users_manage 'DevOps' do
        group_id 214
        action [:create]
        data_bag 'user'
end

template '/home/devops/ahoi.sh' do
	source 'test.sh'
	owner 'devops'
	group 'devops'
	mode '0755'
end

script 'ahoi.sh' do
	interpreter 'bash'
	cwd '/home/devops/'
	action :run
end

