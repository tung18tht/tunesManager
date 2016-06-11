import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    property alias testText: testText
    id: root
    color: "#FF0000"
    Text {
        id: testText
        anchors.fill: parent
        text: "Test"
    }
}
