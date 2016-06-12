import QtQuick 2.5
import QtQuick.Controls 1.4
import QtMultimedia 5.5

Rectangle {
    property alias musicTable: musicTable

    id: root

    TableView {
        id: musicTable
        anchors.fill: parent

        TableViewColumn {
            role: "name"
            title: "Name"
        }

        TableViewColumn {
            role: "size"
            title: "Size"
        }

        TableViewColumn {
            role: "lastModified"
            title: "Last Modified"
        }
    }
}
