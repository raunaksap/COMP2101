#this script will pull various info on ip enabled adapters and format them each into a table

get-ciminstance win32_networkadapterconfiguration | where-object ipenabled -eq yes | select -property servicename,index,description,IPsubnet,IPaddress,dnsdomain,dnsserver | format-table -autosize