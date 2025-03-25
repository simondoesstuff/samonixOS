#!/bin/bash

# Optimized search for markdown files with time-tracker code blocks
find_tracker_files() {
  local search_dir="${1:-.}"
	grep -rl --exclude-dir=.trash --include='*.md' '^```simple-time-tracker$' "$search_dir" 2>/dev/null
}

has_active_entry() {
  local file="$1"
  json_content=$(awk '/^```simple-time-tracker$/{flag=1;next} /^```$/{flag=0} flag' "$file")
  if echo "$json_content" | jq -e '.entries[] | select(.endTime == null)' >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

add_start_time() {
  local file="$1"
  local timestamp
	timestamp=$(python -c 'from datetime import datetime, timezone; print(datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3] + "Z")')
  local tmp_file
  tmp_file=$(mktemp)

  # Check for existing code block markers
  if grep -q '^```simple-time-tracker$' "$file" && grep -q '^```$' "$file"; then
    # Extract content between markers
    json_content=$(awk '/^```simple-time-tracker$/{flag=1;next} /^```$/{flag=0} flag' "$file")

    # Validate JSON or initialize empty structure
    if ! echo "$json_content" | jq -e . >/dev/null 2>&1; then
      json_content='{"entries": []}'
    fi

    # Check for active entries
    if echo "$json_content" | jq -e '.entries[] | select(.endTime == null)' >/dev/null 2>&1; then
      echo "Active entry exists. End it first."
      return 1
    fi

    # Update JSON with new entry
    updated_json=$(echo "$json_content" | jq --arg ts "$timestamp" '.entries += [{"name":"Shell Entry","startTime":$ts,"endTime":null}]')

    # Create temp file with updated JSON
    json_temp=$(mktemp)
    echo "$updated_json" > "$json_temp"

    # Rebuild the markdown file
    awk -v json_temp="$json_temp" '
      /^```simple-time-tracker$/ {
        print;
        in_block=1;
        while ((getline line < json_temp) > 0) { print line }
        close(json_temp);
        next;
      }
      in_block && /^```$/ { print; in_block=0; next }
      !in_block { print }
    ' "$file" > "$tmp_file"
    rm "$json_temp"
  else
    # Create new code block with initial entry
    {
      cat "$file"
      printf "\n\`\`\`simple-time-tracker\n"
      jq -n --arg ts "$timestamp" '{entries: [{name: "Initial Entry", startTime: $ts, endTime: null}]}'
      printf "\n\`\`\`\n"
    } > "$tmp_file"
  fi

  mv "$tmp_file" "$file"
  echo "Added new entry to $file"
}

end_active_entry() {
  local file="$1"
	local timestamp
	timestamp=$(python -c 'from datetime import datetime, timezone; print(datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3] + "Z")')
	local tmp_file
  tmp_file=$(mktemp)

  # Extract and update JSON
  json_content=$(awk '/^```simple-time-tracker$/{flag=1;next} /^```$/{flag=0} flag' "$file")
  updated_json=$(echo "$json_content" | jq --arg ts "$timestamp" '
    .entries |= map(if .endTime == null then .endTime = $ts else . end)
  ')
  json_temp=$(mktemp)
  echo "$updated_json" > "$json_temp"

  # Rebuild file with temporary JSON
  awk -v json_temp="$json_temp" '
    /^```simple-time-tracker$/ {
      print;
      in_block=1;
      while ((getline line < json_temp) > 0) { print line }
      close(json_temp);
      next;
    }
    in_block && /^```$/ { print; in_block=0; next }
    !in_block { print }
  ' "$file" > "$tmp_file"
  rm "$json_temp"

  mv "$tmp_file" "$file"
  echo "Ended active entry in $file"
}

main() {
	local search_dir="${1:-${DEFAULT_SEARCH_PATH:-.}}"

  command -v jq >/dev/null || { echo "Install jq"; exit 1; }
  command -v fzf >/dev/null || { echo "Install fzf"; exit 1; }

  # declare -a file_list
  while IFS= read -r file; do
    status="inactive"
    has_active_entry "$file" && status="active"
    printf "%s\t%s\n" "$file" "$status"
  done < <(find_tracker_files "$search_dir") | sort -u > /tmp/file_list

  if [ ! -s /tmp/file_list ]; then
    echo "No tracker files found"
    exit 0
  fi

	# shellcheck disable=SC2016
	selected=$(fzf --delimiter=$'\t' --with-nth=1,2 \
	--preview 'visualize-timetrack {1}' \
	< /tmp/file_list)

  if [ -n "$selected" ]; then
    selected_file=$(echo "$selected" | cut -d$'\t' -f1)
    status=$(echo "$selected" | cut -d$'\t' -f2)

    if [[ "$status" == "active" ]]; then
      read -r -p "End active entry? (y/n): " choice
      [[ "$choice" == "y" ]] && end_active_entry "$selected_file"
    else
      add_start_time "$selected_file"
    fi
  fi
}

main "$@"
