#Configuration and input Variables
awsMetrics = ['mem-util', 'disk-space-util --disk-path=/']
key = node[:awsAccess][:awsKey]
secret = node[:awsAccess][:awsSecret]

#Download and install AWS monitoring tools
bash 'awsMonitotingInstall' do
	interpreter "bash"
	cwd "/home/ec2-user"
	code <<-EOH
		curl http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip -O
		unzip CloudWatchMonitoringScripts-1.2.1.zip
		rm CloudWatchMonitoringScripts-1.2.1.zip
 	 EOH
end 

#Add custom metrics to cronjob
awsMetrics.each do |metric|
	sendMetric= metric
	cron metric do
		user 'ec2-user'
		minute '*/5'
		command "~/aws-scripts-mon/mon-put-instance-data.pl --#{sendMetric} --from-cron --aws-access-key-id=#{key} --aws-secret-key=#{secret}"
	end
end

#GenerateAlarms Script
template '/home/ec2-user/generateAlarms.sh' do
       source 'generateAlarms.sh.erb'
       owner 'ec2-user'
       group 'opsworks'
       mode '0755'
       variables( {
		:environment => node[:environment], 
		:alarmAction => node[:alarm]
		})
end

#Run command to generate the alarms in AWS
bash 'generateAlarmsRun' do
	user 'ec2-user'
	cwd '/home/ec2-user'
	code <<-EOH
	     ./generateAlarms.sh create
	 EOH
end
