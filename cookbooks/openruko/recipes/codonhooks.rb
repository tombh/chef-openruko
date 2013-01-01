git "/home/rukosan/openruko/codonhooks" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/codonhooks.git"
  action :checkout
  revision node["versions"]["codonhooks"]
end
