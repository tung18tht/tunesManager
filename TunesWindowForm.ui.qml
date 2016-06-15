import QtQuick 2.5
import QtQuick.Controls 1.4
import QtMultimedia 5.5

Rectangle {
    property alias tuneTable: tuneTable

    id: root

    TableView {
        id: tuneTable
        anchors.fill: parent
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
