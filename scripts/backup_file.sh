#!/bin/bash

set -euo pipefail

file="$1"
backup_dir="archive/$(date +%Y-%m)"
metadata_file="archive/.backup_metadata.json"

# Create dated archive directory
mkdir -p "$backup_dir"

# Generate checksums for deduplication
file_hash=$(sha256sum "$file" | cut -d' ' -f1)

# Check if identical backup exists
if grep -q "$file_hash" "$metadata_file" 2>/dev/null; then
  echo "⚠️  Identical backup exists (checksum: ${file_hash:0:8})"
  exit 0
fi

# Find next version number
base=$(basename "$file" | sed 's/\.[^.]*$//')
ext="${file##*.}"
existing=$(find "$backup_dir" -name "${base}-v*.${ext}" 2>/dev/null | sed 's/.*-v//' | sed "s/\.${ext}//" | sort -n | tail -1)
version=$((existing + 1))

# Create versioned backup
backup="${backup_dir}/${base}-v${version}.${ext}"
cp "$file" "$backup"

# Record metadata
echo "{\"file\": \"$file\", \"backup\": \"$backup\", \"checksum\": \"$file_hash\", \"timestamp\": \"$(date -Iseconds)\", \"author\": \"$(git config user.name)\"}" >> "$metadata_file"

echo "✅ Backed up to $backup (v${version})"