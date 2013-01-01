git "/home/rukosan/openruko/apiserver" do
  user "rukosan"
  group "rukosan"

  repository "https://github.com/openruko/apiserver.git"
  action :checkout
  revision node["versions"]["apiserver"]
end

bash "setup-apiserver" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/apiserver"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  set -e
  source /usr/local/bin/nvm/nvm.sh
  make init
  echo -e '\n\n\n\n\n\n\n\n' | make certs
  echo -e '\ny' | ssh-keygen -t rsa -N ''
  EOF
end

bash "setup-postgres" do
  code <<-EOF
  sudo -u postgres psql <<< "CREATE ROLE rukosan PASSWORD 'md5d59d27ea95747738c8b9e5cfd0882e60' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
  EOF
end

bash "setup" do
  user "rukosan"
  cwd "/home/rukosan/openruko/apiserver/postgres"
  environment Hash['HOME' => '/home/rukosan']

  # If there's a pre-existing install don't overwrite DB data on a live system, just update the API funcitons.
  code <<-EOF
  if [[ "$(psql openruko -nq -c "SELECT value FROM openruko_data.settings WHERE key = 'base_domain'")" == *slotbox* ]]; then
    setup="./setup --functions-only"
  else
    setup="./setup"
  fi
  echo -e "openruko\nrukosan\nopenruko@openruko.com\nrukosan" | $setup
  EOF
end

template "/etc/init/openruko-apiserver.conf" do
  source "upstart-openruko-apiserver.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
