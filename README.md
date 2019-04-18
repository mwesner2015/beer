### Craft Beer 
There are a few qualities that qualify a brewer to be a craft brewery. One of those is that is has to be 
small which means that annual production of 6 million barrels of beer or less (approximately 3 percent of U.S. annual sales).
It also has to be independent which means less than 25 percent of the craft brewery is owned or controlled (or equivalent economic 
interest) by a beverage alcohol industry member that is not itself a craft brewer. What makes craft beer more interesting than 
large beer brewers is the creativity that the brewers have in making new styles of beer or innovating normal beer styles with new
twists.

### HOW TO USE
In order to use this app, go to R and run this code:
```
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny")}
library(shiny)
runGitHub( "beer", "mwesner2015") 
```
The first tab that opens is an easy way to find canned craft beers from over 500 craft brewers. Simply click on the 
"choose a brewery" and scroll through to find which beers are brewed by individual brewers. 
The columns of the data stand for brewery is brewery name, city and state for wherethe brewery is located, abv is alcohol content 
by volume, ibu is international bittering units, name is the name of the beer, and style is the style of the beer.

The next tab labelled "regression" is a preliminary investigation into whether there is a relationship between the alcohol content
of a beer and the ibu's of a beer. 


Data comes from www.kaggle.com/nickhould/craft-cans/version/1.
