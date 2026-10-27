const T=__T__;
const LBL=__LBL__;
const ALGN=__ALGN__;
const TASTE=__TASTE__;
const S=__S__;
const FIRST=__FIRST__;
const EXTRAS=__EXTRAS__;
const DR=__DR__;
const SIDE=__SIDE__;
const DRK=__DRK__;
const PR=__PR__;
const DET=__DET__;
const LI={zh:0,es:1,en:2};
const eur=(n,l)=>l==="en"?"€"+n.toFixed(2):n.toFixed(2).replace(".",",")+" €";
const esc=s=>String(s).replace(/[&<>"]/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));
const $=id=>document.getElementById(id);
let L="es";
const nm=a=>a[LI[L]];
// Allergen icons: colored disc + white pictogram, name always shown.
const ALG={
 G:{c:"#c9772b",p:'<path d="M12 6v13" /><path d="M12 9c-2-1-3-3-3-4 2 0 3 2 3 4zM12 9c2-1 3-3 3-4-2 0-3 2-3 4zM12 13c-2-1-3-3-3-4 2 0 3 2 3 4zM12 13c2-1 3-3 3-4-2 0-3 2-3 4z"/>'},
 H:{c:"#e0a21b",p:'<ellipse cx="12" cy="12.5" rx="4.2" ry="5.5"/>'},
 S:{c:"#4f8a3c",p:'<path d="M7 16c-1-4 3-9 9-9 1 4-3 9-9 9z"/><circle cx="10" cy="13" r="1.1"/><circle cx="13" cy="10.5" r="1.1"/>'},
 "Sé":{c:"#9a7a55",p:'<path d="M8 9c0-2 1-3 1.5-3S11 7 11 9s-.7 3-1.5 3S8 11 8 9zM13 9c0-2 1-3 1.5-3S16 7 16 9s-.7 3-1.5 3S13 11 13 9zM10.5 15c0-2 1-3 1.5-3s1.5 1 1.5 3-.7 3-1.5 3-1.5-1-1.5-3z"/>'},
 P:{c:"#3b7fb5",p:'<path d="M4.5 12c3-4 8.5-4 11.5 0-3 4-8.5 4-11.5 0z"/><path d="M16 12l3.5-3v6z"/>'},
 M:{c:"#7d5aa6",p:'<path d="M5.5 12.5a6.5 5.5 0 0 1 13 0z"/><path d="M10 12.5v5h4v-5"/>'}
};
const algIcon=k=>{const a=ALG[k];return `<span class="ai"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="12" fill="${a.c}"/><g fill="none" stroke="#fff" stroke-width="1.6" stroke-linecap="round">${a.p}</g></svg>${nm(ALGN[k])}</span>`};
const algRow=(s,lab)=>{const k=s.split(" ").filter(Boolean);return k.length?`<div class="alg">${lab?`<span class="alab">${T[L].algL}</span>`:""}${k.map(algIcon).join("")}</div>`:""};
__ILLO__
function findDish(c){let r=null;S.forEach(s=>s.d.forEach(x=>{if(x.c===c)r=x}));return r}
function pairLine(d){const p=PR[d.c];if(!p)return "";const t=T[L];const sd=SIDE[p[0]];const d1=DRK[p[1][0]],d2=DRK[p[1][1]];
 const lo=Math.min(d1[1],d2[1]),hi=Math.max(d1[1],d2[1]);const pr=lo===hi?eur(lo,L):eur(lo,L)+"–"+eur(hi,L);
 return `<div class="pairl"><b>${t.pairWith}</b> ${esc(nm(sd[0]))} <span class="plus">+${eur(sd[1],L)}</span>${p[2]?"":` · ${esc(nm(d1[0]))} ${t.orw} ${esc(nm(d2[0]))} <span class="plus">+${pr}</span>`}</div>`}
function pairBox(d){const p=PR[d.c];if(!p)return "";const t=T[L];const sd=SIDE[p[0]];const d1=DRK[p[1][0]],d2=DRK[p[1][1]];
 const lo=Math.min(d1[1],d2[1]),hi=Math.max(d1[1],d2[1]);const pr=lo===hi?eur(lo,L):eur(lo,L)+"–"+eur(hi,L);
 const base=d.p+sd[1];const soup=p[2];const tot=soup?eur(base,L):(lo===hi?eur(base+lo,L):eur(base+lo,L)+"–"+eur(base+hi,L));
 const dn=`${esc(nm(d1[0]))} ${t.orw} ${esc(nm(d2[0]))}`;const why=p[3+LI[L]];
 return `<div class="pair"><dt>${t.pairT}</dt><p>${esc(why)}</p><ul>
  <li><span>${d.c} ${esc(L==="zh"?d.zh:d[L])}</span><span>${eur(d.p,L)}</span></li>
  <li><span>+ ${p[0].replace("s","")} ${esc(nm(sd[0]))}</span><span>+${eur(sd[1],L)}</span></li>
  ${soup?"":`<li><span>+ ${dn}</span><span>+${pr}</span></li>`}
  <li class="tot"><span>${soup?t.soupTotal:t.total}</span><span>${tot}</span></li></ul>
  ${soup?`<small>${t.coldQ} ${dn}, ${pr}.</small>`:""}<small>${t.pairNote}</small></div>`}
function render(){
  const t=T[L]; document.documentElement.lang=L==="zh"?"zh-CN":L;
  $("tagline").textContent=t.tagline; $("h-eye").textContent=t.eye; $("h-title").textContent=t.title;
  $("h-desc").textContent=t.desc; $("h-from").textContent=t.frm;
  $("steps").innerHTML=t.steps.map(s=>`<li>${esc(s)}</li>`).join("");
  $("first-t").textContent=t.firstT;
  $("first").innerHTML=FIRST.map(f=>`<li><a class="c" href="#d-${f.c}">${f.c}</a><span>${esc(f[L])}</span></li>`).join("");
  $("promise").innerHTML=`<b>${esc(t.promiseT)}</b><ul>${t.promise.map(([ic,x])=>`<li><span>${ic}</span>${esc(x)}</li>`).join("")}</ul>`;
  $("f-take").textContent=t.take; $("copy").textContent=t.copy;
  $("f-all").innerHTML=algRow("G H S Sé P M",true)+`<div style="margin-top:6px">${esc(t.all)}</div>`;
  document.querySelectorAll(".lang button").forEach(b=>b.setAttribute("aria-pressed",b.dataset.l===L));
  const secName=s=>L==="zh"?s.zh:s[L];
  $("rail").innerHTML=S.map(s=>`<a href="#${s.id}" data-s="${s.id}">${esc(secName(s))}</a>`).join("")+`<a href="#bebidas" data-s="bebidas">${t.drinks}</a>`;
  let h="";
  for(const s of S){
    h+=`<section id="${s.id}"><div class="sh"><h3>${esc(secName(s))}</h3>${L==="zh"?"":`<span class="zh">${s.zh}</span>`}</div><p class="note">${esc(s.note[L])}</p><div class="list">`;
    for(const d of s.d){
      const name=L==="zh"?d.zh:d[L];
      const sub=L==="zh"?d.es:L==="en"?d.zh+" · "+d.es:d.zh;
      const desc=L==="en"?d.en2:L==="es"?d.es2:"";
      const f=(d.fl||"").split(" ");
      let tags="";
      if(f.includes("vg"))tags+=`<span class="tag veg">${t.vegan}</span>`;
      else if(f.includes("v"))tags+=`<span class="tag veg">${t.veg}</span>`;
      const taste=d.ta.map(k=>{const hot=k==="picante"||k==="mala";return `<span class="tt${hot?" hotx":""}">${hot?"🌶 ":""}${esc(nm(TASTE[k]))}</span>`}).join("");
      const det=DET[d.c]?` data-det="${d.c}" tabindex="0" role="button"`:"";
      const price=d.p2?`<span class="pz">${L==="zh"?"小":L==="en"?"S":"P"}</span> ${eur(d.p,L)}<br><span class="pz">${L==="zh"?"大":L==="en"?"L":"G"}</span> ${eur(d.p2,L)}`:eur(d.p,L);
      h+=`<div class="dish" id="d-${d.c}"${det}><div class="thumb">${d.img?`<img src="img/${d.img}.jpg" alt="" loading="lazy">`:illo(d.c,"")}<span class="badge">${d.c}</span></div>
        <div class="t"><h4>${esc(name)}</h4><div class="zhn">${esc(sub)}</div>${desc?`<p>${esc(desc)}</p>`:""}${taste?`<div class="taste">${taste}</div>`:""}${tags?`<div class="tags">${tags}</div>`:""}${algRow(d.al,true)}${pairLine(d)}${DET[d.c]?`<span class="more">${t.more}</span>`:""}</div>
        <div class="price">${price}</div></div>`;
    }
    h+=`</div>`;
    if(s.id==="hm")h+=`<div class="extras"><b>${t.extras}</b><ul>${EXTRAS.map(e=>`<li><span>${esc(nm(e[0]))}</span><span>+${eur(e[1],L)}</span></li>`).join("")}</ul></div>`;
    h+=`</section>`;
  }
  h+=`<section id="bebidas"><div class="sh"><h3>${t.drinks}</h3>${L==="zh"?"":'<span class="zh">酒水</span>'}</div><div class="drinks">`;
  for(const k of ["beers","wine","soft","water"])h+=`<div><h5>${t[k]}</h5><ul>${DR[k].map(x=>`<li><span>${esc(typeof x[0]==="string"?x[0]:nm(x[0]))}</span><span>${eur(x[1],L)}</span></li>`).join("")}</ul></div>`;
  h+=`</div></section>`;
  $("menu").innerHTML=h;
  spy();
}
function openDet(c){
  const d=findDish(c);if(!d||!DET[c])return;const t=T[L],lb=LBL[L],x=DET[c][L];
  const rows=["what","story","ing","taste","adj","how","note","who"].filter(k=>x[k]).map(k=>{
    const v=k==="adj"?t.adj:(k==="how"&&x.how==="POT"?t.pot:x[k]);return `<div><dt>${lb[k]}</dt><dd>${esc(v)}</dd></div>`}).join("");
  const price=d.p2?`${eur(d.p,L)} / ${eur(d.p2,L)}`:eur(d.p,L);
  const sh=$("sheet");
  sh.innerHTML=`<button class="close" id="close" aria-label="${t.close}">×</button>${d.img?`<img src="img/${d.img}.jpg" alt="">`:`<div class="ph">${illo(d.c,t.illo)}</div>`}
   <div class="in"><h3>${esc(L==="zh"?d.zh:d[L])}</h3><div class="meta"><span>${d.c} · ${esc(L==="zh"?d.es:d.zh)}</span><b>${price}</b></div>
   <div class="algbox"><dt>${lb.alg}</dt>${algRow(d.al)}</div>
   <dl>${rows}</dl>${pairBox(d)}</div>`;
  sh.hidden=false;$("scrim").hidden=false;document.body.style.overflow="hidden";$("close").focus();
  $("close").onclick=closeDet;
}
function closeDet(){$("sheet").hidden=true;$("scrim").hidden=true;document.body.style.overflow=""}
document.addEventListener("click",e=>{const r=e.target.closest("[data-det]");if(r)openDet(r.dataset.det);else if(e.target.id==="scrim")closeDet()});
document.addEventListener("keydown",e=>{if(e.key==="Escape")closeDet();const r=e.target.closest&&e.target.closest("[data-det]");if(r&&(e.key==="Enter"||e.key===" ")){e.preventDefault();openDet(r.dataset.det)}});
function setLang(l){L=l;try{localStorage.setItem("lang",l)}catch(e){}render()}
document.querySelectorAll(".lang button").forEach(b=>b.addEventListener("click",()=>setLang(b.dataset.l)));
$("copy").addEventListener("click",e=>{
  const b=e.currentTarget;const sel=()=>getSelection().selectAllChildren($("phone"));
  const done=()=>{b.textContent=T[L].copied;setTimeout(()=>b.textContent=T[L].copy,1500)};
  try{navigator.clipboard.writeText("+34671343226").then(done,sel)}catch(_){sel()}
});
let obs;
function spy(){
  if(obs)obs.disconnect();
  if(!("IntersectionObserver" in window))return;
  obs=new IntersectionObserver(es=>{es.forEach(en=>{if(en.isIntersecting){document.querySelectorAll(".rail a").forEach(a=>{const on=a.dataset.s===en.target.id;a.classList.toggle("on",on);if(on){a.parentNode.scrollLeft=a.offsetLeft-16}})}})},{rootMargin:"-30% 0px -60% 0px"});
  document.querySelectorAll("main section").forEach(s=>obs.observe(s));
}
(function(){let l=null;try{l=localStorage.getItem("lang")}catch(e){}
 if(!l){const n=(navigator.language||"es").slice(0,2);l=n==="zh"?"zh":(n==="es"||n==="ca")?"es":"en"}
 L=T[l]?l:"es";render()})();
