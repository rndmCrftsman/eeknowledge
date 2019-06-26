import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import "Style"

Rectangle {
    id: content_list_editor
    color: Style.background_color 
    Layout.fillWidth: true
    Layout.fillHeight: true

    signal closeListEditor()
    signal enableArticleList()

    property int articleListCurrentIndex

    Text {
        id: source_path_label
        text: "Source Path"
        color: Style.forground_color
        font.bold: true
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    // Rectangle {
    //     id: source_path_background

    //     color: Style.background_color
    //     border.color: Style.forground_color
    //     border.width: 1
    //     radius: 5
    //     clip: true

    //     height: source_path.height
    //     width: source_path.width

    //     anchors.top: source_path.top
    //     anchors.left: source_path.left
    // }

    // ScrollView {
    //     id: source_path_view

    //     height: parent.height/3 - source_label.height - 25
    //     width: parent.width - 20

    //     anchors.top: source_label.bottom
    //     anchors.topMargin: 10
    //     anchors.left: parent.left 
    //     anchors.leftMargin: 10
    // }

    // TextArea {
    //     id: source_path
    //     color: Style.forground_color
    //     anchors.fill: source_path_view
    //     topPadding: 10
    //     bottomPadding: 10
    //     leftPadding: 10
    //     rightPadding: 10
    // }
    
    TextField {
        id: source_path_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: source_path_label.left
        anchors.top: source_path_label.bottom
        anchors.topMargin: 10
    }

    Text {
        id: type_label
        text: "Type"
        color: Style.forground_color
        font.bold: true
        anchors.left: source_path_text_field.left
        anchors.top: source_path_text_field.bottom
        anchors.topMargin: 20
    }

    TextField {
        id: type_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: type_label.left
        anchors.top: type_label.bottom
        anchors.topMargin: 10
    }
    
    Text {
        id: content_name_label
        text: "Content Name"
        color: Style.forground_color
        font.bold: true
        anchors.left: type_text_field.left
        anchors.top: type_text_field.bottom
        anchors.topMargin: 20
    }

    TextField {
        id: content_name_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: content_name_label.left
        anchors.top: content_name_label.bottom
        anchors.topMargin: 10
    }
    
    Text {
        id: author_label
        text: "Author"
        color: Style.forground_color
        font.bold: true
        anchors.left: content_name_text_field.left
        anchors.top: content_name_text_field.bottom
        anchors.topMargin: 20
    }

    TextField {
        id: author_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: author_label.left
        anchors.top: author_label.bottom
        anchors.topMargin: 10
    }

    Text {
        id: topic_label
        text: "Topic Keywords"
        color: Style.forground_color
        font.bold: true
        anchors.left: author_text_field.left
        anchors.top: author_text_field.bottom
        anchors.topMargin: 20
    } 

    TextField {
        id: topic_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: topic_label.left
        anchors.top: topic_label.bottom
        anchors.topMargin: 10
    }

    Text {
        id: description_label
        text: "Description"
        color: Style.forground_color
        font.bold: true
        anchors.left: topic_text_field.left
        anchors.top: topic_text_field.bottom
        anchors.topMargin: 20
    } 

    TextField {
        id: description_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: description_label.left
        anchors.top: description_label.bottom
        anchors.topMargin: 10
    }
    
    Text {
        id: format_label
        text: "Format"
        color: Style.forground_color
        font.bold: true
        anchors.left: description_text_field.left
        anchors.top: description_text_field.bottom
        anchors.topMargin: 20
    } 

    TextField {
        id: format_text_field
        width: (parent.width-20)/3 - 10
        height: 30
        anchors.left: format_label.left
        anchors.top: format_label.bottom
        anchors.topMargin: 10
    }

    CustomButton {
        id: button_cle_cancel
        buttonText: "Cancel"
        widthPadding: 60
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: button_cle_ok.left
        anchors.rightMargin: 10
        border.color: Style.forground_color
        buttonTextColor: Style.forground_color

        MouseArea {
            anchors.fill: parent
            onClicked: {
                content_list_editor.closeListEditor();
                content_list_editor.enableArticleList();
            }
        }
    }
    CustomButton {
        id: button_cle_ok 
        buttonText: "OK"
        width: button_cle_cancel.width 
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        border.color: Style.forground_color
        buttonTextColor: Style.forground_color

        MouseArea {
            anchors.fill: parent
            onClicked: {
                // console.log("cle OK");
                content_list_editor.closeListEditor();
                content_list_editor.enableArticleList();
                var data_list = [ 
                    source_path_text_field.text,
                    type_text_field.text,
                    content_name_text_field.text,
                    author_text_field.text,
                    topic_text_field.text,
                    description_text_field.text,
                    format_text_field.text
                ];
                var data = data_list.join(',');
                // console.log(data)
                content_model.saveData(data, articleListCurrentIndex)
                content_model.requestPathAndFormat(articleListCurrentIndex)
            }
        }
    }

    signal reEditorOpened(string data)
    Component.onCompleted: {
        content_model.editorOpened.connect(reEditorOpened);
    } 
    
    Connections {
        target: content_list_editor

        onReEditorOpened: {
            // console.log("Hallo die Party geht loos");
            // console.log(data);
            var content = data.split(',')
            source_path_text_field.text = content[0]
            type_text_field.text = content[1]
            content_name_text_field.text = content[2]
            author_text_field.text = content[3]
            topic_text_field.text = content[4]
            description_text_field.text = content[5]
            format_text_field.text = content[6]
        }
    }
}