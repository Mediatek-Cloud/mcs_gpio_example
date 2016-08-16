# mcs_gpio_tcp_example

## Usage

* copy `mcs_gpio_tcp` to your `{SDK_Root}/project/mt7687_hdk/apps/mcs_gpio_tcp`

* Edit the `{SDK_Root}/project/mt7687_hdk/apps/mcs_gpio_tcp/main.c`:

```
#define deviceId "Input your deviceId"
#define deviceKey "Input your deviceKey"
#define Ssid "Input your wifi"
#define Password "Input your password"
#define host "com"

```

* build code, on your SDK_Root : `./build.sh mt7687_hdk mcs_gpio_tcp`

* Burn .bin to your 7687 device.

## SDK version

* [3.3.1](https://cdn.mediatek.com/download_page/index.html?platform=RTOS&version=v3.3.1&filename=LinkIt_SDK_V3.3.1_public.tar.gz)