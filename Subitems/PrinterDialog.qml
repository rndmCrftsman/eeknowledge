import QtQuick 2.7
import QtQuick.Controls 2.2
import "Style"

Dialog {
   id: printer_dialog 
   title: "Print Document"
   standardButtons: Dialog.Ok | Dialog.Cancel

   property var sectionMargin: height / 30
   property var titleMargin: height / 100

   property var printer_name: "No Printer Available"
   property var page_size: "A4"
   property var page_orientation: "Portrait"
   property var doublesided_options: "Singlesided"

   contentItem: Item {
      Text {
         id: available_printers_label
         text: "Available Printers:"
         anchors.left: parent.left
         anchors.top: parent.top
      }
      ComboBox {
         id: available_printers_combobox
         model: ["No Printer Available"]
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.top: available_printers_label.bottom
         anchors.topMargin: titleMargin
         onCurrentIndexChanged: {
            printer_name = model[currentIndex]
         }
      }
      Text {
         id: page_size_label
         text: "Page Size:"
         anchors.left: parent.left
         anchors.top: available_printers_combobox.bottom
         anchors.topMargin: sectionMargin
      }
      ComboBox {
         id: page_size_combobox
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.top: page_size_label.bottom
         anchors.topMargin: titleMargin
         model: ["A3", "A4", "A5"]
         currentIndex: 1
         onCurrentIndexChanged: {
            page_size = model[currentIndex]
         }
      }
      Text {
         id: orientation_label
         text: "Orientation:"
         anchors.left: parent.left
         anchors.top: page_size_combobox.bottom
         anchors.topMargin: sectionMargin
      }
      RadioButton {
         id: orientation_portrait_radiobutton
         anchors.left: parent.left
         anchors.top: orientation_label.bottom
         anchors.topMargin: titleMargin
         checked: true
         text: "Portrait"
         onClicked: {
            page_orientation = text
         }
      }
      RadioButton {
         id: orientation_landscape_radiobutton
         anchors.left: parent.left
         anchors.top: orientation_portrait_radiobutton.bottom
         anchors.topMargin: titleMargin
         text: "Landscape"
         onClicked: {
            page_orientation = text
         }
      }
      Text {
         id: doublesided_printing_label
         text: "Doublesided Printing:"
         anchors.left: parent.left
         anchors.top: orientation_landscape_radiobutton.bottom
         anchors.topMargin: sectionMargin
      }
      ComboBox {
         id: doublesided_printing_combobox
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.top: doublesided_printing_label.bottom
         anchors.topMargin: titleMargin
         model: ["Singlesided", "Doublesided (flipped on long edge)", "Doublesided (flipped on short edge)"]
         onCurrentIndexChanged: {
            doublesided_options = model[currentIndex]
         }
      }
   }

   signal rePrintersListAvailable(string available_printers)

   Component.onCompleted: {
      printer.printersListAvailable.connect(rePrintersListAvailable);
   } 
    
   Connections {
      target: printer_dialog

      onRePrintersListAvailable: {
         var printers = available_printers.split(',')
         if(printer == []) {
            available_printers_combobox.model = ["No Printer Available"]
         } else {
            available_printers_combobox.model = available_printers.split(',')
         }
         printer_name = available_printers_combobox.model[available_printers_combobox.currentIndex]
      }
   }
}