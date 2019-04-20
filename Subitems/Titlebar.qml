import QtQuick 2.0
import QtQuick.Layouts 1.0
import "Style"

RowLayout {
    id: titlebar
    spacing: 3

    Rectangle {
        id: title
        color: Style.bg_color
        
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            text: "ee|knowledge"

            color: Style.fg_color
            font.pointSize: Style.title.text.ptSize
            font.bold: Style.title.text.bold
            font.letterSpacing: Style.title.letterSpacing

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    // Rectangle {
    //     id: close_button
    //     color: Style.bg_color
        
    //     Layout.fillHeight: true
    //     width: 50

    //     signal exit()

    //     Text {
    //         text: "X"

    //         color: Style.fg_color
    //         font.pointSize: Style.title.text.ptSize
    //         font.bold: Style.title.text.bold

    //         anchors.centerIn: parent
    //     }

    //     MouseArea {
    //         onClicked: parent.exit()
    //     }
    // }
}