import QtQuick 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4
import "Style"

Rectangle {
    id: content_source_editor_bg
    color: Style.bg_color 
    Layout.fillWidth: true
    Layout.fillHeight: true

    signal closeSourceEditor()

    Rectangle {
        id: button_cse_ok
        color: Style.bg_color
        radius: 5
        border.width: 1
        border.color: Style.fg_color
        height: button_cse_ok_text.height + 10
        width: button_cse_ok_text.width + 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        Text {
            id: button_cse_ok_text
            text: "OK"
            color: Style.fg_color
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: { 
                console.log("cse OK");
                content_source_editor_bg.closeSourceEditor();
            }
        }
    }
}
