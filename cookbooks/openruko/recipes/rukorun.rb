git "/home/rukosan/openruko/rukorun" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/rukorun.git"
  action :checkout
  revision node["versions"]["rukorun"]
end

bash "setup-rukorun" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/rukorun"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  source /usr/local/bin/nvm/nvm.sh
  make init
  EOF
end
