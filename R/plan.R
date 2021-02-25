plan <- drake_plan(
   tree = GetTreeWithNameProcessing("data/moreaubell2016.tre"), # Tree from https://tree.opentreeoflife.org/curator/study/view/ot_1056/?tab=home, Moreau C.S., & Bell C. 2013. Testing the museum versus cradle tropical biological diversity hypothesis: Phylogeny, diversification, and ancestral biogeographic range evolution of the ants. Evolution, 67(8): 2240-2257. Accessed on Feb. 25, 2021
   all_ranges = GetLatitudinalRangeForAllSpecies(tree),
   cleaned_ranges = CleanRanges(all_ranges),
   pruned_objects = geiger::treedata(phy=tree, data=cleaned_ranges, sort=TRUE, warnings=FALSE),
   pruned_phy = pruned_objects$phy,
   pruned_data = as.data.frame(pruned_objects$data),
   spans_equator = SpansEquator(pruned_data)
)