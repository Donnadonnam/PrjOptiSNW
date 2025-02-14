# See AllocateR\alloc_discrete_paper_graphs\fs_A_alpha_scatter.R
# Updated to consider welfare results, included for RR JEDC.

# try(dev.off(dev.list()["RStudioGD"]),silent=TRUE)
# try(dev.off(),silent=TRUE)

library(tidyverse)
library(REconTools)
# library(PrjOptiAlloc)

# library(forcats)
# library(foreach)
# library(doParallel)

# it_no_cores <- detectCores(logical = TRUE)
# cl <- makeCluster(5)
# registerDoParallel(cl)

# Part 1 Various Allocation files for JEDC Revision ------------
# 0. Testing structure
ls_st_file_suffix_test <- c('snwx_bushchck_tiny_b1_xi0_manna_168')

# 1a. Core Biden check problem
ls_st_file_suffix_bidenchk_main <-
  c('snwx_bchklock_moredense_a65zh266zs5_b1_xi0_manna_168')

# 1b. Biden check UI robustness and low vs high interest rate check
# bchklkr2 = solve as bchklock, but at 2 percent interest rate
# bchknoui = solve as bchklock, without UI benefits
ls_st_file_suffix_bidenchk_uir2 <-
  c('snwx_bcklknou_moredense_a65zh266zs5_b1_xi0_manna_168',
    'snwx_bchklkr2_moredense_a65zh266zs5_b1_xi0_manna_168')

# 1c. Biden Check: change low and high mixture
ls_st_file_suffix_bidenchk_mixturealter <-
  c('snwx_bchklock_moredense_a65zh266zs5_b1_xi0_manna_168_3o6',
    'snwx_bchklock_moredense_a65zh266zs5_b1_xi0_manna_168_4o6',
    'snwx_bchklock_moredense_a65zh266zs5_b1_xi0_manna_168_8o6',
    'snwx_bchklock_moredense_a65zh266zs5_b1_xi0_manna_168_9o6')
ls_st_file_suffix_bidenchk_mixturealter <- rev(ls_st_file_suffix_bidenchk_mixturealter)

# 2a. Bush Check Problem
ls_st_file_suffix_bushchck <-
  c('snwx_bushchck_moredense_a65zh266zs5_b1_xi0_manna_96_bt95',
    'snwx_bushchck_moredense_a65zh266zs5_b1_xi0_manna_96_bt60',
    'snwx_bushchck_moredense_a65zh266zs5_b1_xi0_manna_96_married',
    'snwx_bushchck_moredense_a65zh266zs5_b1_xi0_manna_96_unmarried',
    'snwx_bushchck_moredense_a65zh266zs5_b1_xi0_manna_96')
ls_st_file_suffix_bushchck <- rev(ls_st_file_suffix_bushchck)

# Part B list to run ---------------------
# list to run
ls_st_file_suffix <-
  c(ls_st_file_suffix_bidenchk_main,
    ls_st_file_suffix_bidenchk_uir2,
    ls_st_file_suffix_bidenchk_mixturealter,
    ls_st_file_suffix_bushchck)
snm_main_use <- 'Results202111'

# Part C Parameters to specify ---------------------
# Number of ways to cut income bins
bl_per_capita <- TRUE
fl_rho <- 1
ls_it_income_cuts <- c(1,2,3,4)
ls_it_income_cuts <- c(1,3)

