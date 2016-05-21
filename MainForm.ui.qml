import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


Rectangle {
    property alias folderButton: folderButton

    id: root

    Button {
        id: folderButton
        anchors.centerIn: parent
        text: "Choose folder"
    }
}
