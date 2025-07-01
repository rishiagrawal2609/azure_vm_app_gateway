variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "app-gateway-rg"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network (e.g., 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_gateway_subnet_cidr" {
  description = "CIDR block for Application Gateway subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_gateway_subnet_2_cidr" {
  description = "CIDR block for second Application Gateway subnet (for high availability)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vm_subnet_cidr" {
  description = "CIDR block for VM subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "vm_size" {
  description = "Size of the Azure VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}



variable "app_gateway_name" {
  description = "Name for the Application Gateway"
  type        = string
  default     = "app-gateway"
}

variable "health_check_path" {
  description = "Path for Application Gateway health checks"
  type        = string
  default     = "/health"
}

variable "health_check_port" {
  description = "Port for Application Gateway health checks"
  type        = string
  default     = "80"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "demo"
    Project     = "app-gateway"
    ManagedBy   = "terraform"
  }
} 