## advanced vis
df <- readCensus(local=FALSE)

df$popChange <- df$july11pop - df$july10pop
df$percentChange <- df$popChange/df$july10pop * 100


# coloured fill graph
  g_fill <- ggplot(df, aes(x=reorder(stateName,
                                     july11pop), y=july11pop, fill=percentChange))

  g_fill <- g_fill + geom_col()

  g_fill <- g_fill + theme(axis.text.x =
                             element_text(angle=90, hjust=1))

  g_fill

# scatter plot
  g_scatter <- ggplot(df, aes(x=popChange,
                              y=percentChange))

  g_scatter <- g_scatter + geom_point(aes(size=july11pop,
                                      color=july11pop))


  g_scatter <- g_scatter + geom_text(aes(label=stateName), size=4,
                                     hjust=1, vjust=-1)

  g_scatter

  # this results in a messy graph, we can try cleaning it up a bit

## scatter plot, cleaner
  minPerChange <- 1
  minPopChange <- 100000
  df$keystate <- df$popChange > minPopChange & df$percentChange > minPerChange
  minLabel <- format(min(df$july11pop),
                     big.mark=",", trim=TRUE)
  maxLabel <- format(max(df$july11pop),
                     big.mark=",", trim=TRUE)
  medianLabel <- format(median(df$july11pop),
                        big.mark=",", trim=TRUE)

  g_clean_scatter <- ggplot(df, aes(x=popChange,
                                    y=percentChange))

  g_clean_scatter <- g_clean_scatter + geom_point(aes(size=july11pop, color=july11pop, shape=keystate))

  g_clean_scatter <- g_clean_scatter + geom_text(data=df[df$popChange > minPopChange &
                                                           df$percentChange > minPerChange,], aes(label=stateName, hjust=1, vjust=-1))

  g_clean_scatter <- g_clean_scatter + scale_color_continuous(name="Pop",
                                                              breaks= with(df,
                                                                           c(min(july11pop),
                                                                             median(july11pop),
                                                                             max(july11pop))),
                                                              labels = c(minLabel, medianLabel, maxLabel),
                                                              low = "white", high="black")
  g_clean_scatter
