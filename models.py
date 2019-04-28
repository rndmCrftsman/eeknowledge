import sys
from PySide2.QtCore import QAbstractListModel, Qt, QModelIndex

class ContentListModel(QAbstractListModel):

    def __init__(self, content = [], parent = None):
        QAbstractListModel.__init__(self, parent)
        self._contents = content
        # self._ContentNameRole = Qt.UserRole + 1,
        # self._AuthorRole = Qt.UserRole + 2,
        # self._TypeRole = Qt.UserRole + 3,
        # self._TopicKeywordRole = Qt.UserRole + 4,
        # self._PathRole = Qt.UserRole + 5,
        # self._DescriptionRole = Qt.UserRole + 6

    def rowCount(self, parent):
        return len(self._contents)

    def data(self, index, role):
        if role == Qt.DisplayRole:
            return self._contents[index.row()] # .get("content_name")

    def flags(self, index):
        # if not index.isValid():
        #     return Qt.NoItemFlags
        # else:
        #     return Qt.ItemIsSelectable
        return Qt.ItemIsSelectable