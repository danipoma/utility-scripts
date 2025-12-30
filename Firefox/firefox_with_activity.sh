#!/bin/sh
# Runs Firefox with Activity profile based on KDE Activity Manager.

# Fetch Activity Name, lowercase it, and strip leading numbers
firefox_profile="profile-$(qdbus org.kde.ActivityManager /ActivityManager/Activities ActivityName `qdbus org.kde.ActivityManager /ActivityManager/Activities CurrentActivity` | tr '[:upper:]' '[:lower:]' | sed -E "s/^[0-9]{1,3}\-//")"

# echo "Using profile: $firefox_profile"

# If no URLs are provided, default to a new tab
if [ "$#" -eq 0 ]; then
    set -- "about:newtab"
fi

# echo "Opening target: $@"

# Launch Firefox
firefox -P "$firefox_profile" --new-tab "$@"
