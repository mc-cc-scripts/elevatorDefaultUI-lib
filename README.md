# elevatorDefaultUI-lib
Provides the default UI for the [elevator](https://github.com/mc-cc-scripts/elevator-prog).

# Modifying the UI
If you want to provide your own UI or handle multiple monitors, you can do that! The elevator will call the `draw` and the `click` function and provide the proper parameters.

**Those two functions are required. You may change the content entirely but the functions must exist!**

## `ui.draw(self, floors)`
The draw function takes 2 parameters:
- **self**: a reference to itself to easily access attributes.
- **floors**: a list of all floors that reported to the elevator.
    - The list is unordered! You will probably want to sort by number.
    - A floor is an object containing the following attributes:
        - `number`: The number (integer) of the floor.
        - `isCurrent`: A boolean value indicating whether it is the current floor.
        - `isQueued`: A boolean value indicating whether the floor is already queued.

## `ui.click(self, side, x, y)`
The click function takes 4 parameters:
- **self**: a reference to itself to easily access attributes.
- **side**: the side of the monitor that has been touched.
- **x**: the x coordinate of the click.
- **y**: the y coordinate of the click.

The function is expected to return the number of the clicked floor or nil.