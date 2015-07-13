trusted_certificate 'Github Enterprise' do
  certificate_name 'github_enterprise.company.lan'
  content node['example']['certificate_content']
  action :create
end
