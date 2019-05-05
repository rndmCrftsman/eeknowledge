import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import "Style"

Rectangle {
    id: content_source_editor_bg
    color: Style.background_color 
    Layout.fillWidth: true
    Layout.fillHeight: true

    signal closeSourceEditor()
    
    CustomButton {
        id: button_cse_ok
        buttonText: "OK"
        widthPadding:  100 // buttonText.width + 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        border.color: Style.forground_color
        buttonTextColor: Style.forground_color

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("cse OK");
                content_source_editor_bg.closeSourceEditor();
            }
        }
    }
}