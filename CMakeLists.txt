cmake_minimum_required(VERSION 3.16)

project(VideoPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Multimedia Core)

qt_standard_project_setup()

qt_add_executable(appVideoPlayer
    main.cpp
)

qt_add_qml_module(appVideoPlayer
    URI VideoPlayer
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES PlayerControls.qml
        SOURCES mediaplayerextended.h mediaplayerextended.cpp
        RESOURCES
            assets/play.svg
            assets/next.svg
            assets/pause.svg
            assets/menu.svg
            assets/speed.svg
            QML_FILES ControlPanelButton.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appVideoPlayer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appVideoPlayer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appVideoPlayer
    PRIVATE Qt6::Quick Qt6::Multimedia Qt6::Core
)

include(GNUInstallDirs)
install(TARGETS appVideoPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
