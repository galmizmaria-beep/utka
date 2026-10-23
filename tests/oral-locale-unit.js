const fs=require('node:fs'),vm=require('node:vm'),path=require('node:path'),assert=require('node:assert/strict');
function makeEnvironment(){
 let time=0,id=0;const frames=new Map(),timers=new Map(),elements=new Map();
 function element(){const classes=new Set();const style={setProperty(k,v){this[k]=v},getPropertyValue(k){return this[k]||''}};return {hidden:true,style,clientWidth:960,clientHeight:540,offsetWidth:100,offsetHeight:100,textContent:'',innerHTML:'',value:'',dataset:{},classList:{add(...xs){xs.forEach(x=>classes.add(x))},remove(...xs){xs.forEach(x=>classes.delete(x))},contains(x){return classes.has(x)},toggle(x,on){on??=!classes.has(x);on?classes.add(x):classes.delete(x);return on}},set className(v){classes.clear();v.split(' ').filter(Boolean).forEach(x=>classes.add(x))},get className(){return [...classes].join(' ')},querySelector:select,querySelectorAll(){return []},addEventListener(){},getAnimations(){return []},children:[],append(...xs){this.children.push(...xs)},remove(){},setAttribute(){},focus(){},getBoundingClientRect(){return {left:0,top:0,width:960,height:540,bottom:540}}}}
 function select(k){if(!elements.has(k))elements.set(k,element());return elements.get(k)}
 const env={window:{},document:{querySelector:select,querySelectorAll(){return []},addEventListener(){},createElement:element},location:{search:''},URLSearchParams:class{get(){return null}},localStorage:{getItem(){return null}},structuredClone:x=>JSON.parse(JSON.stringify(x)),addEventListener(){},performance:{now:()=>time},requestAnimationFrame:f=>{frames.set(++id,f);return id},cancelAnimationFrame:i=>frames.delete(i),setTimeout:(f,delay)=>{timers.set(++id,{f,delay});return id},clearTimeout:i=>timers.delete(i),ResizeObserver:class{observe(){}},Audio:class{play(){return Promise.resolve()}},Math,JSON,console:{log(){}},Blob:class{}};
 env.advance=ms=>{time+=ms;const pending=[...frames.values()];frames.clear();pending.forEach(f=>f())};env.frames=frames;env.timers=timers;env.select=select;return env;
}

for(const directory of ['.','player-v20261023-oral-lang1']){
 const source=fs.readFileSync(path.join(__dirname,'..',directory,'app.js'),'utf8');
 new vm.Script(source);new vm.Script(fs.readFileSync(path.join(__dirname,'..',directory,'v8.js'),'utf8'));
 const env=makeEnvironment(),start=source.lastIndexOf('renderSelectors();bind();updateSource();');
 vm.runInNewContext(source.slice(0,start)+'window.test={state,openTask,I,renderMath,layoutHelper};})();',env);
 const api=env.window.test;
 for(const lang of Object.keys(api.I)){
  api.state.locale=lang;api.state.audio.enabled=false;api.state.tasks=[{type:'oral',question:'Explain',answers:[]}];
  api.openTask(true);
  const expected=api.I[lang].oralPrompt;
  assert.ok(expected.includes(api.I[lang].check),lang+' button name');
  assert.equal(env.select('#answerArea').innerHTML,'<p>'+expected+'</p>',lang+' preview');
  if(lang!=='ru')assert.notEqual(expected,api.I.ru.oralPrompt);
  const runtime=makeEnvironment();
  runtime.C=JSON.parse(JSON.stringify(api.state));runtime.C.titleScreen.enabled=true;
  runtime.D=api.I;runtime.M=api.renderMath;runtime.P={};runtime.V=()=>{};runtime.layoutHelper=api.layoutHelper;
  const a=source.indexOf('function standaloneRuntime('),b=source.indexOf('\nfunction generateStandalone',a);
  const code=source.slice(a,b).replace("$('#startGame').onclick=begin;","window.openOralTest=openTask;$('#startGame').onclick=begin;");
  vm.runInNewContext(code+';standaloneRuntime(C,D,M,P,V)',runtime);
  runtime.window.openOralTest();
  assert.equal(runtime.select('#answerArea').innerHTML,'<p>'+expected+'</p>',lang+' export');
 }
 console.log('PASS oral prompt in seven locales, preview and export: '+directory);
}
