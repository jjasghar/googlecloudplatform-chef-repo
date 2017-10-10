# eval "$(chef shell-init zsh)"
# CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_delete_chef_server]"
#

raise "Missing parameter 'CRED_PATH'. Please read docs at #{__FILE__}" \
  unless ENV.key?('CRED_PATH')

myproject = 'jj-test-kitchen'
instancename = 'node'

gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/compute'
  ]
end

gcompute_zone 'us-west1-a' do
  action :create
  project myproject
  credential 'mycred'
end

gcompute_instance instancename do
  action :delete
  zone 'us-west1-a'
  project myproject
  credential 'mycred'
end
