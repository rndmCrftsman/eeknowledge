import sys
from PySide2.QtWidgets import QApplication, QVBoxLayout, QWidget
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QUrl, Qt, QObject, QAbstractListModel, QRect, QStringListModel



app = QApplication(sys.argv)

view = QQuickView()
root_context = view.rootContext()

# add article model to the root context
article_model_source = QStringListModel()
article_list = [
    {"name": "Hannes"},
    {"name": "Debora"},
    {"name": "John"},
    {"name": "Der Kahn"},
    {"name": "Ohne mich"},
    {"name": "Nie ohne mein Team"},
    {"name": "Lass das!!"}
]
article_model_source.setStringList(article_list)
root_context.setContextProperty('articleModel', article_model_source)

# view.setFlags(Qt.FramelessWindowHint)
url = QUrl("main.qml")

view.setSource(url)
view.setResizeMode(QQuickView.SizeRootObjectToView)

# get all needed objects
main_window = view.rootObject()
article_menu = main_window.findChild(QObject, "article_menu")
article_list_view = article_menu.findChild(QObject, "article_list_view")



view.show()

app.exec_()

