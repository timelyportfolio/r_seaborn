# make seaborn color palettes available in R
# http://web.stanford.edu/~mwaskom/software/seaborn/tutorial/color_palettes.html

# the standard set of defined palettes in Seaborn
# deep, muted, pastel, bright, dark, and colorblind
# are defined in a Python dict
# which I will convert into a list
# dict -> list
# [] becomes c()
seaborn_palettes = list(
  deep=c("#4C72B0", "#55A868", "#C44E52",
        "#8172B2", "#CCB974", "#64B5CD"),
  muted=c("#4878CF", "#6ACC65", "#D65F5F",
         "#B47CC7", "#C4AD66", "#77BEDB"),
  pastel=c("#92C6FF", "#97F0AA", "#FF9F9A",
          "#D0BBFF", "#FFFEA3", "#B0E0E6"),
  bright=c("#003FFF", "#03ED3A", "#E8000B",
          "#8A2BE2", "#FFC400", "#00D7FF"),
  dark=c("#001C7F", "#017517", "#8C0900",
        "#7600A1", "#B8860B", "#006374"),
  colorblind=c("#0072B2", "#009E73", "#D55E00",
              "#CC79A7", "#F0E442", "#56B4E9")
)

plotKML::display.pal(seaborn_palettes$muted)

# R has cubeHelix with package rje
# install.packages( "rje" )

library(rCharts)

d <- dPlot(
  y ~ x
  ,groups = c("x","y")
  ,data = do.call(rbind, lapply(names(seaborn_palettes),function(pal){
    data.frame(
      x = pal
      ,y = as.character((which(names(seaborn_palettes) == pal) - 1) * 10 +  1:10)
    )
  }))
  ,type = "bar"
  ,defaultColors = sprintf(
    "#! d3.scale.ordinal()
      .range(['%s'])
      .domain(['%s'])
    !#"
    ,paste0( structure(unlist(seaborn_palettes), names = NULL), collapse = "','" )
    ,paste0( 1:length(unlist(seaborn_palettes)), collapse = "','" )
  )
  ,xAxis = list( orderRule = names( seaborn_palettes ) )
  ,yAxis = list( type = "addCategoryAxis" )
)
d$set( facet = list( x = "x" ))
d

