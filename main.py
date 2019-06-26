import sys, os
from PySide2.QtWidgets import QApplication, QVBoxLayout, QWidget
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QUrl, Qt, QObject, QAbstractListModel, QRect, QStringListModel
from models import ContentListModel
from contentList import ContentList
from stringHandler import StringHandler

app = QApplication(sys.argv)

view = QQuickView()

root_context = view.rootContext()

# add article model to the root context
# content_list = [
#     {   "content_name": "Hannes 1st one",
#         "author" : "Hannes Stoll",
#         "type" : "Article",
#         "topic_keywords" : "Initial Electronics",
#         "path" : "hahhahahaha",
#         "description" : "OOh Yess :D"
#     },
#     {   "content_name": "Let's go",
#         "author" : "Hannes Stoll",
#         "type" : "Exercise",
#         "topic_keywords" : "Signals and Systems",
#         "path" : "noooo",
#         "description" : ":P"
#     }
# ]

file = None
content_list_handler = ContentList(file)
content_list_handler.loadFile(file)
content_list = content_list_handler.getList()

content_model = ContentListModel(content_list)

# content_name_handler = StringHandler()


root_context.setContextProperty('content_model', content_model)
app_dir_path = os.getcwd()
print(app_dir_path)
app_dir_path_unix = app_dir_path.replace("\\", "/")
print(app_dir_path_unix)
root_context.setContextProperty('application_dir_path', app_dir_path_unix)

# view.setFlags(Qt.FramelessWindowHint)
url = QUrl("Main.qml")

view.setSource(url)
view.setResizeMode(QQuickView.SizeRootObjectToView)

# get root objects
main_window = view.rootObject()

view.show()

app.exec_()
