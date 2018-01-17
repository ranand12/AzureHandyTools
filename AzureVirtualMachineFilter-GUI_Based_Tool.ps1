#region Script Settings
#<ScriptSettings xmlns="http://tempuri.org/ScriptSettings.xsd">
#  <ScriptPackager>
#    <process>powershell.exe</process>
#    <arguments />
#    <extractdir>%TEMP%</extractdir>
#    <outputdir>C:\Users\anandku</outputdir>
#    <files />
#    <usedefaulticon>false</usedefaulticon>
#    <icon>C:\Users\anandku\Downloads\windows.ico</icon>
#    <showinsystray>false</showinsystray>
#    <altcreds>false</altcreds>
#    <efs>true</efs>
#    <ntfs>true</ntfs>
#    <local>false</local>
#    <abortonfail>true</abortonfail>
#    <product />
#    <version>1.0.0.1</version>
#    <versionstring />
#    <comments />
#    <company />
#    <includeinterpreter>false</includeinterpreter>
#    <forcecomregistration>false</forcecomregistration>
#    <consolemode>false</consolemode>
#    <EnableChangelog>false</EnableChangelog>
#    <AutoBackup>false</AutoBackup>
#    <snapinforce>false</snapinforce>
#    <snapinshowprogress>false</snapinshowprogress>
#    <snapinautoadd>2</snapinautoadd>
#    <snapinpermanentpath />
#    <cpumode>0</cpumode>
#    <hidepsconsole>false</hidepsconsole>
#  </ScriptPackager>
#</ScriptSettings>
#endregion
Add-Type –AssemblyName System.Windows.Forms
$inputXML = @"
<Window x:Class="WpfApplication1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication1"
        mc:Ignorable="d"
        Title="Azure Virtual Machine Filter - AzureHandyTools" Height="651.135" Width="876.95" ResizeMode="NoResize">
    <Grid Margin="1,0,-1,-0.5">
        <ListView x:Name="listView" HorizontalAlignment="Left" Height="423" Margin="10,177,0,0" VerticalAlignment="Top" Width="840">
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="Name" DisplayMemberBinding ="{Binding 'Name'}" Width="90"/>
                    <GridViewColumn Header="ResourceGroup" DisplayMemberBinding ="{Binding 'ResourceGroup'}" Width="90"/>
                    <GridViewColumn Header="Size" DisplayMemberBinding ="{Binding 'Size'}" Width="100"/>
                    <GridViewColumn Header="PowerState" DisplayMemberBinding ="{Binding 'PowerState'}" Width="100"/>
                    <GridViewColumn Header="PrivateIP" DisplayMemberBinding ="{Binding 'PrivateIP'}" Width="60"/>
                    <GridViewColumn Header="Subnet" DisplayMemberBinding ="{Binding 'Subnet'}" Width="70"/>
                    <GridViewColumn Header="PublicIP" DisplayMemberBinding ="{Binding 'PublicIP'}" Width="60"/>
                    <GridViewColumn Header="AVS" DisplayMemberBinding ="{Binding 'AVS'}" Width="90"/>
                    <GridViewColumn Header="Tags" DisplayMemberBinding ="{Binding 'Tags'}" Width="150"/>
                </GridView>
            </ListView.View>
        </ListView>

        <GroupBox x:Name="gb_AzureLogin" Header="Azure Login &#xA;" HorizontalAlignment="Left" Margin="10,0,0,0" VerticalAlignment="Top" Height="80" Width="250">
            <Grid Margin="0,0,0,0" VerticalAlignment="Top" >
                <ComboBox x:Name="combo_Environment" HorizontalAlignment="Left" Margin="0,0,0,0" VerticalAlignment="Top" Width="140"/>
                <Button x:Name="button_Login" Content="Login" HorizontalAlignment="Left" Margin="150,00,0,0" VerticalAlignment="Top" Width="75"/>
            </Grid>
        </GroupBox>

        <GroupBox x:Name="gb_AzureSubscription" Header="Azure Subscriptions &#xA;" HorizontalAlignment="Left" Margin="270,0,0,0" VerticalAlignment="Top" Height="80" Width="390">
            <Grid Margin="0,0,0,0" VerticalAlignment="Top">
                <ComboBox x:Name="combo_Subscriptions" HorizontalAlignment="Left" Margin="0,0,0,0" VerticalAlignment="Top" Width="250"/>
                <Button x:Name="button_LoadSubscription" Content="Change Subscription" HorizontalAlignment="Left" Margin="260,0,0,0" VerticalAlignment="Top" Width="116"/>
            </Grid>
        </GroupBox>
        <GroupBox x:Name="gb_AzureRefresh" Header="Refresh &#xA;" HorizontalAlignment="Left" Margin="670,0,0,0" VerticalAlignment="Top" Height="80" Width="180">
            <Grid Margin="0,0,0,0" VerticalAlignment="Top">
                <Button x:Name="button_refresh" Content="Refresh" HorizontalAlignment="Left" Margin="00,0,0,0" VerticalAlignment="Top" Width="75"/>
                <TextBlock x:Name="tb_lastsync_name" HorizontalAlignment="Left" Margin="45,18,0,0" TextWrapping="Wrap" Text="Last Synced:" VerticalAlignment="Top" FontSize="8"/>
                <TextBlock x:Name="tb_lastsync_value" HorizontalAlignment="Left" Margin="90,18,0,0" TextWrapping="Wrap" Text="Value" VerticalAlignment="Top" FontSize="8" Foreground="Red"/>
            </Grid>
        </GroupBox>
        <GroupBox x:Name="gb_Filter" Header="Azure Virtual Machine Filter" HorizontalAlignment="Left" Margin="10,90,0,0" VerticalAlignment="Top" Height="75" Width="840">
            <Grid Margin="0,0,0,0" VerticalAlignment="Top">
                <TextBox x:Name="tb_Filter" HorizontalAlignment="Left" Height="23" Margin="10,10,0,0" TextWrapping="Wrap" Text="Filter" VerticalAlignment="Top" Width="120"/>
                <Button x:Name="button_Filter" Content="Filter" HorizontalAlignment="Left" Margin="150,10,0,0" VerticalAlignment="Top" Width="75"/>
                <Button x:Name="button_Export" Content="Export" HorizontalAlignment="Left" Margin="240,10,0,0" VerticalAlignment="Top" Width="75"/>
                <CheckBox x:Name="cb_Filterasyoutype" Content="Filter as you type (slower)" HorizontalAlignment="Left" Margin="10,38,0,0" VerticalAlignment="Top"/>
                
            </Grid>
        </GroupBox>

    </Grid>
