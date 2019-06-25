import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import QtWebEngine 1.1
import "Style"

StackView {
    id: content_view_handler
    initialItem: content_web_view

    signal closeListEditor()
    signal closeSourceEditor()
    signal enableArticleList()

    property alias content_list_editor: content_list_edit
    property alias articleListCurrentIndex: content_list_edit.articleListCurrentIndex
    property alias content_source_editor: content_source_edit
    property var content_path: "/test.html"
    property var content_type: "JS"
    property var source_path

    ListEditor {
        id: content_list_edit

        onCloseListEditor: {
            content_view_handler.closeListEditor()
        }

        onEnableArticleList: {
            content_view_handler.enableArticleList()
        }
    }

    SourceEditor {
        id: content_source_edit

        onCloseSourceEditor: {
            content_view_handler.closeSourceEditor()
        }
    }
    
    WebEngineView {
        id: content_web_view
        settings.pluginsEnabled: true
        settings.javascriptEnabled: true
        url: "file:///" + application_dir_path + ((content_type == "PDF") ? "/pdfjs-2.0.943-dist/web/viewer.html?file=file:///" + application_dir_path : "") + content_path 

        // if (content_type == "PDF") {
            // url: "file:///" + application_dir_path + "/pdfjs-2.0.943-dist/web/viewer.html" + "?file=" + content_path 
        // } else {
            // url: "file:///" + application_dir_path + "/test.html"
            // url: "file:///" + application_dir_path + "/pdfjs-2.0.943-dist/web/viewer.html" + "?file=" + content_path 
        // }
    }
}