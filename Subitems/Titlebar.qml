import QtQuick 2.7
import QtQuick.Layouts 1.5
import "Style"

RowLayout {
    id: titlebar
    spacing: 3

    Rectangle {
        id: title
        color: Style.background_color
        
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            text: "ee|knowledge"

            color: Style.forground_color
            font.pointSize: Style.title.text.ptSize
            font.bold: Style.title.text.bold
            font.letterSpacing: Style.title.letterSpacing

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    // Rectangle {
    //     id: close_button
    //     color: Style.background_color
        
    //     Layout.fillHeight: true
    //     width: 50

    //     signal exit()

    //     Text {
    //         text: "x"

    //         color: Style.forground_color
    //         font.pointSize: Style.title.text.ptSize
    //         font.bold: Style.title.text.bold

    //         anchors.centerIn: parent
    //     }

    //     MouseArea {
    //         onClicked: parent.exit()
    //     }
    // }
}