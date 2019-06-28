import QtQuick 2.7
import QtQuick.Layouts 1.5
import QtQuick.Shapes 1.1
import "Style"

RowLayout {
    id: titlebar
    spacing: 0

    signal printDocument()
    signal loadContents()
    signal saveContents()

    Rectangle {
        id: title
        color: Style.background_color
        
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            text: "ee|knowledge"

            color: Style.forground_color
            font.pointSize: Style.title.text.ptSize
            font.bold: Style.title.text.bold
            font.letterSpacing: Style.title.letterSpacing

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    Rectangle {
        id: print_button
        color: Style.background_color
        
        Layout.fillHeight: true
        width: 50

        Canvas {
            id: print_printer_symbol
            height: parent.height * 4 / 16
            width: parent.width * 12 / 16
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            anchors.horizontalCenter: parent.horizontalCenter

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = Style.forground_color
                ctx.strokeStyle = Style.forground_color
                ctx.lineWidth = parent.height / 10
                ctx.beginPath()
                ctx.lineTo(0, height)
                ctx.lineTo(width, height)
                ctx.lineTo(width, 0)
                ctx.lineTo(0, 0)
                ctx.closePath()
                ctx.stroke()
            }
        }

        Canvas {
            id: print_paper_sheet
            height: parent.height * 7 / 16
            width: parent.width * 7 / 16
            anchors.bottom: print_printer_symbol.bottom
            anchors.bottomMargin: parent.height * 2 / 16
            anchors.horizontalCenter: parent.horizontalCenter

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = Style.background_color
                ctx.strokeStyle = Style.forground_color
                ctx.lineWidth = parent.height / 10
                ctx.beginPath()
                ctx.moveTo(0, (height / 3))
                ctx.lineTo(0, height)
                ctx.lineTo(width, height)
                ctx.lineTo(width, 0)
                ctx.lineTo((width / 3), 0)
                ctx.fill()
                ctx.stroke()
            }
        }

        Canvas {
            id: print_paper_edge
            height: print_paper_sheet.height
            width: print_paper_sheet.width
            anchors.top: print_paper_sheet.top
            anchors.left: print_paper_sheet.left

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = Style.forground_color
                ctx.strokeStyle = Style.forground_color
                ctx.lineWidth = parent.height / 20
                ctx.beginPath()
                ctx.moveTo(0, (height / 3))
                ctx.lineTo((width / 3), 0)
                ctx.lineTo((width / 3), (height / 3))
                ctx.lineTo(0, (height / 3))
                ctx.stroke()
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: titlebar.printDocument()
        }
    }

    // Rectangle {
    //     id: load_button
    //     color: Style.background_color
        
    //     Layout.fillHeight: true
    //     width: 50

    //     Text {
    //         text: "\f093"

    //         color: Style.forground_color
    //         font.pointSize: Style.title.text.ptSize
    //         font.bold: Style.title.text.bold

    //         anchors.centerIn: parent
    //     }

    //     MouseArea {
    //         anchors.fill: parent
    //         onClicked: titlebar.loadContents()
    //     }
    // }


    Rectangle {
        id: load_button
        color: Style.background_color
        
        Layout.fillHeight: true
        width: 50

        Rectangle {
            id: load_horizontal_bar
            height: parent.height / 15
            width: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            color: Style.forground_color
        }
        
        Rectangle {
            id: load_left_bar
            height: parent.height / 5 
            width: parent.width / 15
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            color: Style.forground_color
        }
        
        Rectangle {
            id: load_right_bar
            height: parent.height / 5 
            width: parent.width / 15
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            color: Style.forground_color
        }

        Rectangle {
            id: load_arrow_bar
            height: parent.height / 4
            width: parent.width / 15
            anchors.bottom: load_horizontal_bar.top
            anchors.bottomMargin: parent.height / 10
            anchors.horizontalCenter: parent.horizontalCenter

            color: Style.forground_color
        }

        Canvas {
            id: load_arrow_triangle
            height: parent.height / 8
            width: parent.width / 4
            anchors.bottom: load_arrow_bar.top
            anchors.horizontalCenter: load_arrow_bar.horizontalCenter

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = Style.forground_color
                ctx.strokeStyle = Style.forground_color
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.lineTo(0, height)
                ctx.lineTo(width, height)
                ctx.lineTo((width / 2), 0)
                ctx.closePath()
                ctx.fill()
                ctx.stroke()
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: titlebar.loadContents()
        }
    }

    Rectangle {
        id: save_button
        color: Style.background_color
        
        Layout.fillHeight: true
        width: 50

        Rectangle {
            id: save_horizontal_bar
            height: parent.height / 15
            width: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            color: Style.forground_color
        }
        
        Rectangle {
            id: save_left_bar
            height: parent.height / 5 
            width: parent.width / 15
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            color: Style.forground_color
        }
        
        Rectangle {
            id: save_right_bar
            height: parent.height / 5 
            width: parent.width / 15
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 5
            color: Style.forground_color
        }

        Canvas {
            id: save_arrow_triangle
            height: parent.height / 8
            width: parent.width / 4
            anchors.bottom: save_horizontal_bar.top
            anchors.bottomMargin: parent.height / 10
            anchors.horizontalCenter: parent.horizontalCenter

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = Style.forground_color
                ctx.strokeStyle = Style.forground_color
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.lineTo(0, 0)
                ctx.lineTo(width, 0)
                ctx.lineTo((width / 2), height)
                ctx.closePath()
                ctx.fill()
                ctx.stroke()
            }
        }

        Rectangle {
            id: save_arrow_bar
            height: parent.height / 4
            width: parent.width / 15
            anchors.bottom: save_arrow_triangle.top
            anchors.horizontalCenter: save_arrow_triangle.horizontalCenter

            color: Style.forground_color
        }

        MouseArea {
            anchors.fill: parent
            onClicked: titlebar.saveContents()
        }
    }

    
}