git "/home/rukosan/openruko/gitmouth" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/gitmouth.git"
  action :checkout
  revision node["versions"]["gitmouth"]
end

bash "setup-gitmouth" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/gitmouth"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  set -e
  if [ ! -f ./bin/activate ]; then
	make init
  fi
  EOF
end

bash "setup-gitmouth-certs" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/gitmouth"

  code <<-EOF
  rm -fr certs
  expect <<- EOH\nspawn make certs \nexpect "*passphrase*"\nsend -- "\r"\nexpect "*passphrase*"\nsend -- "\r"\ninteract\nEOH
  EOF
end

template "/etc/init/openruko-gitmouth.conf" do
  source "upstart-openruko-gitmouth.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
