# us state map data
us <- map_data("state")

# create dataframe to contain state names
dummy_df <- data.frame(state.name,
                       stringsAsFactors = FALSE)
dummy_df$state <- tolower(dummy_df$state.name)

# create map!
map.simple <- ggplot(dummy_df, aes(map_id = state))
map.simple <- map.simple + geom_map(map=us,
                                    fill = "white",
                                    color = "black")
map.simple <- map.simple + expand_limits(x = us$long, y=us$lat)
map.simple <- map.simple + coord_map() + ggtitle("Basic map of continental USA")
map.simple

# mashup with census data
dfStates <- readCensus(local=FALSE)

# make sure everything is lowercase
dfStates$state <- tolower(dfStates$stateName)

map.popColor <- ggplot(dfStates,
                       aes(map_id = state))
map.popColor <- map.popColor + geom_map(map = us,
                                        aes(fill=july11pop))
map.popColor <- map.popColor + expand_limits(x =
                                               us$long, y=us$lat)
map.popColor <- map.popColor + coord_map() +
  ggtitle("state population")

map.popColor

# getting point for syracuse ny
latlon <- geocode("syracuse, ny")
