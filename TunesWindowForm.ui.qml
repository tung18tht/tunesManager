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
        id: tunePlayerBox
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
                width: 20
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
        anchors.top: tunePlayerBox.bottom
        width: parent.width - tuneInfo.width
        height: parent.height - tunePlayerBox.height
//        alternatingRowColors: false
        sortIndicatorVisible: true
        model: tuneModel

        TableViewColumn {
            role: "name"
            title: "Name"
            movable: false
            width: 320
        }

        TableViewColumn {
            role: "size"
            title: "Size"
            movable: false
            horizontalAlignment: Text.AlignRight
            width: 90
        }

        TableViewColumn {
            role: "lastModified"
            title: "Last Modified"
            movable: false
            horizontalAlignment: Text.AlignRight
            width: 120
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
