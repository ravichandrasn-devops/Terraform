# AWS Single-Instance Web Infrastructure (Terraform)

This repository contains the Terraform configuration to provision a complete, isolated network stack and a public-facing EC2 application server on AWS. It implements a decoupled network architecture using a standalone Network Interface (ENI) and an Elastic IP (EIP).

## Architecture Overview

The configuration executes the following infrastructure blueprint:
1. **Virtual Private Cloud (VPC):** Provisions an isolated `10.201.0.0/16` network.
2. **Internet Gateway (IGW):** Enables communication between the VPC and the public internet.
3. **Route Table:** Configures a public route table routing all outbound traffic (`0.0.0.0/0`) via the IGW.
4. **Subnet:** Allocates a public subnet block (`10.201.33.0/24`) with auto-assign public IP enabled.
5. **Route Table Association:** Binds the public subnet explicitly to the custom route table.
6. **Security Group:** Restricts inbound access to port 80 (HTTP) and permits all outbound traffic.
7. **Network Interface (ENI):** Creates a static standalone network card attached to the subnet and security group.
8. **Elastic IP (EIP):** Allocates a permanent, static public IP address and binds it directly to the standalone ENI.
9. **EC2 Compute Instance:** Launches a `t3.micro` application server using the pre-configured ENI as its primary boot interface (`eth0`).
