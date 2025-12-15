Issues during dev

# Following Tutorial

* When I created room Bedroom, I think I added my background texture directly to the Background scene instead of to the node in the Room scene. This meant that my character never showed up.
    https://carenalgas.github.io/popochiu/how-to-develop-a-game/create-the-first-room/

* Doesn't show how to make it the main scene:
    https://carenalgas.github.io/popochiu/how-to-develop-a-game/create-the-first-room/

> Clicking on the hotspot, the character will move to the point we defined and face the window.
https://carenalgas.github.io/popochiu/how-to-develop-a-game/create-the-first-room/
Doesn't work. but the next section addresses:
> If you ran the game, you may have seen that, while the character moves towards the window, a message is printed on top of the scene: Can't INTERACT with it.
I got stuck before moving on.

It wasn't clear to me that "Look At Point" means "this is where the character looks" as opposed to "this is where we walk when trying to look". "Look At Point" doesn't appear anywhere in the docs.

> Remember to turn on this property to follow up with this tutorial!
rephrase 
> Make sure this property *is set to On* to follow the rest of this tutorial!

* There's no mention of animating characters. [Create characters](https://carenalgas.github.io/popochiu/how-to-develop-a-game/create-characters/) specifically skips the sprite sheet and uses a static image. [The scripting guide mentions walk](https://carenalgas.github.io/popochiu/the-engine-handbook/scripting-reference/PopochiuCharacter/) and "If the characer has a [b]$Sprite2D[/b] child" which indicates it needs a Sprite2D, but that's not an animation node!

Neither tutorial nor example show how to use E.queue([]). The video tutorial does but calls it E.run (so do some comments) and it was hard to find but seems *very useful*.

# Template

* Setting 2D gui with a large window doesn't scale the gui scene
    * Need to adjust:
        * font size
        * widget heights
        * InventoryBar and SettingsBar:
            * InputZoneHeight (to 100)
            * size and layout
            * I think for SettingsBar, I need to create new large icons. Changing scale didn't work (it didn't hide properly).
        * all popups should double in min size
        * dialog_menu needs bigger max_height (50 -> 300)


Gui inconsistently uses "cancel" vs "Cancel".

* Selecting GameTypes.HD (2D) causes grey borders when my backgrounds aren't bigger than the screen. It's because of this line:
    ProjectSettings.set_setting(PopochiuResources.STRETCH_ASPECT, "expand")
  Changing my settings to use "keep" instead fixes it.


# Functionality

* Creating a background should lock it by default. Annoying to try to set walkable areas and constantly moving the background by mistake.

* Bug: Sometimes when I create a hotspot, it disappears from the Popochiu > Rooms > Hotspots list. I'm not sure when it disappears, but I noticed after I setup the interaction polygon and started editing its script.

* Would be nice to give pretty names to rooms so you can reference them from script. That way it's much easier to rename the room later. I could do this with a custom subclass of PopochiuRoom, but feels like a missing piece. Instead, I implemented a map function.

* It's not clear the project setting "text_speed" is the time between characters. I found it very confusing that it only went up to 0.1. However, it looks like Godot doesn't yet support setting tooltips on these settings: https://github.com/godotengine/godot-proposals/discussions/8224

* Many of the "create new" popups should put focus on the name of the object instead of the ok button -- you can't click ok until you provide a name.
    * Fixed. make a PR.

* When working with large images (not pixel art), it's frustrating when the default interaction polygon is super small. Would be awesome if it automatically used the size of the texture.

* CursorType would be easier to use if the directions had a common prefix so they were adjacent in the Hotspot dropdown.

* I thought the rectangular box when editing Hotspot interaction polygon was a convenience to resize my polygon. But instead, it adjusts scale and popochiu seems to regularly reset the scale to 1. This makes my interaction boxes shrink and I was confused why interaction kept getting reset. Instead of just resetting the scale, could popochiu also adjust the polygon to manually scale it up? That would prevent this kind of confusion and even make the scale box useful!


I didn't realize the box was unchecked when I deleted a Character and was confused when they re-appeared on another machine. Maybe the box should change what it displays when the box is checked?
