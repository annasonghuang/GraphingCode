## Clear R-workspace
rm(list=ls(all=TRUE))
## Set location of R-script as working directory

#path.act <- dirname(sys.frame(1)$ofile)
setwd("~/Documents/Projects/TCP/Paper/Rscripts/")

## Close all graphic devices
graphics.off()

library(Hmisc)
library(ggplot2)
library(reshape2)

# Load CSV file as dataframe
data <- read.csv('~/Documents/Projects/TCP/CSV/FROI_MFG_psc.csv')

# Convert to .long format
data.long <- melt(
  data, id = c("Timepoint"), # keep these columns the same
  measure = c("HC","SZ","BP"),       # Put these two columns into a new column
  variable.name="Group"
)

# Timecourse plot
p <- ggplot(data.long, aes(x=Timepoint, y=value, group = Group))


# Greyscale
print(
  p + geom_line(aes(linetype = Group), size = 1) +
    geom_point(aes(shape = Group), size = 3) +
    ggtitle("MFG") + 
    theme(plot.title = element_text(size=28, face="bold", colour="black", hjust = 0.5)) +
    annotate("rect", fill = "black", alpha = 0.3,
             xmin = 2,
             xmax = 4,
             ymin=-Inf,
             ymax=Inf
             ) +
    annotate("rect", fill = "grey", alpha = 0.3,
             xmin = 4,
             xmax = 12,
             ymin=-Inf,
             ymax=Inf) +
    annotate("rect", fill = "black", alpha = 0.3,
             xmin = 12,
             xmax = 12.5,
             ymin=-Inf,
             ymax=Inf) +
    xlim(0, 20) +
    ylim(-0.1,1.5) +
    scale_linetype_manual(values=c("solid", "twodash", "dotted")) +
    theme(
      axis.title    = element_blank(),
      axis.text     = element_text(size=28, face="bold", colour="black"),
      legend.title  = element_text(size = 28, face = "bold", colour="black"),
      legend.text   = element_text(size = 28, face = "bold", colour="black"), 
      legend.key.size = unit(2, 'lines'),
      panel.border  = element_rect(colour = "black", fill=NA, size=1),
      panel.background = element_blank(), 
      aspect.ratio=1, 
      plot.title = element_text(hjust = 0.5)
    )
)

# Save plot
ggsave(
  "ROI_MFG_timecourse.png", 
  plot=last_plot(), 
  device=NULL, path=NULL, 
  scale=1, width=6, height=6, 
  units = c("in"), 
  dpi=300, 
  limitsize=TRUE
)
