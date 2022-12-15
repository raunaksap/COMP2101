#this is a script with variius functions created for gathering system information

#function for system hardware description
function get-hardware{
get-ciminstance win32_computersystem
}

write-output "Hardware information for this computer"
get-hardware

#function for operating system name and version
function get-operating{
get-ciminstance win32_operatingsystem | select -property Name, Version
}

write-output "Operating System"
get-operating

#processor description function
function get-processor{
get-ciminstance win32_processor | select -property Description,NumberOfCores, MaxClockSpeed, L1CacheSize, L2CacheSize

}

write-output "Processor information for this computer"
get-processor

#function for RAM info
function get-ram{
get-ciminstance win32_physicalmemory | select -property Manufacturer, Description, Capacity, BankLabel, DeviceLocator
}

write-output "RAM information"
get-ram

#function to get info on various drives
function get-diskinfo{
 $diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      }
  }
}

write-output "Disk drive information"
get-diskinfo

#function for network adapter info
function get-network{
get-ciminstance win32_networkadapterconfiguration | where-object ipenabled -eq yes | select -property servicename,index,description,IPsubnet,IPaddress,dnsdomain,dnsserver | format-table -autosize
}

write-output "Network adapter information"
get-network

#function for video card info
function get-videocard{
[string]$width = (get-ciminstance win32_videocontroller).CurrentHorizontalResolution
[string]$height = (get-ciminstance win32_videocontroller).CurrentVerticalResolution
$resolution = $width + "x" + $height

[string]$vendor = (get-ciminstance win32_videocontroller).Caption
[string]$description = (get-ciminstance win32_videocontroller).Description
write-output "Vendor: " $vendor
write-output "Description: " $description
write-output "Resolution: " $resolution
}

write-output "Video card information"
get-videocard
