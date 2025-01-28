library(dplyr)
source('lib.R')

# Read in intSite data and rename / add columns for createIntUCSCTrack()
intSites <- distinct(readr::read_tsv('intSites.tsv.gz', show_col_types = FALSE))
intSites <-  rename(intSites, seqnames = 'chromosome', start = 'position')
intSites$end <- intSites$start

intSites$posid <- paste0(intSites$seqnames, intSites$strand, intSites$start)

# Create labels for sites that will appear in UCSC browser.
intSites$siteLabel <- paste(intSites$subject, intSites$posid)
intSites$siteLabel <- gsub('\\s', '_', intSites$siteLabel)

# Create track file.
createIntUCSCTrack(intSites, siteLabel = 'siteLabel', outputFile = 'myTrack.bed', position = 'chr18:58671465-58754477')

# Copy track file to a web accessible folder, eg.
# scp myTrack.bed microb120:/media/lorax/data/export/UCSC/

# Access the track with this URL.
# http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&hgt.customText=http://microb120.med.upenn.edu/data/export/UCSC/myTrack.bed

