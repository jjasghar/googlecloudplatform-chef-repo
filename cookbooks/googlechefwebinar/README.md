# googlechefwebinar

## Commands

Run the following to create everything:

```
CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_create_chef_server]"
CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_create_automate_server]"
```

Wait about 3-4 mins.

ssh into chef-server:

```
gcloud compute --project "jj-test-kitchen" ssh --zone "us-west1-a" "chef-server"
sudo su -
cat /root/delivery.pem
```

ssh into automate:

```
gcloud compute --project "jj-test-kitchen" ssh --zone "us-west1-a" "automate"
sudo su -
```

Setup automate:

```
automate-ctl setup --license /root/delivery.license \
                        --key /root/delivery.pem \
                        --server-url https://chef-server.local/organizations/googlechef \
                        --fqdn automate.local \
                        --enterprise googlechef
```

Add the following to `/etc/delivery/delivery.rb`:

```ruby
data_collector['token'] = '93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'
```

Run:

```
sudo automate-ctl reconfigure
```

ssh into chef-server:

```
gcloud compute --project "jj-test-kitchen" ssh --zone "us-west1-a" "chef-server"
sudo su -

```

Ping automate to make sure the connection works, and set up the connections:

```
ping automate
sudo chef-server-ctl set-secret data_collector token '93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'
sudo chef-server-ctl restart nginx
sudo chef-server-ctl restart opscode-erchef
```

Add the following to `/etc/opscode/chef-server.rb` on the Chef server:

```ruby
data_collector['root_url'] = 'https://chef-server.local/data-collector/v0/'
profiles['root_url'] = 'https://chef-server.local'
```

Then run:

```
sudo chef-server-ctl reconfigure
```

Now lets create a server:

```
CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_create_node]"
```

Clean up:

```
CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_delete_chef_server]"
CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_delete_automate_server]"
CRED_PATH=~/jj-test-kitchen-8dd45fc19cc2.json chef-client -z --runlist "recipe[googlechefwebinar::_delete_node]"
```

Setting up node:

```
mkdir /etc/chef/
vim /etc/chef/googlechef-validator.pem
vim /etc/chef/client.rb
```

client.rb:

```ruby
log_level        :info
log_location     STDOUT
chef_server_url  'https://chef-server.local/organizations/googlechef'
validation_client_name 'googlechef-validator'
validation_key '/etc/chef/googlechef-validator.pem'
ssl_verify_mode :verify_none
```
