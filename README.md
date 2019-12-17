# Additional code reference for "From failovers to keepalived over vSwitch(es) with Hetzner"

This code serves as demonstration of possible implementations for pruposes of [blog post] called **From failovers to keepalived over vSwitch(es) with Hetzner**

All examples contain fake Public IP addresses. You need to modify the values to make it work properly.

## v1-poc-2-machines

Simple and silly single VRRP instance configuration that utilizes [Hetzner's failover IPs](https://wiki.hetzner.de/index.php/Failover/en).
There's no additional logic that would make this piece of code production ready.

Folder contains [shell script](v1-poc-2-machines/keepalived_notify.sh) (configured as `notify_script` in keepalived config) that handles the Hetzner's Robot API calls to switch failover destination.

## v2-poc-3-machines-vswitch

More sophisticated setup of 2 VRRP instances (equals 2 [Hetzner Failover IPs](https://wiki.hetzner.de/index.php/Failover/en)) running accross 3 machines. This time [`keepalived`](https://www.keepalived.org/manpage.html) daemon communicates over Hetzner's [vSwitch network](https://wiki.hetzner.de/index.php/Vswitch/en).
It's usable piece of code, but still not production ready, read the [blog post] for more details. 

## v3-final-config

Final version that includes all the pieces required to configure the keepalived over vSwitch with additiona IPv[46] subnets for all 3 machines with 3 IP addresses:
  - Debian interfaces configuration with `if-up.d` and `if-down.d` scripts
  - keepalived config files
  - puppet code to automatize all the work

[puppet code](v3-final-config/puppet-code) is a simple version of code that can demonstrates the automation of such setup. It's explicitly written in Hiera without any additional functions or better Hiera code squashing to make it as explicit as possible. In real we utilize additional functions that would make it easier to write and less error prone.

 [blog post]: (https://dtone.engineering/2019/from_failovers_to_keepalived_over_vswitches_with_hetzner/)
