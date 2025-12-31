#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# ANSI color codes
RED='\033[31m'
RESET='\033[0m'

# List of features (feature_path:class_name)
# For nested paths, specify the class name explicitly
FEATURES=("auth:Auth" "home:Home" "splash:Splash" "jobs/job_interviews:JobInterviews")

# Loop through each feature
for ENTRY in "${FEATURES[@]}"
do
    # Split the entry by ':'
    FEATURE="${ENTRY%%:*}"
    CLASS_NAME="${ENTRY##*:}"
    
    ARB_DIR="lib/features/$FEATURE/l10n"
    OUTPUT_DIR="lib/features/$FEATURE/l10n/gen"
    
    # Check if ARB directory exists
    if [ ! -d "$ARB_DIR" ]; then
        echo -e "${RED}Error: ARB directory '$ARB_DIR' does not exist. Stopping.${RESET}"
        exit 1
    fi

    # Find the template ARB (assumes en locale)
    TEMPLATE=$(find "$ARB_DIR" -name "*_en.arb" | head -n 1)

    if [ -z "$TEMPLATE" ]; then
        echo -e "${RED}Error: No template ARB file (*_en.arb) found in '$ARB_DIR'. Stopping.${RESET}"
        exit 1
    fi
    
    echo "Generating localization for $FEATURE using template $(basename "$TEMPLATE")..."
    
    # Run Flutter gen-l10n and check for errors
    if ! flutter gen-l10n \
      --arb-dir="$ARB_DIR" \
      --output-dir="$OUTPUT_DIR" \
      --template-arb-file="$(basename "$TEMPLATE")" \
      --no-nullable-getter \
      --output-class="${CLASS_NAME}Localizations"; then
        echo -e "${RED}Error: Flutter gen-l10n failed for feature '$FEATURE'. Stopping.${RESET}"
        exit 1
    fi

    echo "Localization generated successfully for $FEATURE."
done

echo "All localizations generated successfully!"
