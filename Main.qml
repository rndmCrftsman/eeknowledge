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
                z:2
                anchors.fill: undefined

                onPushContentListEditor: {
                    content_viewer.push(content_viewer.content_list_editor);
                }

                onPushContentSourceEditor: {
                    content_viewer.push(content_viewer.content_source_editor);
                }

                Component.onCompleted: {
                    listEditorButtonEnabled = true;
                    listEditorButtonColor = Style.bg_color;
                    sourceEditorButtonEnabled = true;
                    sourceEditorButtonColor = Style.bg_color;
                }
            }

            ContentViewer {
                id: content_viewer
                objectName: "content_viewer"
                z:1
                Layout.fillWidth: true
                Layout.fillHeight: true

                onCloseListEditor: {
                    article_menu.listEditorButtonEnabled = true;
                    article_menu.listEditorButtonColor = Style.bg_color;
                    content_viewer.pop();
                }

                onCloseSourceEditor: {
                    article_menu.sourceEditorButtonEnabled = true;
                    article_menu.sourceEditorButtonColor = Style.bg_color;
                    content_viewer.pop();
                }
            }
        }
    }
}