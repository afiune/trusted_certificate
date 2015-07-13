require 'spec_helper'
require 'chef/provider'

describe Chef::Provider::TrustedCertificate do
  let(:node) { Chef::Node.new }
  let(:run_context) do
    Chef::RunContext.new(node, {}, Chef::EventDispatch::Dispatcher.new)
  end
  let(:new_resource) { Chef::Resource::TrustedCertificate.new('cert name') }
  let(:current_resource) { Chef::Resource::TrustedCertificate.new('cert name') }
  let(:provider) { described_class.new(new_resource, run_context) }

  before do
    provider.current_resource = current_resource
    new_resource.content 'certificate content'
  end

  describe '#whyrun_supported?' do
    it 'should be true' do
      expect(provider.whyrun_supported?).to be true
    end
  end
end
