
# puppet-chronograf

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with puppet-chronograf](#setup)
    * [What chronograf affects](#what-chronograf-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with chronograf](#beginning-with-chronograf)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module is intended as a means to configure and manage [InfluxDB's Chronograf service](https://www.influxdata.com/time-series-platform/chronograf/). It is currently only tested to work on CentOS 7.

At the time of inital writing of this module, Chronograf was young and there were not existing puppet modules for it on the Forge, so I started writing this.

## Setup

### What chronograf affects

This module will likely touch the other aspects of the TICK stack (Telegraf, InfluxDB, and Kapacitor). While not strictly necessary to hook those up using the avaliable parameters, the main functionality is pretty much gone otherwise.

Note that InfluxDB and Kapacitor configurations can be setup directly through the app, rather than through this module. *Setting them up through the module may make them immutable in the Chronograf UI.*

A couple other things to note:
* The influxdb yum repo will be added so that packages can be grabbed from the appropriate source.
* Only Chronograf is installed via this module

### Setup Requirements

If you would like authentication set up, you _must_ provide a `token_secret`, and addition to the required keys.

### Beginning with chronograf

```
include chronograf
```

## Usage

The class parameters line-up almost perfectly with the options shown in the [Chronograf documentation](https://docs.influxdata.com/chronograf/v1.6/administration/config-options/)

To set up with authentication, see the [Chronograf document regarding security](https://docs.influxdata.com/chronograf/v1.6/administration/managing-security/), and apply the appropriate parameters when setting up the class.

**The only class you need to include is the main class!** Everything else is just a private class used by `init.pp`

## Limitations

This module was developed for usage with RHEL/CentOS. It currently is only set to be compatible with those operating systems.

While the actual Chronograf configuration can support up quite a few Authentication methods, the only ones currently supported by this module are Github and Google. The rest will be added at a later point.

## Release Notes/Contributors/Etc.

See [CHANGELOG.md](CHANGELOG.md) for the changelog.
