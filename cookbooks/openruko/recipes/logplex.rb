git "/home/rukosan/openruko/logplex" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/logplex.git"
  action :checkout
end

bash "setup-logplex" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/logplex"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  source /usr/local/bin/nvm/nvm.sh
  make init
  EOF
end

template "/etc/init/openruko-logplex.conf" do
  source "upstart-openruko-logplex.conf.erb"
  owner "root"
  group "root"
  mode 0644
end