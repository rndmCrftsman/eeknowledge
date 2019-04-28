import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4
import "Subitems"
import "Subitems/Style"

Rectangle {
    id: main_window
    objectName: "main_window"

    width: 1200
    height: 800
    color: Style.fg_color

    ColumnLayout {
        anchors.fill: parent
        spacing: 1

        Titlebar {
            id: main_titlebar
            objectName: "main_titlebar"
            
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            Layout.maximumHeight: 50
        }

        SplitView {
            id: main_splitview
            objectName: "main_splitview"
            orientation: Qt.Horizontal
            Layout.fillWidth: true
            Layout.fillHeight: true

            ArticleMenu {
                id: article_menu
                objectName: "article_menu"
                anchors.fill: undefined
            }

            // Rectangle {
            //     id: content_view
            //     objectName: "article_menu_options_bar"
            //     color: Style.fg_color

            //     Layout.fillWidth: true
            //     Layout.fillHeight: true
            // }
            ContentViewer {
                id: content_viewer
                objectName: "content_viewer"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}