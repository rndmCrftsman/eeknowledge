import os, platform
try:
    import win32
except:
    print("win32 not available! required for Windows Print Capability")
from PySide2.QtCore import QObject, Slot, Signal

class Printer(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.det_os = platform.system

    printersListAvailable = Signal(str)

    @Slot()
    def getAvailablePrinters(self):
        self.printersListAvailable.emit("Hallo")

    @Slot(str, str, str, str, str, str)
    def printDocument(self, printer_name, paper_size, page_orientation, doubleside_enabled, flipping_edge, file_path):
        document_rel_path = file_path
        doc_rel_path_dirs = document_rel_path.split('/')[1:]
        app_path = os.getcwd()
        app_path_dirs = app_path.split('/')
        doc_abs_path_dirs = app_path_dirs  
        while(doc_rel_path_dirs[0] == ".."):
            doc_rel_path_dirs = doc_rel_path_dirs[1:]
            doc_abs_path_dirs = doc_abs_path_dirs[:-1]

        doc_abs_path_dirs = doc_abs_path_dirs + doc_rel_path_dirs
        doc_abs_path = '/'.join(doc_abs_path_dirs)
        print("print document: " + doc_abs_path)