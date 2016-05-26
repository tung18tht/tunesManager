import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import FilesManager 1.0

ApplicationWindow {
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

    MainForm {
        anchors.fill: parent

        directoryPathMouse.onClicked: fileDialog.open()

        scanButtonMouse.onClicked: filesManager.searchTunes(fileDialog.folder);
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


