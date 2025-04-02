#!/usr/bin/env bash

set -e

echo "Running rustfmt..."
cargo fmt 
cargo fmt --check

echo "Running taplo..."
taplo fmt
taplo fmt --check

echo "Running cargo check with all features..."
cargo check --all-features

echo "Running cargo test with all features..."
cargo test --all-features

echo "Pre-commit checks passed successfully!"

