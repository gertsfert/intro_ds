### ch12 challenge
# create a bar chart, showing the avg population in each region of the UNited States.

df = readCensus(local=FALSE)

df <- df[df$stateName != "District of Columbia", ]
df$region <- state.region

# tapply returns a vector, which might be cumbersome?
vector_region_avg <- tapply(df$july11pop, df$region, mean)

# aggregate returns a data frame, which could be more comfortable
df_region_avg_bad <- aggregate(df$july11pop, df$region, mean)

# however that returns it with renamed variables
# instead try using a formula using the "~" operator
df_region_avg <- aggregate(july11pop ~ region, df, mean)
# this says that the july 11 pop is dependant on the region!


g_region_avg <- ggplot(df_region_avg, aes(x=reorder(region, july11pop), y=july11pop, group=1))
g_region_avg <- g_region_avg + geom_col()
g_region_avg <- g_region_avg + theme(axis.text.x =
                                       element_text(angle=90, hjust=1))
g_region_avg
