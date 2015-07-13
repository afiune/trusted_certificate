require 'chef/provider'

class Chef::Provider::TrustedCertificate < Chef::Provider
  def whyrun_supported?
    true
  end
end
