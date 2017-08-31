#!/usr/bin/python3

import os
import sys
import subprocess

os_package_managers = {}


def init_package_managers():
    os_package_managers["ubuntu"] = ["sudo apt-get update",
                                     "sudo apt-get upgrade -y",
                                     "sudo apt-get autoremove -y"]
    os_package_managers["arch"] = ["pacman -Syu"]


def execute_cmd(cmds):
    for cmd in cmds:
        try:
            process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
            output, error = process.communicate()
            if error:
                return False
        except OSError as e:
            raise Exception("OSError {}".format(e))
            return False
    return True


def main():
    if len(sys.argv) != 1:
        raise Exception("Syntax: ./update.py")

    init_package_managers()
    print("Do you want to update your system? [Y/N] ")
    response = sys.stdin.read(1)
    if response.lower()[0] is "y":
        success = False
        uname = os.uname()[3].lower()
        if "ubuntu" in uname:
            success = execute_cmd(os_package_managers["ubuntu"])
        elif "arch" in uname:
            success = execute_cmd(os_package_managers["arch"])
        else:
            raise Exception("Operating System is not supported")
        if success is True:
            print("{} \t update successful!!!".format(uname))


if __name__ == "__main__":
    main()
