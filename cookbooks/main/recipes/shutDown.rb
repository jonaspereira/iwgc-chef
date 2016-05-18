#remove AWS Alarms
bash 'removeGeneratedAlarms' do
	user 'ec2-user'
	cwd '/home/ec2-user'
	code <<-EOH
	     ./generateAlarms.sh delete
	 EOH
end

