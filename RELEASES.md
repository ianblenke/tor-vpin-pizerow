# v0.0.1 - Genesis

This is the first release that will boot LEDE to a functional USB gadget mode once flashed.

Note: After the first boot is complete (the LED stops flashing), unplug it and plug it back in again to boot with the USB gadget mode kernel boot parameter changes.

You will see "LEDE.local" appear mdns on the local segment. Default login is root, there is no password yet by default.

    ssh root@LEDE.local

There is also a web administration interface:

    http://LEDE.local

