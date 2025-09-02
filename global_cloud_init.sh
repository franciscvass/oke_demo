#!/bin/bash

# DO NOT MODIFY
curl --fail -H "Authorization: Bearer Oracle" -L0 http://169.254.169.254/opc/v2/instance/metadata/oke_init_script | base64 --decode >/var/run/oke-init.sh

## run oke provisioning script
bash -x /var/run/oke-init.sh

# add your code here
# install OCI CLI
yum install python36-oci-cli -y
echo "INSTALL DCGM"
# instal dcgmi
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
dnf clean expire-cache
dnf install -y datacenter-gpu-manager
systemctl --now enable nvidia-dcgm



#touch /var/log/oke.done
# /var/lib/cloud/instance/scripts/worker.sh
#CLUSTER_NAME=${cluster_name}
#POOL_NAME=${pool_name}
#freeformjson="{\"OKEclusterName\":\"$CLUSTER_NAME\"}"

##get the inst OCID
#INST_OCID=$(curl -H "Authorization: Bearer Oracle" http://169.254.169.254/opc/v2/instance/id)
#echo $INST_OCID
## get the comp ocid
#COMP_OCID=$(curl -H "Authorization: Bearer Oracle" http://169.254.169.254/opc/v2/instance/compartmentId)
#echo $COMP_OCID
# add freeform tag on worker nodes
#oci compute instance update --instance-id  $INST_OCID  --freeform-tags $freeformjson --force --auth instance_principal



#oci ce cluster list --compartment-id $COMP_OCID --lifecycle-state "ACTIVE" --name $CLUSTER_NAME --sort-by "TIME_CREATED" --auth instance_principal
##get cluster ocid
#CLUSTER_OCID=$(oci ce cluster list --compartment-id $COMP_OCID --lifecycle-state "ACTIVE" --name $CLUSTER_NAME --sort-by "TIME_CREATED" --query 'data[0].id' --auth instance_principal --raw-output)
##get pool ID
#NODE_POOL_OCID=$(oci ce node-pool list --compartment-id $COMP_OCID --cluster-id $CLUSTER_OCID --lifecycle-state "ACTIVE" --name $POOL_NAME --query 'data[0].id' --auth instance_principal --raw-output)
##get the availability domain
#AD=$(oci ce node-pool get --node-pool-id $NODE_POOL_OCID  --auth instance_principal | jq --arg OCID $INST_OCID '.data.nodes[] | select(.id==$OCID) | ."availability-domain" ' | tr -d '"')
#echo $AD
##get the boot vol OCID 
#BOOT_VOL_OCID=$(oci compute boot-volume-attachment list --availability-domain $AD --compartment-id $COMP_OCID  --instance-id $INST_OCID --query 'data[0]."boot-volume-id"' --raw-output --auth instance_principal)
#echo $BOOT_VOL_OCID
##set the BOOT VOL perf
#oci bv boot-volume update --boot-volume-id $BOOT_VOL_OCID --vpus-per-gb 20 --auth instance_principal

