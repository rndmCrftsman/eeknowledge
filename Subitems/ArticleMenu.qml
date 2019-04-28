import QtQuick 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4
import "Style"

Rectangle {
    id: rectangle_content_menu

    Layout.minimumWidth: 250
    color: Style.bg_color

    ColumnLayout {
        Layout.minimumWidth: parent.Layout.minimumWidth
        anchors.fill: parent
        spacing: 1

        Rectangle {
            id: content_header
            height: 120
            Layout.fillWidth: true
            Layout.minimumWidth: parent.Layout.minimumWidth
            color: Style.bg_color
            
            TextField {
                id: text_field_filter
                width: parent.width - 20
                y: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }

            CheckBox {
                id: check_box_case_sensitive
                anchors.verticalCenter: button_maximize_contents_list.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Text {
                text: "Case Sensitive"
                color: Style.fg_color
                anchors.left: check_box_case_sensitive.right
                anchors.leftMargin: 3
                anchors.verticalCenter: check_box_case_sensitive.verticalCenter
            }

            Rectangle {
                id: button_maximize_contents_list
                color: Style.bg_color
                border.width: 1
                border.color: Style.fg_color
                radius: 5
                clip: true
                width: button_edit.width/2 - 5
                height: button_text_maximize_contents_list.height + 10
                anchors.top : text_field_filter.bottom
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                
                Text {
                    id: button_text_maximize_contents_list
                    anchors.centerIn: parent
                    text: ">>"
                    color: Style.fg_color
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { 
                        rectangle_content_menu.anchors.fill = rectangle_content_menu.parent;
                        rectangle_content_menu.width = undefined
                    }
                }
            }

            Rectangle {
                id: button_minimize_contents_list
                color: Style.bg_color
                border.width: 1
                border.color: Style.fg_color
                radius: 5
                clip: true
                width: button_edit.width/2 - 5
                height: button_text_minimize_contents_list.height + 10
                anchors.top : text_field_filter.bottom
                anchors.topMargin: 10
                anchors.right: button_maximize_contents_list.left
                anchors.rightMargin: 10
                
                Text {
                    id: button_text_minimize_contents_list
                    anchors.centerIn: parent
                    text: "<<"
                    color: Style.fg_color
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { 
                        rectangle_content_menu.anchors.fill = undefined;
                        rectangle_content_menu.width = 250
                    }
                }
            }

            Rectangle {
                id: button_edit
                color: Style.bg_color
                border.width: 1
                border.color: Style.fg_color
                radius: 5
                clip: true
                width: parent.width/2 -15
                height: button_text_edit.height + 10
                anchors.top : button_maximize_contents_list.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                
                Text {
                    id: button_text_edit
                    anchors.centerIn: parent
                    text: "Edit"
                    color: Style.fg_color
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Edit")
                }
            }

            Rectangle {
                id: button_add_remove
                color: Style.bg_color
                border.width: 1
                border.color: Style.fg_color
                radius: 5
                clip: true
                width: parent.width/2 -15
                height: button_text_add_remove.height + 10
                anchors.top : button_maximize_contents_list.bottom
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                
                Text {
                    id: button_text_add_remove
                    anchors.centerIn: parent
                    text: "Add/Remove"
                    color: Style.fg_color
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Add/Remove")
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
                        color: Style.fg_color
                        font.pixelSize: 12
                        font.bold: false
                        y: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: item_content_name
                        text: display.content_name
                        color: Style.fg_color
                        font.pixelSize: 16
                        font.bold: true
                        anchors.top: item_type.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: item_topic_keywords
                        text: display.topic_keywords
                        color: Style.fg_color
                        font.pixelSize: 12
                        font.bold: false
                        anchors.top: item_content_name.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: author
                        text: display.author
                        color: Style.fg_color
                        font.pixelSize: 12
                        font.bold: false
                        anchors.top: item_topic_keywords.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: content_list.currentIndex = index
                }
            }

            highlight: Rectangle {
                width: parent.width
                height: parent.height
                color: "gray"
            }
        }
    }
}