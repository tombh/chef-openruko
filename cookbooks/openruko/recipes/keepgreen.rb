package "expect"

git "/home/rukosan/openruko/keepgreen" do
  user "rukosan"
  group "rukosan"
  repository "git://github.com/tombh/integration-tests.git"
  action :checkout
end