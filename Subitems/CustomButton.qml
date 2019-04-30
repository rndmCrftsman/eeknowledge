import QtQuick 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4
import "Style"

Rectangle {
    color: Style.bg_color
    border.width: 1
    border.color: Style.fg_color
    radius: 5
    clip: true
    height: button_text.height + 10

    property var buttonText
    
    Text {
        id: button_text
        text: buttonText
        anchors.centerIn: parent
        color: Style.fg_color
    }
}