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
        Title="The ridiculously SIMPLE NSG TOOL  " Height="992" Width="1260" HorizontalAlignment="Center" HorizontalContentAlignment="Center" VerticalContentAlignment="Top" VerticalAlignment="Top" WindowStartupLocation="CenterScreen" WindowState="Maximized">
    <ScrollViewer VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Auto">
        <Grid Opacity="0.8" Background="#FFF9FCFC">
            <RadioButton x:Name="radio_ASM" Content="ASM" HorizontalAlignment="Left" Margin="24,22,0,0" VerticalAlignment="Top"/>
            <RadioButton x:Name="radio_ARM" Content="ARM" HorizontalAlignment="Left" Margin="97,22,0,0" VerticalAlignment="Top"/>
            <ComboBox x:Name="combo_Environment" HorizontalAlignment="Left" Margin="247,18,0,0" VerticalAlignment="Top" Width="140"/>
            <Button x:Name="button_Login" Content="Login" HorizontalAlignment="Left" Margin="451,19,0,0" VerticalAlignment="Top" Width="75"/>
            <TextBlock x:Name="tbr_ChooseSubscription" HorizontalAlignment="Left" Margin="24,57,0,0" TextWrapping="Wrap" Text="Choose Subscription" VerticalAlignment="Top"/>
            <ComboBox x:Name="combo_Subscriptions" HorizontalAlignment="Left" Margin="140,54,0,0" VerticalAlignment="Top" Width="250"/>
            <Button x:Name="button_Go" Content="Load" HorizontalAlignment="Left" Margin="451,53,0,0" VerticalAlignment="Top" Width="75"/>
            <ListView x:Name="lv_NSGRules" HorizontalAlignment="Left" Height="503" Margin="278,113,0,0" VerticalAlignment="Top" Width="760">
                <ListView.View>
                    <GridView>
                        <GridViewColumn Header="RuleName" DisplayMemberBinding ="{Binding 'Name'}" Width="140"/>
                        <GridViewColumn Header="Direction" DisplayMemberBinding ="{Binding 'Type'}" Width="Auto"/>
                        <GridViewColumn Header="Priority" DisplayMemberBinding ="{Binding 'Priority'}" Width="Auto"/>
                        <GridViewColumn Header="Action" DisplayMemberBinding ="{Binding 'Action'}" Width="Auto"/>
                        <GridViewColumn Header="SrcAddress" DisplayMemberBinding ="{Binding 'SourceAddressPrefix'}" Width="Auto"/>
                        <GridViewColumn Header="SrcPort" DisplayMemberBinding ="{Binding 'SourcePortRange'}" Width="Auto"/>
                        <GridViewColumn Header="DestAddress" DisplayMemberBinding ="{Binding 'DestinationAddressPrefix'}" Width="Auto"/>
                        <GridViewColumn Header="DestPort" DisplayMemberBinding ="{Binding 'DestinationPortRange'}" Width="Auto"/>
                        <GridViewColumn Header="Protocol" DisplayMemberBinding ="{Binding 'Protocol'}" Width="Auto"/>
                    </GridView>
                </ListView.View>
            </ListView>

            <ListView x:Name="lv_NSGnames" HorizontalAlignment="Left" Height="415" Margin="43,113,0,0" VerticalAlignment="Top" Width="175">
                <ListView.View>
                    <GridView>
                        <GridViewColumn Header="NSG Names"  DisplayMemberBinding ="{Binding 'Name'}" Width="175"/>
                        <GridViewColumn Header="ResourceGroupName" DisplayMemberBinding ="{Binding 'ResourceGroupName'}"  Width="0" />
                    </GridView>
                </ListView.View>
            </ListView>

            <TextBlock x:Name="tb_ResourceGroupName" HorizontalAlignment="Left" Margin="430,88,0,0" TextWrapping="Wrap" Text="ResourceGroupName -" VerticalAlignment="Top" FontSize="14" FontWeight="Bold"/>
            <TextBlock x:Name="tb_ResourceGroupNamevalue" HorizontalAlignment="Left" Margin="588,88,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" FontSize="14" FontWeight="Bold"/>
            <TextBlock x:Name="tbr_ChooseEnvironment" HorizontalAlignment="Left" Margin="170,21,0,0" TextWrapping="Wrap" Text="Environment" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_Search" HorizontalAlignment="Left" Height="23" Margin="854,80,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <Button x:Name="button_Modify" Content="ModifyRule" HorizontalAlignment="Left" Margin="1057,80,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438"/>
            <Button x:Name="button_AddNew" Content="NewRule" HorizontalAlignment="Left" Margin="1152,80,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438"/>
            <Button x:Name="button_Filter" Content="Filter" HorizontalAlignment="Left" Margin="999,80,0,0" VerticalAlignment="Top" Width="35" RenderTransformOrigin="4.197,0.438"/>
            <TextBlock x:Name="tbr_RuleName" HorizontalAlignment="Left" Margin="1069,110,0,0" TextWrapping="Wrap" Text="RuleName" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_RuleName" HorizontalAlignment="Left" Height="23" Margin="1106,132,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <TextBlock x:Name="tbr_SourceIP" HorizontalAlignment="Left" Margin="1069,170,0,0" TextWrapping="Wrap" Text="SourceIP" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_SourceIP" HorizontalAlignment="Left" Height="23" Margin="1106,192,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <TextBlock x:Name="tbr_SourcePort" HorizontalAlignment="Left" Margin="1069,230,0,0" TextWrapping="Wrap" Text="SourcePort" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_SourcePort" HorizontalAlignment="Left" Height="23" Margin="1106,252,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <TextBlock x:Name="tbr_DestinationIP" HorizontalAlignment="Left" Margin="1069,290,0,0" TextWrapping="Wrap" Text="DestinationIP" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_DestinationIP" HorizontalAlignment="Left" Height="23" Margin="1106,312,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <TextBlock x:Name="tbr_DestinationPort" HorizontalAlignment="Left" Margin="1069,350,0,0" TextWrapping="Wrap" Text="DestinationPort" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_DestinationPort" HorizontalAlignment="Left" Height="23" Margin="1106,377,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <TextBlock x:Name="tbr_Action" HorizontalAlignment="Left" Margin="1069,410,0,0" TextWrapping="Wrap" Text="Action" VerticalAlignment="Top"/>
            <ComboBox x:Name="combo_Action" HorizontalAlignment="Left" Margin="1106,437,0,0" VerticalAlignment="Top" Width="120">
                <ComboBoxItem>Allow</ComboBoxItem>
                <ComboBoxItem>Deny</ComboBoxItem>
            </ComboBox>

            <TextBlock x:Name="tbr_Type" HorizontalAlignment="Left" Margin="1069,470,0,0" TextWrapping="Wrap" Text="Direction" VerticalAlignment="Top"/>
            <ComboBox x:Name="combo_Type" HorizontalAlignment="Left" Margin="1106,497,0,0" VerticalAlignment="Top" Width="120">
                <ComboBoxItem>Inbound</ComboBoxItem>
                <ComboBoxItem>Outbound</ComboBoxItem>
            </ComboBox>
            <TextBlock x:Name="tbr_Protocol" HorizontalAlignment="Left" Margin="1069,530,0,0" TextWrapping="Wrap" Text="Protocol" VerticalAlignment="Top"/>
            <ComboBox x:Name="combo_Protocol" HorizontalAlignment="Left" Margin="1106,557,0,0" VerticalAlignment="Top" Width="120">
                <ComboBoxItem>TCP</ComboBoxItem>
                <ComboBoxItem>UDP</ComboBoxItem>
                <ComboBoxItem>*</ComboBoxItem>
            </ComboBox>
            <Button x:Name="button_Submit" Content="SubmitRule" HorizontalAlignment="Left" Margin="1057,652,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438"/>
            <Button x:Name="button_Export" Content="Export-CSV" HorizontalAlignment="Left" Margin="963,636,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438" Background="#FF7FC7CB"/>
            <TextBlock x:Name="tbr_Priority" HorizontalAlignment="Left" Margin="1069,591,0,0" TextWrapping="Wrap" Text="Priority" VerticalAlignment="Top"/>
            <TextBox x:Name="tb_Priority" HorizontalAlignment="Left" Height="23" Margin="1106,613,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <Button x:Name="button_DeleteRule" Content="DeleteRule" HorizontalAlignment="Left" Margin="1151,652,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438" Background="#FFF28585" FontWeight="Bold"/>
            <TextBlock x:Name="tbr_Priority_Copy" HorizontalAlignment="Left" Margin="552,29,0,0" TextWrapping="Wrap" Text="[[AZURE OPERATIONS TAKE A COUPLE OF MINUTES TO COMPLETE. PLEASE WAIT AFTER YOU CLICK ON A BUTTON FOR THE OPERATION TO COMPLETE]]" VerticalAlignment="Top" Opacity="0.4" Width="500"/>
            <Button x:Name="button_CreateNSG" Content="CreateNSG" HorizontalAlignment="Left" Margin="145,652,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438"/>


            <Grid Background="White" HorizontalAlignment="Left" Height="40" Margin="278,624,0,0" VerticalAlignment="Top" Width="620">

                <TextBlock x:Name="tbr_VNETName" HorizontalAlignment="Left" Margin="259,12,0,0" TextWrapping="Wrap" Text="VNet Name" VerticalAlignment="Top"/>
                <TextBlock x:Name="tbr_SubnetName" HorizontalAlignment="Left" Margin="17,10,0,0" TextWrapping="Wrap" Text="Subnet Name" VerticalAlignment="Top"/>



                <Button x:Name="button_AssociatedNSG" Content="Get Associated NSG" HorizontalAlignment="Left" Margin="478,12,0,0" VerticalAlignment="Top" Width="120" RenderTransformOrigin="4.197,0.438"/>



                <ComboBox x:Name="combo_Subnet" HorizontalAlignment="Left" Margin="117,10,0,0" VerticalAlignment="Top" Width="120">

                </ComboBox>
                <ComboBox x:Name="combo_VNet" HorizontalAlignment="Left" Margin="333,10,0,0" VerticalAlignment="Top" Width="120">

                </ComboBox>

            </Grid>




            <TextBlock x:Name="tbr_NSGName" HorizontalAlignment="Left" Margin="278,88,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" FontSize="14" FontWeight="Bold"/>
            <TextBox x:Name="tb_NSGNameentry" HorizontalAlignment="Left" Height="23" Margin="100,552,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <TextBlock x:Name="tbr_NSGNameentry" HorizontalAlignment="Left" Margin="41,560,0,0" TextWrapping="Wrap" Text="NSGName" VerticalAlignment="Top"/>
            <TextBlock x:Name="tbr_Location" HorizontalAlignment="Left" Margin="43,591,0,0" TextWrapping="Wrap" Text="Location" VerticalAlignment="Top"/>
            <TextBlock x:Name="tbr_RGNameEntry" HorizontalAlignment="Left" Margin="43,622,0,0" TextWrapping="Wrap" Text="RGName" VerticalAlignment="Top"/>
            <ComboBox x:Name="combo_Location" HorizontalAlignment="Left" Margin="99,591,0,0" VerticalAlignment="Top" Width="120"/>
            <TextBox x:Name="tb_RGNameentry" HorizontalAlignment="Left" Height="23" Margin="100,622,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="120" />
            <Button x:Name="button_DeleteNSG" Content="DeleteNSG" HorizontalAlignment="Left" Margin="35,652,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="4.197,0.438" Background="#FFF28585" FontWeight="Bold"/>
        </Grid>
    </ScrollViewer>
