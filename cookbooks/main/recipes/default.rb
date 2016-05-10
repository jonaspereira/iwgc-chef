case node['platform']
	when 'centos'
		package 'epel-release'
end
yum_package 'nginx'
yum_package 'mysql-server' do
	action [:install;:start]
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
done

