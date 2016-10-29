# RPM specific CPack configuration parameters

set(CPACK_GENERATOR "RPM")
set(CPACK_RPM_PACKAGE_RELEASE ${MAXSCALE_BUILD_NUMBER})
set(CPACK_RPM_PACKAGE_VENDOR "MariaDB Corporation Ab")
set(CPACK_RPM_PACKAGE_LICENSE "MariaDB BSL")
set(CPACK_RPM_PACKAGE_URL "https://github.com/mariadb-corporation/MaxScale")
set(CPACK_RPM_PACKAGE_GROUP "Applications/Databases")
set(CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION "/etc /etc/ld.so.conf.d /etc/init.d /etc/rc.d/init.d /usr/share/man /usr/share/man1")
set(CPACK_RPM_SPEC_MORE_DEFINE "%define ignore \#")
set(CPACK_RPM_PACKAGE_COMPONENT ON)
set(CPACK_RPM_COMPONENT_INSTALL ON)

set(CPACK_RPM_core_PACKAGE_NAME "${PACKAGE_NAME_CORE}")
set(CPACK_RPM_core_FILE_NAME "${PACKAGE_FILE_NAME_CORE}.rpm")
set(CPACK_RPM_experimental_PACKAGE_NAME "${PACKAGE_NAME_EXPERIMENTAL}")
set(CPACK_RPM_experimental_FILE_NAME "${PACKAGE_FILE_NAME_EXPERIMENTAL}.rpm")
set(CPACK_RPM_devel_PACKAGE_NAME "${PACKAGE_NAME_DEVEL}")
set(CPACK_RPM_devel_FILE_NAME "${PACKAGE_FILE_NAME_DEVEL}.rpm")

set(CPACK_RPM_experimental_PACKAGE_DESCRIPTION "Extra modules for MariaDB MaxScale")
set(CPACK_RPM_devel_PACKAGE_DESCRIPTION "Development files for MariaDB MaxScale")

# The experimental package should depend on the core package
set(CPACK_RPM_experimental_PACKAGE_REQUIRES "maxscale")

set(IGNORED_DIRS
  "%ignore /etc"
  "%ignore /etc/init.d"
  "%ignore /etc/ld.so.conf.d"
  "%ignore ${CMAKE_INSTALL_PREFIX}"
  "%ignore ${CMAKE_INSTALL_PREFIX}/bin"
  "%ignore ${CMAKE_INSTALL_PREFIX}/include"
  "%ignore ${CMAKE_INSTALL_PREFIX}/lib"
  "%ignore ${CMAKE_INSTALL_PREFIX}/lib64"
  "%ignore ${CMAKE_INSTALL_PREFIX}/share"
  "%ignore ${CMAKE_INSTALL_PREFIX}/share/man"
  "%ignore ${CMAKE_INSTALL_PREFIX}/share/man/man1")

set(CPACK_RPM_USER_FILELIST "${IGNORED_DIRS}")

set(CPACK_RPM_core_POST_INSTALL_SCRIPT_FILE ${CMAKE_BINARY_DIR}/postinst)
set(CPACK_RPM_core_POST_UNINSTALL_SCRIPT_FILE ${CMAKE_BINARY_DIR}/postrm)

if(EXTRA_PACKAGE_DEPENDENCIES)
  set(CPACK_RPM_PACKAGE_REQUIRES "${EXTRA_PACKAGE_DEPENDENCIES}")
endif()

message(STATUS "Generating RPM packages")
# Installing this prevents RPM from deleting the /var/lib/maxscale folder
install(DIRECTORY DESTINATION ${MAXSCALE_VARDIR}/lib/maxscale COMPONENT core)
