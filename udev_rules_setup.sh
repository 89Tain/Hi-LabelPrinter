#!/bin/bash

echo "Setting up udev rules for Label Printers..."

# Identify USB devices using Vendor and Product ID
# Command to check: udevadm info --name=/dev/usb 

PRINTER1_VENDOR="XXXX"  # Replace with your printer 1 Vendor ID
PRINTER1_PRODUCT="YYYY" # Replace with your printer 1 Product ID
PRINTER2_VENDOR="AAAA"  # Replace with your printer 2 Vendor ID
PRINTER2_PRODUCT="BBBB" # Replace with your printer 2 Product ID
CUSTOM_SYMLINK1="labelPrinter1" # Replace with your custom symlink name
CUSTOM_SYMLINK2="labelPrinter2" # Replace with your custom symlink name

# Create udev rules file
UDEV_RULES_FILE="/etc/udev/rules.d/99-labelprinter.rules"
echo "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"$PRINTER1_VENDOR\", ATTRS{idProduct}==\"$PRINTER1_PRODUCT\", SYMLINK+=$CUSTOM_SYMLINK1, MODE=\"0666\"" | sudo tee $UDEV_RULES_FILE

echo "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"$PRINTER2_VENDOR\", ATTRS{idProduct}==\"$PRINTER2_PRODUCT\", SYMLINK+=$CUSTOM_SYMLINK2, MODE=\"0666\"" | sudo tee -a $UDEV_RULES_FILE

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "✅ udev rules set successfully! Please unplug and plug back your printers."
