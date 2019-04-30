import sys, os
from PySide2.QtWidgets import QApplication, QVBoxLayout, QWidget
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QUrl, Qt, QObject, QAbstractListModel, QRect, QStringListModel
from models import ContentListModel


app = QApplication(sys.argv)

view = QQuickView()

root_context = view.rootContext()

# add article model to the root context
# article_model_source = QStringListModel()
content_list = [
    {   "content_name": "Hannes 1st one",
        "author" : "Hannes Stoll",
        "type" : "Article",
        "topic_keywords" : "Initial Electronics",
        "path" : "hahhahahaha",
        "description" : "OOh Yess :D"
    },
    {   "content_name": "Let's go",
        "author" : "Hannes Stoll",
        "type" : "Exercise",
        "topic_keywords" : "Signals and Systems",
        "path" : "noooo",
        "description" : ":P"
    }
]
# article_model_source.setStringList(article_list)
content_model = ContentListModel(content_list)
root_context.setContextProperty('content_model', content_model)
root_context.setContextProperty('application_dir_path', os.getcwd())

# view.setFlags(Qt.FramelessWindowHint)
url = QUrl("Main.qml")

view.setSource(url)
view.setResizeMode(QQuickView.SizeRootObjectToView)

# get all needed objects
main_window = view.rootObject()
# article_menu = main_window.findChild(QObject, "article_menu")
# article_list_view = article_menu.findChild(QObject, "article_list_view")

view.show()

app.exec_()

