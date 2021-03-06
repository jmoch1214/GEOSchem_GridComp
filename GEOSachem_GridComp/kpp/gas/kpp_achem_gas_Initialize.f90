! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Initialization File
! 
! Generated by KPP-2.2.3 symbolic chemistry Kinetics PreProcessor
!       (http://www.cs.vt.edu/~asandu/Software/KPP)
! KPP is distributed under GPL, the general public licence
!       (http://www.gnu.org/copyleft/gpl.html)
! (C) 1995-1997, V. Damian & A. Sandu, CGRER, Univ. Iowa
! (C) 1997-2005, A. Sandu, Michigan Tech, Virginia Tech
!     With important contributions from:
!        M. Damian, Villanova University, USA
!        R. Sander, Max-Planck Institute for Chemistry, Mainz, Germany
! 
! File                 : kpp_achem_gas_Initialize.f90
! Time                 : Thu Jun 11 11:33:46 2015
! Working directory    : /gpfsm/dnb32/adarmeno/models/geos-5/heracles-UNSTABLE-DEV_MICROPHYSICS/src/GEOSgcs_GridComp/GEOSgcm_GridComp/GEOSagcm_GridComp/GEOSphV
! Equation file        : kpp_achem_gas.kpp
! Output root filename : kpp_achem_gas
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE kpp_achem_gas_Initialize

  USE kpp_achem_gas_Parameters, ONLY: dp, NVAR, NFIX
  IMPLICIT NONE

CONTAINS


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Initialize - function to initialize concentrations
!   Arguments :
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Initialize ( )


  USE kpp_achem_gas_Global

  INTEGER :: i
  REAL(kind=dp) :: x

  CFACTOR = 1.000000e+00_dp

  x = (0.)*CFACTOR
  DO i = 1, NVAR
    VAR(i) = x
  END DO

  x = (0.)*CFACTOR
  DO i = 1, NFIX
    FIX(i) = x
  END DO

  VAR(1) = (1.0e6)*CFACTOR
  VAR(2) = (1.0e7)*CFACTOR
  VAR(3) = (2.0e7)*CFACTOR
  VAR(4) = (0.0)*CFACTOR
  VAR(5) = (0.0)*CFACTOR
  FIX(1) = (3.0e6)*CFACTOR
  FIX(2) = (5.0e6)*CFACTOR
! constant rate coefficients
! END constant rate coefficients

! INLINED initializations

    temp  = 270.0

    c_O2  = 0.5e19
    c_air = 2.0e19

    dt     = 1800.0              ! seconds
    tstart = 0.0
    tend   = tstart + 1800

! End INLINED initializations

      
END SUBROUTINE Initialize

! End of Initialize function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



END MODULE kpp_achem_gas_Initialize

