# famcal
A family calendar LaTeX package.

See the LICENSE file for the license details (Mozilla Public License Version 2.0).

## Manual
Load the documentclass ``` famcal ```. 
The current documentclass options are:

 * ```german```: to have the german version for month and week day names. 
 * ```vacation=colour```: set the vacation colouring to color ```colour```. Default colour is ```green```

Then use the command ```\makeFamCal{year}{names}{vacations}``` which has 3 parameters to draw the calendar:

 * ```year```: Has to be the year of the calendar, e.g., ```2023```.
 * ```names```: Has to be a comma separated list of the names, e.g., ```Marie, John, Jill, Jack```.
 * ```vacations```: can be empty. Otherwise it must be of the following form:
```
if (between=2023-01-30 and 2023-01-31) [vacation]
if (between=2023-03-27 and 2023-04-11) [vacation]
if (between=2023-07-06 and 2023-08-16) [vacation]
if (between=2023-10-16 and 2023-10-30) [vacation]
if (between=2023-12-27 and 2023-12-31) [vacation]
``

Enjoy.


## Whishlist

1. Make adding vacations a bit more comfortable.
2. Colour / font themes?

## Screenshot
![Screenshot of the produced pdf](screenshot.png "Screenshot")