
package 'git' do
  action :install
end

case node['platform']
	when 'centos'
		package 'epel-release'
end
package 'nginx'

users_manage 'DevOps' do
	group_id 214
	action [:create]
	data_bag 'user'
end
