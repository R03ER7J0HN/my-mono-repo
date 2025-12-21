#!/bin/bash

# =============================================================================
# generate_secrets.sh
# =============================================================================
# 
# PURPOSE:
#   Generates platform-specific secret configuration files from a single source.
#   This keeps API keys out of version control while providing a consistent
#   developer experience across the team.
#
# SECURITY NOTE:
#   This script does NOT secure API keys in the final app binary. Anyone can
#   decompile the APK/IPA and extract them. Real security comes from:
#   - Google Cloud Console API key restrictions (package name, SHA-1, bundle ID)
#   - You should have already configured these restrictions!
#
# USAGE:
#   Local development:
#     1. Copy secrets.json.example to secrets.json
#     2. Fill in your API keys
#     3. Run: ./scripts/generate_secrets.sh
#     4. Run app: flutter run --dart-define-from-file=secrets.json
#
#   CI/CD:
#     1. Set environment variables: GOOGLE_MAPS_API_KEY, ANDROID_SHA1
#     2. Run: ./scripts/generate_secrets.sh
#     3. Build: flutter build apk --dart-define=GOOGLE_MAPS_API_KEY=$GOOGLE_MAPS_API_KEY
#
# GENERATED FILES (all gitignored):
#   - ios/Flutter/Secrets.xcconfig    → Used by Xcode build system
#   - android/secrets.properties      → Used by Gradle build system
#
# =============================================================================

# -----------------------------------------------------------------------------
# SHELL OPTIONS
# -----------------------------------------------------------------------------
# -e : Exit immediately if any command returns a non-zero status.
#      This prevents the script from continuing after an error.
set -e

# -----------------------------------------------------------------------------
# DIRECTORY RESOLUTION
# -----------------------------------------------------------------------------
# Get the absolute path to the directory containing this script.
# - ${BASH_SOURCE[0]} : Path to this script (may be relative)
# - dirname           : Extracts the directory portion
# - cd ... && pwd     : Converts to absolute path
# - $(...)            : Command substitution - captures the output
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the project root directory (parent of scripts/)
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# -----------------------------------------------------------------------------
# TERMINAL COLORS (ANSI escape codes)
# -----------------------------------------------------------------------------
# These codes colorize terminal output for better readability.
# Format: \033[<style>;<color>m
#   - 0 = normal, 1 = bold
#   - 31 = red, 32 = green, 33 = yellow
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # NC = No Color (resets formatting)

echo -e "${YELLOW}Generating native secret configuration files...${NC}"

# -----------------------------------------------------------------------------
# READ SECRETS
# -----------------------------------------------------------------------------
# Priority: secrets.json (local dev) > environment variables (CI/CD)
#
# This dual-source approach allows:
# - Local devs: Use secrets.json (gitignored, not committed)
# - CI/CD: Use environment variables (set in pipeline config)
# -----------------------------------------------------------------------------
SECRETS_FILE="$PROJECT_DIR/secrets.json"

