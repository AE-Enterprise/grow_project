

## Reset server back to auto fan control

ipmitool raw 0x3a 0x07 0x01 0x01
ipmitool raw 0x3a 0x07 0x02 0x01


https://github.com/Nammurg/ipmi_fan_control

However - to get the lowest fan speed. 0% needs to be changed to 0x4 not 0x16
