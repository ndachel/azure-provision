require 'chef/provisioning/azure_driver'
require 'chef/provisioning'

cloud_count = 1
my_run_list = ['my-couchdb::base-install']

# Local Machines

with_driver 'azure'

machine_options = {
    :bootstrap_options => {
      :vm_user => 'localadmin', #required if Windows
      :cloud_service_name => 'chefprovisioning', #required
      :storage_account_name => 'chefprovisioning', #required
      :vm_size => 'Standard_D1', #optional
      :location => 'West US', #optional
      :tcp_endpoints => '3389:3389', #optional
      :winrm_transport => { #optional
        'https' => { #required (valid values: 'http', 'https')
          :disable_sspi => false, #optional, (default: false)
          :basic_auth_only => false, #optional, (default: false)
          :no_ssl_peer_verification => true #optional, (default: false)
        }
      }
    },
    :password => 'P2ssw0rd', #required
    :image_id => 'a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201506.01-en.us-127GB.vhd' #required
}

machine_batch do
  1.upto(cloud_count) do |i|
    machine "cluster-cloud-#{i}" do
      machine_options machine_options
      run_list my_run_list
    end
  end
end
