#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
for file in index.html app.js v8.js v8.css; do
  test -s "$file" || { echo "Missing $file"; exit 1; }
done
grep -q 'Меткий ответ V8' index.html
grep -q 'src="v8.js"' index.html
grep -q 'schemaVersion=8' v8.js
grep -q 'difficultyDefaults' v8.js
grep -q 'page-difficulty' v8.js
grep -q 'page-rounds' v8.js
grep -q 'v8RoundTaskSource' v8.js
grep -q 'METKIY_OTVET_READY' app.js
grep -q 'EditorV8.*activateRound' app.js
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("v8.js",4,null).js; new Function(s)' >/dev/null
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("app.js",4,null).js; new Function(s)' >/dev/null
echo 'V8 smoke checks passed'
