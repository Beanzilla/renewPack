# Renew

Self-Repairing tools and armor pack

## About

This mod supports MTG (via using 3d_armor) and also supports MineClone2. (Excluding the Shears & Elytra from MCL2)

## Credits

* mcl_armor textures with repaint (Original texture is based on the diamond armor set)
* default mtg textures with repaint (Original textures from the iron/steel tool set)
* `renew_plant:plant` texture by Pexels Dominika (Removed background and rescaled, repainted to form end result)
* Original code idea from spacesuit (I found if you wanted to make the suit last a lot longer you could have it repair itself
    while equip.)

## Setup

Currently there are no easily adjustable settings... and the current settings I do have I manually fiddled with to make some what sane defaults.

I do have some very rudimentary debug abilities, it simply dumps what slot it is, and the new durability (in raw) to the logs. (Unfortunately you will need to change it in both renew_tools and renew_armor in their init.lua files)


## News

* Changed the recipe for crafting all equipment due to the fact it is equal to diamond tools/armor thus the need for them to
be expensive.