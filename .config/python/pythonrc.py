import readline
import sys

readline.write_history_file = lambda *args: None

# prompt characters
sys.ps1 = "\x1b[1;49;33m>>>\x1b[0m "
sys.ps2 = '\x1b[1;49;31m...\x1b[0m '
