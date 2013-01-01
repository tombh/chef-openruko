git "/home/rukosan/openruko/gitmouth" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/gitmouth.git"
  action :checkout
end

bash "setup-gitmouth" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/gitmouth"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  set -e
  if [ ! -f ./bin/activate ]; then
  source /usr/local/bin/nvm/nvm.sh
	make init
  fi
  rm -fr certs
  echo '' | make certs
  EOF
end

template "/etc/init/openruko-gitmouth.conf" do
  source "upstart-openruko-gitmouth.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
