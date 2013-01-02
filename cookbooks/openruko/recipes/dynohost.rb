git "/home/rukosan/openruko/dynohost" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/dynohost.git"
  action :checkout
end

bash "setup-dynohost" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/dynohost"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  set -e
  make init
  echo -e '\n\n\n\n\n\n' | make certs
  EOF
end

template "/etc/init/openruko-dynohost.conf" do
  source "upstart-openruko-dynohost.conf.erb"
  owner "root"
  group "root"
  mode 0644
end