</Window>
"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'

[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Error Loading Windows.Markup.XamlReader. Please verify if .NET is installed."}
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "UI_$($_.Name)" -Value $Form.FindName($_.Name)}
Function Get-SaveFile($initialDirectory)
{ 
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
 $SaveFileDialog.initialDirectory = $initialDirectory
 $SaveFileDialog.filter = "CSV files (*.*)| *.csv"
 $SaveFileDialog.ShowDialog() | Out-Null
 $SaveFileDialog.filename
} 


function Login-Azure
{
          
      Login-AzureRmAccount -EnvironmentName $UI_combo_Environment.Text
       

    
}

function Populate-AzureSubscriptions
{
    
   
    
        $subscriptionARM = @((Get-AzureRmSubscription -ErrorAction SilentlyContinue).Name )
        $UI_combo_Subscriptions.ItemsSource = $subscriptionARM
        if(!$subscriptionARM)
        {
             
        $UI_combo_Subscriptions.ItemsSource = ""
        
        }
        
    
    
    $UI_combo_Subscriptions.SelectedIndex = $UI_combo_Subscriptions.items.IndexOf((Get-AzureRmContext).Subscription.Name)
}

function Populate-AzureEnvironments
{
    $UI_combo_Environment.ItemsSource= @((Get-AzureRmEnvironment).Name )
    $UI_combo_Environment.SelectedIndex = $UI_combo_Environment.Items.IndexOf('AzureCloud')
}

