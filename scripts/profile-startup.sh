#!/usr/bin/env bash
# Profile full zsh startup to identify slow sections

set -e

echo "=== Full ZSH Startup Profiling ==="
echo ""

# Add profiling to .zshrc temporarily
TEMP_ZSHRC=$(mktemp)
cat > "$TEMP_ZSHRC" << 'PROFILE_EOF'
zmodload zsh/zprof
typeset -F SECONDS=0

# Source the real .zshrc
source ~/.zshrc

# Show results
echo ""
echo "=== Total startup time: ${SECONDS}s ==="
echo ""
echo "Top 10 slowest functions:"
zprof | head -20
PROFILE_EOF

echo "Running profiled zsh startup..."
echo ""

# Run with profiling
zsh -c "source $TEMP_ZSHRC"

rm -f "$TEMP_ZSHRC"

echo ""
echo "=== Quick timing test (5 runs) ==="
for i in {1..5}; do
    printf "Run %d: " "$i"
    /usr/bin/time -f "%E" zsh -i -c exit 2>&1 | tail -1
done
