require 'chef/provisioning/azure_driver'
require 'chef/provisioning'

cloud_count = 1
my_run_list = ['my-couchdb::base-install']

# Local Machines

with_driver 'azure'

machine_options = {
    :bootstrap_options => {
      :cloud_service_name => 'mbfrahryTest', #required
      :storage_account_name => 'mbfrahrytest', #required
      :vm_size => "Standard_D1", #required
      :location => 'Central US', #required
      :tcp_endpoints => '80:80' #optional
    },
    :image_id => 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150706-en-us-30GB', #required
    # Until SSH keys are supported (soon)
    :password => "Test12" #required
}

machine_batch do
  1.upto(cloud_count) do |i|
    machine "mbfrahry-#{i}" do
      machine_options machine_options
      run_list my_run_list
    end
  end
end
