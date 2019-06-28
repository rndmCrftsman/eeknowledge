import sys, os
from PySide2.QtWidgets import QApplication, QVBoxLayout, QWidget
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QUrl, Qt, QObject, QAbstractListModel, QRect, QStringListModel, QSortFilterProxyModel
from models import ContentListModel, FilterModel
from contentList import ContentList

app = QApplication(sys.argv)

view = QQuickView()

root_context = view.rootContext()

source_model = ContentListModel()
filter_proxy_model = FilterModel(source_model)
filter_proxy_model.setSourceModel(source_model)

root_context.setContextProperty('source_model', source_model)
root_context.setContextProperty('filter_proxy_model', filter_proxy_model)
app_dir_path = os.getcwd()
app_dir_path_unix = app_dir_path.replace("\\", "/")
root_context.setContextProperty('application_dir_path', app_dir_path_unix)

url = QUrl("Main.qml")

view.setSource(url)
view.setResizeMode(QQuickView.SizeRootObjectToView)

# get root objects
main_window = view.rootObject()

view.show()

app.exec_()
