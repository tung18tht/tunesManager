import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import FilesManager 1.0

ApplicationWindow {
    property string directoryPath: fileDialog.folder.toString().substring(7)

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
            tuneModel.clear()
            tuneModel.insert(0, filesManager.searchTunes(directoryPath))

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

        backToHomeButtonMouse.onClicked: {
            tunePlayer.stop()

            root.width = 600
            root.height = 300

            tunesWindow.visible = false
            homeWindow.visible = true
        }

        tuneTable.onSortIndicatorColumnChanged: {
            tuneModel.clear()
            tuneModel.insert(0, filesManager.sortTuneList("name", 1))
        }

        tuneTable.onSortIndicatorOrderChanged: {
            tuneModel.clear()
            tuneModel.insert(0, filesManager.sortTuneList("name", 1))
        }

        tuneTable.onClicked: {
        }

        tuneTable.onDoubleClicked: {
            tunePlayer.source = tuneModel.get(row).path
            tunePlayer.play()
        }
    }

    ListModel {
        id: tuneModel
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


