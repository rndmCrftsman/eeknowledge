import os, platform
import subprocess
try:
    import win32print
except:
    print("Win32Print not available (required for printing on Windows)")

class Printer():

    def __init__(self):
        self._printer = ""
        self._det_os = platform.system()

    def listPrinters(self):
        pass

    def setPrinter(self, sel_printer):
        self._printer = sel_printer

    def print_document(self, document):
        if(self._det_os == 'Linux'):
            print("Printing on Linux...")
            # lpr = subprocess.Popen(["lpr", doc_abs_path])
        elif(self._det_os == 'Darwin'):
            print("Printing on MacOS...")
            # lpr = subprocess.Popen(["lpr", doc_abs_path])
        else:
            print('Printing on Windows...')