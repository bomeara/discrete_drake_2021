GetTreeWithNameProcessing <- function(treefile) {
	raw <- readLines(treefile)
	raw <- gsub(" CSM", "", raw)
	raw <- gsub(" ", "_", raw)
	phy <- ape::read.tree(text=raw)
}

GetLatitudinalRangeForSpecies <- function(species) {
	print(species)
	all_points <- NULL
	try(all_points <- rgbif::occ_search(scientificName = species, limit = 50, fields="minimal"))
	return_object <- c(NA, NA)
	if(!is.null(all_points)) {
		if(!is.null(all_points$data)) {
			return_object <- range(all_points$data$decimalLatitude)
		}
	}
	return(return_object)
}

GetLatitudinalRangeForAllSpecies <- function(tree) {
	result <- data.frame(species=tree$tip.label, minlat=NA, maxlat=NA)
	for (tip_index in seq_along(tree$tip.label)) {
		ranges <- GetLatitudinalRangeForSpecies(tree$tip.label[tip_index])
		result$minlat[tip_index] <- ranges[1]
		result$maxlat[tip_index] <- ranges[2]
	}
	return(result)
}

CleanRanges <- function(all_ranges) {
	all_ranges <- subset(all_ranges, !is.na(all_ranges$minlat))
	rownames(all_ranges) <- all_ranges$species
	all_ranges <- all_ranges[,-1]
	return(all_ranges)
}

SpansEquator <- function(lat_ranges) {
	results <- sign(lat_ranges$minlat)!=sign(lat_ranges$maxlat)
	names(results) <- rownames(lat_ranges)
	return(results)
} 