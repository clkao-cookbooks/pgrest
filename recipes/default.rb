
pg_version = node['postgresql']['version'] || '9.2'

node.override['postgresql']['config']['local_preload_libraries'] = 'pgextwlist.so'
node.override['postgresql']['config']['extwlist.extensions'] = 'plv8'
node.override['postgresql']['server']['packages'] = ["postgresql-#{ pg_version}", "postgresql-#{ pg_version }-plv8"]

include_recipe 'postgresql::server'

package "libv8-dev"

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
