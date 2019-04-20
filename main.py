import sys
from PySide2.QtWidgets import QApplication
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QUrl, Qt



app = QApplication(sys.argv)
view = QQuickView()
# view.setFlags(Qt.FramelessWindowHint)
url = QUrl("main.qml")


view.setSource(url)
view.setResizeMode(QQuickView.SizeRootObjectToView)
view.show()
app.exec_()