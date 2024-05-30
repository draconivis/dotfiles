# easyeffects

for equalizing on linux i am using easyeffects (fka pulseeffects) which can do much more thanks to linux studio plugins

for getting new equalizers, go to the [autoeq](https://github.com/jaakkopasanen/autoeq) repo and download the txt files to import them (when in the equalizer view, you can select import on the right side)

## presets

you can create presets and save them. they are saved in the input / output directories (if they were linked to `.config/easyeffects` of course)

## autoloading

when easyeffects starts, it can also autoload presets.

to set it up, go into the `pipewire` tab at the top and select `presets autoloading`. then select the device and preset to load and finally click on add. at the bottom you can switch between input and output 