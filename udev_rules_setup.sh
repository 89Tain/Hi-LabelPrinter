#!/bin/bash

echo "Setting up udev rules for Label Printers..."

# Identify USB devices using Vendor and Product ID
# udevadm info --name=/dev/ttyUSB0 --attribute-walk

PRINTER1_VENDOR="XXXX"  # Replace with your printer 1 Vendor ID
PRINTER1_PRODUCT="YYYY" # Replace with your printer 1 Product ID
PRINTER2_VENDOR="AAAA"  # Replace with your printer 2 Vendor ID
PRINTER2_PRODUCT="BBBB" # Replace with your printer 2 Product ID

# Create udev rules file
UDEV_RULES_FILE="/etc/udev/rules.d/99-labelprinter.rules"
echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"$PRINTER1_VENDOR\", ATTRS{idProduct}==\"$PRINTER1_PRODUCT\", SYMLINK+=\"ttyUSB0\", MODE=\"0666\"" | sudo tee $UDEV_RULES_FILE

echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"$PRINTER2_VENDOR\", ATTRS{idProduct}==\"$PRINTER2_PRODUCT\", SYMLINK+=\"labelPrinter\", MODE=\"0666\"" | sudo tee -a $UDEV_RULES_FILE

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "✅ udev rules set successfully! Please unplug and plug back your printers."
