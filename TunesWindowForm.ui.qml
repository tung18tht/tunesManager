import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtMultimedia 5.5

Rectangle {
    property alias tuneTable: tuneTable
    property alias backToHomeButtonMouse: backToHomeButtonMouse

    id: root

    Rectangle {
        id: backToHomeButton
        height: parent.height * 0.1
        width: height;
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
        height: parent.height * 0.1
        width: parent.width - height
        anchors.left: backToHomeButton.right

        MediaPlayer {
            id: tunePlayer
        }

        MouseArea {
            anchors.fill: parent
            onClicked: tunePlayer.play()
        }
    }

    TableView {
        id: tuneTable
        anchors.top: tunePlayerBox.bottom
        width: parent.width * 0.75
        height: parent.height * 0.9
        alternatingRowColors: false
        sortIndicatorVisible: true

        TableViewColumn {
            role: "name"
            title: "Name"
            movable: false
        }

        TableViewColumn {
            role: "size"
            title: "Size"
            movable: false
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
        width: parent.width * 0.25
        height: parent.height * 0.9
    }
}
