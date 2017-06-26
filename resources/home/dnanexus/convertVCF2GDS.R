# Takes a VCF file as input and outputs it to GDS format.
# A wrapper for the seqVCF2GDS function in the SeqArray package.
# options(repos = c(CRAN = "http://cran.revolutionanalytics.com"))

# VCF Input: can be one vcf or several, as a character vector
args <- commandArgs(trailingOnly = TRUE)
print(args)
base.filename <- args[1]
num.files <- as.numeric(args[2])
# File args get cut in half because of a space so stick them back together
# vcf.file <- c()
#for (i in seq(3,length(args)-1,by=2)) {
#	vcf.file <- c(vcf.file,paste(args[i],args[i+1]))
#}
vcf.file <- args[3:(3+num.files-1)]
# print(vcf.file)
vcf.file <- gsub("[vV][cC][fF]","vcf",vcf.file)
if (sum(grepl("vcf",vcf.file))<length(vcf.file)) {
  stop("This app requires the input filename to contain the 'vcf' file extension. Please check your file.")
}

# GDS Ouput
gds.file <- paste0(base.filename,".gds")

library(SeqArray)

# Conversion -- This will take a long time.
seqVCF2GDS(vcf.file,gds.file)

# Quick summary for log's sake
g <- seqOpen(gds.file)
seqSummary(g)

