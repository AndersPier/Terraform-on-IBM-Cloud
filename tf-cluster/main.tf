data ibm_resource_group "resource_group" {
    name = "default"
}

#
# Kubernetes cluster, version 1.24.8 in eu-de region
#
resource ibm_container_cluster "tfcluster" {
    name            = "tfclusterdoc"
    datacenter      = "fra04"
    machine_type    = "b3c.4x16"
    hardware        = "shared"
    public_vlan_id  = "2576961"
    private_vlan_id = "2576959"

    kube_version = "1.24.8"

    default_pool_size = 3
    
    public_service_endpoint  = "true"
    private_service_endpoint = "true"

    resource_group_id = data.ibm_resource_group.resource_group.id
}

#
# OpenShift cluster, version 4.10.39 in eu-de region
# Comment above kubernetes cluster and uncomment below OpenShift cluster to test
#
#resource "ibm_container_cluster" "tfcluster" {
#    name            = "tfcluster"
#    datacenter      = "fra04"
#    machine_type    = "b3c.4x16"
#    hardware        = "shared"
#    public_vlan_id  = "2576961"
#    private_vlan_id = "2576959"
#
#    kube_version = "4.10.39_openshift"
#
#    default_pool_size = 3
#        
#    public_service_endpoint  = "true"
#    private_service_endpoint = "true"
#
#    resource_group_id = data.ibm_resource_group.resource_group.id
#}


#
# Uncomment below 2 blocks, for extending 2 more zones to tfcluster (fra02 and fra05) in eu-de region
#

#resource "ibm_container_worker_pool_zone_attachment" "fra02" {
#cluster         = ibm_container_cluster.tfcluster.id
#worker_pool     = ibm_container_cluster.tfcluster.worker_pools.0.id
#zone            = "fra02"
#private_vlan_id = "<private_vlan_ID_fra02>"
#public_vlan_id  = "<public_vlan_ID_fra02>"
#resource_group_id = data.ibm_resource_group.resource_group.id
#}

#resource "ibm_container_worker_pool_zone_attachment" "fra05" {
#cluster         = ibm_container_cluster.tfcluster.id
#worker_pool     = ibm_container_cluster.tfcluster.worker_pools.0.id
#zone            = "fra05"
#private_vlan_id = "<private_vlan_ID_fra05>"
#public_vlan_id  = "<public_vlan_ID_fra05>"
#resource_group_id = data.ibm_resource_group.resource_group.id
#}

#
# Uncomment below 2 blocks, for adding multizone workerpool to tfcluster (fra02, fra04 and fra05) in eu-de region
#

#resource "ibm_container_worker_pool" "workerpool" {
#    worker_pool_name = "tf-workerpool"
#    machine_type     = "u3c.2x4"
#    cluster          = ibm_container_cluster.tfcluster.id
#    size_per_zone    = 2
#    hardware         = "shared"
#
#    resource_group_id = data.ibm_resource_group.resource_group.id
#}

#resource "ibm_container_worker_pool_zone_attachment" "tfwp-fra04" {
#    cluster         = ibm_container_cluster.tfcluster.id
#    worker_pool     = element(split("/",ibm_container_worker_pool.workerpool.id),1)
#    zone            = "fra04"
#    public_vlan_id  = "2576961"
#    private_vlan_id = "2576959"
#    resource_group_id = data.ibm_resource_group.resource_group.id
#}

#resource "ibm_container_worker_pool_zone_attachment" "tfwp-fra02" {
#    cluster         = ibm_container_cluster.tfcluster.id
#    worker_pool     = element(split("/",ibm_container_worker_pool.workerpool.id),1)
#    zone            = "fra02"
#    private_vlan_id = "<private_vlan_ID_fra02>"
#    public_vlan_id  = "<public_vlan_ID_fra02>"
#    resource_group_id = data.ibm_resource_group.resource_group.id
#}

#resource "ibm_container_worker_pool_zone_attachment" "tfwp-fra05" {
#    cluster         = ibm_container_cluster.tfcluster.id
#    worker_pool     = element(split("/",ibm_container_worker_pool.workerpool.id),1)
#    zone            = "fra05"
#    private_vlan_id = "<private_vlan_ID_fra05>"
#    public_vlan_id  = "<public_vlan_ID_fra05>"
#    resource_group_id = data.ibm_resource_group.resource_group.id
#}

#
#  Remove the default worker pool from your cluster tfcluster (Kubernetes)
#

#resource "null_resource" "delete-default-worker-pool" {
#    provisioner "local-exec" {
#    command = "ibmcloud ks worker-pool rm --cluster ${ibm_container_cluster.tfcluster.id} --worker-pool ${ibm_container_cluster.tfcluster.worker_pools.0.id}"
#    }
#}

#
#  Remove the default worker pool from your cluster tfcluster (OpenShift)
#

#resource "null_resource" "delete-default-worker-pool" {
#    provisioner "local-exec" {
#    command = "ibmcloud oc worker-pool rm --cluster ${ibm_container_cluster.tfcluster.id} --worker-pool ${ibm_container_cluster.tfcluster.worker_pools.0.id}"
#    }
#}



#
# Uncomment to Remove the ibm_container_worker_pool_zone_attachment resources for the default worker pool
#

#resource "ibm_container_worker_pool_zone_attachment" "fra02" {
#cluster         = ibm_container_cluster.tfcluster.id
#worker_pool     = ibm_container_cluster.tfcluster.worker_pools.0.id
#zone            = "fra02"
#private_vlan_id = "<private_vlan_ID_fra02>"
#public_vlan_id  = "<public_vlan_ID_fra02>"
#resource_group_id = data.ibm_resource_group.resource_group.id
#} 

#resource "ibm_container_worker_pool_zone_attachment" "fra05" {
#cluster         = ibm_container_cluster.tfcluster.id
#worker_pool     = ibm_container_cluster.tfcluster.worker_pools.0.id
#zone            = "fra05"
#private_vlan_id = "<private_vlan_ID_fra05>"
#public_vlan_id  = "<public_vlan_ID_fra05>"
#resource_group_id = data.ibm_resource_group.resource_group.id
#}