</Window>

"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'

[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Error Loading Windows.Markup.XamlReader. Please verify if .NET is installed."}
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "UI_$($_.Name)" -Value $Form.FindName($_.Name)}

$global:NSGRulesList = @()
 
$UI_tb_ResourceGroupName.Visibility = "Hidden" 
$UI_tb_ResourceGroupNamevalue.Visibility = "Hidden"
$global:ismodify = $false

function Validate-Powershell {

Add-Type -AssemblyName System.Windows.Forms
$module = Get-Module | ? { $_.name -like '*Azure*'}
    if($module.Count -eq '0')
    {

         [System.Windows.Forms.MessageBox]::Show("PLEASE ENSURE YOU HAVE AZURE POWERSHELL INSTALLED" , "The ridiculously SIMPLE NSG TOOL " , 1)
    }

}
 
function Get-SaveFile($initialDirectory)
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
    if($UI_radio_ARM.IsChecked)
    {
       
                Login-AzureRmAccount -EnvironmentName $UI_combo_Environment.Text
       

     }
    if($UI_radio_ASM.IsChecked)
    {
       
                Add-AzureAccount -Environment $UI_combo_Environment.Text
         

     }
}

function Populate-AzureSubscriptions
{
    
    if($UI_radio_ASM.IsChecked)
    {
        $subscriptionASM = @((Get-AzureSubscription -ErrorAction SilentlyContinue).SubscriptionId)
        $UI_combo_Subscriptions.ItemsSource = $subscriptionASM
         if(!$subscriptionASM)
        {
             
        $UI_combo_Subscriptions.ItemsSource = ""
        }
        
        
    }
    if($UI_radio_ARM.IsChecked)
    {
        
        $subscriptionARM = @((Get-AzureRmSubscription -ErrorAction SilentlyContinue).SubscriptionId )
        $UI_combo_Subscriptions.ItemsSource = $subscriptionARM
        if(!$subscriptionARM)
        {
             
        $UI_combo_Subscriptions.ItemsSource = ""
        }
        
    }

    $UI_combo_Subscriptions.SelectedIndex = "0"
}

