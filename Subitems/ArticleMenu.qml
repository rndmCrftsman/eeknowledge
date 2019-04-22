import QtQuick 2.0
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.4
import "Style"

RowLayout {
    Layout.alignment: Qt.AlignLeft
    Layout.fillHeight: true

    spacing: 0

    ScrollView {
        id: article_scrollview
        Layout.fillWidth: true
        Layout.fillHeight: true

        ListView {
            id: articleList
            objectName: "article_list_view"

            Layout.fillWidth: true
            clip: false
            model: articleModel
            delegate: articleDelegate
            highlight: Rectangle {
                width: parent.width
                height: 80
                color: "lightgray"
            }
        }
    }

    Component {
        id: articleDelegate
        Rectangle {
            color: "gray"
            width: parent.width
            height: 80

            Text {
                text: display
                font.pixelSize: 24
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }

    Rectangle {
        Layout.fillHeight: true
        color: Style.bg_color
        width: 30

    }
}