import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


Rectangle {
    property alias directoryButton: directoryButton

    id: root

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        TextField {
            id: diretoryPath
            text: fileDialog.folder
        }

        Button {
            id: directoryButton
            text: "Choose folder"
        }
    }
}
