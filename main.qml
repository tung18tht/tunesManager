import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import FilesManager 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 600
    maximumWidth: width
    minimumWidth: width
    height: 300
    maximumHeight: height
    minimumHeight: height
    title: "Tunes Manager"

    menuBar: MenuBar {
    }

    HomeWindowForm {
        id: homeWindow
        anchors.fill: parent

        directoryPathMouse.onClicked: fileDialog.open()

        scanButtonMouse.onClicked: {
            homeWindow.visible = false
            tunesWindow.visible = true
            tunesWindow.testText.text = filesManager.searchTunes(fileDialog.folder.toString().substring(7));
        }
    }

    TunesWindowForm {
        id: tunesWindow
        visible: false
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                tunesWindow.visible = false
                homeWindow.visible = true
            }
        }
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


