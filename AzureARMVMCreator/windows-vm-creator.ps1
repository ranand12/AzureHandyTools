$csv = Import-csv '<file url>\SampleInput.csv'

foreach ($vm in $csv )
{

  if(!(Get-AzureRmResourceGroup -Name $vm.Rg))
  {
    New-AzureRmResourceGroup -Name $vm.Rg -Location $vm.Location
  }



  $vnet = Get-AzureRmVirtualNetwork -Name $vm.VNetName -ResourceGroupName $vm.VNetRG
  $subnetConfig = Get-AzureRmVirtualNetworkSubnetConfig -Name $vm.Subnet -VirtualNetwork $vnet



  # Create a virtual network card and associate with public IP address and NSG
  $nic = New-AzureRmNetworkInterface -Name "$($vm.VMName)-nic" -ResourceGroupName $vm.Rg -Location $vm.Location `
  -SubnetId $subnetConfig.Id -PrivateIpAddress $vm.IPAddress 

  # Define a credential object or define it in Azure KeyVault if using runbooks
  $securePassword = ConvertTo-SecureString '<password>' -AsPlainText -Force
  $cred = New-Object System.Management.Automation.PSCredential ("<azureloginusername>", $securePassword)

  # Create a virtual machine configuration


  ##WINDOWS
  $vmConfig = New-AzureRmVMConfig -VMName $vm.VMName -VMSize $vm.VMSize | `
  Set-AzureRmVMOperatingSystem -Windows -ComputerName $vm.VMName -Credential $cred  | `
  Set-AzureRmVMSourceImage -PublisherName $vm.PublisherName -Offer $vm.Offer -Skus $vm.SKUs -Version latest | `
  Add-AzureRmVMNetworkInterface -Id $nic.Id



  New-AzureRmVM -ResourceGroupName $vm.Rg -Location $vm.Location -VM $vmConfig

}

