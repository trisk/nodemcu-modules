RTCOA Module
============
`rtcoa` is a Lua module for devices running [NodeMCU][1] to communicate with
thermostats using Radio Thermostat Company of America's [WiFi API][2].

[1]: http://nodemcu.com/
[2]: http://www.radiothermostat.com/documents/RTCOAWiFIAPIV1_3.pdf

## Features
* Supports Radio Thermostat and 3M Filtrete thermostats with WiFi capability or
  additional WiFi USNAP module
* Sets attributes on any resources

## Require
```lua
rtcoa = require("rtcoa")
```
## Release
```lua
rtcoa = nil
package.loaded["rtcoa"] = nil
```
## open()
#### Description
Select thermostat host to open (no discovery yet).

#### Syntax
open(host)

#### Parameters
host: Hostname or address of the thermostat

#### Returns
nil

#### Example
```lua
rt_host = "thermostat.xxx"
rtcoa.open(rt_host)
```

## set()
#### Description
Sets attributes of a resource exposed by the API.

#### Syntax
set(resource, attributes)

#### Parameters
resource: A resource name (relative to `/tstat/`).<br />
attributes: A table containing the names and values of attributes to set.

#### Returns
nil

#### Example
```lua
temp_f = 85
rtcoa.set("remote_temp", { ["rem_temp"] = temp_f })
```
