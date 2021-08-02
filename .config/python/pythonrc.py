# nimai's
#              _   _                                        
#  _ __  _   _| |_| |__   ___  _ __  _ __ ___   _ __  _   _ 
# | '_ \| | | | __| '_ \ / _ \| '_ \| '__/ __| | '_ \| | | |
# | |_) | |_| | |_| | | | (_) | | | | | | (__ _| |_) | |_| |
# | .__/ \__, |\__|_| |_|\___/|_| |_|_|  \___(_) .__/ \__, |
# |_|    |___/                                 |_|    |___/ 

import readline
import sys

readline.write_history_file = lambda *args: None

# prompt characters
sys.ps1 = "\x1b[1;49;33m>>>\x1b[0m "
sys.ps2 = '\x1b[1;49;31m...\x1b[0m '
