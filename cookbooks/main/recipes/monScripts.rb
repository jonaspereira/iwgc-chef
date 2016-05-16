awsMetrics = ['mem-util', 'disk-space-util --disk-path=/']
key=node[:awsKey]
secret=node[:awsSecret]
bash 'awsMonitotingInstall' do
	interpreter "bash"
	cwd "/home/ec2-user"
	code <<-EOH
		curl http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip -O
		unzip CloudWatchMonitoringScripts-1.2.1.zip
		rm CloudWatchMonitoringScripts-1.2.1.zip
 	 EOH
end 

awsMetrics.each do |metric|
	sendMetric= metric
	cron metric do
		user 'ec2-user'
		minute '*/5'
		command "~/aws-scripts-mon/mon-put-instance-data.pl --#{sendMetric} --from-cron --aws-access-key-id=#{key} --aws-secret-key=#{secret}"
	end
end
