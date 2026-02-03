#!/usr/bin/env python3

import subprocess
import json
import sys
import os

def run_command(command):
    try:
        if "|" in command:
            result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, text=True)
            return result.stdout.strip()
        else:
            args = command.split()
            result = subprocess.run(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            return result.stdout.strip()
    except Exception as e:
        return ""

def get_history():
    result = run_command("makoctl history")
    try:
        data = json.loads(result)
        all_notifs = []
        if 'data' in data and isinstance(data['data'], list):
            for group in data['data']:
                if isinstance(group, list):
                    for notif in group:
                        all_notifs.append(notif)
                else:
                    all_notifs.append(group)
        return all_notifs
    except json.JSONDecodeError:
        return []

def format_entry(notif):
    app = notif.get('app-name', 'Unknown')
    summary = notif.get('summary', '').replace('\n', ' ')
    body = notif.get('body', '').replace('\n', ' ')
    
    display = f"{app}: {summary} - {body}"
    if len(display) > 90:
        display = display[:87] + "..."
    
    return display

def main():
    history = get_history()
    
    OPT_CLEAR = "  Dismiss All"
    OPT_DISMISS = "󰂛  Dismiss Last"
    OPT_RESTORE = "󰃢  Restore Last"
    SEPARATOR = "────────────────────────"
    
    menu_lines = [OPT_CLEAR, OPT_DISMISS, OPT_RESTORE]
    display_notifs = []
    
    if history:
        menu_lines.append(SEPARATOR)
        for n in history:
            display_notifs.append(format_entry(n))
        menu_lines.extend(display_notifs)
    else:
        menu_lines.append(SEPARATOR)
        menu_lines.append("(No recent notifications)")

    input_str = "\n".join(menu_lines)
    
    try:
        p = subprocess.Popen(["fuzzel", "-d", "-l", "20", "-w", "50", "-p", "Notifications: "], 
                             stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        selected, _ = p.communicate(input=input_str)
        selected = selected.strip()
    except Exception:
        return

    if not selected:
        return

    if selected == OPT_CLEAR:
        os.system("makoctl dismiss -a")
    elif selected == OPT_DISMISS:
        os.system("makoctl dismiss")
    elif selected == OPT_RESTORE:
        os.system("makoctl restore")
    elif selected == SEPARATOR or selected == "(No recent notifications)":
        pass
    else:
        try:
            index = display_notifs.index(selected)
            notif = history[index]
            
            body = notif.get('body', '')
            summary = notif.get('summary', '')
            text_to_copy = f"{summary}\n{body}"
            
            p_copy = subprocess.Popen(['wl-copy'], stdin=subprocess.PIPE)
            p_copy.communicate(input=text_to_copy.encode('utf-8'))
            
            os.system(f"notify-send 'Copied' 'Notification content copied to clipboard.'")
        except ValueError:
            pass

if __name__ == "__main__":
    main()
