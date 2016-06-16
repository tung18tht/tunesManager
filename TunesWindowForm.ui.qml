import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtMultimedia 5.5

Rectangle {
    property alias tuneTable: tuneTable

    id: root

    Rectangle {
        id: tunePlayer
        width: parent.width
        height: parent.height * 0.1
        color: "#FF0000"
    }

    TableView {
        id: tuneTable
        anchors.top: tunePlayer.bottom
        width: parent.width
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
}
