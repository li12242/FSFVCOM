include(fvcom_config)

# define target
set(FVCOM_NAME fvcom)
# file(GLOB_RECURSE FVCOM_SOURCE *.c *.F)
set(FVCOM_SRC_MODS
  mod_prec.F sinter.F mod_types.F mod_time.F mod_main.F mod_spherical.F mod_utils.F mod_clock.F eqs_of_state.F mod_interp.F mod_par.F mod_par_special.F mod_ncll.F mod_nctools.F mod_wd.F mod_sng.F mod_heatflux.F mod_solar.F mod_bulk.F mod_input.F mod_force.F mod_obcs.F mod_petsc.F mod_semi_implicit.F mod_non_hydro.F mod_set_time.F ice_kinds_mod.F ice_model_size.F ice_domain.F ice_constants.F ice_fileunits.F ice_state.F ice_work.F ice_grid.F ice_albedo.F ice_calendar.F ice_flux.F ice_flux_in.F ice_itd.F ice_mechred.F ice_itd_linear.F ice_scaling.F ice_atmo.F ice_ocean.F ice_therm_vertical.F ice_init.F ice_therm_itd.F mod_ice2d.F mod_ice.F mod_startup.F mod_wqm.F mod_ncdio.F mod_setup.F mod_newinp.F particle.F linklist.F mod_lag.F mod_northpole.F mod_pwp.F mod_dye.F mod_optimal_interpolation.F mod_report.F mod_probe.F mod_gotm.F mod_balance_2d.F mod_tridiag.F mod_scal.F mod_meanflow.F mod_obcs2.F mod_obcs3.F mod_sed.F mod_enkf.F mod_etkf.F mod_rrk.F mod_rrkf_obs.F mod_rrkassim.F mod_enkf_ncd.F enkf_ncdio.F mod_enkf_obs.F mod_enkfassim.F mod_assim.F mod_nesting.F mod_visit.F mod_plbc.F mod_dam.F mod_station_timeseries.F mod_sparse_timeseries.F mod_boundschk.F mod_esmf_nesting.F mod_cstms_vars.F mod_flocmod.F mod_sed_cstms.F mod_fluid_mud.F mod_tvd.F mod_mld_rho.F mod_vegetation.F mod_heatflux_sediment.F mod_vector_projection.F)

set(FVCOM_SRC_MODS_W
  mod_main_wave.F swmod1.F swmod2.F swmod3.F mod_action_im.F mod_action_ex.F mod_wavesetup.F mod_wave_current_interaction.F mod_bbl.F
)

set(FVCOM_SRC_MAIN
  fvcom.F genmap.F tge.F longshore_flow.F cell_area.F open_all.F load_grid.F allocate_all.F setup_domain.F genmap_obc.F genmap_lsf.F print_vals.F coords_n_const.F shape_coef_gcn.F shape_coef_gcy.F depth_grad.F grid_metrics.F cntrl_prmtrs.F init_sed.F internal_step.F bcond_gcn.F bcond_gcy.F adjust2d3d.F brough.F advection_edge_gcn.F advection_edge_gcy.F ghostuv.F phy_baropg.F baropg.F external_step.F extel_edge.F extuv_edge.F depth_check.F vertvl_edge.F adv_uv_edge_gcn.F adv_uv_edge_gcy.F vdif_uv.F extelpf_edge.F wreal.F viscofh.F adv_q.F fct_q2.F fct_q2l.F vdif_q.F adv_t.F adv_s.F fct_t.F vdif_ts.F vdif_ts_gom.F fct_s.F bcond_ts.F adjust_ts.F conv_over.F visitsim.F startup_type.F edge_len.F adcor.F icing.F rho_pmean.F calc_vort.F namelist.F nh_set_nesting.F coare26z.F coare40vn.F adv_uv_edge_gcn_rk.F adv_uv_edge_gcy_rk.F adv_t_rk.F adv_s_rk.F adv_q_rk.F)

