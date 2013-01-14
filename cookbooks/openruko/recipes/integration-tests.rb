package "expect"

git "/home/rukosan/openruko/integration-tests" do
  user "rukosan"
  group "rukosan"
  repository "git://github.com/slotbox/integration-tests.git"
  action :checkout
  revision node["versions"]["integration-tests"]
end