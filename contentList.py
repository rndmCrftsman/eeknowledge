import sys

class ContentList():

    def __init__(self, file=None):
        self.content = []
        self.loadFile(file)

    def loadFile(self, file):
        self.content = [
            {   "source_path" : "test.pdf",
                "type" : "Article",
                "content_name": "Hannes 1st one",
                "author" : "Hannes Stoll",
                "topic" : "Initial Electronics",
                "description" : "OOh Yess :D",
                "format" : "PDF"
            },
            {   
                "source_path" : "test.html",
                "type" : "Tool",
                "content_name": "Let's go",
                "author" : "Hannes Stoll",
                "topic" : "Signals and Systems",
                "description" : ":P",
                "format" : "JS"
            }
        ]

    def getList(self):
        return self.content

    def setList(self, list):
        pass