# -f : Tests if the path is a regular file (not a directory)
if [ -f "$SECRETS_FILE" ]; then
    echo -e "${GREEN}Reading from secrets.json${NC}"
    
    # Extract values from JSON using grep and sed (no jq dependency required)
    # 
    # Pattern breakdown:
    #   grep -o '...'     : Only print the matching portion
    #   [[:space:]]*      : Match zero or more whitespace characters
    #   [^"]*             : Match any characters except quotes
    #   sed 's/.../\1/'   : Extract the captured group (the value)
    #
    # Example: "GOOGLE_MAPS_API_KEY": "abc123" → abc123
    GOOGLE_MAPS_API_KEY=$(cat "$SECRETS_FILE" | grep -o '"GOOGLE_MAPS_API_KEY"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
    ANDROID_SHA1=$(cat "$SECRETS_FILE" | grep -o '"ANDROID_SHA1"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
else
    echo -e "${YELLOW}secrets.json not found, using environment variables${NC}"
    # If secrets.json doesn't exist, the script will use environment variables.
    # These should already be set by CI/CD pipeline (e.g., GitHub Actions secrets).
fi

# -----------------------------------------------------------------------------
# VALIDATION
# -----------------------------------------------------------------------------
# Ensure all required secrets are available before generating config files.
# -z : Tests if string is empty (zero length)
# -----------------------------------------------------------------------------
if [ -z "$GOOGLE_MAPS_API_KEY" ]; then
    echo -e "${RED}Error: GOOGLE_MAPS_API_KEY is not set${NC}"
    echo "Either create secrets.json or set the GOOGLE_MAPS_API_KEY environment variable"
    exit 1  # Exit with error code 1 (non-zero = failure)
fi

if [ -z "$ANDROID_SHA1" ]; then
    echo -e "${RED}Error: ANDROID_SHA1 is not set${NC}"
    echo "Either create secrets.json or set the ANDROID_SHA1 environment variable"
    exit 1
fi

# -----------------------------------------------------------------------------
# GENERATE iOS CONFIGURATION
# -----------------------------------------------------------------------------
# Xcode uses .xcconfig files for build settings.
# This file is included by Debug.xcconfig and Release.xcconfig.
# The GOOGLE_MAPS_API_KEY variable is then available in Info.plist as $(GOOGLE_MAPS_API_KEY)
# -----------------------------------------------------------------------------
IOS_SECRETS_FILE="$PROJECT_DIR/ios/Flutter/Secrets.xcconfig"
echo -e "${GREEN}Generating $IOS_SECRETS_FILE${NC}"

# Here document (<<EOF...EOF): Write multi-line content to file
# cat > file : Redirects output to file (overwrites if exists)
# Variables inside here-doc are expanded (replaced with their values)
cat > "$IOS_SECRETS_FILE" << EOF
// =============================================================================
// Secrets.xcconfig
// =============================================================================
// AUTO-GENERATED by scripts/generate_secrets.sh
// DO NOT EDIT MANUALLY - your changes will be overwritten
// DO NOT COMMIT TO VERSION CONTROL - this file is gitignored
// =============================================================================

GOOGLE_MAPS_API_KEY=$GOOGLE_MAPS_API_KEY
EOF

# -----------------------------------------------------------------------------
# GENERATE ANDROID CONFIGURATION
# -----------------------------------------------------------------------------
# Gradle reads .properties files for build configuration.
# In build.gradle.kts, we load this file and expose values as:
# - manifestPlaceholders (for AndroidManifest.xml)
# - buildConfigField (for Java/Kotlin code)
# -----------------------------------------------------------------------------
ANDROID_SECRETS_FILE="$PROJECT_DIR/android/secrets.properties"
echo -e "${GREEN}Generating $ANDROID_SECRETS_FILE${NC}"

cat > "$ANDROID_SECRETS_FILE" << EOF
# =============================================================================
# secrets.properties
# =============================================================================
# AUTO-GENERATED by scripts/generate_secrets.sh
# DO NOT EDIT MANUALLY - your changes will be overwritten
# DO NOT COMMIT TO VERSION CONTROL - this file is gitignored
# =============================================================================

GOOGLE_MAPS_API_KEY=$GOOGLE_MAPS_API_KEY
ANDROID_SHA1=$ANDROID_SHA1
EOF

# -----------------------------------------------------------------------------
# SUCCESS OUTPUT
# -----------------------------------------------------------------------------
echo -e "${GREEN}✓ Secret configuration files generated successfully!${NC}"
echo ""
echo "Generated files:"
echo "  - ios/Flutter/Secrets.xcconfig"
echo "  - android/secrets.properties"
echo ""
echo -e "${YELLOW}Remember: These files are gitignored and should not be committed.${NC}"
echo ""
echo "Next steps:"
echo "  flutter run --dart-define-from-file=secrets.json"
