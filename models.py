import sys, os, re, platform
import subprocess
from PySide2.QtCore import QAbstractListModel, Qt, QModelIndex, Slot, Signal, QSortFilterProxyModel, qDebug
from PySide2.QtPrintSupport import QPrinter, QPrintDialog

class ContentListModel(QAbstractListModel):

    def __init__(self, parent = None):
        QAbstractListModel.__init__(self, parent)
        self.readFromFile("content.txt")
        # self.writeToFile("content.txt")

    def rowCount(self, parent):
        return len(self._content)

    def data(self, index, role):
        if role == Qt.DisplayRole:
            return self._content[index.row()]

    def flags(self, index):
        return Qt.ItemIsSelectable

    editorOpened = Signal(str)

    @Slot(int)
    def requestData(self, index):
        item_list = [
            self._content[index].get("source_path"),
            self._content[index].get("type"),
            self._content[index].get("name"),
            self._content[index].get("author"),
            self._content[index].get("keyword"),
            self._content[index].get("description"),
            self._content[index].get("format")
        ]
        item_list_str = ",".join(item_list)
        self.editorOpened.emit(item_list_str)

    @Slot(str, int)
    def saveData(self, data, index):
        item_list = data.split(',')
        self._content[index]["source_path"] = item_list[0]
        self._content[index]["type"] = item_list[1]
        self._content[index]["name"] = item_list[2]
        self._content[index]["author"] = item_list[3]
        self._content[index]["keyword"] = item_list[4]
        self._content[index]["description"] = item_list[5]
        self._content[index]["format"] = item_list[6]
        item_index = self.index(index, 0)
        self.dataChanged.emit(item_index, item_index, 0)
        self.writeToFile("content.txt")

    pathAndFormatChanged = Signal(str)

    @Slot(int)
    def requestPathAndFormat(self, index):
        if(index < 0):
            item_list = [
                "None",
                "None"
            ]
        else:
            item_list = [
                self._content[index].get("source_path"),
                self._content[index].get("format")
            ]
        item_list_str = ','.join(item_list)
        self.pathAndFormatChanged.emit(item_list_str)

    @Slot(int)
    def removeData(self, index):
        if(len(self._content) > 0 and index >= 0):
            self._content.pop(index)
            self.modelReset.emit()
            if(len(self._content) < 1):
                self.requestPathAndFormat(-1)
            else:
                self.requestPathAndFormat(index)
            self.writeToFile("content.txt")

    @Slot(int)
    def addData(self, index):
        empty_data = {
            "source_path" : "",
            "type" : "",
            "name": "",
            "author" : "",
            "keyword" : "",
            "description" : "",
            "format" : ""
        }
        self._content.insert(index, empty_data)
        self.modelReset.emit()
        self.requestData(index)

    @Slot(str)
    def readFromFile(self, file_path):
        self._content = []
        self.temp_data = {
            "source_path" : "",
            "type" : "",
            "name": "",
            "author" : "",
            "keyword" : "",
            "description" : "",
            "format" : ""
        }
        with open(file_path, 'r') as opened_file:
            file_lines = opened_file.readlines()
            for line in file_lines:
                line = re.sub('^[ \t]+', '', line)
                line = re.sub('[ \t]+$', '', line)
                if(line == "{\n"):
                    self.temp_data = {
                        "source_path" : "",
                        "type" : "",
                        "name": "",
                        "author" : "",
                        "keyword" : "",
                        "description" : "",
                        "format" : ""
                    }
                elif(line == "}\n"):
                    self._content.append(self.temp_data)
                else:
                    line = re.sub(' : ', '*', line)
                    line = re.sub('[\n]', '', line)
                    content_info = line.split('*')
                    self.temp_data[content_info[0]] = content_info[1]
                    
    @Slot(str)
    def writeToFile(self, file_path):
        with open(file_path, 'w') as opened_file:
            for entry in self._content:
                opened_file.write("{" + "\n")
                opened_file.write("source_path : " + entry.get("source_path") + "\n")
                opened_file.write("type : " + entry.get("type") + "\n")
                opened_file.write("name : " + entry.get("name") + "\n")
                opened_file.write("author : " + entry.get("author") + "\n")
                opened_file.write("keyword : " + entry.get("keyword") + "\n")
                opened_file.write("description : " + entry.get("description") + "\n")
                opened_file.write("format : " + entry.get("format") + "\n")
                opened_file.write("}" + "\n")

    @Slot(int)
    def printDocument(self, index):
        document_rel_path = self._content[index].get("source_path")
        doc_rel_path_dirs = document_rel_path.split('/')[1:]
        app_path = os.getcwd()
        app_path_dirs = app_path.split('/')
        doc_abs_path_dirs = app_path_dirs  
        while(doc_rel_path_dirs[0] == ".."):
            doc_rel_path_dirs = doc_rel_path_dirs[1:]
            doc_abs_path_dirs = doc_abs_path_dirs[:-1]

        doc_abs_path_dirs = doc_abs_path_dirs + doc_rel_path_dirs
        doc_abs_path = '/'.join(doc_abs_path_dirs)
        det_os = platform.system()
        if(det_os == 'Linux'):
            print("Printing on Linux...")
            # lpr = subprocess.Popen(["lpr", doc_abs_path])
        elif(det_os == 'Darwin'):
            print("Printing on MacOS...")
            # lpr = subprocess.Popen(["lpr", doc_abs_path])
        else:
            print('Printing on Windows...')




        # lpr = subprocess.Popen(["lpr", doc_abs_path])
        






class FilterModel(QSortFilterProxyModel):
    
    def __init__(self, source_model):
        QSortFilterProxyModel.__init__(self)
        self._source_model = source_model
        self._type_filter = []
        self._name_filter = []
        self._author_filter = []
        self._keyword_filter = []
        self._description_filter = []
        self._format_filter = []

    def filterAcceptsRow(self, sourceRow, sourceParent):
        row_index = self._source_model.index(sourceRow,0)
        row_data = self._source_model.data(row_index, Qt.DisplayRole)
        filter_accepted = True
        for word in self._type_filter:
            if(not re.search(word, row_data.get("type"), re.RegexFlag.IGNORECASE)):
                filter_accepted = False
        for word in self._name_filter:
            if(not re.search(word, row_data.get("name"), re.RegexFlag.IGNORECASE)):
                filter_accepted = False
        for word in self._author_filter:
            if(not re.search(word, row_data.get("author"), re.RegexFlag.IGNORECASE)):
                filter_accepted = False
        for word in self._keyword_filter:
            if(not re.search(word, row_data.get("keyword"), re.RegexFlag.IGNORECASE)):
                filter_accepted = False
        for word in self._description_filter:
            if(not re.search(word, row_data.get("description"), re.RegexFlag.IGNORECASE)):
                filter_accepted = False
        for word in self._format_filter:
            if(not re.search(word, row_data.get("format"), re.RegexFlag.IGNORECASE)):
                filter_accepted = False
        return filter_accepted 

    @Slot(str, str, str, str, str, str)
    def updateFilters(self, type_filter, name_filter, author_filter, keyword_filter, description_filter, format_filter):
        self._type_filter = type_filter.split(' ')
        self._name_filter = name_filter.split(' ')
        self._author_filter = author_filter.split(' ')
        self._keyword_filter = keyword_filter.split(' ')
        self._description_filter = description_filter.split(' ')
        self._format_filter = format_filter.split(' ')
        self.invalidateFilter()