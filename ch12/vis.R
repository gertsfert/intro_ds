# get data for census
df = readCensus(local=FALSE)


## -- histogram plotting ##
  # create a ggplot, using census as dataframe. x-axis will be july11pop variable
  g_hist <- ggplot(df, aes(x=july11pop))

  # use a histogram, define graph colors and set bin width
  g_hist <- g_hist + geom_histogram(binwidth = 5000000,
                          color="black", fill="white")

  # set title
  g_hist <- g_hist + ggtitle("states population histogram")

  # display graph
  g_hist


## box plot ##

  # create new variable for change in population
  df$popChange <- df$july11pop - df$july10pop

  # new column, indicating if change was positive or negative
  df$increasePop <- ifelse(df$popChange > 0, "positive", "negative")

  # createing plot. using x=factor(increasePop) creates a plot for each
  # value of increasePop (in this case 2 values)
  g_boxplot <- ggplot(df, aes(x=factor(increasePop), july11pop))

  # setting plot to be a (flipped) box plot
  g_boxplot <- g_boxplot + geom_boxplot() + coord_flip()

  # set title
  g_boxplot <- g_boxplot + ggtitle('Population grouped by positive or negative change')

  # display plot
  g_boxplot


## line chart

  # set x axis to be state name, order by july11pop
  g_line <- ggplot(df, aes(x=reorder(stateName, july11pop), y=july11pop, group=1))

  # set geometry to be line graph
  g_line <- g_line + geom_line()

  # set x asix text to be the state name, angle it to be 90
  g_line <- g_line + theme(axis.text.x = element_text(angle=90, hjust = 1))

  # display graph
  g_line

## bar graph
  g_bar <- ggplot(df,aes(x=reorder(stateName, july11pop), y=july11pop, group=1))
  g_bar <- g_bar + geom_col()
  g_bar <- g_bar + theme(axis.text.x =
                           element_text(angle=90, hjust=1))
  g_bar
