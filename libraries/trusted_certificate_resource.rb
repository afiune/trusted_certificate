require 'chef/resource'

class Chef::Resource::TrustedCertificate < Chef::Resource
  provides :trusted_certificate

  def initialize(name, run_context = nil)
    super

    @provider = Chef::Provider::TrustedCertificate
    @resource_name = :trusted_certificate
    @action = :create
    @allowed_actions = [:create, :update, :delete]
  end

  def content(arg = nil)
    set_or_return(
      :content,
      arg,
      kind_of: String, required: true
    )
  end
end
