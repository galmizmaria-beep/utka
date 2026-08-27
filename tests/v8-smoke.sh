#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
for file in index.html game.html app.js v8.js v8.css; do
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
grep -q "player=1" game.html
grep -q 'copyGeniallyCode' v8.js
grep -q 'background.*textColor.*borderColor.*glowColor.*glowSize' v8.js
grep -q 'v8-player-mode' v8.css
grep -q 'CompressionStream' v8.js
grep -q 'DecompressionStream' game.html
grep -q 'v8RoundGlowSize' v8.js
grep -q 'round-glow' v8.css
grep -q 'bindTaskSource' v8.js
grep -q 'internalTaskSync' v8.js
grep -q 'bindSharedRoundStyle' v8.js
grep -q 'v8ContinueGlowSize' v8.js
grep -q 'continueButton' v8.js
grep -q 'bindHelperTransform' v8.js
grep -q 'helper-selected' v8.css
grep -q "checkAnswer.*hidden=ok" app.js
grep -q "taskCard.*className='task-card'" enhancements.js
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("v8.js",4,null).js; new Function(s)' >/dev/null
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("app.js",4,null).js; new Function(s)' >/dev/null
echo 'V8 smoke checks passed'
