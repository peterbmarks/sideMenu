sideMenu
========

Simple example of iOS ViewControllerContainer used for a side menu

* The app loads from a storyboard that has:
  - MainContainerView
    - MenuView (which goes at the back and will contain the menu you reveal)
    - HomeView (which goes at the front and has a button to slide it away)

* I use notifications to trigger the show/hide menu so they can come from anywhere
* There is a pan gesture recognizer as well as the menu button
