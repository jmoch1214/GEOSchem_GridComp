module module_mosaic_cam_init

#ifndef GEOS5_PORT
  use shr_kind_mod,            only: r8 => shr_kind_r8
  use infnan,                  only: nan, bigint
#else
  use MAPL_ConstantsMod,       only: r8 => MAPL_R8
  use infnan,                  only: nan, bigint
#endif

  !---------------------------------------------------------------------------------------!
  !BSINGH: This module initilizes Mosaic chemistry variables.
  !---------------------------------------------------------------------------------------!

  implicit none
  private

  public:: mosaic_cam_init

contains

#ifndef GEOS5_PORT
  subroutine mosaic_cam_init
#else
  subroutine mosaic_cam_init(verbose)
#endif
    !---------------------------------------------------------------------------------------!
    !BSINGH: This subroutine initialzies some Mosaic conastans and inpput parameters
    ! Called by: modal_aero_initialize_data.F90
    !---------------------------------------------------------------------------------------!
#ifndef GEOS5_PORT
    use spmd_utils,                   only: masterproc
#endif
    use cam_logfile,                  only: iulog
    use modal_aero_amicphys,          only: max_mode

    use module_data_mosaic_aero,      only: nbin_a_max, nbin_a, mhyst_method, mhyst_force_up, &
         mGAS_AER_XFER, mDYNAMIC_SOLVER, msize_framework, mmodal, alpha_ASTEM, rtol_eqb_ASTEM,      &
         ptol_mol_ASTEM, method_bcfrac, method_kappa, maersize_init_flag1, mcoag_flag1,     &
         ifreq_coag, mmovesect_flag1, mnewnuc_flag1, msectional_flag1, &
         use_cam5mam_soa_params, use_cam5mam_accom_coefs

    use module_data_mosaic_main,      only: ipmcmos,    &
         mgas, maer, mcld, maeroptic, mshellcore, msolar, mphoto

    use module_data_mosaic_asecthp,     only: ntype_md1_aer, ntype_md2_aer

    use module_data_mosaic_constants, only: pi, piover4, piover6, deg2rad, third
#ifndef GEOS5_PORT
    use physconst,                    only: pi_cam => pi
#else
    use MAPL_ConstantsMod,            only: pi_cam => MAPL_PI
#endif
    use module_mosaic_init_aerpar,    only: mosaic_init_aer_params

#ifdef GEOS5_PORT
    implicit none

    ! arguments
    logical, intent(in) :: verbose

    ! local
    logical :: masterproc
    masterproc = verbose
#endif
    

    !Initialize Mosaic constants with values from CAM constants
    nbin_a_max = max_mode !*BALLI* Ask Dick about it
    nbin_a     = max_mode !Maximum # of modes is equal to # of bins in Mosaic
    if(masterproc) then
       write(iulog,*) 'mosaic_cam_init: nbin_a_max=', nbin_a_max
    endif

    pi         = pi_cam          !Pi value from CAM
    piover4      = 0.25_r8 * pi
    piover6      = pi/6.0_r8
    deg2rad      = pi/180.0_r8
    third        = 1.0_r8/3.0_r8

    use_cam5mam_soa_params  = 1  ! use cam5-mam soa/soag parameter values
    use_cam5mam_accom_coefs = 1  ! use cam5-mam accomodation coefficient values

    !BSINGH - Initialize other constants which sit in the input file of Mosaic
    !and are used in the present code(**BALLI Ask Dick about it)
    mhyst_method    = mhyst_force_up  !rceaster !mhyst_method (1=uporlo_jhyst, 2=uporlo_waterhyst, 3=force_up, 4=force_low)
    mGAS_AER_XFER   = 1    !mGAS_AER_XFER: 1=do gas-aerosol partitioning 0=do not partition
    mDYNAMIC_SOLVER = 1    !mDYNAMIC_SOLVER: 1=astem  2=lsodes
    msize_framework = mmodal  ! rceaster (1=modal, 2=unstructured, 3=sectional)
    alpha_ASTEM     = 0.5  !Solver parameter. range: 0.01 - 1.0
    rtol_eqb_ASTEM  = 0.01 !Relative eqb tolerance. range: 0.01 - 0.03
    ptol_mol_ASTEM  = 0.01 !Percent mol tolerance.  range: 0.01 - 1.0
    ipmcmos         = 0    !Additional inputs needed when ipmcmos > 0


    !BSINGH - Initialize constants to 'bigint' which sit in the input file of Mosaic
    !and are NOT used in the present code(**BALLI Ask Dick about it)
    !'bigint' initialized variables will cause the code to halt on their first use

    ntype_md1_aer       = bigint !(number of aerosol types)
    ntype_md2_aer       = bigint !(number of aerosol types)
    method_bcfrac       = bigint !(only used for sectional and ntype>1)
    method_kappa        = bigint !(only used for sectional and ntype>1)
    maersize_init_flag1 = bigint !(only used for sectional and ntype>1)

    mcoag_flag1         = bigint !(only used for sectional)
    ifreq_coag          = bigint !(only used for sectional)
    mmovesect_flag1     = bigint !(only used for sectional)
    mnewnuc_flag1       = bigint !(only used for sectional)
    msectional_flag1    = bigint !(currently not used)

! these variables are now in module_data_mosaic_boxmod, and can be ignored by cam and cambox codes
!   iprint              = bigint !freq of output. Every iprint*dt_min mins.
!   iwrite_gas          = bigint
!   iwrite_aer_bin      = bigint
!   iwrite_aer_dist     = bigint
!   iwrite_aer_species  = bigint
!   mmode               = bigint !: 1=time integration 2=parametric analysis

    mgas                = bigint !: 1=gas chem on,  0=gas chem off**
    maer                = bigint !: 1=aer chem on,  0=aer chem off**
    mcld                = bigint !: 1=cld chem on,  0=cld chem off**
    maeroptic           = bigint !: 1=aer_optical on,  0=aer_optical off **
    mshellcore          = bigint !: 0=no shellcore,  1=core is BC only,  2=core is BC and DUST **
    msolar              = bigint !: 1=diurnally varying phot, 2=fixed phot**
    mphoto              = bigint !: 1=Rick's param 2=Yang's param**

    call mosaic_init_aer_params

  end subroutine mosaic_cam_init

end module module_mosaic_cam_init
