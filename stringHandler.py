import sys
from PySide2.QtCore import QObject, Property, Signal, Slot

class StringHandler(QObject):
    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.text = "Hallo Hannes"

    textChanged = Signal(str)

    def get_text(self):
        return self.text

    def set_text(self, text):
        self.text = text
        self.textChanged.emit(self.text)

    @Slot(str)
    def change_text(self, text):
        print(text)
        self.text = text
