esma_set_this ()

set (srcs
   HEMCO_GridCompMod.F90
   )

esma_add_library (
  ${this}
  SRCS ${srcs}
  DEPENDENCIES Chem_Shared MAPL_Base HEMCO
  )
target_compile_definitions (${this} PRIVATE ESMF_ DEVEL GEOS_FP)
target_include_directories (${this} PUBLIC ${INC_ESMF} ${INC_NETCDF})

set (acg_headers
  HEMCO_InternalSpec___.h HEMCO_DeclarePointer___.h HEMCO_GetPointer___.h
  )
add_custom_command (
  OUTPUT ${acg_headers}
  COMMAND ${esma_include}/MAPL_Base/mapl_acg.pl ${acg_flags} -v -F ${CMAKE_CURRENT_SOURCE_DIR}/HEMCO_Registry.rc
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  MAIN_DEPENDENCY HEMCO_Registry.rc 
#  DEPENDS ${include_MAPL_Base}/mapl_acg.pl
  COMMENT "Generating automated code for HEMCO"
  )
add_custom_target (phony_HEMCO DEPENDS ${acg_headers})
add_dependencies (${this} phony_HEMCO)

file (GLOB resource_files "*.rc")

install(
   FILES ${resource_files}
   DESTINATION etc
   )
