# famcal
A family calendar LaTeX package.

See the LICENSE file for the license details (Mozilla Public License Version 2.0).

## Manual
Load the documentclass ``` famcal ```. 
The current documentclass options are:

 * ```german```: to have the german version for month and week day names. 
 * ```theme-bubbles```: activates the bubbles theme

You can modify the colours for vacation and/or weekend days by using ```\colorlet{vacation}{your-colour}``` respectively ```\colorlet{weekends}{your-colour}```.

Then use the command ```\makeFamCal{year}{names}{vacations}``` which has 3 parameters to draw the calendar:

 * ```year```: Has to be the year of the calendar, e.g., ```2023```.
 * ```names```: Has to be a comma separated list of the names, e.g., ```Marie, John, Jill, Jack```.
 * ```vacations```: can be empty. Otherwise it must be of the following form:
```
2025-01-01,2025-01-10/2025-01-14
```
Here, possible is a single date as, e.g., `2025-01-01`, or a date range, e.g., `2025-01-10/2025-01-14`. The values have to be comma separated.

Enjoy.


## Whishlist

1. Make adding vacations a bit more comfortable. &#x2714;
2. Further colour / font themes?

## Screenshots
Plain:
![Screenshot of the produced pdf for plain theme](https://github.com/ArneMeier/famcal/blob/main/screenshot.png?raw=true "Screenshot plain")

Bubbles (with option ```theme-bubbles```):
![Screenshot of the produced pdf for bubbles theme](https://github.com/ArneMeier/famcal/blob/main/theme-bubbles.png?raw=true "Screenshot bubbles")
