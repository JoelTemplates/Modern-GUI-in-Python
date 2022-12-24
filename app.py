import sys
import os
from PySide6.QtQml import *
from PySide6.QtGui import *
from PySide6.QtCore import *

class MainBackend(QObject):
    def __init__(self):
        QObject.__init__(self)
    
    staticUser = "user123"
    staticPass = "123"
    signalUser = Signal(str)
    signalIn = Signal(bool)
    
    @Slot(str, str)
    def cLogin(self, getUser, getPass):
        if(self.staticUser.lower() == getUser.lower() and self.staticPass.lower() == getPass.lower()):
            self.signalUser.emit("Welcome back,\n" + getUser)
            self.signalIn.emit(True)
        else:
            self.signalIn.emit(False)

if __name__ == "__main__":
    # os.environ["QT_QUICK_BACKEND"] = "software"
    # ^ If the code doesn't work and gives and error use this
    # It might fix your problem
    app = QGuiApplication(sys.argv)
    main = MainBackend()
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("backend", main)
    engine.load(os.path.join(os.path.dirname(__file__), "qml/login.qml"))
    if not engine.rootContext():
        sys.exit(-1)
    try:
        sys.exit(app.exec())
    except:pass