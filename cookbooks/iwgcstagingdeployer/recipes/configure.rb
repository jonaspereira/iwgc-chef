#
awsMetrics = ['mem-util', 'disk-space-util --disk-path=/']
key = node[:awsAccess][:awsKey]
secret = node[:awsAccess][:awsSecret]
environment = node[:environment]

#Create General Configuration File
template "/var/www/iWGCV5/iWGC/protected/config/shared.php" do
       source 'sharedPhpConfig.php.erb'
       owner 'apache'
       group 'apache'
       mode '0755'
       variables( {
                :accessKey              => node[:awsAccess][:awsKey],
                :accessSecret           => node[:awsAccess][:awsSecret],
        })
end

#Create the php configuration file for the environment
template "/var/www/iWGCV5/iWGC/protected/config/#{environment}.php" do
       source 'productionPhpConfig.php.erb'
       owner 'apache'
       group 'apache'
       mode '0755'
       variables( {
#Stack Variables                
		:accessKey 		=> node[:awsAccess][:awsKey],
                :accessSecret 		=> node[:awsAccess][:awsSecret],
		:dbEndpoint 		=> node[:database][:endpoint],
		:dbUser	   		=> node[:database][:user],
		:dbPassword 		=> node[:database][:password],
		:dbSchema		=> node[:database][:schema],
#Layer Variables
	#Cache Settings
		:cacheClass		=> node[:cacheSettings][:class],
		:cacheHost		=> node[:cacheSettings][:connectionParameters][:host],
                :cacheDB      		=> node[:cacheSettings][:connectionParameters][:database], 
	#Session Cache
                :sessionCacheClass     	=> node[:sessionCache][:class],
                :sessionCacheHost      	=> node[:sessionCache][:connectionParameters][:host],   
                :sessionCacheDB      	=> node[:sessionCache][:connectionParameters][:database], 
	#Solr
		:solrHost 		=> node[:solr][:host],
		:solrPort		=> node[:solr][:port],
		:solrTimeout		=> node[:solr][:timeout],
	#API
	       	:apiEndpoint		=> node[:api][:endpoit],
		:apiPort		=> node[:api][:port],
	# Params
		:UsePrimaryDomainRule	=> node[:params][:usePrimaryDomainUrlRule],
		:stripePublishableKey	=> node[:params][:stripe][:publishableKey],
		:stripeSecretKey   	=> node[:params][:stripe][:secretKey],
	# Queue Provider	
		:queueProvider		=> node[:params][:queueProvider][:provider],
		:alertQueueUrl		=> node[:params][:queueProvider][:alertQueueUrl],
                :moderationQueueUrl     => node[:params][:queueProvider][:moderationQueueUrl],
	})
end

#Reload Nginx
service "nginx" do
	action :reload
end



