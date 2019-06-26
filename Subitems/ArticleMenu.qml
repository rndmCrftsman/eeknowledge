import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import "Style"

Rectangle {
    id: rectangle_content_menu

    signal pushContentListEditor()
    signal pushContentSourceEditor()
    
    property var listEditorButtonEnabled
    property var listEditorButtonColor
    property var listEditorButtonTextColor
    property var listEditorButtonBorderColor
    property var sourceEditorButtonEnabled
    property var sourceEditorButtonColor
    property var sourceEditorButtonTextColor
    property var sourceEditorButtonBorderColor
    property var articleListIsSelectable 
    property var articleListCurrentIndex: 0

    Layout.minimumWidth: 300
    color: Style.background_color

    ColumnLayout {
        id: test
        Layout.minimumWidth: parent.Layout.minimumWidth
        anchors.fill: parent
        spacing: 1

        Rectangle {
            id: content_header
            height: text_field_filter.height + button_maximize_contents_list.height + button_list_edit.height + 40
            Layout.fillWidth: true
            Layout.minimumWidth: parent.Layout.minimumWidth
            color: Style.background_color
            
            TextField {
                id: text_field_filter
                placeholderText: "Filter"
                width: parent.width - 20
                height: 30
                y: 10
                font.pointSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }

            CheckBox {
                id: check_box_case_sensitive
                font.pointSize: 10
                anchors.verticalCenter: button_maximize_contents_list.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Text {
                text: "Case Sensitive"
                color: Style.forground_color
                anchors.left: check_box_case_sensitive.right
                anchors.leftMargin: 3
                anchors.verticalCenter: check_box_case_sensitive.verticalCenter
            }

            CustomButton {
                id: button_maximize_contents_list
                buttonText: ">>"
                width: button_list_edit.width/2 - 5
                anchors.top: text_field_filter.bottom
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // console.log(">>")
                        rectangle_content_menu.anchors.fill = rectangle_content_menu.parent;
                        rectangle_content_menu.width = undefined
                    }
                }

                Component.onCompleted: {
                    buttonTextColor = Style.forground_color
                    border.color = Style.forground_color
                }
            }

            CustomButton {
                id: button_minimize_contents_list
                buttonText: "<<"
                width: button_list_edit.width/2 - 5
                anchors.top: text_field_filter.bottom
                anchors.topMargin: 10
                anchors.right: button_maximize_contents_list.left
                anchors.rightMargin: 10

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // console.log("<<")
                        rectangle_content_menu.anchors.fill = undefined;
                        rectangle_content_menu.width = 250
                    }
                }

                Component.onCompleted: {
                    buttonTextColor = Style.forground_color
                    border.color = Style.forground_color
                }
            }

            CustomButton {
                id: button_list_edit
                buttonText: "List Editor"
                anchors.top : button_maximize_contents_list.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                color: listEditorButtonColor
                border.color: listEditorButtonBorderColor
                buttonTextColor: listEditorButtonTextColor

                MouseArea {
                    id: mouse_area_list_edit
                    enabled: listEditorButtonEnabled
                    anchors.fill: parent
                    onClicked: { 
                        // console.log("List Editor"); 
                        if(button_list_edit.buttonText == "List Editor") {
                            rectangle_content_menu.pushContentListEditor(); 
                            listEditorButtonEnabled = false;
                            listEditorButtonTextColor = Style.inactive_color;
                            listEditorButtonBorderColor = Style.inactive_color;
                            content_model.requestData(articleListCurrentIndex);
                        }
                    }
                }
            }
        }

        ListView {
            visible: true
            id: content_list
            objectName: "content_list_view"
            
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: parent.Layout.minimumWidth
            clip: true
            model: content_model
            delegate: Rectangle {
                width: parent.width
                height: content_item.height + 20
                color: "#00000000"
                Item {
                    id: content_item
                    width: parent.width
                    height: childrenRect.height
                    Text {
                        id: item_type
                        text: display.type
                        color: Style.forground_color
                        font.pixelSize: 12
                        font.bold: false
                        y: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: item_content_name
                        text: display.content_name
                        color: Style.forground_color
                        font.pixelSize: 16
                        font.bold: true
                        anchors.top: item_type.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: item_topic
                        text: display.topic
                        color: Style.forground_color
                        font.pixelSize: 12
                        font.bold: false
                        anchors.top: item_content_name.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: author
                        text: display.author
                        color: Style.forground_color
                        font.pixelSize: 12
                        font.bold: false
                        anchors.top: item_topic.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(articleListIsSelectable) {
                            content_list.currentIndex = index;
                            articleListCurrentIndex = index;
                            content_model.requestPathAndFormat(articleListCurrentIndex); 
                        }
                    }
                }
            }

            highlight: Rectangle {
                width: parent.width
                height: parent.height
                color: Style.highlight_color 
            }

            Component.onCompleted: {
                content_model.requestPathAndFormat(articleListCurrentIndex); 
            }
        }

        Rectangle {
            id: content_footer
            height: button_source_edit.height + 20
            Layout.fillWidth: true
            Layout.minimumWidth: parent.Layout.minimumWidth
            color: Style.background_color
            
            CustomButton {
                id: button_source_edit
                buttonText: "Source Editor"
                width: parent.width - 20
                anchors.top : content_footer.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: sourceEditorButtonColor
                border.color: sourceEditorButtonBorderColor
                buttonTextColor: sourceEditorButtonTextColor

                MouseArea {
                    id: mouse_area_source_edit
                    enabled: sourceEditorButtonEnabled
                    anchors.fill: parent
                    onClicked: { 
                        // console.log("Source Editor"); 
                        if(button_source_edit.buttonText == "Source Editor") {
                            rectangle_content_menu.pushContentSourceEditor(); 
                            sourceEditorButtonEnabled = false;
                            sourceEditorButtonTextColor = Style.inactive_color;
                            sourceEditorButtonBorderColor = Style.inactive_color;
                        }
                    }
                }
            }
        }
    }
}