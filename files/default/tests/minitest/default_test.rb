require File.expand_path('../support/helpers', __FILE__)

describe 'pgrest::default' do
  include Helpers::PgRest

  it 'installs the postgresql server packages' do
    node['postgresql']['server']['packages'].each do |pkg|
      package(pkg).must_be_installed
    end
  end

  it 'installs postgresql-9.2-plv8' do
    package("postgresql-9.2-plv8").must_be_installed
  end

  it 'makes pgrest available' do
    psql = shell_out("pgrest --version")
    assert psql.stdout.include?("PgRest")
  end

end
