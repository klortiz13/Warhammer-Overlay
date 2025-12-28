# Warhammer Overlay

## General Set up
1. Download this repository (either by direct zip file download or cloning).
2. Open every `.lua` file and change the variable `local file_path` to the path of that lua file in your personal computer.
3. Open OBS and create a new scene.

## Set up of text files (things that change)
1. Create a new `Text (GDI+)` file and tick the `Read from file` box.
2. Browse and select the file this `Text (GDI+)` file is going to read from (which is any of the text files inside the `data` folder).
3. Click OK.

## Set up of the lua files (the scripts that change the text files)
1. Go to Tools -> Scripts.
2. Click the `+` icon located at the bottom left to add a script.
3. Browse and select each of the `.lua` files inside the `scripts` folder.

## Connect everything
1. Go to Settings -> Hotkeys -> Scroll down until you see the name of this script.
2. Assign a hotkey to trigger that script (could be from keyboard or Stream Deck).
3. Save and test it out!

### Notes
1. If an error occurs or the script didn't load, try removing it and adding it again or closing OBS and opening it again (sometimes it just needs to restart).
2. If the text file is not changing, try checking the `local file_path` vvariable to ensure it is pointing to that target text file.