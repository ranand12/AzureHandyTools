# Total Size of all blobs in Storage account container based off last modified or last created date 
## Useful in estimating cost savings before implementing Lifecycle management for blobs

This script lists all the blobs in a storage account container based off a certain criteria (last modified date or last creation date) 

This will also list the total size of all the blobs which match the criteria - useful if you want to estimate how much you can save by using the Blob Storage LifeCycleManagement feature

**_How to run this script ?_**

Edit the following values alone with the respective fields : 

$storageAccountName = "NAMEOFSTORAGEACCOUNT"

$storageAccountKey = "STORAGEKEY"

$blobContainerName = "BLOBCONTAINERNAME"

$cutoff = Get-Date '9/1/2016 1:00' #modify date here 

$table = @()**

_**Output**_

Will have two fields : 

1. Total size in GB 
2. The table of all the blobs with the modified date, created date and size
