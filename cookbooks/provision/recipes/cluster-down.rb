require 'chef/provisioning/vagrant_driver'
require 'chef/provisioning/azure_driver'

with_driver 'azure'

# Max topology

local_count = 2
cloud_count = 0

# Destroy local machines
#machine_batch do
  1.upto(local_count) do |i|
    machine "cluster-cloud-#{i}" do
      action :destroy
    end
  end
#end
