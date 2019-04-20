import QtQuick 2.0
import "Style"

Rectangle {
    color: Style.bg_color

    height: 50

    Text {
        font.pointSize: Style.menuitem.ptSize
        font.bold: Style.menuitem.bold
    }
}