const fs=require('node:fs'),vm=require('node:vm'),path=require('node:path'),assert=require('node:assert/strict');
const root=path.join(__dirname,'..');
for(const directory of ['.','player-v20261022-orderfix1']){
 const source=fs.readFileSync(path.join(root,directory,'app.js'),'utf8');
 const context=vm.createContext({});
 const functions=source.slice(source.indexOf('function splitPipe('),source.indexOf('function normalizeLegacyTasks('))+'\n'+source.slice(source.indexOf('function shuffle('),source.indexOf('function openTask('));
 vm.runInContext(functions,context);
 const run=expression=>vm.runInContext(expression,context,{timeout:1000});
 for(const input of ['[порядок] Числа | |','[порядок] Числа |   |   ','[порядок] Числа | 1 |','[порядок] Числа | | 2']){
  context.input=input;
  assert.equal(run('parseTasks(input).tasks.length'),0,input);
  assert.equal(run('parseTasks(input).errors.length'),1,input);
 }
 context.input='[порядок] Числа | 1 | 2 | 3';
 assert.equal(run('parseTasks(input).errors.length'),0);
 assert.equal(run('parseTasks(input).tasks[0].answers.length'),3);
 context.input='[устно] Объясните правило\n[ввод] Столица | Париж\n2+2? | 4* | 5';
 assert.equal(run('parseTasks(input).tasks.length'),3);
 assert.equal(run('parseTasks(input).errors.length'),0);
 assert.equal(run('shuffle([]).length'),0);
 assert.equal(run('shuffle([{id:"one"}])[0].id'),'one');
 for(let i=0;i<20;i++){
  assert.equal(run('JSON.stringify(shuffle([{id:"a"},{id:"b"}]).map(x=>x.id))'),'["b","a"]');
 }
 console.log('PASS empty-order validation and shuffle regression: '+directory);
}