function Populate-AzureNetwork 
{
 if($UI_radio_ASM.IsChecked)
    {
        $VNetConfig = Get-AzureVNetConfig
        [xml]$VNetConfigXML = $VNetConfig.XMLConfiguration
 
        $subnets = $VNetConfigXML.DocumentElement.VirtualNetworkConfiguration.VirtualNetworkSites.VirtualNetworkSite.Subnets

        $UI_combo_Subnet.ItemsSource = @($subnets.Subnet.Name)
        $UI_combo_VNet.ItemsSource = @($VNetConfigXML.DocumentElement.VirtualNetworkConfiguration.VirtualNetworkSites.VirtualNetworkSite.Name)

                
    }

    if($UI_radio_ARM.IsChecked)
    {
        
        $UI_combo_Subnet.ItemsSource = @((Get-AzureRmVirtualNetwork).Subnets.Name)
        $UI_combo_VNet.ItemsSource = @((Get-AzureRmVirtualNetwork).Name)

                
    }


    $UI_combo_Subnet.SelectedIndex = "0"
    $UI_combo_VNet.SelectedIndex = "0"
}
function select-CurrentAzure
{

    if($UI_radio_ASM.IsChecked)
    {
    select-AzureSubscription -Current -SubscriptionId $UI_combo_Subscriptions.SelectedItem 
    
    }
    if($UI_radio_ARM.IsChecked)
    {
    Get-AzureRmSubscription -SubscriptionId $UI_combo_Subscriptions.SelectedItem | select-AzureRmSubscription
    
    }

}

