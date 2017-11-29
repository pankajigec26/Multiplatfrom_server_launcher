from subprocess import Popen 
from subprocess import Popen, CREATE_NEW_CONSOLE,PIPE,STDOUT
import time
import subprocess
import platform
import os
import signal
#K option tells cmd to run the command and keep the command window from closing. You may use /C instead to close the command window after the command finishes.


def windows_open_appium(*args):
        global test
        test=[]
        print 'hi'
        if platform.system()=='Windows':
            for item in args:
                for port in item:
                    terminal='cmd'
                    command='appium -p'
                    command=terminal+' '+'/K' +' '+ command+' '+str(port)
                    print command
                    server_start=Popen(command,creationflags=CREATE_NEW_CONSOLE)
                    test.extend([server_start.pid])
        return test

        if platform.system()=='Linux':
            global linux_window
            command='appium -p'
            linux_terminal=['gnome-terminal']
            for item in args:
                for port in item:
                    linux_terminal.extend((['--tab','--disable-factory','-e', '''
                    bash -c '
                    echo "%(command)s %(port)s"
                    %(command)s "%(port)s"
                    read
                    '    
                    ''' % locals()]))
            linux_window=Popen(terminal,preexec_fn=os.setpgrp)

            
            
def kill_appium():
    import time
    time.sleep(10)
    if platform.system()=='Windows':
        for item in test:
                subprocess.Popen('taskkill /F /T /PID %i' % item)
       
    if platform.system()=='Linux':
        os.killpg(linux_window.pid,signal.SIGINT)