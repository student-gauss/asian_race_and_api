library(ggplot2)
df <- read.csv("2010Census_DemoProfile3a_SchDist.csv", header=F, skip=11)
numeric.colnames <- c("total.population",
                      "total.population.of.one.race",
                      "white",
                      "black.or.african.american",
                      "american.indian.and.alaska.native",
                      "total.asian",
                      "asian.indian",
                      "chinese",
                      "filipino",
                      "japanese",
                      "korean",
                      "vietnames",
                      "other.asian")

colnames(df) <- c("geography", numeric.colnames)

for(numeric.colname in numeric.colnames) {
    df[[numeric.colname]] = as.numeric(gsub(",","",df[[numeric.colname]]))
}

asian.ratio <- data.frame(
    Japanese = df$japanese / df$total.population,
    Korean   = df$korean / df$total.population,
    Chinese  = df$chinese / df$total.population)

asian.ratio.plot <- ggplot(asian.ratio) +
    geom_density(aes(x=Korean, colour="Korean")) +
    geom_density(aes(x=Chinese, colour="Chinese")) +
    geom_density(aes(x=Japanese, colour="Japanese")) +
    scale_x_log10(limits=c(0.01, 0.8)) +
    scale_colour_manual(values=c("Korean"="red", "Chinese" = "green", "Japanese" = "blue"), name="Asian Race") +
    xlab("Population Ratio") +
    ylab("Density")


png(filename = "asian.density.plot.png")
print(asian.ratio.plot)
dev.off()

