#!/usr/bin/python
import pulsectl

pulse = pulsectl.Pulse("my-client-name")
sink = pulse.sink_list()[0]
pulse.mute(sink, mute=(not sink.mute))
print(sink.mute and "true" or "false")
pulse.close()
