
#
# This list contains the versions of Python that will be detected
# and the bindings built against (if that version is installed).
#
# If you want to support another version of Python, add it here.
#
set(PYTHON_BINDING_VERSIONS 2.7 3.6 3.7 3.8)

message("-- trying to build Python bindings for Python versions:  ${PYTHON_BINDING_VERSIONS}")

foreach(PYTHON_BINDING_VERSION ${PYTHON_BINDING_VERSIONS})
	set(BUILD_BINDINGS FALSE)
	if (${PYTHON_BINDING_VERSION} MATCHES "^2.*")
		if (NOT Python2_FOUND)
			find_package(Python2 COMPONENTS Interpreter Development)
		endif()

		if (Python2_FOUND AND ${PYTHON_BINDING_VERSION} MATCHES "${Python2_VERSION_MAJOR}.${Python2_VERSION_MINOR}")
			set(BUILD_BINDINGS TRUE)
		endif()
	elseif (${PYTHON_BINDING_VERSION} MATCHES "^3.*")
		if (NOT Python3_FOUND)
			find_package(Python3 COMPONENTS Interpreter Development)
		endif()

		if (Python3_FOUND AND ${PYTHON_BINDING_VERSION} MATCHES "${Python3_VERSION_MAJOR}.${Python3_VERSION_MINOR}")
			set(BUILD_BINDINGS TRUE)
		endif()
	endif()

	if (BUILD_BINDINGS)
	  message("-- building Python bindings for Python versions:  ${PYTHON_BINDING_VERSION}")
		add_subdirectory(bindings bindings_python_${PYTHON_BINDING_VERSION})
	endif()
endforeach()


#
# install Python examples
#
file(GLOB pyInferenceExamples examples/*.py)

foreach(pyExample ${pyInferenceExamples})
	message("-- Copying ${pyExample}")
	file(COPY ${pyExample} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
	install(FILES "${pyExample}" DESTINATION bin PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endforeach()
