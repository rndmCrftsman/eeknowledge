import sys

class ContentList():

    def __init__(self, file=None):
        self.content = []
        self.loadFile(file)

    def loadFile(self, file):
        self.content = [
            {   "source_paths" : "hahhahahaha",
                "type" : "Article",
                "content_name": "Hannes 1st one",
                "author" : "Hannes Stoll",
                "topic" : "Initial Electronics",
                "description" : "OOh Yess :D"
            },
            {   
                "source_paths" : "noooo",
                "type" : "Exercise",
                "content_name": "Let's go",
                "author" : "Hannes Stoll",
                "topic" : "Signals and Systems",
                "description" : ":P"
            }
        ]

    def getList(self):
        return self.content

    def setList(self, list):
        pass