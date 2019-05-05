import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import "Style"

Rectangle {
    property alias buttonText: button_text.text
    property alias buttonTextColor: button_text.color
    property var widthPadding: 0

    color: Style.background_color
    border.width: 1
    radius: 5
    clip: true 
    height: button_text.height + 10
    width: button_text.width + widthPadding
    
    Text {
        id: button_text
        anchors.centerIn: parent
        font.pointSize: 10
    }
}