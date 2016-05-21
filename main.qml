import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 960
    height: 600
    title: qsTr("Tunes Manager")

    menuBar: MenuBar {
    }

    MainForm {
        anchors.fill: parent
    }
}
