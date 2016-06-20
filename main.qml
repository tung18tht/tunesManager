import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtMultimedia 5.5

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
            tunesManager.searchTunes(directoryPath, "mp3")
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
            tunePlayer.source = ""
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
            color:  tuneModel.get(styleData.row).duplicate == 1 ? "#FF6666" : styleData.textColor
            text: styleData.value
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
            tunePath.text = tuneModel.get(row).path.toString().substring(7)
        }

        tuneTable.onPressAndHold: {
            tunePath.text = tuneModel.get(row).path.toString().substring(7)
        }

        tuneTable.onDoubleClicked: {
            tunePlayer.source = tuneModel.get(row).path
            tunePlayer.play()
        }

        tunePathMouse.onClicked: {
            tunePlayer.source = "file://" + tunePath.text
            tunePlayer.play()
        }

        playIcon.visible: tunePlayer.playbackState == MediaPlayer.PlayingState ? false : true
        pauseIcon.visible: tunePlayer.playbackState == MediaPlayer.PlayingState ? true : false

        tuneTitle.visible: tunePlayer.playbackState == MediaPlayer.StoppedState ? false : true
        tuneArtistAlbum.visible: tunePlayer.playbackState == MediaPlayer.StoppedState ? false : true
        timeSlider.visible: tunePlayer.playbackState == MediaPlayer.StoppedState ? false : true

        playPauseButtonMouse.onClicked: {
            if (tunePlayer.source == "") return
            tunePlayer.playbackState == MediaPlayer.PlayingState ? tunePlayer.pause() : tunePlayer.play()
        }

        timeSlider.onValueChanged: {
            tunePlayer.seek(timeSlider.value * 1000)
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

    TunesManager {
        id: tunesManager
    }

    MessageDialog {
        id: helpDialog
        text: "To start manage tunes in your directory, choose an directory, press \"Scan\" then you will see a list of all tunes in the directory."
    }
}
