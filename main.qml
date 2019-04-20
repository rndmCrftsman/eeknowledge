import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import "Subitems"
import "Subitems/Style"

Rectangle {
    id: main_window

    width: 1200
    height: 800
    color: Style.fg_color

    ColumnLayout {
        anchors.fill: parent
        spacing: 3

        Titlebar {
            id: main_titlebar
            
            Layout.fillWidth: true
            Layout.maximumHeight: 50
        }

        Rectangle {
            color: Style.bg_color
            
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}