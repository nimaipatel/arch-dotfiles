#!/usr/bin/python
import pulsectl
import sys

change = None
if len(sys.argv) != 2:
    sys.exit("Incorrent number of arguments")
else:
    change = float(sys.argv[1])

pulse = pulsectl.Pulse("my-client-name")

inputs = pulse.sink_input_list()

initial = None
for i in inputs:
    if i.proplist["node.name"] != "buckle":
        initial = pulse.volume_get_all_chans(i)
        break

for i in inputs:
    if i.proplist["node.name"] != "buckle":
        pulse.volume_set_all_chans(i, initial + change)

pulse.close()
