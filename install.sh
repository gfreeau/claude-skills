#!/bin/bash
#
# Install Claude Code skills by symlinking to ~/.claude/skills/
#
# Usage:
#   ./install.sh          # Install all skills
#   ./install.sh --remove # Remove symlinks (uninstall)
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DST="$CLAUDE_DIR/skills"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check prerequisites
check_prerequisites() {
    if ! command -v yt-dlp &> /dev/null; then
        warn "yt-dlp not found. Install with: pipx install yt-dlp"
        warn "Skills will be installed but transcript fetching won't work without yt-dlp"
    else
        info "yt-dlp found: $(which yt-dlp)"
    fi
}

# Install skills
install_skills() {
    info "Installing skills to $SKILLS_DST"

    mkdir -p "$SKILLS_DST"

    for skill_dir in "$SKILLS_SRC"/*/; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            target="$SKILLS_DST/$skill_name"

            # Remove existing symlink or directory
            if [ -L "$target" ]; then
                rm "$target"
                info "Removed existing symlink: $skill_name"
            elif [ -d "$target" ]; then
                warn "Directory exists at $target - skipping (remove manually if you want to replace)"
                continue
            fi

            # Create symlink
            ln -s "$skill_dir" "$target"
            info "Linked: $skill_name -> $target"
        fi
    done

    echo ""
    info "Installation complete!"
    echo ""
    echo "Skills installed:"
    ls -la "$SKILLS_DST"
}

# Remove skills
remove_skills() {
    info "Removing skills from $SKILLS_DST"

    for skill_dir in "$SKILLS_SRC"/*/; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            target="$SKILLS_DST/$skill_name"

            if [ -L "$target" ]; then
                rm "$target"
                info "Removed: $skill_name"
            else
                warn "Not a symlink or doesn't exist: $target"
            fi
        fi
    done

    info "Removal complete!"
}

# Main
case "${1:-}" in
    --remove|-r)
        remove_skills
        ;;
    --help|-h)
        echo "Usage: $0 [--remove]"
        echo ""
        echo "Install Claude Code skills by symlinking to ~/.claude/skills/"
        echo ""
        echo "Options:"
        echo "  --remove, -r    Remove installed symlinks"
        echo "  --help, -h      Show this help"
        ;;
    *)
        check_prerequisites
        install_skills
        ;;
esac
