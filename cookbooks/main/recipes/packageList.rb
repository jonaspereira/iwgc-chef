#Update existing Repositories
bash 'Update Repos' do
	user 'root'
	code  <<-EOH
 		yum update 
	EOH
end

#Select list of packages to install
case node[:layer]
	when  'webserver'
		package_list = ['epel-release', 'nginx', 'mysql-server','ncurses-devel', 'nmap', 'htop','php','gcc', 'perl-Switch','perl-DateTime', 'perl-Sys-Syslog', 'perl-LWP-Protocol-https', 'zip', 'unzip']
	else 
		log 'No layer prescribed'
	end



#Run yum install for each package
package_list.each do |packageName|
	package packageName
end
