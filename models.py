import sys
from PySide2.QtCore import QAbstractListModel, Qt, QModelIndex, Slot, Signal

class ContentListModel(QAbstractListModel):

    def __init__(self, content = [], parent = None):
        QAbstractListModel.__init__(self, parent)
        self._contents = content

    def rowCount(self, parent):
        return len(self._contents)

    def data(self, index, role):
        if role == Qt.DisplayRole:
            return self._contents[index.row()]

    def flags(self, index):
        return Qt.ItemIsSelectable

    editorOpened = Signal(str)

    @Slot(int)
    def requestData(self, index):
        item_list = [
            self._contents[index].get("source_paths"),
            self._contents[index].get("type"),
            self._contents[index].get("content_name"),
            self._contents[index].get("author"),
            self._contents[index].get("topic"),
            self._contents[index].get("description"),
            self._contents[index].get("format")
        ]
        item_list_str = ",".join(item_list)
        self.editorOpened.emit(item_list_str)

    @Slot(str, int)
    def saveData(self, data, index):
        item_list = data.split(',')
        self._contents[index]["source_paths"] = item_list[0]
        self._contents[index]["type"] = item_list[1]
        self._contents[index]["content_name"] = item_list[2]
        self._contents[index]["author"] = item_list[3]
        self._contents[index]["topic"] = item_list[4]
        self._contents[index]["description"] = item_list[5]
        self._contents[index]["format"] = item_list[6]
        item_index = self.index(index, 0)
        self.dataChanged.emit(item_index, item_index, 0)

