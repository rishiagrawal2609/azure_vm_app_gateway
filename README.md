# Azure Application Gateway with VM Setup

This Terraform configuration creates an Azure Application Gateway with a backend VM, replicating the AWS ALB setup for Azure.

## Architecture Overview

The setup includes:
- **Virtual Network** with multiple subnets
- **Application Gateway** for load balancing (Azure equivalent of AWS ALB)
- **Linux VM** in private subnet running Apache web server
- **Network Security Groups** for proper security configuration
- **Public IP** for external access

## Prerequisites

1. **Azure CLI** installed and authenticated
2. **Terraform** (version >= 1.0)
3. **Azure subscription** with sufficient permissions
4. **Azure subscription** with sufficient permissions

## Quick Start

1. **Clone and navigate to the directory:**
   ```bash
   cd azure_vm_app_gateway
   ```

2. **Copy the example variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit terraform.tfvars** with your specific values:
   ```hcl
   resource_group_name = "your-resource-group-name"
   location            = "your-preferred-region"
   ```

4. **Initialize Terraform:**
   ```bash
   terraform init
   ```

5. **Plan the deployment:**
   ```bash
   terraform plan
   ```

6. **Apply the configuration:**
   ```bash
   terraform apply
   ```

## Configuration

### Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `resource_group_name` | Azure Resource Group name | `app-gateway-rg` |
| `location` | Azure region | `East US` |
| `vnet_cidr` | Virtual Network CIDR | `10.0.0.0/16` |
| `app_gateway_subnet_cidr` | Application Gateway subnet | `10.0.1.0/24` |
| `vm_subnet_cidr` | VM subnet | `10.0.3.0/24` |
| `vm_size` | VM size | `Standard_B1s` |
| `admin_username` | VM admin username | `azureuser` |

### Network Architecture

```
Internet
    │
    ▼
┌─────────────────┐
│  Public IP      │
└─────────────────┘
    │
    ▼
┌─────────────────┐
│ Application     │ ← Public Subnet (10.0.1.0/24)
│ Gateway         │
└─────────────────┘
    │
    ▼
┌─────────────────┐
│ Private VM      │ ← Private Subnet (10.0.3.0/24)
│ (Apache)        │
└─────────────────┘
```

## Outputs

After successful deployment, you'll get:

- **Application Gateway Public IP**: External access point
- **VM Private IP**: Internal VM address
- **Health Check URL**: `/health` endpoint
- **Status Page URL**: `/status` endpoint
- **Main Application URL**: Root endpoint

## Testing

1. **Access the main application:**
   ```bash
   curl http://<app-gateway-public-ip>/
   ```

2. **Check health status:**
   ```bash
   curl http://<app-gateway-public-ip>/health
   ```

3. **View server status:**
   ```bash
   curl http://<app-gateway-public-ip>/status
   ```

## VM Access

The VM is configured with password authentication enabled. You can access it through the Azure portal or using SSH with the admin username.

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

## Troubleshooting

### Common Issues

1. **Application Gateway Health Checks:**
   - Check if Apache is running on the VM
   - Verify the `/health` endpoint is accessible
   - Check NSG rules allow traffic from Application Gateway subnet

3. **VM Connectivity:**
   - Ensure the VM is in the correct subnet
   - Verify NSG rules are properly configured
   - Check if cloud-init completed successfully

### Debugging Commands

1. **Check VM status:**
   ```bash
   ssh azureuser@<vm-private-ip> "systemctl status apache2"
   ```

2. **Test local web server:**
   ```bash
   ssh azureuser@<vm-private-ip> "curl -s http://localhost/health"
   ```

3. **View cloud-init logs:**
   ```bash
   ssh azureuser@<vm-private-ip> "sudo cat /var/log/cloud-init-output.log"
   ```

## Security Considerations

- VM is placed in private subnet for security
- NSG rules restrict access to necessary ports only
- Application Gateway provides SSL termination capability
- Consider enabling HTTPS for production use

## Cost Optimization

- Use `Standard_B1s` VM size for development/testing
- Consider using Spot instances for non-critical workloads
- Monitor Application Gateway usage and adjust capacity as needed

## Differences from AWS Version

| AWS Component | Azure Equivalent |
|---------------|------------------|
| VPC | Virtual Network |
| ALB | Application Gateway |
| Security Groups | Network Security Groups |
| EC2 Instance | Virtual Machine |
| Target Groups | Backend Address Pools |
| Health Checks | Probes |

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Azure Application Gateway documentation
3. Verify Terraform provider version compatibility 