resource "ibm_compute_vm_instance" "vm1-anpier" {
    hostname = "vm1-anpier"
    domain = "pier.dk"
    os_reference_code = "DEBIAN_8_64"
    datacenter = "fra02"
    network_speed = 100
    hourly_billing = true
    private_network_only = false
    cores = 1
    memory = 1024
    disks = [25]
    local_disk = false
}