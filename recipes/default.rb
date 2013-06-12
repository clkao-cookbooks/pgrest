include_recipe 'postgresql::server'

node.override['postgresql']['config']['local_preload_libraries'] = 'pgextwlist.so'
node.override['postgresql']['config']['extwlist.extensions'] = 'plv8'

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

script "install pgextwlist" do
  interpreter "bash"
  user "root"
  cwd "/root"
  code <<-EOH
    git clone git://github.com/dimitri/pgextwlist.git
    cd pgextwlist
    make
    mkdir /usr/lib/postgresql/#{ node['postgresql']['version'] }/lib/plugins
    cp -f ./pgextwlist.so /usr/lib/postgresql/#{ node['postgresql']['version'] }/lib/plugins/
  EOH
  not_if "test -e /usr/share/postgresql/#{ node['postgresql']['version'] }/lib/plugins/pgextwlist.so"
end
