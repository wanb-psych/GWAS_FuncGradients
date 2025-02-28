#!/bin/R

library("CMplot")
library("data.table")

mode <- "grad_refHCP_0.9"

for (x in list("g1","g2","g3")) {
  my_data <- fread(paste("/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/distance/",mode,"/",mode,"_",x,"_GWAS.txt.gz",sep=""))
  plot <- my_data[,c("SNP","CHR","POS","P")]
  CMplot(plot, plot.type="m", col=c("grey30","grey60"), LOG10=TRUE, ylim=c(3,12), threshold=c(5e-8,5e-5),
         threshold.lty=c(1,2), threshold.lwd=c(1,1), threshold.col=c("black","grey"), amplify=TRUE,
         chr.den.col=c("darkgreen", "yellow", "red"), signal.col=c("dodgerblue4","dodgerblue"), signal.cex=c(1,1),signal.pch=c(19,19),
         file="png",file.name=paste("distance_",mode,"_",x,sep=""),dpi=300,file.output=TRUE,verbose=TRUE,width=12,height=4)
  CMplot(plot,plot.type="q",box=FALSE,file="png",file.name=paste("distance_",mode,"_",x,sep=""),dpi=300,
         conf.int=TRUE,conf.int.col=NULL,threshold.col="grey",threshold.lty=2,
         file.output=TRUE,verbose=TRUE,width=4,height=4)
}
# Note: if the length of parameter 'chr.den.col' is bigger than 1, SNP density that counts
#       the number of SNP within given size('bin.size') will be plotted. 
# file.name: specify the output file name, the default is corresponding column name when setting file.name=""
