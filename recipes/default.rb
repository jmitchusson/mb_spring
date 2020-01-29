#Attributes declared in install_spring_apps.rb 

#Installs java 8 and firewalld
node['packs'].each do |pkg|
  package pkg
end

#Creates dirs for the .jar file
node['nec_dirs'].each do |ndirs|
  directory ndirs
end

#Imports the jar form cookbook to dir created above
cookbook_file '/src/target/hello_world_SNAPSHOT.jar' do
  source 'hello_world_SNAPSHOT.jar'
end

#Enable and Start firewalld
service 'firewalld' do
  action [:enable, :start]
end

#Expose port 8080 to the public
execute 'sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp' do
  action :run
  notifies :reload, 'service[firewalld]', :immediately
  not_if 'firewall-cmd --info-zone=public | grep 8080'
end

#Deploy the jar 
execute 'java -jar /src/target/hello_world_SNAPSHOT.jar & ' do
  action :run
  not_if 'curl localhost:8080'
end
