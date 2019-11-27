# GeoASN2 Add-On for Splunk

This add-on does local lookups of AS number, organization and selected
geographic data for IP address(es) using the GeoIP2-format database
from MAXMIND.  It is based loosely on and intended as a near-drop-in
replacement for GeoASN by Heinrik Strom at Telenor.

The following commands are provided


| Command       | Input(s)       | Outputs  |
| ------------- | -------------- | -------- |
| asn2          | src_ip dest_ip | src_asn dest_asn |
| ga2           | ip             | country asn org |
| geo2          | clientip       | client_country client_region client_city client_lat client_lon |
| geoasn2       | src_ip dest_ip | src_country dest_country src_asn src_as src_org dest_asn dest_as dest_org |

## Installation

Your system must have the following installed prior to installing this
add-on:

 * Python version 3.6 or later.
 * The GeoIP2 API for Python and all of its prerequisites.  On Linux distributions derived from Red Hat, this is available in the EPEL repo as python-geoip2.

## Setup

Copy the GeoASN2 directory into `$SPLUNK_HOME/etc/apps`.

In the copy, change into the `data` directory and run `make clean
build`.  This will download the latest data from MAXMIND and make it
ready for use.  This process can be repeated to update the data.

Restart Splunk.


## Testing the programs

You can 

  cd $SPLUNK_HOME/etc/apps/GeoASN/bin
  $SPLUNK_HOME/bin/splunk cmd python ga.py < ga.csv 

If it works, it should output something along these lines:

ip,country,asn,org
200.148.108.124,Brazil,27699,DE SAO PAULO S/A - TELESP
203.129.108.100,Japan,10000,Nagasaki Cable Media Inc.

You are now ready to start using the GeoASN lookup commands!
  

## Example Searches

If you have logs with a single IP address field:
```
* | lookup ga2 ip
* | lookup ga2 ip AS the_name_of_your_ip_addr_field
```

If you have logs with two IP address fields:
```
* | lookup geoasn2 src_ip dest_ip
* | lookup geoasn2 src_ip AS your_1st_field dest_ip AS your_2nd_field
```


## Example `props.conf`

**TODO: This doesn't work the same way in this version.**

If you always want your searches to lookup the Country, AS number and 
Organization for IP addresses, you can configure props.conf to do this:

[asa]
LOOKUP-geoasn = geoasn2 src_ip dest_ip

In this example, all events with sourcetype 'asa' (Cisco firewall logs) 
will use the geoasn command to lookup the src_ip and dest_ip 
This produces the following fields:

src_country  : The Country as found in the Maxmind GeoCity database
dest_country : The Country as found in the Maxmind GeoCity database
src_asn      : The AS number and Org as found in the Maxmind ASN database
src_as       : The AS number, without the 'AS' prefix 
src_org      : The Organization, without the AS number
dest_asn     : The AS number and Orgn as found in the Maxmind ASN database
dest_as      : The AS number, without the 'AS' prefix 
dest_org     : The Organization, without the AS number

If the IP address being looked up is within the ranges defined in RFC 1918, 
the Country and Organization fields are set to 'RFC1918', to make it easy to 
filter on Private IP addresses. AS number is set to 0.

If the address was not found in the database, and it is not an RFC 1918 address, 
the Country and/or Organization is set to 'Unknown', and the AS number is set to 0.
