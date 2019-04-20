pragma Singleton
import QtQuick 2.0

QtObject {
    property color white: "#FFFFFF"
    property color dark: "#565656"
    property color black: "#000000"

    property color bg_color: dark

    property color fg_color: white

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