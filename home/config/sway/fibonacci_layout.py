#!/usr/bin/env python
# Created by olemartinorg https://github.com/olemartinorg/sway-alternating-layout/blob/master/alternating_layouts.py

import getopt
import os
import sys

from i3ipc import Connection, Event


def find_parent(sway, window_id):
    """
    Find the parent of a given window id
    """

    def finder(con, parent):
        if con.id == window_id:
            return parent
        for node in con.nodes:
            res = finder(node, con)
            if res:
                return res
        return None

    return finder(sway.get_tree(), None)


def set_layout(sway, e):
    """
    Set the layout/split for the currently
    focused window to either vertical or
    horizontal, depending on its width/height
    """
    win = sway.get_tree().find_focused()
    parent = find_parent(sway, win.id)

    if parent and parent.layout != "tabbed" and parent.layout != "stacked":
        if win.rect.height > win.rect.width:
            if parent.orientation == "horizontal":
                sway.command("split v")
        else:
            if parent.orientation == "vertical":
                sway.command("split h")


def print_help():
    print("Usage: " + sys.argv[0] + " [-p path/to/pid.file]")
    print("")
    print("Options:")
    print(
        "    -p path/to/pid.file   Saves the PID for this program in the filename specified"
    )
    print("")


def main():
    """
    Main function - listen for window focus
        changes and call set_layout when focus
        changes
    """
    opt_list, _ = getopt.getopt(sys.argv[1:], "hp:")
    pid_file = None
    for opt in opt_list:
        if opt[0] == "-h":
            sys.exit()
        if opt[0] == "-p":
            pid_file = opt[1]

    if pid_file:
        with open(pid_file, "w") as f:
            f.write(str(os.getpid()))

    sway = Connection()
    sway.on(Event.WINDOW_FOCUS, set_layout)
    sway.main()


if __name__ == "__main__":
    main()
