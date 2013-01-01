package "curl"

script "install-nvm" do
  interpreter "bash"
  user  "root"
  cwd   "/usr/local/bin"

  code <<-EOF
    git clone http://github.com/creationix/nvm.git
    source /usr/local/bin/nvm/nvm.sh
    nvm install 0.8
    nvm alias default 0.8
    npm config set --global registry http://registry.npmjs.org/
  EOF

  not_if "test -d /usr/local/bin/nvm"
end

script "ensure-rukosan-has-nvm" do
  interpreter "bash"
  user  "rukosan"

  code <<-EOF
    echo -e '\n\nsource /usr/local/bin/nvm/nvm.sh' >> /home/rukosan/.bashrc
    source /usr/local/bin/nvm/nvm.sh
  EOF

  not_if "grep nvm.sh /home/rukosan/.bashrc"
end

template "/etc/profile.d/nvm.sh" do
  source "nvm.erb"
  owner "root"
  group "root"
  mode 0755
end
