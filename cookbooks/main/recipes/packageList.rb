package_list = ['epel-release', 'nginx', 'mysql-server','ncurses-devel', 'nmap', 'htop','php','gcc', 'perl-Switch','perl-DateTime', 'perl-Sys-Syslog', 'perl-LWP-Protocol-https', 'zip', 'unzip']

package_list.each do |packageName|
	package packageName
end
