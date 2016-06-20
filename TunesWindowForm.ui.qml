import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtMultimedia 5.5

Rectangle {
    property alias tuneTable: tuneTable
    property alias tunePlayer: tunePlayer
    property alias searchBox: searchBox
    property alias backToHomeButtonMouse: backToHomeButtonMouse
    property alias tunePath: tunePath
    property alias tunePathMouse: tunePathMouse
    property alias pauseIcon: pauseIcon
    property alias playIcon: playIcon
    property alias playPauseButtonMouse: playPauseButtonMouse
    property alias tuneTitle: tuneTitle
    property alias tuneArtistAlbum: tuneArtistAlbum
    property alias timeSlider: timeSlider

    id: root

    Rectangle {
        id: headerBar
        height: 50
        width: parent.width

        Rectangle {
            id: backToHomeButton
            height: 40
            width: height
            radius: height / 2
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            color: "#BBDEFB"

            Image {
                source: "/icons/back.png"
                width: 18
                height: width
                anchors.centerIn: parent

            }

            MouseArea {
                id: backToHomeButtonMouse
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = "#64B5F6"
                onExited: parent.color = "#BBDEFB"
            }
        }

        Rectangle {
            id: playPauseButton
            anchors.left: backToHomeButton.right
            anchors.leftMargin: 10
            height: 40
            width: 40
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                id: playPauseButtonMouse
                anchors.fill: parent
            }

            Image {
                id: playIcon
                source: "/icons/play.png"
                width: 30
                height: width
                anchors.centerIn: parent
            }

            Image {
                id: pauseIcon
                source: "/icons/pause.png"
                width: 30
                height: width
                anchors.centerIn: parent
                visible: false
            }
        }

        Rectangle {
            height: parent.height
            x: (tunePlayerBox.x + playPauseButton.x) / 2 - 50

            Slider {
                id: volumeSlider
                width: 130
                anchors.verticalCenter: parent.verticalCenter
                value: 1
            }
        }

        Rectangle {
            id: tunePlayerBox
            height: 45
            width: 300
            radius: 5
            anchors.centerIn: parent
            color: "#BBDEFB"

            Text {
                id: tuneTitle
                text: tunePlayer.metaData.title
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: tuneArtistAlbum
                text: tunePlayer.metaData.albumArtist + " - " + tunePlayer.metaData.albumTitle
                font.pixelSize: 10
                font.italic: true
                anchors.top: tuneTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Slider {
                id: timeSlider
                width: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                maximumValue: tunePlayer.duration / 1000
                stepSize: 1
                value: tunePlayer.position / 1000
            }

            MediaPlayer {
                id: tunePlayer
                source: ""
                volume: volumeSlider.value
            }
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: 35
            width: 140
            radius: 5
            color: "#BBDEFB"

            Image {
                source: "icons/search.png"
                width: 18
                height: 18
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 6

            }

            TextField {
                id: searchBox
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                placeholderText: "Search"
            }
        }
    }

    TableView {
        id: tuneTable
        anchors.top: headerBar.bottom
        width: parent.width - 2
        height: parent.height - headerBar.height - footerBar.height - 2
        x: 1
        sortIndicatorVisible: true
        model: tuneModel

        TableViewColumn {
            role: "name"
            title: "Name"
            movable: false
            width: 350
        }

        TableViewColumn {
            role: "size"
            title: "Size"
            movable: false
            horizontalAlignment: Text.AlignRight
            width: 100
        }

        TableViewColumn {
            role: "lastModified"
            title: "Last Modified"
            movable: false
            horizontalAlignment: Text.AlignRight
            width: 150
        }

        TableViewColumn {
            role: "path"
            visible: false
        }
    }

    Rectangle {
        id: footerBar
        width: parent.width
        height: 20
        anchors.bottom: parent.bottom
        color: "#1565C0"

        Text {
            id: tunePath
            color: "#FFFFFF"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        MouseArea {
            id: tunePathMouse
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: tunePath.font.underline = true
            onExited: tunePath.font.underline = false
        }
    }
}
