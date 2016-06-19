import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    property alias scanButtonMouse: scanButtonMouse
    property alias directoryPathMouse: directoryPathMouse

    id: root
    color: "#FFFFFF"

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

    Rectangle {
        id: directoryPathBox
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height * .45
        width: parent.width * 0.9
        height: 40
        color: "#DDDDDD"
        radius: 5

        Text {
            id: diretoryPath
            anchors.fill: parent
            text: directoryPath
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            anchors.margins: 10
        }

        MouseArea {
            id: directoryPathMouse
            anchors.fill: parent
            hoverEnabled: true
            onEntered: diretoryPath.font.underline = true
            onExited: diretoryPath.font.underline = false
        }
    }

    Text {
        anchors.bottom: directoryPathBox.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 5
        text: "Choose your directory:"
    }

    Rectangle {
        id: scanButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30
        width: 100
        height: 50
        radius: 5
        color: "#FFFFFF"
        border.color: "#DDDDDD"
        border.width: 5

        Text {
            id: scanText
            anchors.centerIn: parent
            text: "Scan"
            font.pixelSize: 20
            font.italic: true
        }

        MouseArea {
            id: scanButtonMouse
            anchors.fill: parent
            hoverEnabled: true
            onEntered: scanButton.color = "#DDDDDD"
            onExited: scanButton.color = "#FFFFFF"
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 35
        anchors.bottomMargin: 35
        width: 20
        height: width
        radius: width / 2

        color: "#DDDDDD"

        Text {
            text: "?"
            color: "#159CFB"
            anchors.centerIn: parent
        }
    }
}
