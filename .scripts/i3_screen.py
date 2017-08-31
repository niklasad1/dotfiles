#!/usr/bin/python3

import sys
import subprocess
import copy
import time


def execute_cmd(cmd):
    process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
    try:
        output, error = process.communicate()
    except:
        raise Exception("Process error ")
    return output


def status_changed(current, new):
    if len(current) != len(new):
        return True
    else:
        for i in range(0, len(current)):
            if current[i] != new[i]:
                return True
    return False


def change_output(active_screens):
    if len(active_screens) > 1:
        tmp = copy.deepcopy(active_screens)
        tmp.remove("eDP-1")
        for (i, screen) in enumerate(tmp):
            if i == 0:
                print("enable output: {}".format(screen))
                execute_cmd("xrandr --output {} --auto --primary"
                            .format(screen))
            else:
                print("enable output: {}".format(screen))
                execute_cmd("xrandr --output {} --auto".format(screen))
        execute_cmd("xrandr --output eDP-1 --off")
    else:
        print("enable output: eDP-1")
        execute_cmd("xrandr --output eDP-1 --auto")


def main():
    active_screens = []

    if len(sys.argv) != 1:
        raise Exception("Syntax: python i3_screen_check.py")

    while True:
        time.sleep(1)
        output = execute_cmd("xrandr")

        if output is None:
            raise Exception("Invalid command")
        else:
            output_str = output.decode('ascii').split('\n')
            new_status = []

            for s in output_str:
                words = s.split()
                if len(words) >= 2 and words[1].lower() == "connected":
                    new_status.append(words[0])
                    new_status.sort()

            if status_changed(active_screens, new_status) is True:
                active_screens = new_status
                change_output(active_screens)


if __name__ == "__main__":
    main()
