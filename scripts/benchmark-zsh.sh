#!/usr/bin/env bash
# Benchmark zsh startup time with zinit

set -e

echo "=== ZSH Startup Benchmark ==="
echo ""

# Check if hyperfine is available (better benchmarking)
if command -v hyperfine &> /dev/null; then
    echo "Using hyperfine for accurate benchmarking..."
    hyperfine --warmup 3 --runs 10 'zsh -i -c exit'
else
    echo "Running simple benchmark (10 iterations)..."
    echo "Install 'hyperfine' for more accurate results: https://github.com/sharkdp/hyperfine"
    echo ""

    total=0
    runs=10

    for i in $(seq 1 $runs); do
        # Use date for timing (more portable than /usr/bin/time)
        start=$(date +%s%N)
        zsh -i -c exit 2>/dev/null
        end=$(date +%s%N)

        # Calculate milliseconds
        elapsed=$(( (end - start) / 1000000 ))
        total=$((total + elapsed))

        printf "  Run %2d: %4d ms\n" "$i" "$elapsed"
    done

    avg=$((total / runs))
    echo ""
    echo "  Average: ${avg} ms (${runs} runs)"
fi

echo ""
echo "=== Zinit Plugin Load Times ==="
zsh -i -c 'zinit times'

echo ""
echo "=== Detailed Profiling with zprof ==="
echo "To enable detailed profiling, add to the TOP of your .zshrc:"
echo "  zmodload zsh/zprof"
echo ""
echo "Then run:"
echo "  zsh -i -c zprof"