function refresh-vm 
{
    $vms = get-azurermvm -Status
    $nics = get-azurermnetworkinterface | where VirtualMachine -NE $null #skip Nics with no VM
    $singlevmdata = $null
    $singlevmdata = @()
    $totalvmdata = $null
    $totalvmdata = @()
    foreach($nic in $nics)
    {


        $vmmatch = ($vms | ? { $_.Id -eq $nic.VirtualMachine.id })
        $privateIP = $nic.IpConfigurations | select-object -ExpandProperty PrivateIpAddress
        if(!$privateIP)
        {
            $privateIP = $null   
        }
  
        try {
        $avs = $vmmatch.AvailabilitySetReference.Id.Split('/')[8]
        if(!$avs)
        {
             $avs = $null
        }
        }
        catch 
        {

        }
    
        $tags =  $vmmatch.Tags.Values
        if(!$tags)
        {
             $tags = $null
        
        }
        else 
        {
    
        
                $tagsplit = $null
                foreach($tag in $tags) 
                {
                $tagsplit =  $tag + ',' + $tagsplit
                }
                $tags = $null
                $tags = $tagsplit
           
        

        }
        $publicIP =   ($nic.IpConfigurations | select-object -ExpandProperty PublicIpAddress).IpAddress

        if( !$publicIP)
        {
            $publicIP = $null
        }
        $Subnet =   $nic.IpConfigurations.Subnet.Id.Split('/')[10] 

        if( !$Subnet )
        {
            $Subnet = $null
        }
   
        $singlevmdata = [pscustomobject] @{ 
            Name = $vmmatch.Name
            ResourceGroup = $vmmatch.ResourceGroupName
            Size = $vmmatch.HardwareProfile.VmSize
            PrivateIP =  $privateIP
            Subnet=  $Subnet
            PublicIP = $publicIP
            AVS = $avs
            PowerState = $vmmatch.PowerState
            Tags = $tags
        } 
    
  
      $totalvmdata += $singlevmdata
    }
   
   
       $UI_tb_lastsync_value.Text = (Get-date -Format g)
       return $totalvmdata
}

function load-azurevmlist
{

 
     $global:TotalVMDataout = refresh-vm 
     $UI_listView.ItemsSource = $global:TotalVMDataout
     $UI_tb_Filter.Text = ""
}


function filter-Results 
{

    $filterword = '*'+ $UI_tb_Filter.Text + '*'
    $UI_listView.ItemsSource = @($global:TotalVMDataout| ? { $_ -like $filterword})

} 
 



 $UI_button_LoadSubscription.add_Click({
 
     Get-AzureRmSubscription -SubscriptionName $UI_combo_Subscriptions.SelectedItem | Select-AzureRmSubscription
     load-azurevmlist


 })

 $UI_button_refresh.add_click({

    load-azurevmlist

 })
 $UI_button_Login.add_Click({

     Login-Azure
     Populate-AzureSubscriptions
     load-azurevmlist

 })
 
 $UI_button_Filter.add_Click({

    filter-Results
 })

 $UI_button_Export.Add_Click({

 $exportcsvfile = Get-SaveFile
 $UI_listView.ItemsSource | Export-csv -NoTypeInformation -Path $exportcsvfile

 })
 
 $UI_tb_Filter.Add_TextChanged({

 if($UI_cb_Filterasyoutype.IsChecked)
 {

 filter-Results

 }
 })

Populate-AzureEnvironments
 
if ((Get-AzureRmContext).Subscription.Name)
 {
     Populate-AzureSubscriptions
     load-azurevmlist
 }


$Form.ShowDialog() | Out-Null