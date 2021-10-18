# GeoASN2 Add-On for Splunk

This add-on does local lookups of AS number, organization and selected
geographic data for IP address(es) using the GeoIP2-format database
from MaxMind and ASN data from the RIRS and
[iptoasn.com](https://iptoasn.com).  It is based loosely on and
intended as a near-drop-in replacement for
[GeoASN](https://splunkbase.splunk.com/app/576/) by Heinrik Strom at
Telenor.

The following commands are provided:


| Command       | Input(s)       | Outputs  |
| ------------- | -------------- | -------- |
| asn2          | src_ip dest_ip | src_asn dest_asn |
| asnumber      | asn            | rir country org |
| ga2           | ip             | country asn org |
| geo2          | clientip       | client_country client_region client_city client_lat client_lon |
| geoasn2       | src_ip dest_ip | src_country dest_country src_asn src_as src_org dest_asn dest_as dest_org |

Input can be any set of fields as long as they include those listed.


## Installation

Your system must have the following installed prior to installing this
add-on:

 * Python version 3.6 or later.
 * The GeoIP2 API for Python and all of its prerequisites.
 * SQLite 3.

On systems derived from RHEL 8, `dnf install -y python36,
python3-geoip2 and sqlite` will install the prerequisites.

**NOTE:** These are requirements for the _system_ Python, not the one
built into Splunk.  There is a temporary hack in place to make this
plugin play nicely with Splunk at the author's site by using the
system's Python instead of Splunk's.


You will need a license key issued by MaxMind.  To do that:

 * [Sign up for a MaxMind account](https://www.maxmind.com/en/geolite2/signup).
 * Set up your password as directed in the confirmation email.
 * [Create a license key](https://www.maxmind.com/en/accounts/current/license-key).


## Setup

Copy the GeoASN2 directory into `$SPLUNK_HOME/etc/apps`.

In the copy, create a file in the `etc` directory called
`maxmind-key` containing your license key.

In the top-level directory of the copy, run `make` to set up the
add-on and update the data.

Optionally, test the programs using the procedure below.

Restart Splunk.


## Updating the Data

The data can be brought up to date by doing the following:

```
$ make -C $SPLUNK_HOME/etc/apps/GeoASN2 update
```

Running this regularly in a `cron(8)` job is recommended.


## Testing the Programs

You can verify that the programs work by doing the following:

```
$ cd $SPLUNK_HOME/etc/apps/GeoASN2/bin
$ make test
```

If it works, you should see output for each of the programs that
resembles this:

```
ip,country,asn,org
200.148.108.124,Brazil,27699,DE SAO PAULO S/A - TELESP
203.129.108.100,Japan,10000,Nagasaki Cable Media Inc.
```

Note that there are a couple of items in the input that are erroneous.
These exist to make sure the programs behave gracefully and should be
pretty obvious.  Ignore any warnings about invalid data.
  

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
