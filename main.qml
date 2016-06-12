import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import FilesManager 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 600
    minimumWidth: 600
    height: 300
    minimumHeight: 300
    title: "Tunes Manager"

    menuBar: MenuBar {
    }

    HomeWindowForm {
        id: homeWindow
        anchors.fill: parent

        directoryPathMouse.onClicked: fileDialog.open()

        scanButtonMouse.onClicked: {
            root.width = 800
            root.height = 500

            homeWindow.visible = false
            tunesWindow.visible = true
        }
    }

    TunesWindowForm {
        id: tunesWindow
        anchors.fill: parent
        visible: false
    }

    FileDialog {
        id: fileDialog
        folder: shortcuts.home
        selectFolder: true
    }

    FilesManager {
        id: filesManager
    }
}


