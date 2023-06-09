cmake_minimum_required(VERSION 3.14)

project(overwatch_manager VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONFIGS_PATH ${CMAKE_CURRENT_SOURCE_DIR}/configs)
set(NETWORK_PATH ${CMAKE_CURRENT_SOURCE_DIR}/network)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/settings.ini ${CMAKE_CURRENT_BINARY_DIR}/settings.ini COPYONLY)

include_directories(${NETWORK_PATH})
include_directories(${CONFIGS_PATH})

set(PROJECT_SOURCES
        main.cpp
        network/connection.h network/connection.cpp
        network/clientconnection.h network/clientconnection.cpp
        network/protocol.h
        configs/configurer.h configs/configurer.cpp
        configs/networkconfig.h configs/networkconfig.cpp
        qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(overwatch_manager
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET overwatch_manager APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(overwatch_manager SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(overwatch_manager
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(overwatch_manager
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)

set_target_properties(overwatch_manager PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS overwatch_manager
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(overwatch_manager)
    qt_finalize_executable(overwatch_manager)
endif()
