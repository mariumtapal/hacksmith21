
# Welcome to our `HackSmith21` project!

## We are Eleni Partakki and Marium Tapal, two junior undergrads with less than 24 hours to hack.

Our project: We decided to focus on something current, and decided to
make a website that informs people about the latest updates related to the Covid19 vaccine roll-out in Massachusetts.

Link to project: https://marium.shinyapps.io/hacksmith21/

# What we achieved

## Our dashboard has 4 components:
- First, a searchable and sortable table that shows Proportion of people vaccinated in MA by age and by town - so say you want to find out the proportion of people fully vaccinated between the ages of 20-29 in Northampton - (show demo) == 0.005
- Next, on the right-hand side of this dashboard, you can see an interactive plot of the proportions of people fully vaccinated by race/ethnicity in MA. For example, If you hover over the Asian bar, we can see that 0.098 or 9.8% percent of Asians in MA are fully vaccinated
- Thirdly, we have an interactive map that tells us the vaccination locations in MA. Clicking on each pointer will give an address for the vaccination center.
- Fourth, we made a sample chat tool named Cooper the Chatbot.

## To develop the dashboard:
- We used a simple R shiny app to create this dashboard and deployed it to ShinyApps.io 
Data from mass.gov that was not utilized in the states dashboard in order to make it more user friendly and accessible instead of having to read an excel or pdf file
- We used the tidyverse to do our data wrangling, reactable r package for the table, leaflet for the map, plotly for the bar plot.
- Chatbot (python to R): Initially we started working on a Python chatbot using chatterbot from ChatBot and ListTrainer from chatterbot.trainers to teach our bot how to respond better to questions but ultimately realized that Shiny would not support Python very well, and we did not have time to adapt, so we pivoted
- Our pivot included switching to R, and utilizing shiny.collections from the devtools package where we made a messaging feature where we would ultimately integrate our chatbot
- For the database we used RethinkDB which “stores JSON documents with dynamic schemas, and is designed to facilitate pushing real-time updates for query results to applications”
- Interface with the panels
- We finally worked on an interface by creating different panels in order for the information to be displayed in a readable manner

## If we had more time we would have:
- Completed the chatbot
- Improved the dashboard and improve color
- Added navbar functionality
- Added all US states


Data Sources:
- https://www.mass.gov/doc/covid-19-vaccine-locations-for-currently-eligible-recipients-pdf/download
- https://www.mass.gov/doc/weekly-covid-19-public-health-report-march-25-2021/download
