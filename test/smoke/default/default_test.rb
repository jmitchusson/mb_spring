describe command('java -version 2>&1') do
  its('stdout') { should match /1\.8\.0/ }
end

describe command('sudo lsof -nP -iTCP -sTCP:LISTEN') do
  its('stdout') { should match /8080/ }
end

describe command('curl http://localhost:8080') do
  its('stdout') { should match /Hello World!/ }
end

describe command('curl http://172.18.03:8080') do
  its('stdout') { should match /Hello World!/ }
end

describe command('firewall-cmd --info-zone=public') do
  its('stdout') { should match /8080\/tcp/ }
end
