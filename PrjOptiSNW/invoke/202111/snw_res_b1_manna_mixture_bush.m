%% Solve for MPC At Each Check Level over Beta and Alpha Types
%{
Copied from PrjOptiSNW\invoke\202102\snw_res_b1_manna_mixture.m
For BUSH = Economic Stimulus Act of 2008 (BUsh Checks)

Adjustments from PrjOptiSNW\invoke\202102\snw_res_b1_manna_mixture.m:

In 2008, Ratio of average Social Seciurity benefits between college and
non-college educated individuals from 2019=1.209. In 2019:
Let SS_{e=0}=$13,775/$62,502=0.220 and
let SS_{e=1}=0.220*1.209=0.266.

Robustness:

1. 4% + bchklock
2. 2% + bchklock
3. 4% + bchklock + noui, b = 0

xi=0.25 to 0.651 for noui version;

- go calculate the b for 2009 and similarly for COVID time.
%}

clc;
clear all;

%% Model Call Type
%{

JDEC submission version:

    * trumpchk = trump check, 1st round check
    * bidenchk = biden check, 3rd round
    * bchklock = biden check with lockdown, meaning 3rd round check in 2nd
        year with lockdown parameter on utility
    * bchknoui = biden check, without lockdown, but no ui benefits

    st_biden_or_trump = 'trumpchk';
    st_biden_or_trump = 'bchklock';
    st_biden_or_trump = 'bidenchk';
    st_biden_or_trump = 'bchknoui';

JEDC revision version, COVID 19 problem:

    * bchklock = biden check with lockdown this is benchmark
    * bchklkr2 = biden check with lockdown and 2 percent interest rates
    * bcklknou = b (biden) ck (check) lk (lockdown) nou (no ui)

    st_biden_or_trump = 'bchklock';
    st_biden_or_trump = 'bchklkr2';
    st_biden_or_trump = 'bcklknou';

%}

%% Call Groups
% For COVID Check, solve the problem 3 times for JEDC revision
ar_it_solve_jedc_rr = [1];

