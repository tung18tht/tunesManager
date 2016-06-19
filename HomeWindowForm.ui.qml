import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    property alias scanButtonMouse: scanButtonMouse
    property alias directoryPathMouse: directoryPathMouse
    property alias helpButton: helpButton

    id: root
    color: "#FFFFFF"

    Rectangle {
        id: titleBar
        width: parent.width

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
            anchors.top: title.bottom
            text: "Managing tunes on your drive"
            font.bold: true
        }
    }

    Text {
        anchors.bottom: directoryPathBox.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 5
        text: "Choose your directory:"
    }

    Rectangle {
        id: directoryPathBox
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height * .45
        width: parent.width * 0.9
        height: 40
        color: "#BBDEFB"
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

    Rectangle {
        id: scanButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30
        width: 100
        height: 50
        radius: 5
        color: "#FFFFFF"
        border.color: "#64B5F6"
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
            onEntered: scanButton.color = "#64B5F6"
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
        color: "#BBDEFB"

        Text {
            text: "?"
            color: "#1565C0"
            anchors.centerIn: parent
        }

        MouseArea {
            id: helpButton
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.color = "#64B5F6"
            onExited: parent.color = "#BBDEFB"
        }
    }
}
