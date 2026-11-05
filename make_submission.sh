#!/bin/bash
# Builds submission/ (handout section 7.2) from git-tracked files
set -e

OUT=submission/lab3_src_06
rm -rf "$OUT" submission/lab3_src_06.zip
mkdir -p "$OUT/sw" "$OUT/hw"

copy_tracked() {
    git ls-files "$1" | while read -r f; do
        mkdir -p "$2/$(dirname "${f#$1/}")"
        cp "$f" "$2/${f#$1/}"
    done
}
copy_tracked software_testing "$OUT/sw"
copy_tracked staged_mac "$OUT/hw/staged_mac"
copy_tracked piped_mac "$OUT/hw/piped_mac"
cp report/lab3_report_06.pdf submission/lab3_report_06.pdf

(cd "$OUT" && zip -qr -X ../lab3_src_06.zip sw hw)
echo "sw: $(find "$OUT/sw" -type f | wc -l | tr -d ' ') files, staged_mac: $(find "$OUT/hw/staged_mac" -type f | wc -l | tr -d ' '), piped_mac: $(find "$OUT/hw/piped_mac" -type f | wc -l | tr -d ' ')"
ls -la submission | awk 'NR>3 {print $5, $9}'
