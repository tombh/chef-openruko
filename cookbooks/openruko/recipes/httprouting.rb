git "/home/rukosan/openruko/httprouting" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/Filirom1/httprouting.git"
  action :checkout
  revision node["versions"]["httprouting"]
end

bash "setup-httprouting" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/httprouting"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  set -e
  make init
  echo -e '\n\n\n\n\n\n\n\n' | make certs
  EOF
end

template "/etc/init/openruko-httprouting.conf" do
  source "upstart-openruko-httprouting.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
