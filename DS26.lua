local P,R,W,U,SV=game:GetService("Players"),game:GetService("RunService"),game:GetService("Workspace"),game:GetService("UserInputService"),game:GetService("StarterGui")
local TS,VIM,VU,HS=game:GetService("TweenService"),game:GetService("VirtualInputManager"),game:GetService("VirtualUser"),game:GetService("HttpService")
local plr=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")
local C={r=14,dl=0.5,sc=1.2,eq=0.7,skd=0.6,skillMode=2,bs=true,kn=true,knd=3,pu=true,pr=30,bm=false,bmr=300,fr=false,frr=5000,fs=true,cf=false,ct=300,hl=false,nt=true,bs2=false,dodge=false,hpr=30,hpCd=8,dodgeR=35,dodgeCd=1.2,kaMode=0,autoFPS=true,kaMax=15,esp=false,espFruit=false,espBerry=false,espFlower=false,stuck=false,stuckT=3,sea=false,seaKd=0.5,seaKill=false,raid=false,raidType="Flame",raidBuyChip=true,af=false,afR=250,speed=350,autoEquip=true,weaponPref={Melee=true,Sword=false,Gun=false,Fruit=true},aq=false,aqStage=0,bossPick="",kboss=false}
local S={run=true,c={},ls=0,la=0,le=0,cn=nil,lsk=0,lbs=0,lkn=0,lpu=0,lbr=0,lfr=0,lhp=0,fc={},fs=setmetatable({},{__mode="k"}),hls={},esps={},cbTime=0,nc=nil,kc=0,t0=os.clock(),ci=1,lastPos=Vector3.zero,stuckTimer=0,nco=false,lastHP=0,dodgeT=0,lastHPLoss=0,raidState="idle",raidCd=0,kaBackup=nil,frameN=0,fpsT=0,fps=60,frT=0,m1Warned=false,espFruitHL={},espBerryHL={},espFlowerHL={},aqT=0,espItemT=0,cleanT=0}
local RP=RaycastParams.new()RP.FilterType=Enum.RaycastFilterType.Exclude
local DG,CO={},setmetatable({},{__mode="k"})
local KW={Melee={"melee","combat","black leg","electro","dragon claw","superhuman","karate","fishman","death step","godhuman","dragon talon","electric claw","sharkman","sanguine","ghoul"},Sword={"sword","blade","katana","cutlass","saber","yama","shisui","saddi","koko","bisento","trident","pole","dagger","dual","dark blade","true triple","cursed dual","buddy","iron mace","pipe","wando","dark dagger","gravity cane","longsword","rengoku","hallow","spikey","antlers"},Gun={"gun","rifle","bow","slingshot","flintlock","kabucha","cannon","soul cane","acidium","serpent","musket","bizarre","bazooka","gatling"},Fruit={"rocket","spin","chop","spring","bomb","smoke","spike","flame","falcon","ice","sand","dark","diamond","light","rubber","barrier","magma","door","quake","human","buddha","love","spider","sound","phoenix","portal","rumble","pain","blizzard","gravity","mammoth","trex","dough","shadow","venom","control","spirit","dragon","leopard","kitsune","yeti","gas","creation","revive","eagle","lightning"}}
local FRUIT_M1={"light","ice","phoenix","buddha","gas","kitsune","trex","dragon","venom","control","dough","mammoth","leopard","yeti"}
local BERRY_KW={"red berry","blue berry","green berry","yellow berry","purple berry","pink berry","orange berry","white berry","black berry","magma berry","ice berry","dark berry","light berry","revive berry"}
local FLOWER_KW={"pink flower","red flower","blue flower","yellow flower","purple flower","orange flower","green flower","white flower","black flower","red spiral","blue spiral","yellow spiral","green spiral","purple spiral","pink spiral"}
local BOSS_LIST={"Saber Expert","Gorilla King","Bobby","Yeti","Mob Leader","Cyborg","Fajita","Don Swan","Wysper","Thunder God","Diamond","Jeremy","Cursed Captain","Rip Indra","Order","Longma","Dough King","Darkbeard","Graybeard","Soul Reaper","Stone","Island Empress","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Smoke Admiral","Flame Admiral","Ice Admiral","Quake Admiral"}
local QUESTS={
[1]={name="Bandit",npc=Vector3.new(-1137,10,1100),lv=1},[2]={name="Monkey",npc=Vector3.new(-1565,10,175),lv=15},[3]={name="Pirate",npc=Vector3.new(-2904,10,3291),lv=30},[4]={name="Brute",npc=Vector3.new(-1145,10,3460),lv=45},[5]={name="Desert Bandit",npc=Vector3.new(-1220,10,3542),lv=60},[6]={name="Desert Officer",npc=Vector3.new(-1220,10,3542),lv=75},[7]={name="Snow Bandit",npc=Vector3.new(-974,10,6028),lv=90},[8]={name="Snowman",npc=Vector3.new(-974,10,6028),lv=105},[9]={name="Marine",npc=Vector3.new(-5030,10,4240),lv=120},[10]={name="Sky Bandit",npc=Vector3.new(-4877,558,2383),lv=150},[11]={name="Dark Master",npc=Vector3.new(-4877,558,2383),lv=175},[12]={name="Prisoner",npc=Vector3.new(5184,10,1043),lv=190},[13]={name="Dangerous Prisoner",npc=Vector3.new(5184,10,1043),lv=210},[14]={name="Toga Warrior",npc=Vector3.new(-1398,100,-3089),lv=225},[15]={name="Gladiator",npc=Vector3.new(-1398,100,-3089),lv=240},[16]={name="Military Soldier",npc=Vector3.new(-5210,10,5022),lv=255},[17]={name="Military Spy",npc=Vector3.new(-5210,10,5022),lv=275},[18]={name="Galley Pirate",npc=Vector3.new(-1312,10,-2611),lv=300},[19]={name="Galley Captain",npc=Vector3.new(-1312,10,-2611),lv=375},[20]={name="Raider",npc=Vector3.new(673,10,-4177),lv=450},[21]={name="Mercenary",npc=Vector3.new(673,10,-4177),lv=525},[22]={name="Swan Pirate",npc=Vector3.new(620,10,-2608),lv=625},[23]={name="Factory Staff",npc=Vector3.new(325,10,-5180),lv=700},[24]={name="Marine Lieutenant",npc=Vector3.new(241,10,3279),lv=775},[25]={name="Marine Captain",npc=Vector3.new(241,10,3279),lv=850},[26]={name="Zombie",npc=Vector3.new(-5493,10,4467),lv=900},[27]={name="Vampire",npc=Vector3.new(-5493,10,4467),lv=975},[28]={name="Snow Trooper",npc=Vector3.new(-3111,10,5480),lv=1000},[29]={name="Winter Warrior",npc=Vector3.new(-3111,10,5480),lv=1100},[30]={name="Pirate Millionaire",npc=Vector3.new(-1315,10,5620),lv=1200},[31]={name="Pistol Billionaire",npc=Vector3.new(-1315,10,5620),lv=1325},[32]={name="Dragon Crew Warrior",npc=Vector3.new(5735,10,2282),lv=1450},[33]={name="Dragon Crew Archer",npc=Vector3.new(5735,10,2282),lv=1575},[34]={name="Female Islander",npc=Vector3.new(4575,100,1955),lv=1700},[35]={name="Giant Islander",npc=Vector3.new(4575,100,1955),lv=1825},[36]={name="Marine Commodore",npc=Vector3.new(-5143,10,4581),lv=1950},[37]={name="Marine Rear Admiral",npc=Vector3.new(-5143,10,4581),lv=2100},[38]={name="Peanut Scout",npc=Vector3.new(-1650,10,355),lv=2075},[39]={name="Peanut President",npc=Vector3.new(-1650,10,355),lv=2100},[40]={name="Ice Cream Chef",npc=Vector3.new(-820,10,-1050),lv=2125},[41]={name="Ice Cream Commander",npc=Vector3.new(-820,10,-1050),lv=2150},[42]={name="Cookie Crafter",npc=Vector3.new(-1275,10,-2770),lv=2175},[43]={name="Cake Guard",npc=Vector3.new(-1275,10,-2770),lv=2200},[44]={name="Baking Staff",npc=Vector3.new(350,10,-3250),lv=2225},[45]={name="Head Baker",npc=Vector3.new(350,10,-3250),lv=2250},[46]={name="Cocoa Warrior",npc=Vector3.new(-1700,10,-3500),lv=2275},[47]={name="Chocolate Bar Battler",npc=Vector3.new(-1700,10,-3500),lv=2300},[48]={name="Sweet Thief",npc=Vector3.new(-3750,10,-3800),lv=2325},[49]={name="Candy Rebel",npc=Vector3.new(-3750,10,-3800),lv=2350},[50]={name="Candy Pirate",npc=Vector3.new(-3750,10,-3800),lv=2375},[51]={name="Snow Demon",npc=Vector3.new(-3900,10,-2700),lv=2400},[52]={name="Snow Lurker",npc=Vector3.new(-3900,10,-2700),lv=2425},[53]={name="Isle Outlaw",npc=Vector3.new(-3435,10,-6990),lv=2450},[54]={name="Island Boy",npc=Vector3.new(-3435,10,-6990),lv=2475},[55]={name="Serpent Hunter",npc=Vector3.new(-3435,10,-6990),lv=2500},[56]={name="Isle Champion",npc=Vector3.new(-3435,10,-6990),lv=2525},[57]={name="Diving Expert",npc=Vector3.new(-3435,10,-6990),lv=2550},[58]={name="Deep Sea Fisherman",npc=Vector3.new(-3435,10,-6990),lv=2575},[59]={name="Seaborn Soldier",npc=Vector3.new(-3435,10,-6990),lv=2600},[60]={name="Reef Bandit",npc=Vector3.new(-3925,10,-5200),lv=2600},[61]={name="Coral Pirate",npc=Vector3.new(-3925,10,-5200),lv=2625},[62]={name="Sea Chanter",npc=Vector3.new(-3925,10,-5200),lv=2650},[63]={name="Ocean Prophet",npc=Vector3.new(-3925,10,-5200),lv=2675},[64]={name="High Disciple",npc=Vector3.new(-3925,10,-5200),lv=2700},[65]={name="Grand Devotee",npc=Vector3.new(-3925,10,-5200),lv=2725}}
local function getWType(nm)local n=nm:lower()for wt,kl in pairs(KW)do for _,k in ipairs(kl)do if string.find(n,k,1,true)then return wt end end end return nil end
local function hasM1(nm)local n=nm:lower()for _,k in ipairs(FRUIT_M1)do if string.find(n,k,1,true)then return true end end return false end
local function isBerry(nm)local n=nm:lower()for _,k in ipairs(BERRY_KW)do if string.find(n,k,1,true)then return true end end return false end
local function isFlower(nm)local n=nm:lower()for _,k in ipairs(FLOWER_KW)do if string.find(n,k,1,true)then return true end end return false end
local function getQuestByLevel(lv)local best=nil for i,q in ipairs(QUESTS)do if q.lv<=lv then best=q end end return best end
local SEAS={[2753915549]="sea1",[4442272183]="sea2",[7449423635]="sea3"}
local ISL={sea1={{"Starter",0,10,0},{"MarineFort",-4700,10,4200},{"Middle",-700,10,1200},{"Jungle",-1500,10,200},{"Pirate",-3000,10,3300},{"Desert",-1200,10,3500},{"Frozen",-1000,10,6000},{"MarineFord",-5000,10,4200},{"Skylands",-5000,550,2500},{"Prison",5000,10,1000},{"Colosseum",-1500,100,-3000},{"Magma",-5200,10,5000},{"Underwater",-3700,100,6000},{"Fountain",-5000,100,4000}},sea2={{"Kingdom",200,10,3000},{"Cafe",-200,10,3000},{"Mansion",500,10,3000},{"Grave",5000,10,500},{"SnowMt",2000,200,-5000},{"HotCold",5000,10,-2000},{"Cursed",2000,10,5000},{"IceCastle",5000,100,-5000},{"Forgot",-3000,10,-4000},{"Green",200,10,-5000},{"Diamond",5000,10,-1500}},sea3={{"Port",-500,10,5000},{"Hydra",5000,10,2000},{"Tree",3000,100,-2000},{"Turtle",-1000,100,-5000},{"Castle",-5000,100,-5000},{"Treats",-2000,100,5000},{"CastleSea",-5000,100,-1000},{"PiratePort",-5000,100,5000},{"Sunflower",-1000,100,3000}}}
local function gs()return SEAS[game.PlaceId]or"sea1"end
local function tp(p)
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local v=Vector3.new(p[2],p[3],p[4])
local d=(v-h.Position).Magnitude
local du=math.clamp(d/C.speed,0.5,10)
local st=math.max(1,math.ceil(du/2))
task.spawn(function()
for i=1,st do
if not h.Parent then return end
local tg=h.Position:Lerp(v+Vector3.new(0,3,0),1/(st-i+1))
TS:Create(h,TweenInfo.new(du/st,Enum.EasingStyle.Linear),{CFrame=CFrame.new(tg)}):Play()
task.wait(du/st) end end) end
local function ib(p)return p:IsA("BasePart")and not p:FindFirstAncestorOfClass("Tool")and not p:FindFirstAncestorOfClass("Accessory")end
local BL={"Rip Indra","Dough King","Cursed Captain","Order","Longma","Darkbeard","Graybeard","Soul Reaper","Don Swan","Jeremy","Saber Expert","Gorilla King","Bobby","Yeti","Mob Leader","Cyborg","Fajita","Wysper","Thunder God","Diamond","Stone","Island Empress","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Smoke Admiral","Flame Admiral","Ice Admiral","Quake Admiral"}
local function isB(n)for _,b in ipairs(BL)do if string.find(n:lower(),b:lower(),1,true)then return true end end return false end
local function en(m)
if not m or not m.Parent or not m:IsA("Model")or m==plr.Character then return false end
local h=m:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 or m:FindFirstChildOfClass("ForceField")then return false end
local tp2=P:GetPlayerFromCharacter(m)
if tp2 then return false end
if C.kboss then
if C.bossPick=="" then if not isB(m.Name)then return false end
else if not string.find(m.Name:lower(),C.bossPick:lower(),1,true)then return false end end
return true end
if C.bs2 and not isB(m.Name)then return false end
return true end
local function rt(m)return m and(m:FindFirstChild("HumanoidRootPart")or m:FindFirstChild("UpperTorso")or m.PrimaryPart)end
local function ct()local l={} for _,n in ipairs({"Enemies","NPCs","Mobs","Monsters"})do local f=W:FindFirstChild(n)if f then table.insert(l,f)end end if #l==0 then table.insert(l,W)end return l end
local function sc()
local t=os.clock()if t-S.ls<C.sc then return S.c end
S.ls=t
local f={}
local c=plr.Character
if not c then S.c=f return f end
local mr=rt(c)if not mr then S.c=f return f end
local mp=mr.Position
for _,cc in ipairs(ct())do for _,o in ipairs(cc:GetChildren())do
if en(o)then
local r=rt(o)
if r and math.abs(r.Position.Y-mp.Y)<=8 then
local d=(r.Position-mp).Magnitude
if d<=C.r then table.insert(f,{m=o,r=r,d=d})end end end end end
table.sort(f,function(a,b)return a.d<b.d end)S.c=f return f end
local function eq()
if not C.autoEquip then return end
local c=plr.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")if not h then return end
local cu=c:FindFirstChildOfClass("Tool")
if cu then
local wt=getWType(cu.Name)
if wt and C.weaponPref[wt]then
if wt=="Fruit" and not hasM1(cu.Name) and not S.m1Warned then
S.m1Warned=true
pcall(function()SV:SetCore("SendNotification",{Title="⚠ Trái không M1",Text="Khuyên dùng Auto Skill!",Duration=6})end)
if C.skillMode==0 then C.skillMode=2 end end
return end end
local bp=plr:FindFirstChild("Backpack")if not bp then return end
local pri={"Melee","Fruit","Sword","Gun"}
for _,pt in ipairs(pri)do
if C.weaponPref[pt]then
for _,t in ipairs(bp:GetChildren())do
if t:IsA("Tool")then
if getWType(t.Name)==pt then
pcall(function()h:EquipTool(t)end)
if pt=="Fruit" and not hasM1(t.Name) and not S.m1Warned then
S.m1Warned=true
pcall(function()SV:SetCore("SendNotification",{Title="⚠ Trái không M1",Text="Khuyên dùng Auto Skill!",Duration=6})end)
if C.skillMode==0 then C.skillMode=2 end end
return end end end end end end
local function atk()
local c=plr.Character
local t=c and c:FindFirstChildOfClass("Tool")
if not t or not t.Enabled then return false end
return pcall(function()t:Activate()end)end
local KM={Z=Enum.KeyCode.Z,X=Enum.KeyCode.X,C=Enum.KeyCode.C,V=Enum.KeyCode.V}
local function useSkill()
if C.skillMode==0 then return end
local n=os.clock()if n-S.lsk<C.skd then return end S.lsk=n
if C.skillMode==1 then
local k=KM[({"Z","X","C","V"})[S.ci]]
if k then pcall(function()VIM:SendKeyEvent(true,k,false,game)VU:KeyDown(k)end)task.wait(0.03)pcall(function()VIM:SendKeyEvent(false,k,false,game)VU:KeyUp(k)end)end
S.ci=S.ci+1 if S.ci>4 then S.ci=1 end
else
for _,kk in ipairs({"Z","X","C","V"})do
local k=KM[kk]
pcall(function()VIM:SendKeyEvent(true,k,false,game)VU:KeyDown(k)end)
task.wait(0.02)
pcall(function()VIM:SendKeyEvent(false,k,false,game)VU:KeyUp(k)end)
end end end
local function Rm()local r=RS:FindFirstChild("Remotes")return r and r:FindFirstChild("CommF_")end
local function bsu()
if not C.bs then return end
local n=os.clock()if n-S.lbs<3 then return end S.lbs=n
local c=plr.Character
if c and not c:FindFirstChild("HasBuso")then local f=Rm()if f then pcall(function()f:InvokeServer("Buso")end)end end end
local function kn()
if not C.kn then return end
local n=os.clock()if n-S.lkn<C.knd then return end S.lkn=n
local c=plr.Character
if c and not c:FindFirstChild("HasKen")then local f=Rm()if f then pcall(function()f:InvokeServer("Ken")end)end end end
local function pu()
if not C.pu then return end
local n=os.clock()if n-S.lpu<0.5 then return end S.lpu=n
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local mp=h.Position
for _,o in ipairs(W:GetChildren())do if o:IsA("Tool")and o:FindFirstChild("Handle")then
if (o.Handle.Position-mp).Magnitude<=C.pr then
local dist=(o.Handle.Position-h.Position).Magnitude
local du=math.clamp(dist/C.speed,0.2,3)
TS:Create(h,TweenInfo.new(du),{CFrame=CFrame.new(o.Handle.Position)}):Play()return end end end end
local function bm()
if not C.bm and not C.af then return end
local n=os.clock()
local iv=0.15
if C.af and not C.bm then iv=0.3 end
if n-S.lbr<iv then return end S.lbr=n
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local mp=h.Position
local range=C.bmr
if C.af then range=C.afR end
for _,cc in ipairs(ct())do for _,o in ipairs(cc:GetChildren())do
if en(o)then
local hh=o:FindFirstChildOfClass("Humanoid")
local r=rt(o)
if hh and r and (r.Position-mp).Magnitude<=range then pcall(function()hh:MoveTo(mp)end)end end end end end
local fSea
local function dodge()
if not C.dodge then return end
local c=plr.Character
local h=c and c:FindFirstChildOfClass("Humanoid")
local h2=c and c:FindFirstChild("HumanoidRootPart")
if not h or not h2 then return end
local n=os.clock()
if n-S.dodgeT<C.dodgeCd then return end
if h.Health/h.MaxHealth*100<C.hpr then
S.dodgeT=n
local s=h:GetState()
if s==Enum.HumanoidStateType.Running or s==Enum.HumanoidStateType.Landed or s==Enum.HumanoidStateType.RunningNoPhysics then
h2.AssemblyLinearVelocity=Vector3.new(0,120,0)end
return end
local hpLoss=S.lastHP-h.Health
if hpLoss>0 and S.lastHP>0 then S.lastHPLoss=hpLoss end
S.lastHP=h.Health
if S.lastHPLoss>50 then
S.dodgeT=n
local dd=(h2.Position-Vector3.new(0,h2.Position.Y,0)).Unit
local target=h2.Position+dd*60+Vector3.new(0,50,0)
TS:Create(h2,TweenInfo.new(0.3,Enum.EasingStyle.Linear),{CFrame=CFrame.new(target)}):Play()
S.lastHPLoss=0
return end
if fSea then
local sb,sd=fSea()
if sb and sd<C.dodgeR then S.dodgeT=n h2.AssemblyLinearVelocity=Vector3.new(0,120,0)end end end
local FK={"rocket","spin","chop","spring","bomb","smoke","spike","flame","falcon","ice","sand","dark","diamond","light","rubber","barrier","magma","door","quake","human","buddha","love","spider","sound","phoenix","portal","rumble","pain","blizzard","gravity","mammoth","trex","dough","shadow","venom","control","spirit","dragon","leopard","kitsune","yeti","gas","creation","revive","eagle","lightning"}
local function ifr(o)
if not o or not o:IsA("Tool")or not o:FindFirstChild("Handle")then return false end
local c=plr.Character
if c and o:IsDescendantOf(c)then return false end
for _,k in ipairs(FK)do if string.find(o.Name:lower(),k,1,true)then return true end end return false end
local function sf()
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return{}end
local mp=h.Position local l={}
for _,o in ipairs(W:GetChildren())do if ifr(o)then
local hh=o:FindFirstChild("Handle")
local d=(hh.Position-mp).Magnitude
if d<=C.frr then table.insert(l,{n=o.Name,d=d,p=hh.Position,o=o})end end end
table.sort(l,function(a,b)return a.d<b.d end)return l end
local function chl()for _,h in pairs(S.hls)do pcall(function()h:Destroy()end)end S.hls={}end
local function uhl(l)
chl()if not C.hl then return end
for _,f in ipairs(l)do if f.o and f.o.Parent then
local h=Instance.new("Highlight")h.FillColor=Color3.fromRGB(255,80,180)h.FillTransparency=0.5 h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Adornee=f.o h.Parent=f.o
S.hls[f.o]=h end end end
local function espCl()for _,e in pairs(S.esps)do if e.hl then pcall(function()e.hl:Destroy()end)end if e.nm then pcall(function()e.nm:Destroy()end)end end S.esps={}end
local espT=0
local function espUp()
if not C.esp then if next(S.esps)then espCl()end return end
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
local mp=h and h.Position
local dD=(os.clock()-espT>0.5)if dD then espT=os.clock()end
for _,p in ipairs(P:GetPlayers())do if p~=plr then
local c2=p.Character
local hh=c2 and c2:FindFirstChildOfClass("Humanoid")
local ro=c2 and rt(c2)
if c2 and hh and hh.Health>0 and ro then
if not S.esps[p]then
local hl=Instance.new("Highlight")hl.FillColor=Color3.fromRGB(0,255,100)hl.FillTransparency=0.5 hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop hl.Adornee=c2 hl.Parent=c2
local nm=Instance.new("BillboardGui")nm.Size=UDim2.new(0,180,0,36)nm.StudsOffset=Vector3.new(0,3,0)nm.AlwaysOnTop=true nm.Adornee=ro nm.Parent=c2
local t1=Instance.new("TextLabel",nm)t1.Size=UDim2.new(1,0,0.5,0)t1.BackgroundTransparency=1 t1.Text=p.Name t1.TextColor3=Color3.new(1,1,1)t1.TextStrokeTransparency=0 t1.TextSize=13 t1.Font=Enum.Font.GothamBold
local t2=Instance.new("TextLabel",nm)t2.Size=UDim2.new(1,0,0.5,0)t2.Position=UDim2.new(0,0,0.5,0)t2.BackgroundTransparency=1 t2.TextColor3=Color3.fromRGB(255,220,120)t2.TextStrokeTransparency=0 t2.TextSize=11 t2.Font=Enum.Font.Code
S.esps[p]={hl=hl,nm=nm,d=t2}end
if dD then local e=S.esps[p]if e.d and mp then e.d.Text=math.floor((ro.Position-mp).Magnitude).."m"end end
elseif S.esps[p]then
local e=S.esps[p]
if e.hl then pcall(function()e.hl:Destroy()end)end
if e.nm then pcall(function()e.nm:Destroy()end)end
S.esps[p]=nil end end end end
local function espItemUp(list,cfg,dic,ic,col)
if not cfg then if next(dic)then for _,e in pairs(dic)do if e.hl then pcall(function()e.hl:Destroy()end)end if e.nm then pcall(function()e.nm:Destroy()end)end end for k in pairs(dic)do dic[k]=nil end end return end
for _,o in ipairs(W:GetChildren())do
if o:IsA("Tool")and o:FindFirstChild("Handle")and list(o.Name)then
if not dic[o]then
local hl=Instance.new("Highlight")hl.FillColor=col hl.FillTransparency=0.5 hl.OutlineColor=Color3.new(1,1,1)hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop hl.Adornee=o hl.Parent=o
local nm=Instance.new("BillboardGui")nm.Size=UDim2.new(0,150,0,30)nm.StudsOffset=Vector3.new(0,3,0)nm.AlwaysOnTop=true nm.Adornee=o.Handle nm.Parent=o
local t1=Instance.new("TextLabel",nm)t1.Size=UDim2.new(1,0,1,0)t1.BackgroundTransparency=1 t1.Text=ic.." "..o.Name t1.TextColor3=col t1.TextStrokeTransparency=0 t1.TextSize=12 t1.Font=Enum.Font.GothamBold
dic[o]={hl=hl,nm=nm}end
elseif dic[o]then
local e=dic[o]
if e.hl then pcall(function()e.hl:Destroy()end)end
if e.nm then pcall(function()e.nm:Destroy()end)end
dic[o]=nil end end end
local function espFruitUp()espItemUp(function(n)return getWType(n)=="Fruit"end,C.espFruit,S.espFruitHL,"🍎",Color3.fromRGB(255,80,180))end
local function espBerryUp()espItemUp(isBerry,C.espBerry,S.espBerryHL,"🫐",Color3.fromRGB(100,80,255))end
local function espFlowerUp()espItemUp(isFlower,C.espFlower,S.espFlowerHL,"🌸",Color3.fromRGB(255,140,200))end
local function espFruitCl()espItemUp(function()return false end,false,S.espFruitHL,"","")end
local function espBerryCl()espItemUp(function()return false end,false,S.espBerryHL,"","")end
local function espFlowerCl()espItemUp(function()return false end,false,S.espFlowerHL,"","")end
local function scc(c,s)
for _,p in ipairs(c:GetDescendants())do if ib(p)then
if s==false then if CO[p]==nil then CO[p]=p.CanCollide end p.CanCollide=false
else local o=CO[p]p.CanCollide=(o==nil)and true or o CO[p]=nil end end end end
local function onc()S.nco=true local c=plr.Character if not c then return end scc(c,false)if S.nc then S.nc:Disconnect()end S.nc=R.Heartbeat:Connect(function()local c2=plr.Character if not c2 then return end for _,p in ipairs(c2:GetDescendants())do if ib(p)and p.CanCollide then if CO[p]==nil then CO[p]=true end p.CanCollide=false end end end)end
local function dnc()S.nco=false if S.nc then S.nc:Disconnect()S.nc=nil end local c=plr.Character if not c then return end scc(c,true)end
plr.CharacterAdded:Connect(function()S.m1Warned=false S.c={}S.ls=0 S.la=0 S.le=0 S.lsk=0 S.lbs=0 S.lkn=0 S.lpu=0 S.lbr=0 S.lfr=0 S.lhp=0 S.cbTime=0 S.ci=1 S.stuckTimer=0 S.lastHP=0 if S.nco then task.wait(0.5)if S.nco then onc()end end end)
local function us()
local c=plr.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart")
local hm=c:FindFirstChildOfClass("Humanoid")
if not h then return end
h.Velocity=Vector3.zero h.AssemblyLinearVelocity=Vector3.zero h.AssemblyAngularVelocity=Vector3.zero h.Anchored=false
if hm then hm.PlatformStand=false pcall(function()hm:ChangeState(Enum.HumanoidStateType.GettingUp)end)end
h.CFrame=h.CFrame+Vector3.new(0,-3,0)task.wait(0.3)
if not h.Parent then return end
local ry=RaycastParams.new()ry.FilterType=Enum.RaycastFilterType.Exclude ry.FilterDescendantsInstances={c}
local hi=W:Raycast(h.Position,Vector3.new(0,-500,0),ry)
if hi then h.CFrame=CFrame.new(hi.Position+Vector3.new(0,4,0))end end
local CK={"daimon","demon","gold","chest"}
local function ic(o)if not o or o:IsA("Player")or o:FindFirstChildOfClass("Humanoid")then return false end for _,k in ipairs(CK)do if string.find(o.Name:lower(),k,1,true)then return o:IsA("Model")or o:IsA("BasePart")end end return false end
local function ctr(o)local n=o.Name:lower()if string.find(n,"daimon",1,true)or string.find(n,"demon",1,true)then return 3 end if string.find(n,"gold",1,true)then return 2 end return 1 end
local function crt(o)if o:IsA("BasePart")then return o end return o:FindFirstChild("HumanoidRootPart")or o:FindFirstChild("Base")or o:FindFirstChild("Handle")or o.PrimaryPart end
local function fc()
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return nil end
local mp=h.Position local be,bt,bd=nil,0,math.huge
local fo={}
for _,n in ipairs({"Chests","Chest","Rewards"})do local f=W:FindFirstChild(n)if f then table.insert(fo,f)end end
if #fo==0 then table.insert(fo,W)end
for _,ff in ipairs(fo)do for _,o in ipairs(ff:GetChildren())do
if ic(o)then
local r=crt(o)
if r and r.Parent then
local d=(r.Position-mp).Magnitude
if d<=C.ct then
local t=ctr(o)
if t>bt or(t==bt and d<bd)then be,bt,bd=o,t,d end end end end end end
return be end
local function gc()
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
local hh=c and c:FindFirstChildOfClass("Humanoid")
if not h or not hh or hh.Health<=0 then return end
local c2=fc()if not c2 then return end
local r=crt(c2)if not r then return end
local dist=(r.Position-h.Position).Magnitude
local du=math.clamp(dist/C.speed,0.4,4)
local tw=TS:Create(h,TweenInfo.new(du),{CFrame=CFrame.new(r.Position+Vector3.new(0,2,0))})
local dn=false tw.Completed:Once(function()dn=true end)tw:Play()
local t0=os.clock()while not dn and os.clock()-t0<du+2 do task.wait()end
task.wait(0.3)end
local function goFr()
if not C.fs or #S.fc==0 then return end
local n=os.clock()if n-S.frT<1 then return end S.frT=n
local f=S.fc[1]
if not f or not f.o or not f.o.Parent then return end
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local d=(f.p-h.Position).Magnitude
if d<5 then return end
local du=math.clamp(d/C.speed,0.3,5)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(f.p)}):Play()end
local SKW={"terror shark","terror","shark","sea beast","seabeast","sea king","seaking","ghostship","ghost ship","pirate ship","pirate grand","rumbling","strong sea","kraken","leviathan","hydra","fishman"}
local function isSea(m)
if not m or not m.Parent or not m:IsA("Model")then return false end
local h=m:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 then return false end
local n=string.lower(m.Name)
for _,k in ipairs(SKW)do if string.find(n,k,1,true)then return true end end
return false end
fSea=function()
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return nil,0 end
local mp=h.Position local be,bd=nil,math.huge
local fo={W}
for _,fn in ipairs({"SeaBeasts","Sea","SeaEvents","Effects"})do local f=W:FindFirstChild(fn)if f then table.insert(fo,f)end end
for _,f in ipairs(fo)do for _,o in ipairs(f:GetChildren())do
if isSea(o)then
local r=rt(o)
if r then
local d=(r.Position-mp).Magnitude
if d<bd then be,bd=o,d end end end end end
return be,bd end
local SeaT=0
local function seaAct()
if not C.sea then return end
local n=os.clock()if n-SeaT<C.seaKd then return end SeaT=n
local sb,sd=fSea()
if not sb then return end
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
local sr=rt(sb)
if not h or not sr then return end
if sd>20 then
local du=math.clamp(sd/C.speed,0.5,6)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(sr.Position+Vector3.new(0,3,0))}):Play()end end
local killT=0
local function seaKill()
if not C.seaKill or not C.sea then return end
local n=os.clock()
if n-killT<0.1 then return end killT=n
local sb,sd=fSea()
if not sb then return end
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
if not c:FindFirstChild("HasBuso")then local f=Rm()if f then pcall(function()f:InvokeServer("Buso")end)end end
if not c:FindFirstChild("HasKen")then local f=Rm()if f then pcall(function()f:InvokeServer("Ken")end)end end
local sbn=os.clock()
if sbn-S.lsk>=C.skd then
S.lsk=sbn
for _,kk in ipairs({"Z","X","C","V"})do
local k=KM[kk]
pcall(function()VIM:SendKeyEvent(true,k,false,game)VU:KeyDown(k)end)
task.wait(0.02)
pcall(function()VIM:SendKeyEvent(false,k,false,game)VU:KeyUp(k)end)
end end
if sd<C.r then atk()end end
local RPOS=Vector3.new(-400,10,-1000)
local function raidMove()
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local d=(RPOS-h.Position).Magnitude
if d>15 then
local du=math.clamp(d/C.speed,0.5,8)
local tw=TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(RPOS+Vector3.new(0,3,0))})
tw:Play()
local t0=os.clock()while tw.PlaybackState==Enum.PlaybackState.Playing and os.clock()-t0<du+1 do task.wait()end end end
local function raidBuy()local f=Rm()if not f then return end pcall(function()f:InvokeServer("RaidsNpc","Chip")end)task.wait(0.5)pcall(function()f:InvokeServer("RaidsNpc","Buy")end)end
local function raidStart()local f=Rm()if not f then return end pcall(function()f:InvokeServer("RaidsNpc","Select",C.raidType)end)task.wait(0.4)pcall(function()f:InvokeServer("RaidsNpc","Start")end)end
local function inRaid()local c=plr.Character local h=c and c:FindFirstChild("HumanoidRootPart") if not h then return false end return h.Position.Y>500 or h.Position.X<-9000 end
local function autoRaid()
if not C.raid then return end
local n=os.clock()
if n-S.raidCd<0.5 then return end S.raidCd=n
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
if inRaid()then
S.raidState="in_raid"
C.bm=true C.skillMode=2
if C.kaMode==0 then
S.kaBackup={dl=C.dl,r=C.r,skd=C.skd,bm=C.bm,sc=C.sc}
C.dl=0.05 C.r=50 C.skd=0.2 C.bm=true C.sc=0.3 C.kaMode=3 end
return
else
if C.kaMode==3 and S.kaBackup then
C.dl=S.kaBackup.dl C.r=S.kaBackup.r C.skd=S.kaBackup.skd C.bm=S.kaBackup.bm C.sc=S.kaBackup.sc C.kaMode=0
S.kaBackup=nil end end
if S.raidState=="idle"then
S.raidState="moving"
task.spawn(function()raidMove()task.wait(0.8)if C.raidBuyChip then raidBuy()task.wait(1)end raidStart()task.wait(2)S.raidState="idle"end)end end
local DP={[1]=Vector3.new(-1000,10,5000),[2]=Vector3.new(-2000,10,5000),[3]=Vector3.new(-3000,10,5000),[4]=Vector3.new(-4000,10,5000),[5]=Vector3.new(-5000,10,5000),[6]=Vector3.new(-6000,10,5000)}
local function goD(lv)
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local v=DP[lv]if not v then return end
local d=(v-h.Position).Magnitude
local du=math.clamp(d/C.speed,0.5,8)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(v)}):Play()
pcall(function()SV:SetCore("SendNotification",{Title="🌊 Sea",Text="Danger Lv "..lv,Duration=3})end)end
local BP={sea1=Vector3.new(-1200,15,3500),sea2=Vector3.new(200,15,3000),sea3=Vector3.new(-500,15,5000)}
local function buyB()
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local bp=BP[gs()]
if bp then task.spawn(function()
local dist=(bp-h.Position).Magnitude
local du=math.clamp(dist/C.speed,1,10)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(bp)}):Play()
task.wait(du+0.3)
local f=Rm()if f then pcall(function()f:InvokeServer("BuyBoat")end)pcall(function()f:InvokeServer("Boat",1)end)end end)end end
local function tSea(tg)
local f=Rm()if not f then return end
local cu=gs()
if cu==tg then pcall(function()SV:SetCore("SendNotification",{Title="DS26",Text="Đang ở "..tg:upper().." rồi!",Duration=3})end)return end
local ok=false
if cu=="sea1"and tg=="sea2"then pcall(function()f:InvokeServer("TravelDressrosa")end)ok=true end
if cu=="sea2"and tg=="sea1"then pcall(function()f:InvokeServer("TravelMain")end)ok=true end
if cu=="sea2"and tg=="sea3"then pcall(function()f:InvokeServer("TravelZou")end)ok=true end
if cu=="sea3"and tg=="sea2"then pcall(function()f:InvokeServer("TravelDressrosa")end)ok=true end
if not ok then pcall(function()SV:SetCore("SendNotification",{Title="DS26",Text="Không hỗ trợ!",Duration=4})end)end end
local function doQuest()
if not C.aq then return end
local c=plr.Character
local h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local lv=plr.Data and plr.Data.Level and plr.Data.Level.Value or 1
local q=getQuestByLevel(lv)
if not q then return end
local d=(q.npc-h.Position).Magnitude
if d>15 then
local du=math.clamp(d/C.speed,0.5,8)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(q.npc+Vector3.new(0,3,0))}):Play()
task.wait(du+0.3)
return end
if C.aqStage==0 then
local f=Rm()if f then pcall(function()f:InvokeServer("StartQuest",q.name,q.lv)end)end
C.aqStage=1
pcall(function()SV:SetCore("SendNotification",{Title="📜 Quest",Text="Đã nhận: "..q.name,Duration=3})end)
elseif C.aqStage==1 then
local f=Rm()if f then pcall(function()f:InvokeServer("CompleteQuest")end)end
C.aqStage=0
pcall(function()SV:SetCore("SendNotification",{Title="✅ Quest",Text="Đã trả: "..q.name,Duration=3})end)end end
local function svC()pcall(function()local d={r=C.r,dl=C.dl,skd=C.skd,skillMode=C.skillMode,kaMode=C.kaMode,autoFPS=C.autoFPS,af=C.af,raidType=C.raidType,raidBuyChip=C.raidBuyChip,bs=C.bs,kn=C.kn,dodge=C.dodge,stuck=C.stuck,fs=C.fs,frr=C.frr,speed=C.speed,autoEquip=C.autoEquip,weaponPref=C.weaponPref,bossPick=C.bossPick,kboss=C.kboss}writefile("ds26_cfg.json",HS:JSONEncode(d))end)end
local function ldC()local ok,d=pcall(function()if isfile and isfile("ds26_cfg.json")then return HS:JSONDecode(readfile("ds26_cfg.json"))end end)if ok and d then C.r=d.r or C.r C.dl=d.dl or C.dl C.skd=d.skd or C.skd C.skillMode=d.skillMode or C.skillMode C.kaMode=d.kaMode or C.kaMode C.autoFPS=d.autoFPS~=nil and d.autoFPS or C.autoFPS C.af=d.af~=nil and d.af or C.af C.raidType=d.raidType or C.raidType C.raidBuyChip=d.raidBuyChip~=nil and d.raidBuyChip or C.raidBuyChip C.bs=d.bs~=nil and d.bs or C.bs C.kn=d.kn~=nil and d.kn or C.kn C.dodge=d.dodge~=nil and d.dodge or C.dodge C.stuck=d.stuck~=nil and d.stuck or C.stuck C.fs=d.fs~=nil and d.fs or C.fs C.frr=d.frr or C.frr C.speed=d.speed or C.speed C.autoEquip=d.autoEquip~=nil and d.autoEquip or C.autoEquip C.weaponPref=d.weaponPref or C.weaponPref C.bossPick=d.bossPick or C.bossPick C.kboss=d.kboss~=nil and d.kboss or C.kboss end end
local function chkSt()if not C.stuck then return end local c=plr.Character local h=c and c:FindFirstChild("HumanoidRootPart")local hh=c and c:FindFirstChildOfClass("Humanoid") if not h or not hh or hh.Health<=0 then return end local mv=(h.Position-S.lastPos).Magnitude if mv<2 then S.stuckTimer=S.stuckTimer+1 if S.stuckTimer>=C.stuckT*60 then task.spawn(us)S.stuckTimer=0 end else S.stuckTimer=0 S.lastPos=h.Position end end
local function applyKA()if C.kaMode==0 then return end if not S.kaBackup then S.kaBackup={dl=C.dl,r=C.r,skd=C.skd,bm=C.bm,sc=C.sc}end if C.kaMode==1 then C.dl=0.15 C.r=30 C.skd=0.3 C.bm=true C.sc=0.6 elseif C.kaMode==2 then C.dl=0.1 C.r=40 C.skd=0.25 C.bm=true C.sc=0.4 elseif C.kaMode==3 then C.dl=0.05 C.r=50 C.skd=0.2 C.bm=true C.sc=0.3 end end
local function hb()
if not S.run then return end
local n=os.clock()
local c=plr.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")if not h or h.Health<=0 then return end
S.frameN=S.frameN+1
if n-S.fpsT>=1 then S.fps=S.frameN/(n-S.fpsT) S.frameN=0 S.fpsT=n end
if C.autoFPS and C.kaMode>0 and S.fps<25 and C.kaMode==3 then C.kaMode=2 applyKA()end
if C.autoFPS and C.kaMode>0 and S.fps<18 then
if not S.kaBackup then S.kaBackup={dl=C.dl,r=C.r,skd=C.skd,bm=C.bm,sc=C.sc}end
C.dl=S.kaBackup.dl C.r=S.kaBackup.r C.skd=S.kaBackup.skd C.bm=S.kaBackup.bm C.sc=S.kaBackup.sc
C.kaMode=0 end
bsu()kn()bm()dodge()espUp()seaAct()seaKill()autoRaid()
if n-S.espItemT>0.5 then S.espItemT=n espFruitUp()espBerryUp()espFlowerUp()end
if n-S.cleanT>5 then S.cleanT=n for k in pairs(S.espFruitHL)do if not k.Parent then S.espFruitHL[k]=nil end end for k in pairs(S.espBerryHL)do if not k.Parent then S.espBerryHL[k]=nil end end for k in pairs(S.espFlowerHL)do if not k.Parent then S.espFlowerHL[k]=nil end end end
if C.aq and n-S.aqT>5 then S.aqT=n task.spawn(doQuest)end
useSkill()chkSt()
if C.fr and n-S.lfr>=0.5 then
S.lfr=n local l=sf()S.fc=l
if C.hl then uhl(l)end
if C.nt then for _,f in ipairs(l)do if not S.fs[f.o]then S.fs[f.o]=true
pcall(function()SV:SetCore("SendNotification",{Title="🍎 Fruit!",Text=f.n.." "..math.floor(f.d).."m",Duration=5})end)end end end
if C.fs and #l>0 then task.spawn(goFr)end end
if C.cf then
if S.cbTime>0 and n-S.cbTime>3 then S.cbTime=0 end
if S.cbTime==0 then S.cbTime=n task.spawn(function()pcall(gc)S.cbTime=0 end)return end
return end
if n-S.le>=C.eq then S.le=n eq()end
local mr=rt(c)if not mr then return end
local np=sc()
if #np==0 then pu()return end
local mx=#np
if C.kaMode>0 and mx>C.kaMax then mx=C.kaMax end
local t=c:FindFirstChildOfClass("Tool")
if not t then pu()return end
local mp=mr.Position
for i=1,mx do
local tg=np[i]
if tg and tg.m and tg.m.Parent and tg.r and tg.r.Parent then
if (tg.r.Position-mp).Magnitude<=C.r then
if n-S.la>=C.dl then if atk()then S.la=n S.kc=S.kc+1 end end
return end end end
pu()end
local function st()if S.cn then S.cn:Disconnect()end S.run=true S.cn=R.Heartbeat:Connect(hb)if not S.nco then onc()end end
local function sp()S.run=false if S.cn then S.cn:Disconnect()S.cn=nil end if S.nco then dnc()end end
local function cl()
if S.cn then pcall(function()S.cn:Disconnect()end)end
if S.nc then pcall(function()S.nc:Disconnect()end)end
for _,c in ipairs(DG)do pcall(function()c:Disconnect()end)end
DG={}chl()espCl()espFruitCl()espBerryCl()espFlowerCl()
if _G.DS26 then pcall(function()_G.DS26:Destroy()end)_G.DS26=nil end end
local function bd(h,t)local a,b table.insert(DG,h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then a=i.Position b=t.Position end end))table.insert(DG,U.InputChanged:Connect(function(i)if a and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement)then local d=i.Position-a t.Position=UDim2.new(b.X.Scale,b.X.Offset+d.X,b.Y.Scale,b.Y.Offset+d.Y)end end))table.insert(DG,U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then a=nil end end))end
local function gui()
cl()
local g=Instance.new("ScreenGui")g.Name="DS26"g.ResetOnSpawn=false g.IgnoreGuiInset=true
pcall(function()g.Parent=game:GetService("CoreGui")end)if not g.Parent then g.Parent=plr:WaitForChild("PlayerGui")end
_G.DS26=g
local m=Instance.new("Frame")m.Size=UDim2.new(0,340,0,250)m.Position=UDim2.new(0,10,0,20)m.BackgroundColor3=Color3.fromRGB(18,18,22)m.BorderSizePixel=0 m.Parent=g
Instance.new("UICorner",m).CornerRadius=UDim.new(0,10)
local bord=Instance.new("UIStroke",m)bord.Color=Color3.fromRGB(80,140,255)bord.Thickness=1.5
local top=Instance.new("Frame")top.Size=UDim2.new(1,0,0,28)top.BackgroundColor3=Color3.fromRGB(32,38,58)top.BorderSizePixel=0 top.Parent=m
Instance.new("UICorner",top).CornerRadius=UDim.new(0,10)
local logo=Instance.new("TextLabel",top)logo.Size=UDim2.new(0,140,1,0)logo.Position=UDim2.new(0,10,0,0)logo.BackgroundTransparency=1 logo.Text="🐉 DS26 HUB"logo.TextColor3=Color3.fromRGB(120,180,255)logo.TextSize=13 logo.Font=Enum.Font.GothamBold logo.TextXAlignment=Enum.TextXAlignment.Left logo.Parent=top
local fpsl=Instance.new("TextLabel",top)fpsl.Size=UDim2.new(0,80,1,0)fpsl.Position=UDim2.new(1,-120,0,0)fpsl.BackgroundTransparency=1 fpsl.Text="FPS 60"fpsl.TextColor3=Color3.fromRGB(160,160,180)fpsl.TextSize=11 fpsl.Font=Enum.Font.Code fpsl.Parent=top
local close=Instance.new("TextButton",top)close.Size=UDim2.new(0,22,0,22)close.Position=UDim2.new(1,-26,0,3)close.BackgroundColor3=Color3.fromRGB(200,60,60)close.BorderSizePixel=0 close.Text="X"close.TextColor3=Color3.new(1,1,1)close.TextSize=12 close.Font=Enum.Font.GothamBold
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)
close.Parent=top
local dS,dP
table.insert(DG,top.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dS=i.Position dP=m.Position end end))
table.insert(DG,U.InputChanged:Connect(function(j)if dS and(j.UserInputType==Enum.UserInputType.Touch or j.UserInputType==Enum.UserInputType.MouseMovement)then local d=j.Position-dS m.Position=UDim2.new(dP.X.Scale,dP.X.Offset+d.X,dP.Y.Scale,dP.Y.Offset+d.Y)end end))
table.insert(DG,U.InputEnded:Connect(function(j)if j.UserInputType==Enum.UserInputType.Touch or j.UserInputType==Enum.UserInputType.MouseButton1 then dS=nil end end))
local tabBar=Instance.new("Frame")tabBar.Size=UDim2.new(1,-8,0,26)tabBar.Position=UDim2.new(0,4,0,30)tabBar.BackgroundTransparency=1 tabBar.Parent=m
local tl=Instance.new("UIListLayout",tabBar)tl.FillDirection=Enum.FillDirection.Horizontal tl.Padding=UDim.new(0,2)tl.SortOrder=Enum.SortOrder.LayoutOrder
local content=Instance.new("ScrollingFrame")content.Size=UDim2.new(1,-8,1,-62)content.Position=UDim2.new(0,4,0,60)content.BackgroundTransparency=1 content.BorderSizePixel=0 content.CanvasSize=UDim2.new(0,0,0,0)content.AutomaticCanvasSize=Enum.AutomaticSize.Y content.ScrollBarThickness=3 content.ScrollBarImageColor3=Color3.fromRGB(80,140,255)content.Parent=m
local cl2=Instance.new("UIListLayout",content)cl2.Padding=UDim.new(0,3)cl2.SortOrder=Enum.SortOrder.LayoutOrder
local function mb(txt,col,cb)local b=Instance.new("TextButton",content)b.Size=UDim2.new(1,-4,0,26)b.BackgroundColor3=col b.BorderSizePixel=0 b.Text=txt b.TextColor3=Color3.new(1,1,1)b.TextSize=11 b.Font=Enum.Font.GothamBold Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(cb)return b end
local tabs={}
local function addTab(icon,name,builder)
local b=Instance.new("TextButton",tabBar)b.Size=UDim2.new(0,32,1,0)b.BackgroundColor3=Color3.fromRGB(38,44,66)b.BorderSizePixel=0 b.Text=icon b.TextSize=15 b.Font=Enum.Font.GothamBold b.TextColor3=Color3.fromRGB(200,200,220)
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
for _,ch in ipairs(content:GetChildren())do if not ch:IsA("UIListLayout")then ch:Destroy()end end
for _,tb in pairs(tabs)do tb.btn.BackgroundColor3=Color3.fromRGB(38,44,66)end
b.BackgroundColor3=Color3.fromRGB(70,130,255)
builder()end)
tabs[name]={btn=b,builder=builder}
return b end
addTab("⚔","combat",function()
local tg
tg=mb("⏸ DỪNG",Color3.fromRGB(200,70,70),function()if S.run then sp()tg.Text="▶ CHẠY"tg.BackgroundColor3=Color3.fromRGB(70,180,100)else st()tg.Text="⏸ DỪNG"tg.BackgroundColor3=Color3.fromRGB(200,70,70)C.bm=true end end)
local ka
ka=mb("💥 Kill All: OFF",Color3.fromRGB(60,40,60),function()if C.kaMode==3 and S.kaBackup then C.dl=S.kaBackup.dl C.r=S.kaBackup.r C.skd=S.kaBackup.skd C.bm=S.kaBackup.bm C.sc=S.kaBackup.sc S.kaBackup=nil end if C.kaMode==0 then C.kaMode=1 ka.Text="💥 Kill All: NHẸ"ka.BackgroundColor3=Color3.fromRGB(120,60,60)elseif C.kaMode==1 then C.kaMode=2 ka.Text="💥 Kill All: VỪA"ka.BackgroundColor3=Color3.fromRGB(180,80,60)elseif C.kaMode==2 then C.kaMode=3 ka.Text="💥 Kill All: MẠNH"ka.BackgroundColor3=Color3.fromRGB(255,100,50)else C.kaMode=0 ka.Text="💥 Kill All: OFF"ka.BackgroundColor3=Color3.fromRGB(60,40,60)end applyKA()end)
local sk
sk=mb("🎯 Auto Skill: OFF",Color3.fromRGB(60,40,60),function()if C.skillMode==0 then C.skillMode=1 sk.Text="🎯 Auto Skill: THỨ TỰ"sk.BackgroundColor3=Color3.fromRGB(140,60,140)elseif C.skillMode==1 then C.skillMode=2 sk.Text="🎯 Auto Skill: CÙNG LÚC"sk.BackgroundColor3=Color3.fromRGB(180,80,180)else C.skillMode=0 sk.Text="🎯 Auto Skill: OFF"sk.BackgroundColor3=Color3.fromRGB(60,40,60)end end)
local bs=mb("🔥 Buso: ON",Color3.fromRGB(180,50,50),function()C.bs=not C.bs bs.Text="🔥 Buso: "..(C.bs and"ON"or"OFF")end)
local kn2=mb("👁 Ken: ON",Color3.fromRGB(100,180,100),function()C.kn=not C.kn kn2.Text="👁 Ken: "..(C.kn and"ON"or"OFF")end)
local bo=mb("👹 Boss Only: OFF",Color3.fromRGB(180,80,30),function()C.bs2=not C.bs2 bo.Text="👹 Boss Only: "..(C.bs2 and"ON"or"OFF")end)
local aff=mb("⚡ Auto FPS: ON",Color3.fromRGB(60,120,120),function()C.autoFPS=not C.autoFPS aff.Text="⚡ Auto FPS: "..(C.autoFPS and"ON"or"OFF")end)
end)
addTab("🗺","travel",function()
local dg
dg=mb("❤️ Né Đòn: OFF",Color3.fromRGB(200,80,120),function()C.dodge=not C.dodge dg.Text="❤️ Né Đòn: "..(C.dodge and"ON"or"OFF")dg.BackgroundColor3=C.dodge and Color3.fromRGB(255,120,160)or Color3.fromRGB(200,80,120)end)
mb("🆘 Chống Kẹt",Color3.fromRGB(220,140,40),function()task.spawn(us)end)
local spb
spb=mb("⚡ Tốc độ bay: "..C.speed,Color3.fromRGB(80,120,180),function()if C.speed==100 then C.speed=200 spb.Text="⚡ Tốc độ bay: 200"elseif C.speed==200 then C.speed=350 spb.Text="⚡ Tốc độ bay: 350"elseif C.speed==350 then C.speed=500 spb.Text="⚡ Tốc độ bay: 500"elseif C.speed==500 then C.speed=800 spb.Text="⚡ Tốc độ bay: 800"else C.speed=100 spb.Text="⚡ Tốc độ bay: 100"end pcall(function()SV:SetCore("SendNotification",{Title="⚡ Speed",Text="Đã đổi: "..C.speed.." studs/s",Duration=2})end)end)
mb("🏝 Teleport Đảo",Color3.fromRGB(60,130,200),function()
for _,ch in ipairs(content:GetChildren())do if not ch:IsA("UIListLayout")then ch:Destroy()end end
mb("◀ Quay lại Travel",Color3.fromRGB(100,140,80),function()tabs.travel.btn.MouseButton1Click:Fire()end)
local sea=gs()
for _,i in ipairs(ISL[sea]or{})do
mb(i[1],Color3.fromRGB(60,90,140),function()task.spawn(function()tp(i)end)end)
end end)
end)
addTab("🎒","farm",function()
local aqb
aqb=mb("📜 Auto Quest: OFF",Color3.fromRGB(180,140,60),function()C.aq=not C.aq C.aqStage=0 aqb.Text="📜 Auto Quest: "..(C.aq and"ON"or"OFF")aqb.BackgroundColor3=C.aq and Color3.fromRGB(220,180,80)or Color3.fromRGB(180,140,60) if C.aq then local lv=plr.Data and plr.Data.Level and plr.Data.Level.Value or 1 local q=getQuestByLevel(lv) if q then pcall(function()SV:SetCore("SendNotification",{Title="📜 Quest",Text="Sẽ nhận: "..q.name,Duration=4})end)end end end)
local afb
afb=mb("🏃 Auto Farm Level: OFF",Color3.fromRGB(60,140,80),function()C.af=not C.af afb.Text="🏃 Auto Farm Level: "..(C.af and"ON"or"OFF")afb.BackgroundColor3=C.af and Color3.fromRGB(80,200,100)or Color3.fromRGB(60,140,80) if C.af then C.bm=true pcall(function()SV:SetCore("SendNotification",{Title="🏃 AF",Text="Bring Mob tự bật (250m)",Duration=3})end)end end)
local ck
ck=mb("📦 Chest: OFF",Color3.fromRGB(90,70,50),function()C.cf=not C.cf ck.Text="📦 Chest: "..(C.cf and"ON"or"OFF")end)
local bmb
bmb=mb("🧲 Bring Mob: OFF",Color3.fromRGB(60,140,140),function()C.bm=not C.bm bmb.Text="🧲 Bring Mob: "..(C.bm and"ON"or"OFF")bmb.BackgroundColor3=C.bm and Color3.fromRGB(80,200,180)or Color3.fromRGB(60,140,140)end)
local pkb
pkb=mb("💰 Pickup: ON",Color3.fromRGB(180,150,50),function()C.pu=not C.pu pkb.Text="💰 Pickup: "..(C.pu and"ON"or"OFF")end)
local ast
ast=mb("🛡 Anti-Stuck: OFF",Color3.fromRGB(120,100,80),function()C.stuck=not C.stuck ast.Text="🛡 Anti-Stuck: "..(C.stuck and"ON"or"OFF")ast.BackgroundColor3=C.stuck and Color3.fromRGB(180,150,100)or Color3.fromRGB(120,100,80)end)
mb("💾 Save Config",Color3.fromRGB(80,120,80),function()svC()pcall(function()SV:SetCore("SendNotification",{Title="DS26",Text="Đã lưu",Duration=3})end)end)
mb("📂 Load Config",Color3.fromRGB(80,120,80),function()ldC()pcall(function()SV:SetCore("SendNotification",{Title="DS26",Text="Đã load",Duration=3})end)end)
end)
addTab("🍎","fruit",function()
local ff
ff=mb("🍎 Fruit Finder: OFF",Color3.fromRGB(160,60,100),function()C.fr=not C.fr ff.Text="🍎 Fruit Finder: "..(C.fr and"ON"or"OFF")if not C.fr then chl()end end)
local afr
afr=mb("🍎 Auto Tween Fruit: OFF",Color3.fromRGB(200,100,150),function()C.fs=not C.fs afr.Text="🍎 Auto Tween Fruit: "..(C.fs and"ON"or"OFF")afr.BackgroundColor3=C.fs and Color3.fromRGB(240,140,180)or Color3.fromRGB(200,100,150)end)
local hlg
hlg=mb("✨ Highlight: OFF",Color3.fromRGB(120,60,180),function()C.hl=not C.hl hlg.Text="✨ Highlight: "..(C.hl and"ON"or"OFF")if not C.hl then chl()end end)
mb("🍎 TP Fruit Gần Nhất",Color3.fromRGB(200,60,140),function()task.spawn(goFr)end)
end)
addTab("👤","esp",function()
local esp
esp=mb("👤 ESP Player: OFF",Color3.fromRGB(60,180,60),function()C.esp=not C.esp esp.Text="👤 ESP Player: "..(C.esp and"ON"or"OFF")esp.BackgroundColor3=C.esp and Color3.fromRGB(80,255,80)or Color3.fromRGB(60,180,60)if not C.esp then espCl()end end)
local ef
ef=mb("🍎 ESP Fruit: OFF",Color3.fromRGB(200,60,140),function()C.espFruit=not C.espFruit ef.Text="🍎 ESP Fruit: "..(C.espFruit and"ON"or"OFF")ef.BackgroundColor3=C.espFruit and Color3.fromRGB(255,100,180)or Color3.fromRGB(140,40,90)if not C.espFruit then espFruitCl()end end)
local eb
eb=mb("🫐 ESP Berry: OFF",Color3.fromRGB(80,60,180),function()C.espBerry=not C.espBerry eb.Text="🫐 ESP Berry: "..(C.espBerry and"ON"or"OFF")eb.BackgroundColor3=C.espBerry and Color3.fromRGB(120,100,240)or Color3.fromRGB(50,40,120)if not C.espBerry then espBerryCl()end end)
local efl
efl=mb("🌸 ESP Flower: OFF",Color3.fromRGB(200,120,180),function()C.espFlower=not C.espFlower efl.Text="🌸 ESP Flower: "..(C.espFlower and"ON"or"OFF")efl.BackgroundColor3=C.espFlower and Color3.fromRGB(255,160,220)or Color3.fromRGB(120,60,100)if not C.espFlower then espFlowerCl()end end)
mb("❌ Tắt hết ESP",Color3.fromRGB(120,60,60),function()espCl()espFruitCl()espBerryCl()espFlowerCl()end)
end)
addTab("👹","bosstab",function()
local h1=Instance.new("TextLabel",content)h1.Size=UDim2.new(1,-4,0,22)h1.BackgroundColor3=Color3.fromRGB(80,40,40)h1.BorderSizePixel=0 h1.Text="👹 BOSS FARMER"h1.TextColor3=Color3.new(1,1,1)h1.TextSize=11 h1.Font=Enum.Font.GothamBold
Instance.new("UICorner",h1).CornerRadius=UDim.new(0,6)
local kb
kb=mb("⚔ Kill Boss: OFF",Color3.fromRGB(120,50,50),function()C.kboss=not C.kboss kb.Text="⚔ Kill Boss: "..(C.kboss and"ON"or"OFF")kb.BackgroundColor3=C.kboss and Color3.fromRGB(200,60,60)or Color3.fromRGB(120,50,50)if C.kboss then C.bm=true C.skillMode=2 pcall(function()SV:SetCore("SendNotification",{Title="👹 Boss",Text="Đang tìm: "..(C.bossPick==""and"Tất cả"or C.bossPick),Duration=3})end)end end)
local pickLbl
pickLbl=Instance.new("TextLabel",content)pickLbl.Size=UDim2.new(1,-4,0,22)pickLbl.BackgroundColor3=Color3.fromRGB(60,40,40)pickLbl.BorderSizePixel=0 pickLbl.Text="Chọn: "..(C.bossPick==""and"Tất cả boss"or C.bossPick)pickLbl.TextColor3=Color3.fromRGB(255,200,180)pickLbl.TextSize=11 pickLbl.Font=Enum.Font.GothamBold
Instance.new("UICorner",pickLbl).CornerRadius=UDim.new(0,6)
local allb
allb=mb("🌐 Tất cả Boss",Color3.fromRGB(80,100,120),function()C.bossPick=""C.kboss=true C.bm=true pickLbl.Text="Chọn: Tất cả boss"kb.Text="⚔ Kill Boss: ON"kb.BackgroundColor3=Color3.fromRGB(200,60,60)pcall(function()SV:SetCore("SendNotification",{Title="👹 Boss",Text="Farm TẤT CẢ boss",Duration=3})end)end)
local l2=Instance.new("TextLabel",content)l2.Size=UDim2.new(1,-4,0,22)l2.BackgroundColor3=Color3.fromRGB(50,50,70)l2.BorderSizePixel=0 l2.Text="👇 Chọn boss cụ thể:"l2.TextColor3=Color3.fromRGB(220,220,255)l2.TextSize=11 l2.Font=Enum.Font.GothamBold
Instance.new("UICorner",l2).CornerRadius=UDim.new(0,6)
for _,bname in ipairs(BOSS_LIST)do
mb("👹 "..bname,Color3.fromRGB(100,50,50),function()C.bossPick=bname C.kboss=true C.bm=true C.skillMode=2 pickLbl.Text="Chọn: "..bname kb.Text="⚔ Kill Boss: ON"kb.BackgroundColor3=Color3.fromRGB(200,60,60)pcall(function()SV:SetCore("SendNotification",{Title="👹 Boss",Text="Đang tìm: "..bname,Duration=3})end)end)
end
mb("❌ Tắt Kill Boss",Color3.fromRGB(80,80,80),function()C.kboss=false C.bossPick=""kb.Text="⚔ Kill Boss: OFF"kb.BackgroundColor3=Color3.fromRGB(120,50,50)pickLbl.Text="Chọn: Tất cả boss"pcall(function()SV:SetCore("SendNotification",{Title="👹 Boss",Text="Đã tắt",Duration=2})end)end)
end)
addTab("🌊","sea",function()
mb("🛒 Mua Thuyền",Color3.fromRGB(120,90,60),function()task.spawn(buyB)end)
mb("🌊 Sea 2",Color3.fromRGB(60,140,200),function()tSea("sea2")end)
mb("🌊 Sea 3",Color3.fromRGB(80,180,240),function()tSea("sea3")end)
mb("⚡ DANGER 1-6 (Sea 3):",Color3.fromRGB(40,60,80),function()end)
for lv=1,6 do
mb("⚡ Danger Lv "..lv,Color3.fromRGB(50+lv*20,50+lv*10,120+lv*10),function()goD(lv)end)
end
local sev
sev=mb("🌊 Sea Event: OFF",Color3.fromRGB(50,100,180),function()C.sea=not C.sea sev.Text="🌊 Sea Event: "..(C.sea and"ON"or"OFF")sev.BackgroundColor3=C.sea and Color3.fromRGB(80,160,240)or Color3.fromRGB(50,100,180)end)
local sak
sak=mb("⚔ Auto Kill Sea: OFF",Color3.fromRGB(200,80,50),function()C.seaKill=not C.seaKill sak.Text="⚔ Auto Kill Sea: "..(C.seaKill and"ON"or"OFF")sak.BackgroundColor3=C.seaKill and Color3.fromRGB(255,120,60)or Color3.fromRGB(200,80,50)end)
end)
addTab("🌋","raid",function()
local raLbl=Instance.new("TextLabel",content)raLbl.Size=UDim2.new(1,-4,0,22)raLbl.BackgroundColor3=Color3.fromRGB(60,40,40)raLbl.BorderSizePixel=0 raLbl.Text="Chọn: "..C.raidType raLbl.TextColor3=Color3.new(1,1,1)raLbl.TextSize=11 raLbl.Font=Enum.Font.GothamBold
Instance.new("UICorner",raLbl).CornerRadius=UDim.new(0,6)
local raidList={"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human","Buddha","Spider","Chop","Spring","Bomb","Smoke","Spike","Sand","Door","Rubber","Barrier","Revive","Phoenix"}
for _,rt2 in ipairs(raidList)do
mb(rt2,Color3.fromRGB(100,50,50),function()C.raidType=rt2 raLbl.Text="Chọn: "..rt2 end)
end
local rc
rc=mb("🛒 Mua Chip: ON",Color3.fromRGB(150,100,50),function()C.raidBuyChip=not C.raidBuyChip rc.Text="🛒 Mua Chip: "..(C.raidBuyChip and"ON"or"OFF")end)
local ra
ra=mb("▶ Bắt Đầu Raid",Color3.fromRGB(60,180,60),function()C.raid=not C.raid ra.Text=(C.raid and"⏸ Dừng Raid"or"▶ Bắt Đầu Raid")ra.BackgroundColor3=C.raid and Color3.fromRGB(200,60,60)or Color3.fromRGB(60,180,60)if C.raid then C.bm=true C.skillMode=2 end end)
end)
addTab("⚙","setting",function()
local l1=Instance.new("TextLabel",content)l1.Size=UDim2.new(1,-4,0,22)l1.BackgroundColor3=Color3.fromRGB(40,60,80)l1.BorderSizePixel=0 l1.Text="🎯 Ưu tiên vũ khí"l1.TextColor3=Color3.new(1,1,1)l1.TextSize=11 l1.Font=Enum.Font.GothamBold
Instance.new("UICorner",l1).CornerRadius=UDim.new(0,6)
local mb1
mb1=mb("⚔ Võ (Melee): "..(C.weaponPref.Melee and"BẬT"or"TẮT"),Color3.fromRGB(120,50,50),function()C.weaponPref.Melee=not C.weaponPref.Melee mb1.Text="⚔ Võ (Melee): "..(C.weaponPref.Melee and"BẬT"or"TẮT")mb1.BackgroundColor3=C.weaponPref.Melee and Color3.fromRGB(180,70,70)or Color3.fromRGB(80,40,40)end)
local mb2
mb2=mb("🗡 Kiếm (Sword): "..(C.weaponPref.Sword and"BẬT"or"TẮT"),Color3.fromRGB(80,40,40),function()C.weaponPref.Sword=not C.weaponPref.Sword mb2.Text="🗡 Kiếm (Sword): "..(C.weaponPref.Sword and"BẬT"or"TẮT")mb2.BackgroundColor3=C.weaponPref.Sword and Color3.fromRGB(150,80,200)or Color3.fromRGB(80,40,40)end)
local mb3
mb3=mb("🔫 Súng (Gun): "..(C.weaponPref.Gun and"BẬT"or"TẮT"),Color3.fromRGB(80,40,40),function()C.weaponPref.Gun=not C.weaponPref.Gun mb3.Text="🔫 Súng (Gun): "..(C.weaponPref.Gun and"BẬT"or"TẮT")mb3.BackgroundColor3=C.weaponPref.Gun and Color3.fromRGB(80,120,200)or Color3.fromRGB(80,40,40)end)
local mb4
mb4=mb("🍎 Trái (Fruit): "..(C.weaponPref.Fruit and"BẬT"or"TẮT"),Color3.fromRGB(140,60,100),function()C.weaponPref.Fruit=not C.weaponPref.Fruit mb4.Text="🍎 Trái (Fruit): "..(C.weaponPref.Fruit and"BẬT"or"TẮT")mb4.BackgroundColor3=C.weaponPref.Fruit and Color3.fromRGB(200,100,150)or Color3.fromRGB(80,40,40)end)
local info=Instance.new("TextLabel",content)info.Size=UDim2.new(1,-4,0,40)info.BackgroundColor3=Color3.fromRGB(30,40,60)info.BorderSizePixel=0 info.Text="Thứ tự: Võ > Trái > Kiếm > Súng. Trái không M1 → auto Skill"info.TextColor3=Color3.fromRGB(200,220,255)info.TextSize=10 info.Font=Enum.Font.Gotham info.TextWrapped=true
Instance.new("UICorner",info).CornerRadius=UDim.new(0,6)
local ae
ae=mb("🔄 Auto Equip: ON",Color3.fromRGB(60,90,140),function()C.autoEquip=not C.autoEquip ae.Text="🔄 Auto Equip: "..(C.autoEquip and"ON"or"OFF")end)
end)
task.spawn(function()while S.run do task.wait(1)fpsl.Text="FPS "..math.floor(S.fps)end end)
local ob=Instance.new("TextButton",g)ob.Size=UDim2.new(0,42,0,42)ob.Position=UDim2.new(1,-58,0,100)ob.BackgroundColor3=Color3.fromRGB(80,140,255)ob.BorderSizePixel=0 ob.Text="🐉"ob.TextSize=20 ob.Font=Enum.Font.GothamBold ob.Visible=false
Instance.new("UICorner",ob).CornerRadius=UDim.new(1,0)
bd(ob,ob)
close.MouseButton1Click:Connect(function()m.Visible=false ob.Visible=true end)
ob.MouseButton1Click:Connect(function()m.Visible=true ob.Visible=false end)
tabs.combat.btn.MouseButton1Click:Fire()
end
ldC() st() gui()
