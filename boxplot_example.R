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

# load spss file
betas <- spss.get(
  "Betas.sav", lowernames=FALSE, datevars = NULL,
  use.value.labels = TRUE, to.data.frame = TRUE,
  max.value.labels = Inf, force.single=TRUE,
  allow=NULL, charfactor=FALSE, reencode = NA
)

# Cue period activity
cuebeta <- data.frame(betas$Group,betas$Cue.IPS,betas$D2.IPS,betas$P.IPS)
colnames(cuebeta)<- c("Group", "Cue", "D2", "Probe")


# Convert it to long format
cuebeta.long <- melt(
  cuebeta, id = c("Group"), # keep these columns the same
  measure = c("Cue", "D2", "Probe"),       # Put these two columns into a new column
  variable.name="region"
)


# print as boxplot
cuep <- ggplot(cuebeta.long, aes(fill=Group, y=value, x=region))


# print as boxplot with legend
print(
  cuep + geom_boxplot() + 
    scale_fill_manual(values=c("dodgerblue1","pink2","green3"),
                      name="Group", 
                      labels = c("HC", "SZ", "BP")) +
    ggtitle("IPS") + 
    theme(plot.title = element_text(size=32, face="bold", colour="black")) +
    ylim(-5,15) +
    theme(
      axis.title    = element_blank(),
      axis.text     = element_text(size=32, face="bold", colour="black"),
      legend.title  = element_text(size = 32, face = "bold", colour="black"),
      legend.text   = element_text(size = 32, face = "bold", colour="black"), 
      panel.border  = element_rect(colour = "black", fill=NA, size=1),
      legend.key.size = unit(2, 'lines'),
      panel.background = element_blank(), 
      aspect.ratio=1, 
      plot.title = element_text(hjust = 0.5)
    )
)

#plot.title = element_text(hjust = 0.5)

# Save plot
ggsave(
  "ROI_IPS.png", 
  plot=last_plot(), 
  device=NULL, path=NULL, 
  scale=1, width=6, height=6, 
  units = c("in"), 
  dpi=300, 
  limitsize=TRUE
)