import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4 as Ctrl1
import QtQuick.Controls 2.2
import "Subitems"
import "Subitems/Style"

Rectangle {
    id: main_window
    objectName: "main_window"

    width: Screen.width // 1200
    height: Screen.height // 800
    color: Style.forground_color

    ColumnLayout {
        anchors.fill: parent
        spacing: 1

        Titlebar {
            id: main_titlebar
            objectName: "main_titlebar"
            
            Layout.fillWidth: true
            Layout.minimumHeight: Screen.height / 20
            Layout.maximumHeight: Screen.height / 20

            content_path: content_viewer.content_path
            content_format: content_viewer.content_format

            onPrintDocument: {
                // printer.printDocument(filter_proxy_model.mapToSource(filter_proxy_model.index(article_menu.articleListCurrentIndex, 0)).row)
            }

            onLoadContents: {
                console.log("load...")
            }

            onSaveContents: {
                console.log("save...")
            }
        }

        Ctrl1.SplitView {
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
                    articleListIsSelectable = false
                }

                Component.onCompleted: {
                    addButtonEnabled = true;
                    addButtonColor = Style.background_color;
                    addButtonTextColor = Style.forground_color;
                    addButtonBorderColor = Style.forground_color;
                    listEditorButtonEnabled = true;
                    listEditorButtonColor = Style.background_color;
                    listEditorButtonTextColor = Style.forground_color;
                    listEditorButtonBorderColor = Style.forground_color;
                    articleListIsSelectable = true;
                }
            }

            ContentViewer {
                id: content_viewer
                objectName: "content_viewer"
                z:1
                Layout.fillWidth: true
                Layout.fillHeight: true

                articleListCurrentIndex: article_menu.articleListCurrentIndex 

                onCloseListEditor: {
                    article_menu.listEditorButtonEnabled = true;
                    article_menu.listEditorButtonColor = Style.background_color;
                    article_menu.listEditorButtonBorderColor = Style.forground_color;
                    article_menu.listEditorButtonTextColor = Style.forground_color;
                    // console.log("Close List Editor");
                    content_viewer.pop();
                }

                onEnableArticleList: {
                    article_menu.articleListIsSelectable = true;
                }

                onEnableAddButton: {
                    article_menu.addButtonEnabled = true;
                    article_menu.addButtonColor = Style.background_color;
                    article_menu.addButtonBorderColor = Style.forground_color;
                    article_menu.addButtonTextColor = Style.forground_color;
                }
            }
        }
    }
}