# Part D Looping over different runs --------------------
for (it_income_cuts in ls_it_income_cuts) {
  if (it_income_cuts == 1) {
    # 20k interval, between 0 and 100k and 100 million
    # generate income cut-offs
    fl_bin_start <- 0
    # width equal to 20,000
    fl_bin_width <- 2e4
    # final point is 100 million
    fl_bin_final_end <- 1e8
    # final segment starting point is 100,000 dollars
    fl_bin_final_start <- 1e5
    # File name
    st_snm_suffix_save <- '_0t100k20kbin'

  } else if (it_income_cuts == 2) {
    # 10k interval, between 0 and 150k and 100 million
    # generate income cut-offs
    fl_bin_start <- 0
    # width equal to 20,000
    fl_bin_width <- 1e4
    # final point is 100 million
    fl_bin_final_end <- 1e8
    # final segment starting point is 100,000 dollars
    fl_bin_final_start <- 1.5e5
    # File name
    st_snm_suffix_save <- '_0t150k10kbin'

  } else if (it_income_cuts == 3) {
    # 10k interval, between 0 and 200k and 100 million
    # generate income cut-offs
    fl_bin_start <- 0
    # width equal to 20,000
    fl_bin_width <- 1e4
    # final point is 100 million
    fl_bin_final_end <- 1e8
    # final segment starting point is 100,000 dollars
    fl_bin_final_start <- 2e5
    # File name
    st_snm_suffix_save <- '_0t200k10kbin'

  } else if (it_income_cuts == 4) {
    # 5k interval, between 0 and 200k and 100 million
    # generate income cut-offs
    fl_bin_start <- 0
    # width equal to 20,000
    fl_bin_width <- 5e3
    # final point is 100 million
    fl_bin_final_end <- 1e8
    # final segment starting point is 100,000 dollars
    fl_bin_final_start <- 2e5
    # File name
    st_snm_suffix_save <- '_0t200k5kbin'

  }
  ar_income_bins <- c(seq(fl_bin_start, fl_bin_final_start, by=fl_bin_width),
                      fl_bin_final_end)
  # Solve iteratively
  for (st_which_solu in ls_st_file_suffix) {
  # foreach (st_which_solu=ls_st_file_suffix) %dopar% {

    # Files:
    # source('fs_opti_support.R')
    # st_which_solu <- 'b1_manna'
    # st_which_solu <- paste0('b1_xi0_manna_88_', st_file_suffix)
    ls_output <- fs_opti_support_202111(st_which_solu,
                                        snm_main=snm_main_use,
                                        bl_per_capita=bl_per_capita,
                                        fl_rho=fl_rho)
    st_b0b1 <- ls_output$st_b0b1
    st_file_type_withspouse_shock <- ls_output$st_file_type_withspouse_shock
    st_file_type_withspouse_shock <- ls_output$st_file_type_withspouse_shock
    snm_simu_csv_withspouse_shock <- ls_output$snm_simu_csv_withspouse_shock

    srt_simu_path <- ls_output$srt_simu_path
    srt_csv_path_root <- ls_output$srt_csv_path_root
    srt_imgcsv_mpcapc_root <- ls_output$srt_imgcsv_mpcapc_root
    ar_rho <- ls_output$ar_rho

    bl_save_img <- TRUE

    ### Variable Names and Paths
    ## Common Parameters Across
    it_bin_dollar_before_phaseout = 500
    # Dollar Per Check
    fl_percheck_dollar = 100
    # Max Phase Out given 1200*2 + 500*4 = 4400
    fl_max_phaseout_trump_biden = 200000
    fl_max_phaseout_bush = 225000
    # Meaning of Ymin Ymax simulated interval of 1
    fl_multiple_trump_biden = 62502
    fl_multiple_bush = 54831
    if (grepl('bushchck', st_which_solu)) {
      fl_multiple <- fl_multiple_bush
      fl_max_phaseout <- fl_max_phaseout_bush
    } else {
      fl_multiple <- fl_multiple_trump_biden
      fl_max_phaseout <- fl_max_phaseout_trump_biden
    }

    # Number of Max Checks
    it_max_checks_1st = 44
    it_max_checks_2nd = 88
    # Number of Tax Paying Households
    fl_tax_hh = 128580000
    # Number of Income Groups to Use: use 25 for 10,000 = 1
    # Age Conditions

    # Two age group considerations
    for (bl_cap_x_axis in c(TRUE, FALSE)) {
      for (bl_log_x_axis in c(TRUE, FALSE)) {
        for (it_age_type in c(1, 2)) {
          if (it_age_type == 1) {
            it_max_age = 64
            it_min_age = 18
          }
          if (it_age_type == 2) {
            it_max_age = 99
            it_min_age = 18
          }
          st_img_suf_age_ybin <- paste0(it_min_age, 't', it_max_age)

          for (MPC_type in c(1, 5)) {

            snm_save_csv <- ""

            # Keep C or V for x-axis, c is default
            svr_c_or_v_zerochk <- 'c_avg_chk0_usd'

            if (MPC_type == 1 | MPC_type == 3) {
              if (MPC_type == 1) {
                snm_save_csv <- 'mpc_smooth'
              }
              if (MPC_type == 3) {
                snm_save_csv <- 'apc_smooth'
              }
            }
            if (MPC_type == 2 | MPC_type == 4) {
              if (MPC_type == 2) {
                snm_save_csv <- 'mpc_raw'
              }
              if (MPC_type == 4) {
                snm_save_csv <- 'apc_raw'
              }
            }
            if (MPC_type == 5 | MPC_type == 6) {
              if (MPC_type == 5) {
                snm_save_csv <- 'mpv_raw'
              }
              if (MPC_type == 6) {
                snm_save_csv <- 'apv_raw'
              }
              # Keep C or V for x-axis, c is default
              svr_c_or_v_zerochk <- 'v_avg_chk0_usd'
            }

            # File name final construction
            snm_save_csv_file = paste0(snm_save_csv,
                                       '_bykidsmarital20k_allchecks_',
                                       st_img_suf_age_ybin,
                                       st_snm_suffix_save)

            # Load File
            df_MPC_results <- as_tibble(
              read.csv(file.path(srt_imgcsv_mpcapc_root,
                                 paste0(snm_save_csv_file, '.csv')), header=TRUE))

            # summarize
            # REconTools::ff_summ_percentiles(df_MPC_results, bl_statsasrows = FALSE)

            # Gather the needed data
            df_MPC_results_A_alpha <- df_MPC_results %>%
              select(X, marital, kids, ymin_group, mass, one_of(svr_c_or_v_zerochk), X0) %>%
              mutate(A = !!sym(svr_c_or_v_zerochk)/(1 + marital + kids),
                     alpha = X0)

            # The continuous variables are A, alpha, mass. The categorical variables are kids and marital.
            # Modifying dataframe ------
            # Marital and Kids Level Labeling
            marry_levels <- c(Single = "0", Married = "1")
            kids_levels <- c("0" = "0", "1" = "1",
                             "2" = "2", "3" = "3",
                             "4" = "4")

            # ## Unique Kids Count
            # it_kids_marital_unique_n <- dim(as.matrix(df_alloc_combined
            #                                           %>% group_by(kids, marital) %>% summarize(freq=n())))[1]

            ## Select, as factor, and recode
            df_alloc_use <- df_MPC_results_A_alpha %>%
              mutate(kids = as.numeric(kids)) %>%
              # filter(kids <= 2) %>%
              mutate(kids = as.factor(kids),
                     marital = as.factor(marital)) %>%
              mutate(kids = fct_recode(kids, !!!kids_levels),
                     marital = fct_recode(marital, !!!marry_levels))

            # Get value for minimum and maximum income levels for each bin
            df_alloc_use <- df_alloc_use %>%
              rowwise() %>%
              mutate(y_group_min = substring(strsplit(ymin_group, ",")[[1]][1], 2),
                     y_group_max = gsub(strsplit(ymin_group, ",")[[1]][2],  pattern = "]", replacement = "")) %>%
              ungroup()

            # To avoid discontinuity of the highest income bin, >200k for all
            if (bl_cap_x_axis) {
              df_alloc_use <- df_alloc_use %>%
                mutate(y_group_max = as.numeric(y_group_max)) %>%
                filter(y_group_max <= 10)
            }

            # Generate factors
            df_alloc_use <- df_alloc_use %>%
              mutate(ymin_group = as.factor(ymin_group),
                     kids = as.factor(kids),
                     marital = as.factor(marital))

            # Transform scale
            df_alloc_use <- df_alloc_use %>% mutate(mass = mass*100, alpha = alpha*100)
            if (bl_log_x_axis) {
              df_alloc_use <- df_alloc_use %>% mutate(A = log(A))
            }

            # Use R4Econ Scatter Code Template
            # Graphing
            plt_mtcars_scatter <-
              ggplot(df_alloc_use, aes(x=A, y=alpha)) +
              geom_jitter(aes(size=mass,
                              colour=kids,
                              shape=marital), width = 0.15) +
              # geom_smooth(span = 0.50, se=FALSE) +
              theme(text = element_text(size = 16))

            # Color controls
            # ar_st_colors <- c("#33cc33", "#F8766D")
            # ar_st_colors_label <- c("v-shaped", "straight")
            fl_legend_color_symbol_size <- 5
            st_leg_color_lab <- "Number of children"
            # Shape controls
            # ar_it_shapes <- c(9, 15)
            # ar_st_shapes_label <- c("auto", "manuel")
            fl_legend_shape_symbol_size <- 5
            st_leg_shape_lab <- "Marital status"
            # Control scatter point size
            fl_min_size <- 1.25
            fl_max_size <- 12
            ar_size_range <- c(fl_min_size, fl_max_size)
            st_leg_size_lab <- "Population share (%)"

            # Labeling
            # st_title <- paste0('Distribution of HP and QSEC from mtcars')
            # st_subtitle <- paste0('https://fanwangecon.github.io/',
            #                       'R4Econ/tabgraph/ggscatter/htmlpdfr/fs_ggscatter_3cts_mdisc.html')
            # st_caption <- paste0('mtcars dataset, ',
            #                      'https://fanwangecon.github.io/R4Econ/')

            if (grepl('bushchck', st_which_solu)) {
               # 2008 Bush stimulus were tax rebates
                st_stimulus_or_rebate <- "tax rebates"
            } else {
              # COVID stimulus were not tax rebates, but just stimulus checks
                st_stimulus_or_rebate <- "stimulus checks"
            }

            if (MPC_type == 5 | MPC_type == 6) {
              if (bl_log_x_axis) {
                st_x_label <- paste0('Log average life-discounted-lifetime-perm-c per household member before receiving ', st_stimulus_or_rebate)
              } else {
                st_x_label <- paste0('Average life-discounted-perm-c per household member before receiving ', st_stimulus_or_rebate)
                # st_x_label <- 'Minimum household income given income bin'
              }
              st_y_label <- paste0('MPV (life-discounted-perm-c) out of first $100 in ', st_stimulus_or_rebate, ' (percent)')
            } else {
              if (bl_log_x_axis) {
                st_x_label <- paste0('Log average consumption per household member before receiving ', st_stimulus_or_rebate)
              } else {
                st_x_label <- paste0('Average consumption per household member before receiving ', st_stimulus_or_rebate)
                # st_x_label <- 'Minimum household income given income bin'
              }
              st_y_label <- paste0('MPC out of first $100 in ', st_stimulus_or_rebate, ' (percent)')
            }

            # Add titles and labels
            plt_mtcars_scatter <- plt_mtcars_scatter +
              labs(x = st_x_label, y = st_y_label)

            # Color, shape and size controls
            plt_mtcars_scatter <- plt_mtcars_scatter +
              # scale_colour_manual(values=ar_st_colors, labels=ar_st_colors_label) +
              # scale_shape_manual(values=ar_it_shapes, labels=ar_st_shapes_label) +
              scale_size_continuous(range = ar_size_range)

            # replace the default labels for each legend segment
            plt_mtcars_scatter <- plt_mtcars_scatter +
              labs(colour = st_leg_color_lab,
                   shape = st_leg_shape_lab,
                   size = st_leg_size_lab)

            # Control the order of legend display
            # Show color, show shape, then show size.
            plt_mtcars_scatter <- plt_mtcars_scatter + guides(
              shape = guide_legend(order = 1, override.aes = list(size = fl_legend_shape_symbol_size)),
              colour = guide_legend(order = 2, override.aes = list(size = fl_legend_color_symbol_size)),
              size = guide_legend(order = 3))

            # x-axis
            if (bl_log_x_axis) {
              print('do not label x-axis, not in level')
            } else {
              if (MPC_type == 5 | MPC_type == 6) {
                x.labels <- c('0', '2.5K', '5k', '7.5k', '10K', '15k', '20k')
                x.breaks <- c(0,
                              2500,
                              5000,
                              7500,
                              10000,
                              15000,
                              20000)
                # x-axis labeling
                plt_mtcars_scatter <- plt_mtcars_scatter +
                  scale_x_continuous(labels = x.labels, breaks = x.breaks)
              } else {
                x.labels <- c('0', '25K', '50k', '75k', '100K', '125K', '150K')
                x.breaks <- c(0,
                              25000,
                              50000,
                              75000,
                              100000,
                              125000,
                              150000)
                # x-axis labeling
                plt_mtcars_scatter <- plt_mtcars_scatter +
                  scale_x_continuous(labels = x.labels, breaks = x.breaks)
              }
            }

            # Graph
            if (bl_save_img) {

              # Image names for savings
              if (bl_log_x_axis) {
                snm_save_csv_file <- paste0(snm_save_csv_file, '_logy')
              }
              if (bl_cap_x_axis) {
                snm_save_csv_file <- paste0(snm_save_csv_file, '_capx')
              }

              # add png
              snm_save_png <- paste0(snm_save_csv_file, '.png')

              #
              ggsave(plt_mtcars_scatter,
                     file=file.path(srt_imgcsv_mpcapc_root, snm_save_png),
                     width = 270,
                     height = 216, units='mm',
                     dpi = 300)
            }


          }
        }
      }
    }
  }
}
# stopCluster(cl)
