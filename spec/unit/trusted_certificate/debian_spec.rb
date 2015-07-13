require 'spec_helper'

describe 'example::default' do
  let(:content) do
    <<-CERT
-----BEGIN CERTIFICATE-----
Trust me, I'm a certificate.
-----END CERTIFICATE-----
    CERT
  end

  let(:cert_file) do
    '/usr/local/share/ca-certificates/github_enterprise.company.lan.crt'
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04',
      step_into: 'trusted_certificate'
    ) do |node|
      node.set['example']['certificate_content'] = content
    end.converge(described_recipe)
  end

  it 'writes certificate to file on disk' do
    expect(chef_run).to create_file(cert_file)
      .with(content: content, owner: 'root', group: 'staff')
  end

  it 'updates the OS trust store' do
    execute = chef_run.execute('update-ca-certificates')
    expect(execute).to do_nothing

    file = chef_run.file(cert_file)
    expect(file).to notify('execute[update-ca-certificates]').to(:run).delayed
  end
end