set(FVCOM_SRC_MAIN_W
  ocpmix.F ocpcre.F ocpids.F swanpre1.F swanpre2.F swanser.F swanmain.F swancom1.F swancom2.F swancom3.F swancom4.F swancom5.F w3part.F)

set(FVCOM_SRC_MAIN_V
  advave_edge_gcn.F advave_edge_gcy.F)

set(FVCOM_SRC_COBJS
  func_pointer.c
  partition.c
)

set(FVCOM_SRC_BIOGEN
  mod_bio_3D.F mod_onedtide.F)

# list(REMOVE_ITEM ${FVCOM_SOURCE} partition.c)
add_executable(${FVCOM_NAME}
  ${FVCOM_SRC_MODS}
  ${FVCOM_SRC_MODS_W}
  ${FVCOM_SRC_MAIN}
  ${FVCOM_SRC_MAIN_W}
  ${FVCOM_SRC_MAIN_V}
  ${FVCOM_SRC_COBJS}
  ${FVCOM_SRC_BIOGEN})

set_target_properties(
  ${FVCOM_NAME}
  PROPERTIES
  # Just dump everything in here
  Fortran_FORMAT FREE
)

# set FVCOM_EXTENAL_PATH
set(FVCOM_EXTENAL_PATH $ENV{FVCOM_EXTENAL_PATH} CACHE PATH "Path to external FVCOM")

if("${FVCOM_EXTENAL_PATH}" STREQUAL "")
  message(FATAL_ERROR "FVCOM external libraries path not set")
else()
  message(STATUS "Found FVCOM_EXTENAL_PATH : ${FVCOM_EXTENAL_PATH}")
  set(FVCOM_EXTENAL_BINARY_PATH ${FVCOM_EXTENAL_PATH}/bin)
  set(FVCOM_EXTENAL_LIBRARY_PATH ${FVCOM_EXTENAL_PATH}/lib)
  set(FVCOM_EXTENAL_INCLUDE_PATH ${FVCOM_EXTENAL_PATH}/include)
endif()

find_package(netCDF REQUIRED)
find_package(netCDF-Fortran REQUIRED)
find_package(metis REQUIRED)
find_package(julian REQUIRED)

target_link_libraries(
  ${FVCOM_NAME}
  PRIVATE
  # Just dump everything in here
  $<$<BOOL:${FVCOM_MULTIPROCESSOR}>:$<TARGET_NAME_IF_EXISTS:MPI::MPI_Fortran>>
  ${netCDF-Fortran_FLIBS}
  ${netCDF_LIBRARIES}
  ${metis_LIBRARIES}
  ${julian_LIBRARIES}
  -Wl,-rpath,$<$<OR:$<LINK_LANGUAGE:C>,$<LINK_LANGUAGE:Fortran>>:${netCDF_LIBRARY_DIR}>
)

target_include_directories(
  ${FVCOM_NAME}
  PRIVATE
  # Just dump everything in here
  $<$<BOOL:${FVCOM_MULTIPROCESSOR}>:$<TARGET_PROPERTY:MPI::MPI_Fortran,INTERFACE_INCLUDE_DIRECTORIES>>
  ${FVCOM_EXTENAL_PATH}/include
)

# message(STATUS "FVCOM_PRECISION value: ${FVCOM_PRECISION}")

