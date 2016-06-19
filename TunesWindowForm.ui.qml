import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtMultimedia 5.5

Rectangle {
    property alias tuneTable: tuneTable
    property alias tunePlayer: tunePlayer
    property alias searchBox: searchBox
    property alias backToHomeButtonMouse: backToHomeButtonMouse

    id: root

    Rectangle {
        id: backToHomeButton
        height: 50
        width: height
        color: "#DDDDDD"

        Text {
            anchors.centerIn: parent
            text: "Back"
        }

        MouseArea {
            id: backToHomeButtonMouse
            anchors.fill: parent
        }
    }

    Rectangle {
        id: tunePlayerBox
        height: 50
        width: parent.width - backToHomeButton.width
        anchors.left: backToHomeButton.right

        MediaPlayer {
            id: tunePlayer
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
                source: "icons/searchIcon.png"
                width: 18
                height: 18
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 5

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
        anchors.top: tunePlayerBox.bottom
        width: parent.width - tuneInfo.width
        height: parent.height - backToHomeButton.height
//        alternatingRowColors: false
        sortIndicatorVisible: true
        model: tuneModel

        TableViewColumn {
            role: "name"
            title: "Name"
            movable: false
            width: 300
        }

        TableViewColumn {
            role: "size"
            title: "Size"
            movable: false
            horizontalAlignment: Text.AlignRight
            width: 80
        }

        TableViewColumn {
            role: "lastModified"
            title: "Last Modified"
            movable: false
        }

        TableViewColumn {
            role: "path"
            visible: false
        }
    }

    Rectangle {
        id: tuneInfo
        anchors.top: tunePlayerBox.bottom
        anchors.left: tuneTable.right
        width: 250
        height: parent.height - backToHomeButton.height
        color: "#00FF00"
    }
}
