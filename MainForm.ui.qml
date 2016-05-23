import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: root

    Rectangle {
        id: titleBar
        width: parent.width
        height: 30
        color: "red"

        ColumnLayout {
            id: titleColumn
            anchors.fill: parent
            Text {
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Tunes Manager"
            }

            Text {
                id: description
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Scan tunes on your drive"
            }
        }
    }

    Text {
        id: diretoryPath
        anchors.centerIn: root
        text: fileDialog.folder.toString().substring(7)
    }

    Button {
        id: scanButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: "Scan"
    }
}
