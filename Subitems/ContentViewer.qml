import QtQuick 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4
import QtWebEngine 1.1
import "Style"

StackView {
    id: content_view_handler
    initialItem: content_web_view

    signal closeListEditor()
    signal closeSourceEditor()

    property alias content_list_editor: content_list_edit
    property alias content_source_editor: content_source_edit

    WebEngineView {
        id: content_web_view
        settings.pluginsEnabled: true
        settings.javascriptEnabled: true
        url: "file:///" + application_dir_path + "/pdfjs-2.0.943-dist/web/viewer.html" + "?file=" + "file:///home/hannes/Documents/eeknowledge/test.pdf"
    }

    ContentListEditor {
        id: content_list_edit

        onCloseListEditor: {
            content_view_handler.closeListEditor()
        }
    }

    ContentSourceEditor {
        id: content_source_edit

        onCloseSourceEditor: {
            content_view_handler.closeSourceEditor()
        }
    }
}