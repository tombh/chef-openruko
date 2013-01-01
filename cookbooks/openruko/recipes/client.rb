git "/home/rukosan/openruko/client" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/client.git"
  action :checkout
end

template "/home/rukosan/.ssh/config" do
  source "ssh-config.erb"
  owner "root"
  group "root"
  mode 0644
end