#!/usr/bin/env python3
import datetime
import json
import sys
from datetime import datetime as dt
from datetime import timezone

# ANSI color codes
RESET = "\033[0m"
BOLD = "\033[1m"
CYAN = "\033[96m"
GREEN = "\033[92m"
BLUE = "\033[94m"
YELLOW = "\033[93m"
WHITE = "\033[97m"
DIM_WHITE = "\033[37m"
RED = "\033[91m"


def parse_time(time_str):
    parsed = dt.strptime(time_str, "%Y-%m-%dT%H:%M:%S.%fZ")
    return parsed.replace(tzinfo=timezone.utc)


def visualize_entries(json_data):
    try:
        if not json_data.strip():
            json_data = '{"entries": []}'

        data = json.loads(json_data)
        entries = data.get("entries", [])

        total_time = datetime.timedelta()
        for entry in entries:
            if "startTime" in entry:
                start = parse_time(entry["startTime"])
                end = (
                    parse_time(entry["endTime"])
                    if entry.get("endTime")
                    else dt.now(timezone.utc)
                )
                total_time += end - start

        # Print summary with colors
        print(f"{BOLD}{CYAN}Total entries:{RESET} {WHITE}{len(entries)}{RESET}")
        hours, remainder = divmod(total_time.total_seconds(), 3600)
        minutes, seconds = divmod(remainder, 60)
        print(
            f"{BOLD}{CYAN}Total time tracked:{RESET} "
            f"{YELLOW}{int(hours)}h {int(minutes)}m {int(seconds)}s{RESET}\n"
        )

        last_entries = entries[-10:]
        entry_list = []

        for entry in last_entries:
            if "startTime" in entry:
                start = parse_time(entry["startTime"])
                end = (
                    parse_time(entry["endTime"])
                    if entry.get("endTime")
                    else dt.now(timezone.utc)
                )
                duration = end - start
                duration_sec = duration.total_seconds()

                name = entry.get("name", "Unnamed")
                start_str = start.strftime("%Y-%m-%d %H:%M")
                status = "active" if not entry.get("endTime") else "completed"
                end_str = end.strftime("%H:%M") if status == "completed" else "ongoing"

                hours_entry, rem = divmod(duration_sec, 3600)
                mins_entry, secs_entry = divmod(rem, 60)
                duration_str = (
                    f"{int(hours_entry)}h {int(mins_entry)}m {int(secs_entry)}s"
                )

                entry_list.append(
                    {
                        "name": name,
                        "start_str": start_str,
                        "end_str": end_str,
                        "status": status,
                        "duration_str": duration_str,
                        "duration_sec": duration_sec,
                    }
                )

        # Visualization
        print(f"{BOLD}{CYAN}Time Distribution (last 10 entries):{RESET}")
        print(f"{CYAN}{'─' * 60}{RESET}")

        max_duration = max(e["duration_sec"] for e in entry_list) if entry_list else 0

        for entry in entry_list:
            bar_length = (
                int((entry["duration_sec"] / max_duration) * 50) if max_duration else 0
            )
            bar_length = min(bar_length, 50)

            # Entry line
            name_part = f"{BOLD}{WHITE}{entry['name']}{RESET}"
            time_range = (
                f"{DIM_WHITE}({entry['start_str']} - {entry['end_str']}){RESET}"
            )
            duration = f"{YELLOW}[{entry['duration_str']}]{RESET}"
            print(f"{name_part} {time_range} {duration}")

            # Bar line
            if entry["status"] == "active":
                symbol = f"{GREEN}▶{RESET}"
                bar_color = GREEN
                print(
                    f"{symbol} {bar_color}{'■' * bar_length}{RESET} {GREEN}(ongoing){RESET}"
                )
            else:
                symbol = f"{BLUE}✓{RESET}"
                bar_color = BLUE
                print(f"{symbol} {bar_color}{'■' * bar_length}{RESET}")

        print(f"{CYAN}{'─' * 60}{RESET}")

    except json.JSONDecodeError:
        print(f"{GREEN}Initializing fresh time tracker{RESET}\n")
    except Exception as e:
        print(f"{RED}Error visualizing data: {str(e)}{RESET}")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        file_path = sys.argv[1]
        try:
            with open(file_path, "r") as f:
                content = f.read()
                start_marker = "```simple-time-tracker"
                end_marker = "```"
                if start_marker in content and end_marker in content:
                    start_idx = content.find(start_marker) + len(start_marker)
                    end_idx = content.find(end_marker, start_idx)
                    json_content = content[start_idx:end_idx].strip()
                    visualize_entries(json_content)
                else:
                    print(f"{YELLOW}No time-tracker data found in file{RESET}")
        except Exception as e:
            print(f"{RED}Error reading file: {str(e)}{RESET}")
    else:
        print(f"{RED}Please provide a file path{RESET}")
