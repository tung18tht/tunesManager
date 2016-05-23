import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import FilesManager 1.0

ApplicationWindow {
    property alias fileDialog: fileDialog

    visible: true
    width: 600
    height: 300
    title: "Tunes Manager"

    menuBar: MenuBar {
    }

    MainForm {
        anchors.fill: parent
//        .onClicked: fileDialog.open()
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


