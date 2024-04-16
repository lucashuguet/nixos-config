#!/usr/bin/env python 

import subprocess

def parse_wpctl_status():
    output = str(subprocess.check_output("wpctl status", shell=True, encoding='utf-8'))
    lines = output.replace("├", "").replace("─", "").replace("│", "").replace("└", "").splitlines()

    sinks_index = None
    for index, line in enumerate(lines):
        if "Sinks:" in line:
            sinks_index = index
            break

    sinks = []
    for line in lines[sinks_index +1:]:
        if not line.strip():
            break
        sinks.append(line.strip())

    sinks_dict = []

    for idx, sink in enumerate(sinks):
        res = {}

        res["master"] = sink.startswith("*")
        res["muted"] = "MUTED" in sink

        sink = sink.replace("*", "").replace("MUTED", "").strip()

        res["volume"] = float(sink.split("[vol:")[1].split("]")[0].strip())

        sink = sink.split("[vol:")[0].strip()

        res["id"] = int(sink.split(".")[0])
        res["name"] = sink.split(".")[1].strip()

        if len(sinks_dict) > 0:
            if sinks_dict[-1]["name"].replace(" - (current)", "") in res["name"]:
                continue

        if res["master"]:
            res["name"] += " - (current)"

        sinks_dict.append(res)

    return sinks_dict

if __name__ == "__main__":
    sinks = parse_wpctl_status()

    inputs = "\n".join([sink["name"] for sink in sinks])

    selected_name = subprocess.check_output(["rofi", "-dmenu"], text=True, input=inputs).strip()

    if not "current" in selected_name:
        sink = next((s["id"] for s in sinks if s["name"] == selected_name), None)
  
        if sink:
            subprocess.run(["mpc", "pause"])
            subprocess.run(["wpctl", "set-default", str(sink)])
            subprocess.run(["notify-send", "rofisink.py", "sink changed"])
        else:
            exit(1)