target_compile_definitions(
  ${FVCOM_NAME}
  PUBLIC
  $<$<BOOL:${FVCOM_DOUBLE_PRECISION}>:DOUBLE_PRECISION>

  $<$<BOOL:${FVCOM_SPHERICAL}>:SPHERICAL>
  $<$<BOOL:${FVCOM_WET_DRY}>:WET_DRY>
  
  $<$<BOOL:${FVCOM_MULTIPROCESSOR}>:MULTIPROCESSOR>
  $<$<BOOL:${FVCOM_MULTIPROCESSOR}>:METIS_5>

  $<$<BOOL:${FVCOM_WATER_QUALITY}>:WATER_QUALITY>
  $<$<BOOL:${FVCOM_PROJ}>:PROJ>
  $<$<BOOL:${FVCOM_DATA_ASSIM}>:DATA_ASSIM>

  $<$<STREQUAL:${FVCOM_LIMITED},LIMITED_NO>:LIMITED_NO>
  $<$<STREQUAL:${FVCOM_LIMITED},LIMITED_1>:LIMITED_1>
  $<$<STREQUAL:${FVCOM_LIMITED},LIMITED_2>:LIMITED_2>

  $<$<BOOL:${FVCOM_SEMI_IMPLICIT}>:SEMI_IMPLICIT>

  $<$<STREQUAL:${FVCOM_GCN},GCN>:GCN>
  $<$<STREQUAL:${FVCOM_GCN},GCY1>:GCY1>
  $<$<STREQUAL:${FVCOM_GCN},GCY2>:GCY2>

  $<$<BOOL:${FVCOM_GOTM}>:GOTM>
  $<$<BOOL:${FVCOM_EQUI_TIDE}>:EQUI_TIDE>
  $<$<BOOL:${FVCOM_ATMO_TIDE}>:ATMO_TIDE>
  $<$<BOOL:${FVCOM_RIVER_FLOAT}>:RIVER_FLOAT>
  $<$<BOOL:${FVCOM_TVD}>:TVD>
  $<$<BOOL:${FVCOM_MPDATA}>:MPDATA>
  $<$<BOOL:${FVCOM_TWO_D_MODEL}>:TWO_D_MODEL>
  $<$<BOOL:${FVCOM_BALANCE_2D}>:BALANCE_2D>
  $<$<BOOL:${FVCOM_MEAN_FLOW}>:MEAN_FLOW>
  $<$<BOOL:${FVCOM_TIDE_OUTPUT}>:TIDE_OUTPUT>
  $<$<BOOL:${FVCOM_DYE_RELEASE}>:DYE_RELEASE>
  $<$<BOOL:${FVCOM_SEDIMENT}>:SEDIMENT>
  $<$<BOOL:${FVCOM_RRKF}>:RRKF>
  $<$<BOOL:${FVCOM_ONE_D_MODEL}>:ONE_D_MODEL>
  $<$<BOOL:${FVCOM_BioGen}>:BioGen>
  $<$<BOOL:${FVCOM_ICE}>:ICE>

  $<$<STREQUAL:${FVCOM_HEATFLUX},HEATING_CALCULATED>:HEATING_CALCULATED>
  $<$<STREQUAL:${FVCOM_HEATFLUX},HEATING_SOLAR>:HEATING_SOLAR>

  $<$<BOOL:${FVCOM_AIR_PRESSURE}>:AIR_PRESSURE>
  $<$<BOOL:${FVCOM_NH}>:NH>
  $<$<BOOL:${FVCOM_LAG_PARTICLE}>:LAG_PARTICLE>
  $<$<BOOL:${FVCOM_WAVE_CURRENT_INTERACTION}>:WAVE_CURRENT_INTERACTION>
  $<$<BOOL:${FVCOM_THIN_DAM}>:THIN_DAM>
  $<$<BOOL:${FVCOM_PWP}>:PWP>
  $<$<BOOL:${FVCOM_LIMITER_VER_ADV}>:LIMITER_VER_ADV>
  $<$<BOOL:${FVCOM_OLD_PETSC}>:OLD_PETSC>
  $<$<BOOL:${FVCOM_PARTITION_SPECIAL}>:PARTITION_SPECIAL>
  $<$<BOOL:${FVCOM_VEGETATION}>:VEGETATION>
  $<$<BOOL:${FVCOM_PIO}>:PIO>
  $<$<BOOL:${FVCOM_COUPLED}>:COUPLED>
)

# get_target_property(COMPILE_DEFINITIONS ${FVCOM_NAME} COMPILE_DEFINITIONS)
# message(STATUS "Compile definitions: ${COMPILE_DEFINITIONS}")