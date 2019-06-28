import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import QtWebEngine 1.1
import "Style"

StackView {
    id: content_view_handler
    initialItem: content_web_view

    signal closeListEditor()
    signal enableArticleList()
    signal enableAddButton()

    property alias content_list_editor: content_list_edit
    property alias articleListCurrentIndex: content_list_edit.articleListCurrentIndex
    property var content_path: "/test.pdf"
    property var old_path: ""
    property var content_format: "PDF"

    ListEditor {
        id: content_list_edit

        onCloseListEditor: {
            content_view_handler.closeListEditor()
        }

        onEnableArticleList: {
            content_view_handler.enableArticleList()
        }

        onEnableAddButton: {
            content_view_handler.enableAddButton()
        }
    }

    WebEngineView {
        id: content_web_view
        settings.pluginsEnabled: true
        settings.javascriptEnabled: true
        url: ""

        Component.onCompleted: {
            update_url();
        }

        function update_url() {
            if(content_path != "None" && content_format != "None") {
                var file_exists = false;
                var file_path = "file:///" + application_dir_path + content_path;
                var file = new XMLHttpRequest();
                file.open("GET", file_path, false)
                file.onreadystatechange = function() {
                    if(file.status == 0) {
                        var content = file.responseText;
                        if(content != "") {
                            file_exists = true;
                        }
                    }
                }
                file.send(null)

                if(file_exists) {
                    if(content_path != old_path) {
                        old_path = content_path;
                        url = "file:///" + application_dir_path + 
                        ((content_format == "PDF") ? "/pdfjs_mod/web/viewer.html?file=file:///" + application_dir_path : "") // add path to PDF viewer
                        + content_path;
                    }
                } else {
                    url = "file:///" + application_dir_path + "/file_does_not_exist.html";
                    old_path = "/file_does_not_exist.html";
                }
            } else {
                url = "file:///" + application_dir_path + "/no_file_found.html";
                old_path = "/file_does_not_exist.html";
            }
        }
    }

    signal rePathAndFormatChanged(string data)

    Component.onCompleted: {
        source_model.pathAndFormatChanged.connect(rePathAndFormatChanged);
    } 
    
    Connections {
        target: content_view_handler

        onRePathAndFormatChanged: {
            var content = data.split(',')
            content_view_handler.content_path = content[0]
            content_view_handler.content_format = content[1]
            content_web_view.update_url();
        }
    }
}