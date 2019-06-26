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
    property var content_path: "/test.pdf"
    property var content_format: "PDF"
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
        url: {
            "file:///" + application_dir_path + 
            ((content_format == "PDF") ? "/pdfjs-2.0.943-dist/web/viewer.html?file=file:///" + application_dir_path : "") // add path to PDF viewer
            + content_path 
        }
    }

    signal rePathAndFormatChanged(string data)

    Component.onCompleted: {
        content_model.pathAndFormatChanged.connect(rePathAndFormatChanged);
    } 
    
    Connections {
        target: content_view_handler

        onRePathAndFormatChanged: {
            // console.log("Ist da ein Format und Path aufgetaucht!");
            // console.log(data);
            var content = data.split(',')
            content_view_handler.content_path = content[0]
            content_view_handler.content_format = content[1]
        }
    }
}