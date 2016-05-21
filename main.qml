import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import FilesManager 1.0

ApplicationWindow {
    property alias fileDialog: fileDialog

    visible: true
    width: 300
    height: 300
    title: qsTr("Tunes Manager")

    menuBar: MenuBar {
    }

    MainForm {
        anchors.fill: parent
        directoryButton.onClicked: fileDialog.open()
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


