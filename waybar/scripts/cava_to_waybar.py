#!/usr/bin/env python3
import subprocess
import sys
import shutil
import select
import time
import os
import re

CAVA_CONF = "/home/aditya/.config/cava/config"

if shutil.which("cava") is None:
    print("cava not found")
    sys.exit(1)

BLOCKS = [" ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]

# Candidate cava invocations to try (various flag orders)
# Try safe invocations: prefer explicit config, then fallback to default cava
CANDIDATES = [
    ["cava", "-p", CAVA_CONF],
    ["cava"]
]


def probe_command(cmd):
    try:
        proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    except Exception as e:
        return None, str(e)

    # wait briefly for process to either emit a line or exit with error
    for _ in range(10):
        if proc.poll() is not None:
            # exited quickly -> capture stderr
            stderr = proc.stderr.read() if proc.stderr else ""
            return None, stderr
        # check if there's data ready on stdout
        rlist, _, _ = select.select([proc.stdout], [], [], 0.2)
        if rlist:
            line = proc.stdout.readline()
            if not line:
                continue
            # if the line contains numbers separated by spaces, assume raw mode
            if re.search(r"\d", line):
                return proc, None
            # otherwise keep trying
            proc.terminate()
            return None, "no-numeric-output"
        time.sleep(0.05)

    # No output observed but process still running -> assume it's OK
    return proc, None


def choose_proc():
    last_err = None
    for cmd in CANDIDATES:
        proc, err = probe_command(cmd)
        if proc:
            print("[cava_to_waybar] chosen:", " ".join(cmd))
            return proc, cmd
        last_err = err
    print("[cava_to_waybar] failed to start cava:", last_err or "unknown")
    return None, None


def run(proc, cmd):
    # print a small diagnostic if no frames arrive
    no_frame_since = time.time()
    try:
        while True:
            rlist, _, _ = select.select([proc.stdout, proc.stderr], [], [], 0.5)
            if proc.stderr in rlist:
                errline = proc.stderr.readline()
                if errline:
                    sys.stderr.write(f"[cava stderr] {errline}")
                    sys.stderr.flush()
            if proc.stdout in rlist:
                raw = proc.stdout.readline()
                if not raw:
                    # process closed
                    break
                no_frame_since = time.time()
                line = raw.strip()
                if not line:
                    continue
                parts = line.split()
                vals = []
                for p in parts:
                    try:
                        vals.append(int(p))
                    except Exception:
                        pass
                if not vals:
                    continue

                maxv = max(vals)
                denom = maxv if maxv > 0 else 1

                out = []
                for v in vals:
                    idx = int((v * (len(BLOCKS) - 1)) / denom)
                    idx = max(0, min(idx, len(BLOCKS) - 1))
                    out.append(BLOCKS[idx])

                sys.stdout.write("".join(out) + "\n")
                sys.stdout.flush()

            # if no frames for >3s, print a notice (once)
            if time.time() - no_frame_since > 3:
                sys.stderr.write("[cava_to_waybar] no frames received yet...\n")
                sys.stderr.flush()
                no_frame_since = time.time()

            # exit if process ended
            if proc.poll() is not None:
                break
    except KeyboardInterrupt:
        proc.terminate()


def main():
    proc, cmd = choose_proc()
    if not proc:
        sys.exit(1)
    run(proc, cmd)


if __name__ == "__main__":
    main()
