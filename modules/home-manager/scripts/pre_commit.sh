#!/usr/bin/env bash

set -e

echo "Running rustfmt..."
cargo fmt --all -- --check

echo "Running taplo..."
taplo fmt --check

echo "Running cargo check with all features..."
cargo check --all-features

echo "Running cargo test with all features..."
cargo test --all-features

echo "Pre-commit checks passed successfully!"

