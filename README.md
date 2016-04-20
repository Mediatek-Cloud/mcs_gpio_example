# mcs_gpio_example

## Usage

* Copy the folder `config/project/mt7687_hdk/mcs_gpio` to your SDK directory `{SDK_Root}/config/project/mt7687_hdk/`

* Copy the folder `project/mt7687_hdk/apps/mcs_gpio` to your SDK directory `{SDK_Root}/config/project/mt7687_hdk/mcs_gpio`

* To build the code, run the command on your SDK_Root : `./build.sh mt7687_hdk mcs_gpio`

* Burn the generated .bin file to your 7687 device.

* Open the 7687 debug window, and type the following commands:

``` bash

nvram set STA Ssid mcs
nvram set STA Password 12345678
nvram set common deviceId 123123123
nvram set common deviceKey 456456456


# mcs is your wifi ssid
# 12345678 is your wifi password
# 123123123 is your mcs deviceId
# 456456456 is your mcs deviceKey

```
* Reboot 7687

* If you want to enable/disable the smart connection feature, go to `{SDK_Root}/mt7687_hdk/apps/mcs_gpio/GCC/feature.mk` and change the line `MTK_SMARTCONNECT_HDK` to `MTK_SMARTCONNECT_HDK = y` or `MTK_SMARTCONNECT_HDK = n`.

## SDK version

* 3.1.0
