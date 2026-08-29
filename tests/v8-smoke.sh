#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
for file in index.html game.html app.js v8.js v8.css tests/v8-browser-smoke.html tests/latex-browser-smoke.html tests/export-browser-smoke.html; do
  test -s "$file" || { echo "Missing $file"; exit 1; }
done
grep -q 'Меткий ответ V8' index.html
grep -q 'src="v8.js' index.html
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
grep -q 'v8-round-tab{background:#171d35' v8.css
grep -q 'bindTaskSource' v8.js
grep -q 'internalTaskSync' v8.js
grep -q 'bindSharedRoundStyle' v8.js
grep -q 'v8ContinueGlowSize' v8.js
grep -q 'continueButton' v8.js
grep -q 'bindHelperTransform' v8.js
grep -q 'helper-selected' v8.css
grep -q "checkAnswer.*hidden=ok" app.js
grep -q "taskCard.*className='task-card'" enhancements.js
grep -q "closest.*#gameStage" enhancements.js
grep -q 'selectionPersists' tests/v8-browser-smoke.html
grep -q 'SOUND_PRESETS' app.js
grep -q 'roundBackground' tests/v8-browser-smoke.html
grep -q 'continueBackground' tests/v8-browser-smoke.html
grep -q 'editorRoundTabIndependent' tests/v8-browser-smoke.html
grep -q 'protectEditorRoundTabs' v8.js
grep -q 'editorRoundTabHasNoInlineStyle' tests/v8-browser-smoke.html
grep -q 'playFullGame' enhancements.js
grep -q 'textAnswerInput' app.js
grep -q 'inputAnswerBackgroundColor' v8.js
grep -q 'simplifyEditor' v8.js
grep -q 'gameButtonStartsFullTest' tests/v8-browser-smoke.html
grep -q 'showTargetPreview' enhancements.js
grep -q 'crosshairPreviewUpdates' tests/v8-browser-smoke.html
grep -q 'targetTrajectoryPreview' tests/v8-browser-smoke.html
grep -q 'initialGameButtonNeutral' tests/v8-browser-smoke.html
grep -q 'updateTaskProgress(game.hits)' app.js
grep -q 'completedTaskProgress' tests/v8-browser-smoke.html
grep -q 'v8RoundEnterAnimation' v8.js
grep -q 'v8RoundExitAnimation' v8.js
grep -q 'Без анимации' v8.js
grep -q 'previewRoundEffect' enhancements.js
grep -q 'playRoundIntro' app.js
grep -q 'roundStylePreviewStatic' tests/v8-browser-smoke.html
grep -q 'roundEnterPreview' tests/v8-browser-smoke.html
grep -q 'roundExitPreview' tests/v8-browser-smoke.html
grep -q 'function renderMath' app.js
grep -q 'standaloneRuntime(C,D,M,P,V)' app.js
grep -q 'absoluteValueDoesNotSplitAnswers' tests/latex-browser-smoke.html
grep -q 'standaloneActuallyRendersFormula' tests/latex-browser-smoke.html
grep -q 'standaloneTargetFalls' tests/latex-browser-smoke.html
grep -q 'standaloneTaskOpens' tests/latex-browser-smoke.html
grep -q 'math-cases' enhancements.css
grep -q 'TARGET_PROFILES' app.js
grep -q 'scheduleTargetVoice' app.js
grep -q 'target-shot' app.js
grep -q 'targetWingLeft' enhancements.css
grep -q 'targetFallsBeforeTask' tests/v8-browser-smoke.html
grep -q 'v8.css?v=' index.html
grep -q 'targetMediaUrl' index.html
grep -q 'Noto Animated Emoji' app.js
grep -q 'duck_female_0.gif' app.js
grep -q 'Special:Redirect/file/Geese' app.js
grep -q "peacock:{motion:'ground',wing:'none'" app.js
grep -q "book:{motion:'slide',wing:'none'" app.js
grep -q "\['hop','ground','slide','swim'\]" app.js
grep -Fq 'data:image\/gif' enhancements.js
grep -q 'HELPER_ANIMATED' app.js
grep -q 'function helperMarkup' app.js
grep -q 'helperMarkup(id,null,true)' app.js
grep -q 'helperMarkup(state.helper.kind,state.helper.custom)' app.js
grep -q 'У помощников есть только визуальная анимация' app.js
grep -q 'helper-art picture' enhancements.css
grep -q 'targetMarkup(id,null,true)' app.js
grep -q 'asset-card\[data-target\].*target-character' enhancements.css
grep -q "!HELPER_ANIMATED\[n.helper.kind\].*n.helper.kind='fox'" app.js
if grep -q "\['capy','Капибара'\]\|\['wizard','Волшебник'\]\|\['scientist','Учёный'\]" app.js; then
  echo 'Static helper emoji found'
  exit 1
fi
grep -q 'function saveNow' app.js
grep -q 'reloadProject' v8.js
grep -q 'showDifficultyScreen' v8.js
grep -q 'helperEnterAnimation' index.html
grep -q 'helperExitAnimation' index.html
grep -q 'previewHelperEffect' enhancements.js
grep -q 'taskShade' enhancements.js
grep -q "task.type==='input'" app.js
grep -q 'textAnswerInput' tests/export-browser-smoke.html
if grep -q 'id="backgroundFit"' index.html; then
  echo 'Removed game background fit control is still present'
  exit 1
fi
if grep -q 'target-motion-magic .*target-motion-trail\|target-motion-float .*target-motion-trail' enhancements.css; then
  echo 'Dotted target aura is still present'
  exit 1
fi
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("v8.js",4,null).js; new Function(s)' >/dev/null
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("app.js",4,null).js; new Function(s)' >/dev/null
osascript -l JavaScript -e 'ObjC.import("Foundation"); var s=$.NSString.stringWithContentsOfFileEncodingError("enhancements.js",4,null).js; new Function(s)' >/dev/null
echo 'V8 smoke checks passed'
