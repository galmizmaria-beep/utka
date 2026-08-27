#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
for file in index.html app.js styles.css enhancements.js enhancements.css v5.css; do
  test -s "$file" || { echo "Missing $file"; exit 1; }
done
grep -q 'schemaVersion:5' app.js
grep -q 'window.EditorV5' app.js
grep -q 'runV5PreviewStabilityTest' enhancements.js
grep -q 'data-preview="title"' index.html
grep -q 'data-preview="helper"' index.html
grep -q 'data-preview="task"' index.html
grep -q 'id="v5TaskBg"' index.html
grep -q 'id="v5HelperShape"' index.html
grep -q 'id="v5HudBg"' index.html
grep -q 'id="v6HelperWidth"' index.html
grep -q 'id="v6CheckBg"' index.html
grep -q 'id="v6CrosshairSize"' index.html
grep -q 'particle-lightning' v5.css
grep -q 'config.crosshair' enhancements.js
grep -q 'let state=fresh()' app.js
grep -q 'id="simultaneousTargets"' index.html
grep -q 'id="lightenProject"' index.html
grep -q 'lightenObject' enhancements.js
grep -q '__editorPreviewScreen' app.js
grep -q 'title="Меткий ответ"' enhancements.js
if grep -Eq 'location\.reload|iframe\.srcdoc[[:space:]]*=' enhancements.js; then
  echo 'Forbidden preview/export reload pattern found'
  exit 1
fi
ruby -e 's=File.read("index.html");a=s.scan(/id="([^"]+)"/).flatten;h=Hash.new(0);a.each{|x|h[x]+=1};d=h.select{|_,v|v>1};abort("Duplicate IDs: #{d}") unless d.empty?'
echo 'V5 smoke checks passed'