function Get-AssociatedNSG 
{

if($UI_radio_ASM.IsChecked)
{
    $error.Clear()
    $nsg = Get-AzureNetworkSecurityGroupForSubnet -VirtualNetworkName $UI_combo_VNet.SelectedValue -SubnetName $UI_combo_Subnet.SelectedValue 
    if($error[0])
    {
        [System.Windows.Forms.MessageBox]::Show("No associated NSGs - $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
                
    }
    $nsgname = $nsg.Name
    $UI_lv_NSGnames.SelectedItem = $UI_lv_NSGnames.Items | ? { $_.name -eq $nsgname}
    $UI_lv_NSGNames.Focus()
    
    
}

if($UI_radio_ARM.IsChecked)
{
    
    $networkSecurityGroupIDforSubnet=((Get-AzureRmVirtualNetwork).Subnets | ? { $_.name -eq $UI_combo_Subnet.SelectedValue}).NetworkSecurityGroup.Id
    if(!$networkSecurityGroupIDforSubnet)
    {
        [System.Windows.Forms.MessageBox]::Show("No associated NSGs for selected subnet and VNet combination" , "The ridiculously SIMPLE NSG TOOL " , 1)
                
    }
    $splitstring = $networkSecurityGroupIDforSubnet.Split('/')
    $nsgname = $splitstring[$splitstring.IndexOf('networkSecurityGroups')+1]
    $UI_lv_NSGnames.SelectedItem = $UI_lv_NSGnames.Items | ? { $_.name -eq $nsgname}
    $UI_lv_NSGNames.Focus()
    
    
}
Populate-NSGRules

}
function Populate-NSGNames
{
    if($UI_radio_ASM.IsChecked)
    {
        $UI_lv_NSGnames.ItemsSource= @(Get-AzureNetworkSecurityGroup | select Name)
    }
    if($UI_radio_ARM.IsChecked)
    {
        $UI_lv_NSGnames.ItemsSource= @(Get-AzureRmNetworkSecurityGroup)
        
    }
    
}

function Populate-NSGRules
{

    $global:NSGRulesList = @()
    $global:rules =@()

    if($UI_radio_ASM.IsChecked)
    {
        
        $UI_lv_NSGRules.Visibility="Visible"
        $rules = @((Get-AzureNetworkSecurityGroup -Detailed -Name $UI_lv_NSGnames.SelectedItem.Name).Rules)
        foreach ( $rule in $rules ) 
        { 
            $global:rules =  [pscustomobject] @{
                Name = $rule.Name
                Priority = $rule.Priority
                Action = $rule.Action
                SourceAddressPrefix = $rule.SourceAddressPrefix
                SourcePortRange = $rule.SourcePortRange
                DestinationAddressPrefix = $rule.DestinationAddressPrefix
                DestinationPortRange = $rule.DestinationPortRange
                Protocol = $rule.Protocol
                type = $rule.Type
            }
            $global:NSGRulesList +=$global:rules
        }
                
        $UI_lv_NSGRules.ItemsSource = $global:NSGRulesList
        if($global:NSGRulesList.Count -eq '0')
        {
            $UI_lv_NSGRules.ItemsSource.Clear()
        }
       #$UI_lv_NSGRules.ItemsSource = @((Get-AzureNetworkSecurityGroup -Detailed -Name $UI_lv_NSGnames.SelectedItem.Name).Rules)
       # $rules = (Get-AzureNetworkSecurityGroup -Detailed -Name $UI_lv_NSGnames.SelectedItem.Name).Rules
        
       
    }
    if($UI_radio_ARM.IsChecked)
    {
        $UI_lv_NSGRules.Visibility="Visible"
        $UI_tb_ResourceGroupName.Visibility = "Visible"
        $UI_tb_ResourceGroupNamevalue.Visibility = "Visible"
        $UI_tb_ResourceGroupNamevalue.Text = $UI_lv_NSGnames.SelectedItem.ResourceGroupName
        $rules = @((Get-AzureRmNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name -ResourceGroupName $UI_lv_NSGnames.SelectedItem.ResourceGroupName).SecurityRules)
        foreach ( $rule in $rules ) 
        { 
                $global:rules =  [pscustomobject] @{
                Name = $rule.Name
                Priority = $rule.Priority
                Action = $rule.Access
                SourceAddressPrefix = $rule.SourceAddressPrefix
                SourcePortRange = $rule.SourcePortRange
                DestinationAddressPrefix = $rule.DestinationAddressPrefix
                DestinationPortRange = $rule.DestinationPortRange
                Protocol = $rule.Protocol
                type = $rule.Direction
            }
            $global:NSGRulesList +=$global:rules
            $UI_lv_NSGRules.ItemsSource = $global:NSGRulesList
           
        }
       
    }
    $UI_tbr_NSGName.Text = $UI_lv_NSGnames.SelectedItem.Name
}

function Populate-AzureEnvironments
{
    $UI_combo_Environment.ItemsSource= @((Get-AzureEnvironment).Name )
    $UI_combo_Environment.SelectedIndex = $UI_combo_Environment.Items.IndexOf('AzureCloud')
}

function filter-Results 
{

$filterword = '*'+ $UI_tb_Search.Text + '*'
$UI_lv_NSGRules.ItemsSource = @($global:NSGRulesList| ? { $_ -like $filterword})

}

function copy-ValuestoColumn
{

$UI_tb_RuleName.Text =  $UI_lv_NSGRules.SelectedItem.Name
$UI_tb_SourceIP.Text =  $UI_lv_NSGRules.SelectedItem.SourceAddressPrefix
$UI_tb_DestinationIP.Text =  $UI_lv_NSGRules.SelectedItem.DestinationAddressPrefix 
$UI_tb_SourcePort.Text =  $UI_lv_NSGRules.SelectedItem.SourcePortRange
$UI_tb_DestinationPort.Text =  $UI_lv_NSGRules.SelectedItem.DestinationPortRange
$UI_combo_Action.SelectedIndex = $UI_combo_Action.Items.Content.Indexof($UI_lv_NSGRules.SelectedItem.Action)
$UI_combo_Type.SelectedIndex = $UI_combo_Type.Items.Content.Indexof($UI_lv_NSGRules.SelectedItem.Type)
$UI_combo_Protocol.SelectedIndex = $UI_combo_Protocol.Items.Content.Indexof($UI_lv_NSGRules.SelectedItem.Protocol)
$UI_tb_Priority.Text = $UI_lv_NSGRules.SelectedItem.Priority



}

function Enable-ResourceGroupText{

if($UI_radio_ARM.IsChecked)
{
$UI_tb_RGNameentry.IsEnabled = $true
$UI_tb_ResourceGroupName.Visibility ="Visible"
$UI_tb_ResourceGroupNamevalue.Visibility ="Visible"

}
if($UI_radio_ASM.IsChecked)
{
$UI_tb_RGNameentry.IsEnabled = $false
$UI_tb_ResourceGroupName.Visibility ="Hidden"
$UI_tb_ResourceGroupNamevalue.Visibility ="Hidden"
}
}

function clear-ValuesinColumn
{

    $UI_tb_RuleName.Text =  ""
    $UI_tb_SourceIP.Text =  ""
    $UI_tb_DestinationIP.Text =  ""
    $UI_tb_SourcePort.Text = ""
    $UI_tb_DestinationPort.Text =  ""
    $UI_combo_Action.SelectedIndex = -1
    $UI_combo_Type.SelectedIndex = -1
    $UI_combo_Protocol.SelectedIndex = -1



}

function Update-NSGRule
{

if($UI_radio_ASM.IsChecked)

{
    $error.clear()
    Get-AzureNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name | set-AzureNetworkSecurityRule -Name $UI_tb_RuleName.Text -type $UI_combo_Type.SelectedValue.Content -Action $UI_combo_Action.SelectedValue.Content -Priority $UI_tb_Priority.Text -SourceAddressPrefix $UI_tb_SourceIP.Text -SourcePortRange $UI_tb_SourcePort.Text -DestinationAddressPrefix $UI_tb_DestinationIP.Text -DestinationPortRange $UI_tb_DestinationPort.Text -Protocol $UI_combo_Protocol.SelectedValue.Content 
    if($error[0])
    {
        [System.Windows.Forms.MessageBox]::Show("Error occurred in creating NSG - $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
    }

}

if ( $UI_radio_ARM.IsChecked)

{
    if(!$global:ismodify)
    {
        $error.clear()
        Get-AzureRmNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name -ResourceGroupName $UI_lv_NSGnames.SelectedItem.ResourceGroupName | Add-AzureRmNetworkSecurityRuleConfig -Name $UI_tb_RuleName.Text -Protocol $UI_combo_Protocol.SelectedValue.Content -SourcePortRange $UI_tb_SourcePort.Text -DestinationPortRange $UI_tb_DestinationPort.Text -SourceAddressPrefix $UI_tb_SourceIP.Text -DestinationAddressPrefix $UI_tb_DestinationIP.Text -Access $UI_combo_Action.SelectedValue.Content -Priority $UI_tb_Priority.Text -Direction $UI_combo_Type.SelectedValue.Content | set-AzureRmNetworkSecurityGroup

        if($error[0])
        {
            [System.Windows.Forms.MessageBox]::Show("Error occurred in creating NSG rule- $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
        }
    }
    else
    {
    
        $error.clear()
        Get-AzureRmNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name -ResourceGroupName $UI_lv_NSGnames.SelectedItem.ResourceGroupName | set-AzureRmNetworkSecurityRuleConfig -Name $UI_tb_RuleName.Text -Protocol $UI_combo_Protocol.SelectedValue.Content -SourcePortRange $UI_tb_SourcePort.Text -DestinationPortRange $UI_tb_DestinationPort.Text -SourceAddressPrefix $UI_tb_SourceIP.Text -DestinationAddressPrefix $UI_tb_DestinationIP.Text -Access $UI_combo_Action.SelectedValue.Content -Priority $UI_tb_Priority.Text -Direction $UI_combo_Type.SelectedValue.Content | set-AzureRmNetworkSecurityGroup
        if($error[0])
        {
            [System.Windows.Forms.MessageBox]::Show("Error occurred in creating NSG rule - $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
        }

    }
}

Populate-NSGRules
}

function Populate-location
{

if($UI_radio_ASM.IsChecked)
{
    $UI_combo_Location.ItemsSource = @((Get-AzureLocation).Name)
}

if($UI_radio_arm.IsChecked)
{
    $UI_combo_Location.ItemsSource = @((Get-AzureRmLocation).Location)
}
$UI_combo_Location.SelectedIndex = 0
}
function Delete-NSGRule
{

    if($UI_radio_ASM.IsChecked)

    {
    
        $error.clear()
        Get-AzureNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name | Remove-AzureNetworkSecurityRule -Name $UI_lv_NSGRules.SelectedItem.Name -Force
        if($error[0])
        {
            [System.Windows.Forms.MessageBox]::Show("Error occurred in deleting NSG rule- $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
        }

    }

    if ( $UI_radio_ARM.IsChecked)

    {
    
        $error.clear()
        Get-AzureRmNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name -ResourceGroupName $UI_lv_NSGnames.SelectedItem.ResourceGroupName | Remove-AzureRmNetworkSecurityRuleConfig -Name $UI_lv_NSGRules.SelectedItem.Name  | set-AzureRmNetworkSecurityGroup

        if($error[0])
        {
            [System.Windows.Forms.MessageBox]::Show("Error occurred in deleting NSG rule- $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
        }
    


    }
    Populate-NSGRules
}

function Create-NewNSG{

if($UI_radio_ASM.IsChecked)
{

    $error.Clear()
    New-AzureNetworkSecurityGroup -Name $UI_tb_NSGNameentry.Text -Location $UI_combo_Location.SelectedValue 
    if($error[0]){
    [System.Windows.Forms.MessageBox]::Show("Error occurred in creating NSG - $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
    }
}

if($UI_radio_ARM.IsChecked)

{
    $error.clear()
    New-AzureRmNetworkSecurityGroup -Name $UI_tb_NSGNameentry.Text -ResourceGroupName $UI_tb_RGNameentry.Text -Location $UI_combo_Location.SelectedValue
    if($error[0]){
    [System.Windows.Forms.MessageBox]::Show("Error occurred in creating NSG - $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
    }
        
}

Populate-NSGNames

}

function clear-Rules{

$UI_lv_NSGRules.ItemsSource =""
$UI_tbr_NSGName.Text =""
}

function clear-IfZeroRules
{
    if($global:NSGRulesList.Count -eq '0')
    {
        $UI_lv_NSGRules.ItemsSource = ""
    }
}
function Delete-NSG{

  if($UI_radio_ASM.IsChecked)

    {
    
        $error.clear()
        Remove-AzureNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name -Force
        if($error[0])
        {
            [System.Windows.Forms.MessageBox]::Show("Error occurred in deleting NSG -$($UI_lv_NSGnames.SelectedItem.Name).Please ensure the NSG is not associated to a Subnet/VM/NIC- $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
        }

    }

    if ( $UI_radio_ARM.IsChecked)

    {
    
        $error.clear()
        Remove-AzureRmNetworkSecurityGroup -Name $UI_lv_NSGnames.SelectedItem.Name -ResourceGroupName $UI_lv_NSGnames.SelectedItem.ResourceGroupName -Force
        

        if($error[0])
        {
            [System.Windows.Forms.MessageBox]::Show("Error occurred in deleting NSG - $($UI_lv_NSGnames.SelectedItem.Name). Please ensure the NSG is not associated to a Subnet/VM/NIC - $($error[0].Exception.Message)" , "The ridiculously SIMPLE NSG TOOL " , 1)
        }
    


    }
    Populate-NSGNames

}
Populate-AzureEnvironments
$UI_tb_RGNameentry.IsEnabled = $false


$UI_radio_ARM.Add_Click( {
    Populate-AzureSubscriptions 
})

$UI_radio_ASM.Add_Click( { 
    Populate-AzureSubscriptions
})


$UI_button_Login.Add_Click({
    Validate-PowerShell
    Login-Azure
    Populate-AzureSubscriptions 
})


$UI_button_Go.Add_Click({
    select-CurrentAzure
    Populate-NSGNames
    clear-Rules
    Populate-AzureNetwork 
    Enable-ResourceGroupText
    Populate-Location
})


 
$UI_lv_NSGnames.Add_MouseDoubleClick({
    
    Populate-NSGRules
    clear-IfZeroRules
})
 


$UI_button_Filter.Add_Click({

    filter-Results

})

$UI_button_Modify.Add_Click({
    $global:ismodify = $true
    copy-ValuestoColumn

})

$UI_button_AddNew.Add_Click({
$global:ismodify = $false
clear-ValuesinColumn

})

$UI_button_Submit.Add_Click({

    Update-NSGRule

})



$UI_button_Export.Add_Click({

 $exportcsvfile = Get-SaveFile
 $UI_lv_NSGRules.ItemsSource | Export-Csv -Path $exportcsvfile
})

$UI_button_DeleteRule.Add_Click({

$output = [System.Windows.Forms.MessageBox]::Show("ARE YOU SURE YOU WANT TO DELETE THE RULE - $($UI_lv_NSGRules.SelectedItem.Name) WITH PRIORITY -- $($UI_lv_NSGRules.SelectedItem.Priority) ?" , "The ridiculously SIMPLE NSG TOOL " , 4)
if($output -eq "YES")
{
Delete-NSGRule
}
})

$UI_button_AssociatedNSG.Add_Click({

Get-AssociatedNSG
})

$UI_button_CreateNSG.Add_Click({

Create-NewNSG
})

$UI_button_DeleteNSG.Add_Click({
$output = [System.Windows.Forms.MessageBox]::Show("ARE YOU SURE YOU WANT TO DELETE THE NSG - $($UI_lv_NSGnames.SelectedItem.Name)?" , "The ridiculously SIMPLE NSG TOOL" , 4)
if($output -eq "YES")
{
Delete-NSG
}

})
$Form.ShowDialog() | Out-Null


 



