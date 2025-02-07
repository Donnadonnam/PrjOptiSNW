# rm(list = ls(all.names = TRUE))
# Load Libraries
library(knitr)
library(kableExtra)
library(formatR)

# jointly use R and Python Together

# RMD Options
options(knitr.duplicate.label = "allow")
options(bookdown.render.file_scope = FALSE)

knitr::opts_chunk$set(fig.width=7, fig.height=4, fig.align="center")
# knitr::opts_chunk$set(tidy.opts=list(width.cutoff=60), tidy=TRUE)
knitr::opts_chunk$set(warning=FALSE, message=FALSE, cache=FALSE)
knitr::opts_chunk$set(engine='R')

# Output HTML or Latex
if (knitr::is_latex_output()) {
  options(knitr.table.format = "latex")
} else {
  options(knitr.table.format = "html")
}

# Table Output Options
kable_styling_fc = function(kable_input){
  kable_styling(kable_input,
    bootstrap_options = c("striped", "hover", "responsive"),
    latex_options = c("striped", "hold_position"),
    full_width = FALSE,
    fixed_thead = T,
    position = "center",
    font_size = NULL,
    row_label_position = "l")
}

# Table Output Options:
# 1. scale_down for TEX
# 2. box width: see PrjOptiSNW\style.css for body width, set width to bodywidth - 225
if (knitr::is_latex_output()) {
  kable_styling_fc_wide = function(kable_input){
    kable_styling(kable_input,
      bootstrap_options = c("striped", "hover", "responsive"),
      latex_options = c("striped", "scale_down", "hold_position"),
      full_width = FALSE,
      fixed_thead = T,
      position = "center",
      font_size = NULL,
      row_label_position = "l")
  }
} else {
  kable_styling_fc_wide = function(kable_input){
    kable_styling(kable_input,
      bootstrap_options = c("striped", "hover", "responsive"),
      latex_options = c("striped", "scale_down", "hold_position"),
      full_width = FALSE,
      fixed_thead = T,
      position = "center",
      font_size = NULL,
      row_label_position = "l") %>%
    scroll_box(width = "875px")
  }
}

# Get Current File Path
spt_file_current <- knitr::current_input(dir = TRUE)
print(paste0('spt_file_current:',spt_file_current))
spt_file_current <- gsub(x = spt_file_current,  pattern = "_mod.Rmd", replacement = ".Rmd")

if(!is.null(spt_file_current)) {
  sfc_prj='/PrjOptiSNW'
  sph_gitpages_root='https://fanwangecon.github.io/'
  sph_github_root='https://github.com/FanWangEcon/'
  sph_branch='/master'
  sph_pdf='/htmlpdfm'
  sph_html='/htmlpdfm'
  sph_r='/htmlpdfm'

  spt_root <- 'C:/Users/fan/PrjOptiSNW/'
  spn_prj_rmd <- gsub(spt_root, "", spt_file_current)
  spt_rmd_path <- paste0('/',dirname(spn_prj_rmd))

  st_fullpath_noname <- dirname(spt_file_current)
  st_fullpath_nosufx <- sub('\\.Rmd$', '', spt_file_current)
  st_file_wno_suffix <- sub('\\.Rmd$', '', basename(spt_file_current))
  print(paste0('st_fullpath_noname:', st_fullpath_noname))
  print(paste0('st_fullpath_nosufx:', st_fullpath_nosufx))
  print(paste0('st_file_wno_suffix:', st_file_wno_suffix))

  spth_pdf_html <- paste0(st_fullpath_noname, '/htmlpdfm/')
  sfle_pdf_html <- paste0(st_fullpath_noname, '/htmlpdfm/', st_file_wno_suffix)
  print(spth_pdf_html)

  sph_source_blob_root = paste0(sph_github_root, sfc_prj, '/blob', sph_branch, spt_rmd_path, '/')
  sph_rmd_pdf = paste0(sph_source_blob_root, sph_pdf, '/', st_file_wno_suffix, '.pdf')
  sph_rmd_m = paste0(sph_source_blob_root, sph_r, '/', st_file_wno_suffix, '.m')
  sph_rmd_mlx = paste0(sph_source_blob_root, '/', st_file_wno_suffix, '.mlx')

  sph_source_web_root = paste0(sph_gitpages_root, sfc_prj, spt_rmd_path, '/')
  sph_rmd_html = paste0(sph_source_web_root, sph_html, '/', st_file_wno_suffix, '.html')

  st_head_link = '> Go to the'
  st_head_link = paste0(st_head_link, ' [**MLX**](', sph_rmd_mlx ,'),')
  st_head_link = paste0(st_head_link, ' [**M**](', sph_rmd_m ,'),')
  st_head_link = paste0(st_head_link, ' [**PDF**](', sph_rmd_pdf ,'),')
  st_head_link = paste0(st_head_link, ' or [**HTML**](', sph_rmd_html ,')')
  st_head_link = paste0(st_head_link, ' version of this file.')

  # Common Shared Text and Strings
  total_area <- (800 * 7) / 2
  if (st_file_wno_suffix == 'NSW-Dynamic-Life-Cycle-and-Stimulus-Checks-Code-Companion') {
    text_shared_preamble_one <- paste0("> Go back to [NSW 2020 Code Companion](https://fanwangecon.github.io/PrjOptiSNW/) home page, [Wang 2020 Optimal Allocation](https://fanwangecon.github.io/PrjOptiAlloc/) project page, or the [MEconTools](https://fanwangecon.github.io/MEconTools/) Toolbox.")
  } else {
    text_shared_preamble_one <- paste0(st_head_link, " Go back to [NSW 2020 Code Companion](https://fanwangecon.github.io/PrjOptiSNW/) home page, [Wang 2020 Optimal Allocation](https://fanwangecon.github.io/PrjOptiAlloc/) project page, or the [MEconTools](https://fanwangecon.github.io/MEconTools/) Toolbox.")
  }
}

text_shared_preamble_two <- ""
text_shared_preamble_thr <- ""

if (knitr::is_latex_output()) {
    text_top_count <- ""
    text_end_count <- ""
} else {
    text_top_count <- "[![ViewCount](https://views.whatilearened.today/views/github/FanWangEcon/PrjOptiSNW.svg)](https://github.com/FanWangEcon/PrjOptiSNW)  [![Star](https://img.shields.io/github/stars/fanwangecon/PrjOptiSNW?style=social)](https://github.com/FanWangEcon/PrjOptiSNW/stargazers) [![Fork](https://img.shields.io/github/forks/fanwangecon/PrjOptiSNW?style=social)](https://github.com/FanWangEcon/PrjOptiSNW/network/members) [![Star](https://img.shields.io/github/watchers/fanwangecon/PrjOptiSNW?style=social)](https://github.com/FanWangEcon/PrjOptiSNW/watchers) [![DOI](https://zenodo.org/badge/273278814.svg)](https://zenodo.org/badge/latestdoi/273278814)"
    text_end_count <- "[![](https://img.shields.io/github/last-commit/fanwangecon/PrjOptiSNW)](https://github.com/FanWangEcon/PrjOptiSNW/commits/master) [![](https://img.shields.io/github/commit-activity/m/fanwangecon/PrjOptiSNW)](https://github.com/FanWangEcon/PrjOptiSNW/graphs/commit-activity) [![](https://img.shields.io/github/issues/fanwangecon/PrjOptiSNW)](https://github.com/FanWangEcon/PrjOptiSNW/issues) [![](https://img.shields.io/github/issues-pr/fanwangecon/PrjOptiSNW)](https://github.com/FanWangEcon/PrjOptiSNW/pulls)"
}
