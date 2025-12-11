Issues during dev:

* When I created room Bedroom, I think I added my background texture directly to the Background scene instead of to the node in the Room scene. This meant that my character never showed up.
    https://carenalgas.github.io/popochiu/how-to-develop-a-game/create-the-first-room/

* Many of the "create new" popups should put focus on the name of the object instead of the ok button -- you can't click ok until you provide a name.


* Doesn't show how to make it the main scene:
    https://carenalgas.github.io/popochiu/how-to-develop-a-game/create-the-first-room/

* Setting 2D gui with a large window doesn't scale the gui scene
    * Need to adjust:
        * font size
        * widget heights
        * InventoryBar and SettingsBar:
            * InputZoneHeight (to 100)
            * size and layout
            * I think for SettingsBar, I need to create new large icons. Changing scale didn't work (it didn't hide properly).
