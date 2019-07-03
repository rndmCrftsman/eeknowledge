import os, platform
import threadedSubprocess
try:
    import win32
except:
    print("win32 not available! required for Windows Print Capability")
from PySide2.QtCore import QObject, Slot, Signal

class Printer(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.det_os = platform.system()

    printersListAvailable = Signal(str)

    def commitAvailablePrinters(self, printerInformation):
        printerList = []
        printerInformationList = printerInformation.split('\n')[:-1]
        for printer in printerInformationList:
            printerList.append(printer.split(' ')[0])
        self.printersListAvailable.emit(','.join(printerList))


    @Slot()
    def getAvailablePrinters(self):
        if(self.det_os == "Linux" or self.det_os == "Darwin"):
            threadedSubprocess.popenAndCall(self.commitAvailablePrinters, ["lpstat", "-a"])
    
    

    @Slot(str, str, str, str, str)
    def printDocument(self, printer_name, page_size, page_orientation, doublesided_options, file_path):
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
        # print("print document: " + doc_abs_path)
        if(self.det_os == "Linux" or self.det_os == "Darwin"):
            print_command = ["lpr"]
            print_command.append("-P")
            print_command.append(printer_name)
            print_command.append("-o")
            print_command.append("media=" + str(page_size))
            if(page_orientation == "Landscape"):
                print_command.append("-o")
                print_command.append("landscape")

            if(doublesided_options == "Doublesided (flipped on long edge)"):
                print_command.append("-o")
                print_command.append("sides=two-sided-long-edge")
            elif(doublesided_options == "Doublesided (flipped on short edge)"):
                print_command.append("-o")
                print_command.append("sides=two-sided-short-edge")
            print_command.append(doc_abs_path)
            print(print_command)
            threadedSubprocess.popenAndCall(print, print_command)
        else:
            # something with win32print
            pass
