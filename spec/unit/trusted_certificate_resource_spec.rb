require 'spec_helper'
require 'chef/resource'

describe Chef::Resource::TrustedCertificate do
  before(:each) do
    @resource = described_class.new('certificate file name')
  end

  describe '#initialize' do
    it 'creates a new Chef::Resource::TrustedCertificate with default attributes' do
      expect(@resource).to be_a(Chef::Resource)
      expect(@resource).to be_a(described_class)
      expect(@resource.provider).to be(Chef::Provider::TrustedCertificate)
      expect(@resource.name).to eql('certificate file name')
      expect(@resource.action).to eql(:create)
      expect(@resource.allowed_actions).to include(:create)
      expect(@resource.allowed_actions).to include(:update)
      expect(@resource.allowed_actions).to include(:delete)
    end

    it 'has a resource name of :trusted_certificate' do
      expect(@resource.resource_name).to eql(:trusted_certificate)
    end
  end

  describe '#content' do
    it 'only accepts a String' do
      @resource.content 'some content'
      expect(@resource.content).to eql('some content')
      expect { @resource.content :not_a_string }.to raise_error(ArgumentError)
    end

    it 'is required' do
      resource = described_class.new('failwhale')
      expect { resource.content }
        .to raise_error(Chef::Exceptions::ValidationFailed)
    end
  end
end
