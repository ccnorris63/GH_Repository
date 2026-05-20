#!/bin/sh

echo "Restoring the dock, desktop, and desktop.db files..."
cp -fv ~/Library/Application\ Support/Dock/desktoppicture.db.backup ~/Library/Application\ Support/Dock/desktoppicture.db
cp -fv ~/Library/Preferences/com.apple.desktop.plist.backup ~/Library/Preferences/com.apple.desktop.plist
cp -fv ~/Library/Preferences/com.apple.dock.plist.backup ~/Library/Preferences/com.apple.dock.plist

echo "Time to reboot..."
shutdown -r now
