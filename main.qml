import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import TunesManager 1.0

ApplicationWindow {
    property string directoryPath: fileDialog.folder.toString().substring(7)

    id: root
    visible: true
    width: 600
    minimumWidth: 600
    maximumWidth: 600
    height: 300
    minimumHeight: 300
    maximumHeight: 300
    title: "Tunes Manager"

    menuBar: MenuBar {
    }

    HomeWindowForm {
        id: homeWindow
        anchors.fill: parent

        directoryPathMouse.onClicked: fileDialog.open()

        scanButtonMouse.onClicked: {
            tuneModel.clear()
            tunesManager.searchTunes(directoryPath)
            tuneModel.append(tunesManager.checkDuplicate())

            tunesWindow.tuneTable.sortIndicatorColumn = 1
            tunesWindow.tuneTable.sortIndicatorColumn = 0

            root.width = 800
            root.height = 450
            root.minimumWidth = 800
            root.minimumHeight = 450
            root.maximumWidth = 10000
            root.maximumHeight = 10000


            homeWindow.visible = false
            tunesWindow.visible = true
        }

        helpButton.onClicked: helpDialog.open()
    }

    TunesWindowForm {
        id: tunesWindow
        anchors.fill: parent
        visible: false

        backToHomeButtonMouse.onClicked: {
            tunePlayer.stop()
            searchBox.text = ""

            root.width = 600
            root.height = 300
            root.minimumWidth = 600
            root.minimumHeight = 300
            root.maximumWidth = 600
            root.maximumHeight = 300

            tunesWindow.visible = false
            homeWindow.visible = true
        }

        tuneTable.itemDelegate: Text {
            color:  tuneModel.get(styleData.row).duplicate == 1 ? "#FF0000" : styleData.textColor
            text: styleData.value
            font.pixelSize: 12
            elide: styleData.elideMode
            horizontalAlignment: styleData.textAlignment
        }

        tuneTable.onSortIndicatorColumnChanged: {
            tuneModel.clear()
            tunesManager.filterTunes(searchBox.text)
            tuneModel.append(tunesManager.sortTuneList(tuneTable.sortIndicatorColumn, (tuneTable.sortIndicatorOrder == Qt.AscendingOrder) ? 0 : 1))
        }

        tuneTable.onSortIndicatorOrderChanged: {
            tuneModel.clear()
            tunesManager.filterTunes(searchBox.text)
            tuneModel.append(tunesManager.sortTuneList(tuneTable.sortIndicatorColumn, (tuneTable.sortIndicatorOrder == Qt.AscendingOrder) ? 0 : 1))
        }

        searchBox.onTextChanged: {
            tuneModel.clear()
            tunesManager.filterTunes(searchBox.text)
            tuneModel.append(tunesManager.sortTuneList(tuneTable.sortIndicatorColumn, (tuneTable.sortIndicatorOrder == Qt.AscendingOrder) ? 0 : 1))
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
//        folder: shortcuts.home
        folder: "file:///Volumes/BOOTCAMP/Users/Macbook Pro/Music"
        selectFolder: true
    }

    TunesManager {
        id: tunesManager
    }

    MessageDialog {
        id: helpDialog
        text: "To start manage tunes in your directory, choose an directory, press \"Scan\" then you will see a list of all tunes in the directory."
    }
}
