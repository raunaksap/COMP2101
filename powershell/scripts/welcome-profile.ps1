# Lab 2 COMP2101 welcome script for profile
#

write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."

$cpu = (get-ciminstance cim_processor).name
write-output "This computer is using $cpu"