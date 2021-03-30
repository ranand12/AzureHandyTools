$storageAccountName = "NAMEOFSTORAGEACCOUNT"
$storageAccountKey = "STORAGEKEY"
$blobContainerName = "BLOBCONTAINERNAME"
$cutoff = Get-Date '9/1/2016 1:00' #modify date here 
$table = @()



###DO NOT EDIT ANYTHING BELOW THIS ####

$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
$blobs= Get-AzStorageBlob -Container $blobContainerName  -Context $ctx | ? {$_.BlobProperties.LastModified -ge $cutoff } 
$totalsize=$null
foreach ($blob in $blobs) 
{

$table = $table + [pscustomobject] @{
Name = $blob.Name
LastModified = $blob.BlobProperties.LastModified
CreatedOn = $blob.BlobProperties.CreatedOn
SizeinB = $blob.BlobProperties.ContentLength

}

$totalsize = $totalsize + $blob.BlobProperties.ContentLength

}

$totalsizeString = $totalsize.ToString()
$totalsizeinGB=$totalsizeString/1073741824

Write-host "Total size in GB $totalsizeinGB"
Write-host "-----------------------------------------------------------------------------------------------"

Write-host "File information"

Write-Host ($table | Format-Table | Out-String)
#if you want to run query for created time 
#Get-AzStorageBlob -Container $blobContainerName  -Context $ctx | ? {$_.BlobProperties.CreatedOn-ge $cutoff }




