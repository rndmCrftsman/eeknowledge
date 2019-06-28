import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.1
import "Style"

Rectangle {
    id: rectangle_content_menu

    signal pushContentListEditor()
    
    property var addButtonEnabled
    property var addButtonColor
    property var addButtonTextColor
    property var addButtonBorderColor
    property var listEditorButtonEnabled
    property var listEditorButtonColor
    property var listEditorButtonTextColor
    property var listEditorButtonBorderColor
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
            height: text_field_filter.height + button_maximize_content_list.height + button_list_edit.height + 40
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

                onTextChanged: {
                    var type_filter = ""
                    var name_filter = ""
                    var author_filter = ""
                    var keyword_filter = ""
                    var description_filter = ""
                    var format_filter = ""
                    var data = text
                    var filters = data.split('@')
                    filters.shift()
                    var i
                    for(i = 0; i < filters.length; i++) {
                        var filter = filters[i].split(':')
                        var filter_indicator = filter[0]
                        if(filter.length > 1) {
                            switch(true) {
                                case /^[Tt]ype$/.test(filter_indicator): {
                                    type_filter = filter[1]
                                    break;
                                }
                                case /^[Nn]ame$/.test(filter_indicator): {
                                    name_filter = filter[1]
                                    break;
                                }
                                case /^[Aa]uthor$/.test(filter_indicator): {
                                    author_filter = filter[1]
                                    break;
                                }
                                case /^[Kk]eyword[s]{0,1}$/.test(filter_indicator): {
                                    keyword_filter = filter[1]
                                    break;
                                }
                                case /^[Dd]escription$/.test(filter_indicator): {
                                    description_filter = filter[1]
                                    break;
                                }
                                case /^[Ff]ormat$/.test(filter_indicator): {
                                    format_filter = filter[1]
                                    break;
                                }
                            }
                        }
                    }
                    filter_proxy_model.updateFilters(type_filter, name_filter, author_filter, keyword_filter, description_filter, format_filter)
                    content_list.currentIndex = 0
                    articleListCurrentIndex = 0
                    source_model.requestPathAndFormat(filter_proxy_model.mapToSource(filter_proxy_model.index(articleListCurrentIndex, 0)).row)
                }
            }

            CustomButton {
                id: button_maximize_content_list
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
                id: button_minimize_content_list
                buttonText: "<<"
                width: button_list_edit.width/2 - 5
                anchors.top: text_field_filter.bottom
                anchors.topMargin: 10
                anchors.right: button_maximize_content_list.left
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
                anchors.top : button_maximize_content_list.bottom
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
                            source_model.requestData(filter_proxy_model.mapToSource(filter_proxy_model.index(articleListCurrentIndex, 0)).row);
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

            model: filter_proxy_model
            delegate: Rectangle {
                id: content_item_frame
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
                        id: item_name
                        text: display.name
                        color: Style.forground_color
                        font.pixelSize: 16
                        font.bold: true
                        anchors.top: item_type.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: item_keyword
                        text: display.keyword
                        color: Style.forground_color
                        font.pixelSize: 12
                        font.bold: false
                        anchors.top: item_name.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: author
                        text: display.author
                        color: Style.forground_color
                        font.pixelSize: 12
                        font.bold: false
                        anchors.top: item_keyword.bottom
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
                            source_model.requestPathAndFormat(filter_proxy_model.mapToSource(filter_proxy_model.index(articleListCurrentIndex, 0)).row); 
                        }
                    }
                }
            }

            highlight: Rectangle {
                color: Style.highlight_color 
            }

            Component.onCompleted: {
                source_model.requestPathAndFormat(filter_proxy_model.mapToSource(filter_proxy_model.index(articleListCurrentIndex, 0)).row); 
            }
        }

        Rectangle {
            id: content_footer
            height: button_add.height + 20
            Layout.fillWidth: true
            Layout.minimumWidth: parent.Layout.minimumWidth
            color: Style.background_color
            
            CustomButton {
                id: button_add
                buttonText: "Add"
                width: button_list_edit.width/2 - 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                color: addButtonColor
                border.color: addButtonBorderColor
                buttonTextColor: addButtonTextColor

                MouseArea {
                    anchors.fill: parent
                    enabled: addButtonEnabled
                    onClicked: {
                        source_model.addData(filter_proxy_model.mapToSource(filter_proxy_model.index(articleListCurrentIndex, 0)).row)
                        rectangle_content_menu.pushContentListEditor(); 
                        listEditorButtonEnabled = false;
                        listEditorButtonTextColor = Style.inactive_color;
                        listEditorButtonBorderColor = Style.inactive_color;
                        addButtonEnabled = false;
                        addButtonTextColor = Style.inactive_color;
                        addButtonBorderColor = Style.inactive_color;
                    }
                }
            }
            
            CustomButton {
                id: button_remove
                buttonText: "Remove"
                width: button_list_edit.width/2 - 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.left: button_add.right
                anchors.leftMargin: 10

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        remove_dialog.open()
                    }
                }

                Component.onCompleted: {
                    buttonTextColor = Style.forground_color
                    border.color = Style.forground_color
                }
            }

            MessageDialog {
                id: remove_dialog
                title: "Remove Entry"
                text: "Really want to remove the selected entry?"
                standardButtons: Dialog.Yes | Dialog.No

                onAccepted: {
                    // console.log("accepted removal")
                    source_model.removeData(filter_proxy_model.mapToSource(filter_proxy_model.index(articleListCurrentIndex, 0)).row)
                }

                onRejected: {
                    // console.log("canceled removal")
                }
            }
        }
    }
}