# GUIyetCLI Operating System

An operating system with 2 boot modes, a command line interface and a graphical user interface made of text and characters.

<b>CLI commands:</b>
1. help: Displays a help message.
2. gui: Launches the GUI interface (No reboot required!)

<b>GUI applications:</b>
1. file: Launches the built-in file manager.
2. cli: Launches the CLI interface (No reboot required!)

## Running in a VM (QEMU)
The default RAM value is sufficient for this OS. No storage is needed as the default files are stored within the disk image. To run GUIyetCLI OS, use this command: `qemu-system-x86_64 -drive format=raw,file=GUIyetCLIOS-0.0.1-x86.img`.