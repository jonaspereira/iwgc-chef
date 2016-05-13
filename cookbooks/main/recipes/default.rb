package 'epel-release'
package 'nginx'
package 'mysql-server'
#package 'nload'
#package 'nmap'
package 'htop'
package 'php'
#package 'gcc'
#package 'g++'
#package 'kernel-devel'

include_recipe 'nginx::default' 
template '/home/jonaspereira/ahoi.sh' do
	source 'test.sh.erb'
	owner 'jonaspereira'
	group 'opsworks'
	mode '0755'
	variables(:test => node[:main][:test])
end

bash 'testScriptRun' do
	user 'root'
	cwd '/home/jonaspereira'
	code <<-EOH
	     ./ahoi.sh
	 EOH
end

