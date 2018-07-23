# tor-vpin-pizerow

[![Build Status](https://travis-ci.org/sofwerx/tor-vpin-pizerow.svg?branch=master)](https://travis-ci.org/sofwerx/tor-vpin-pizerow)

## TOR VPiN for the Raspberry Pi Zero W

This is a dockerized OpenWRT/LEDE based image builder that prepares USB ethernet gadget mode.

Eventual stretch goal is to support an I2C based OLED + button hat for 2-factor auth and display of active wifi/tor connectivity.

This is a "client" of the tor-vpin deployed cloud infrastructure.

## Usage:

To build an `.img` file to flash to a USB micro-sdcard, just run `make`:

    make

This makefile simply runs:

    docker-compose build
    docker-compose up --force-recreate

When run from a machine with a docker-engine that can write to locally referenced volumes, this generates an `.img` file named `tor-vpin-pizerow.img`.

Strongly recommend installing and running Etcher.io to flash the resultant `outputs/*.img` file to your SDCARD:

- https://etcher.io/

