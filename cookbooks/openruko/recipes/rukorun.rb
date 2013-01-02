git "/home/rukosan/openruko/rukorun" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/rukorun.git"
  action :checkout
end

bash "setup-rukorun" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/rukorun"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  make init
  EOF
end
