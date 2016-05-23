import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: root
    color: "#DDDDDD"

    Rectangle {
        id: titleBar
        width: parent.width

        ColumnLayout {
            id: titleColumn
            anchors.fill: parent
            spacing: -5

            Text {
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Tunes Manager"
                font.pixelSize: 36
                font.family: "Brush Script MT"
            }

            Text {
                id: description
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Managing tunes on your drive"
                font.bold: true
            }
        }
    }

    Text {
        id: diretoryPath
        anchors.centerIn: parent
        text: fileDialog.folder.toString().substring(7)
        width: parent.width * 0.8
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap

        MouseArea {
            anchors.fill: parent
            onClicked: fileDialog.open()
            hoverEnabled: true
            onEntered: diretoryPath.font.underline = true
            onExited: diretoryPath.font.underline = false
        }
    }

    Rectangle {
        id: scanButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
        width: 100
        height: 100
        radius: width / 2
        color: "#FFFFFF"

        Text {
            id: scanText
            anchors.centerIn: parent
            text: "Scan"
            font.pixelSize: 20
            font.italic: true
        }
    }
}