for it_solve_jedc_rr = ar_it_solve_jedc_rr

    %% 2021 Nov Parameter Updates
    %
    % NORMALIZATION:
    % Normalize theta such that median household income=1.0, where a value of
    % 1.0 corresponds to $62,502 in 2019 and $54,831 in 2007 (constant 2012
    % USD).
    %
    % 	Unemployment insurance (UI) benefits: Ratio of UI benefits to wages &
    % 	salaries=2.10 percent in 2009 and equal to 5.68 percent in 2020 (BEA,
    % 	Personal Income, Table 2.1, lines 3 and 21). Assume that UI replaces
    % 	share b of lost earnings. \zeta \in [0,1] governs duration of
    % 	unemployment spell (and hence severity of the recession). \zeta=0 means
    % 	no wage earnings in 2009 (unemployed the entire year). Let \zeta be
    % 	equal to the average unemployment duration. In 2009, \zeta=0.532, and
    % 	in 2020, \zeta=0.651 (BLS).
    %
    % a. Average Social Security benefits for 65+ year-old college graduates
    % (non-college graduates) with positive SS income equals $14,858 ($12,334)
    % in 2007 and in $16,653 ($13,775) in 2019 (data from the CPS).
    %
    % b. Ratio of average Social Security benefits between college and
    % non-college educated individuals from 2007=1.205 (from 2019=1.209).
    %
    % c. In 2019: Let SSe=0=$13,775/$62,502=0.220 and let
    % SSe=1=0.220*1.209=0.266.
    %
    % d. In 2007: Let SSe=0=$12,334/$54,831=0.225 and let
    % SSe=1=0.225*1.205=0.271.
    %
    % e. Note: Normalized SSe=0 and SSe=1 are nearly identical in 2007 and
    % 2019. Hence, no need to recalibrate. Just have to keep in mind what
    % dollar value a value of 1.0 in the model corresponds to since it matters
    % for the stimulus checks.
    %
    % f. Note: Social Security benefits-to-GDP ratio in 2007=3.984 percent and
    % in 2019=4.828 percent.

    % COVID Era Updated Parameters
    if (it_solve_jedc_rr >= 1 && it_solve_jedc_rr <= 3)
        fl_ss_non_college = 0.225; % Average SS non-college 2005-2009 as a share of GDP per capita
        fl_ss_college = 0.271; % Average SS college 2005-2009 as a share of GDP per capita
        fl_scaleconvertor = 54831;
        fl_xi = 0.532;
        fl_b = 0.37992;
    end

    %% Beta and edu combos to mix
    % The two mixture beta values
    ls_fl_beta_val = [0.60, 0.95];
    % ls_fl_beta_val = [0.95];
    % Solve for HS and College for each type
    ls_it_edu_simu_type = [1, 2];
    % Biden check (3rd check)

    %% Model Version

    if (it_solve_jedc_rr == 1)
        % it_solve_jedc_rr = 1 and 2 are both biden lockdown policies with
        % different interest rates
        st_biden_or_trump = 'bushchck';

    % elseif (it_solve_jedc_rr == 2)
    %     st_biden_or_trump = 'bchklkr2';
    %
    % elseif (it_solve_jedc_rr == 3)
    %     % higher default interest rate, biden check, lockdown, but without UI benefits
    %     st_biden_or_trump = 'bcklknou';

    end

    %% Function call
    % Solve for beta and edu combinations
    for fl_beta_val = ls_fl_beta_val
        for it_edu_simu_type = ls_it_edu_simu_type

            %% A1. Computing Specifications
            % 1a. Parfor controls
            bl_parfor = true;
            it_workers = 9;
            % 1b. Export Controls
            bl_export = true;
            % 1c. Solution Type
            st_solu_type = 'bisec_vec';

            %% A2. Parameter Specifications by Education Groups.
            % 2. Set Up Parameters
            mp_more_inputs = containers.Map('KeyType','char', 'ValueType','any');
            if (it_edu_simu_type == 1)
                mp_more_inputs('st_edu_simu_type') = 'low';
                st_param_group_suffix = '_e1lm2';
            elseif (it_edu_simu_type == 2)
                mp_more_inputs('st_edu_simu_type') = 'high';
                st_param_group_suffix = '_e2hm2';
            end
            mp_more_inputs('fl_ss_non_college') = fl_ss_non_college;
            mp_more_inputs('fl_ss_college') = fl_ss_college;
            mp_more_inputs('fl_scaleconvertor') = fl_scaleconvertor;

            % param group name
            % st_param_group_base = 'default_tiny';
            % st_param_group_base = 'default_small53';
            % st_param_group_base = 'default_dense';
            % st_param_group_base = 'default_docdense';
            % st_param_group_base = 'default_moredense_a65zh133zs5';
            st_param_group_base = 'default_moredense_a65zh266zs5';
            st_param_group = [st_param_group_base st_param_group_suffix];
            % get parametesr
            mp_params = snw_mp_param(st_param_group, false, 'tauchen', false, 8, 8, mp_more_inputs);

            %% B1. Mixture Calibrated Parameters
            % see
            % Output202101/log/cali_tax_normgdp_multitypes_default_docdense.out
            mp_params('a2') = 1.6996;
            mp_params('a2_bushchkyr_2008') = 1.6996;
            mp_params('a2_greatrecession_2009') = 1.6996;
            mp_params('theta') = 0.5577;
            % if (strcmp(st_biden_or_trump, 'bchklock') || ...
            %         strcmp(st_biden_or_trump, 'bchklkr2') || ...
            %         strcmp(st_biden_or_trump, 'bcklknou'))
            %     mp_params('invbtlock') = 0.66884;
            % end

            %% B2. Unemployment Shock and Benefits
            mp_params('xi') = fl_xi;
            mp_params('b') = fl_b;

            %% B3. Welfare Check Value And Numbers
            % The number of welfare checks to consider and the value of each checks
            TR=100/fl_scaleconvertor;
            % Bush check: The current proposal by Congress is to give $600
            % to adults, $1200 to married couples, and $300 per child 97 =
            % (3*4 + 6*2)*4 + 1, allowing for potentially quadrupling of
            % stimulus
            n_welfchecksgrid = 97;
            mp_params('TR') = TR;
            mp_params('n_welfchecksgrid') = n_welfchecksgrid;

            %% B4. Tax in 2008
            mp_params('a2_covidyr') = mp_params('a2_bushchkyr_2008');

            %% B5. Interest rate adjustment, referee
            % if (strcmp(st_biden_or_trump, 'bchklkr2'))
            %     fl_r_annual = 0.02;
            % else
            fl_r_annual = 0.04;
            % end
            it_yrs_per_period = mp_params('it_yrs_per_period');
            if(contains(st_param_group, "dense"))
                r=fl_r_annual;
            else
                r=((1 + fl_r_annual)^it_yrs_per_period)-1;
            end
            mp_params('r') = r;

            %% C. Income Grid Solution Precision
            % Let's use the current proposal for the third round by Congress.
            % The excel file shows how much single and married people with and
            % without children receive given income. It also shows when the
            % stimulus checks will phase out to zero (reaching 0 at an income
            % of $100k for singles without children; reaching 0 at an income of
            % $150k for singles with children (independent of how many
            % children); and reaching 0 at an income of $200k for married
            % couples (independent of how many children they have). In each
            % case, it's a linear slope from when it starts phasing out until
            % it reaches zero. The magnitude of the slope is a little bit
            % different compared to the common slope of 5 dollar stimulus
            % reduction for each 100 dollar income increase under the Trump
            % policy.
            % max phase out is slightly below 200k
            % fl_max_phaseout = 238000;
            %         fl_max_phaseout = 318000; % 7*58056 is 406392
            fl_max_phaseout = 225000;
            fl_multiple = fl_scaleconvertor;
            it_bin_dollar_before_phaseout = 500;
            it_bin_dollar_after_phaseout = 5000;
            fl_thres = fl_max_phaseout/fl_multiple;
            inc_grid1 = linspace(0,fl_thres,(fl_max_phaseout)/it_bin_dollar_before_phaseout);
            inc_grid2 = linspace(fl_thres, 7, (7*fl_multiple-fl_max_phaseout)/it_bin_dollar_after_phaseout);
            inc_grid=sort(unique([inc_grid1 inc_grid2]'));

            mp_params('n_incgrid') = length(inc_grid);
            mp_params('inc_grid') = inc_grid;

            % 3. Controls
            mp_controls = snw_mp_control('default_test');

            %% D. Parameter overrid for gamma beta and r
            mp_params('beta') = fl_beta_val;
            st_file_name_suffix = ['_bt' num2str(round(fl_beta_val*100))];

            %% E. Display Control Parameters
            mp_controls('bl_print_vfi') = true;
            mp_controls('bl_print_vfi_verbose') = false;
            mp_controls('bl_print_ds') = true;
            mp_controls('bl_print_ds_verbose') = true;
            mp_controls('bl_print_precompute') = true;
            mp_controls('bl_print_precompute_verbose') = false;
            mp_controls('bl_print_a4chk') = false;
            mp_controls('bl_print_a4chk_verbose') = false;
            mp_controls('bl_print_v08p08_jaeemk') = false;
            mp_controls('bl_print_v08p08_jaeemk_verbose') = false;
            mp_controls('bl_print_v08_jaeemk') = false;
            mp_controls('bl_print_v08_jaeemk_verbose') = false;
            mp_controls('bl_print_evuvw20_jaeemk') = false;
            mp_controls('bl_print_evuvw20_jaeemk_verbose') = false;
            mp_controls('bl_print_evuvw19_jaeemk') = false;
            mp_controls('bl_print_evuvw19_jaeemk_verbose') = false;
            mp_controls('bl_print_evuvw19_jmky') = false;
            mp_controls('bl_print_evuvw19_jmky_verbose') = false;
            mp_controls('bl_print_evuvw19_jmky_mass') = false;
            mp_controls('bl_print_evuvw19_jmky_mass_verbose') = false;

            %% F1. Output Save nmae
            snm_suffix = ['_b1_xi0_manna_' num2str(n_welfchecksgrid-1) st_file_name_suffix];

            %% F2. Start log
            mp_paths = snw_mp_path('fan');
            spt_simu_outputs_log = mp_paths('spt_simu_outputs_log');

            snm_invoke_suffix = strrep(mp_params('mp_params_name'), 'default_', '');
            snm_file = ['snwx_v_planner_' char(snm_invoke_suffix) char(snm_suffix)];
            spn_log = fullfile(mp_paths('spt_simu_outputs_log'), [snm_file '.log']);

            diary(spn_log);

            %% F3. Log Show Parameters for Simulation
            ff_container_map_display(mp_params);
            ff_container_map_display(mp_controls);

            %% G. Run Checks Programs
            bl_load_mat = true;
            snw_evuvw19_jmky_allchecks(mp_params, mp_controls, ...
                st_biden_or_trump, st_solu_type, ...
                bl_parfor, it_workers, ...
                bl_export, bl_load_mat, snm_suffix);

            %% H. Stop Log
            diary off;

        end
    end
end
