import threading
import subprocess

def popenAndCall(onExit, popenArgs):
    """
    Runs the given args in a subprocess.Popen, and then calls the function
    onExit when the subprocess completes.
    onExit is a callable object, and popenArgs is a list/tuple of args that 
    would give to subprocess.Popen.
    """
    def runInThread(onExit, popenArgs):
        # proc = subprocess.Popen(popenArgs, stdout=subprocess.PIPE)
        # proc.wait()
        # stdout = proc.communicate()
        out = subprocess.check_output(popenArgs)
        onExit(out.decode("utf-8"))
        return
    thread = threading.Thread(target=runInThread, args=(onExit, popenArgs))
    thread.start()
    # returns immediately after the thread starts
    return thread