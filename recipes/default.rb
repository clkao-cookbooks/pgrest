package "python-pip" do
  action :install
end

execute "install-pgxnclient" do
  command "pip install pgxnclient"
  not_if "test -e /usr/local/bin/pgxn"
end

package "libv8-dev"

execute "install-plv8" do
  command "pgxn install plv8"
  not_if "test -e /usr/share/postgresql/#{ node['postgresql']['version'] }/extension/plv8.control"
end

execute "install pgrest" do
  command "npm i -g pgrest"
  not_if "test -e /usr/bin/pgrest"
end
