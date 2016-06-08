import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 500
    height: 500

    menuBar: MenuBar {
    }

    TunesWindowForm {
        anchors.fill: parent
    }

    Loader {
        id: loader
    }
}
