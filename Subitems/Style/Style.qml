pragma Singleton
import QtQuick 2.7

QtObject {
    property color white: "#FFFFFF"
    property color darkgray: "#505050"
    property color gray: "#808080"
    property color lightgray: "#A0A0A0"
    property color black: "#000000"

    property color background_color: darkgray
    property color forground_color: white
    property color inactive_color: gray
    property color highlight_color: lightgray

    property QtObject title: QtObject {
        property QtObject text: QtObject {
            property real ptSize: 24
            property bool bold: true
        }
        property real letterSpacing: 10
    }

    property QtObject menuitem: QtObject {
        property real ptSize: 12
        property bool bold: true
    }
}