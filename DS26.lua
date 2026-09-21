local P,R,W,U,SV=game:GetService("Players"),game:GetService("RunService"),game:GetService("Workspace"),game:GetService("UserInputService"),game:GetService("StarterGui")
local TS,VIM,VU,HS=game:GetService("TweenService"),game:GetService("VirtualInputManager"),game:GetService("VirtualUser"),game:GetService("HttpService")
local plr=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")
local CT=3
local C={r=14,dl=0.5,sc=1.2,eq=0.7,skd=0.6,skillMode=2,bs=true,kn=true,knd=3,pu=true,pr=30,bm=false,bmr=300,fr=false,frr=5000,fs=true,cf=false,ct=300,hl=false,nt=true,bs2=false,dodge=false,hpr=30,hpCd=8,dodgeR=35,dodgeCd=1.2,kaMode=0,autoFPS=true,kaMax=15,esp=false,stuck=false,stuckT=3,sea=false,seaKd=0.5,seaKill=false,raid=false,raidType="Flame",raidBuyChip=true,af=false,afR=250,kw={"Melee","Combat","Black Leg","Electro","Dragon Claw","Superhuman"}}
local S={run=true,c={},ls=0,la=0,le=0,cn=nil,lsk=0,lbs=0,lkn=0,lpu=0,lbr=0,lfr=0,lhp=0,fc={},fs=setmetatable({},{__mode="k"}),hls={},esps={},cbTime=0,nc=nil,kc=0,t0=os.clock(),ci=1,lastPos=Vector3.zero,stuckTimer=0,nco=false,lastHP=0,dodgeT=0,lastHPLoss=0,raidState="idle",raidCd=0,kaBackup=nil,frameN=0,fpsT=0,fps=60,frT=0}
local RP=RaycastParams.new()RP.FilterType=Enum.RaycastFilterType.Exclude
local DG,CO={},setmetatable({},{__mode="k"})
local SEAS={[2753915549]="sea1",[4442272183]="sea2",[7449423635]="sea3"}
local ISL={sea1={{"Starter",0,10,0},{"MarineFort",-4700,10,4200},{"Middle",-700,10,1200},{"Jungle",-1500,10,200},{"Pirate",-3000,10,3300},{"Desert",-1200,10,3500},{"Frozen",-1000,10,6000},{"MarineFord",-5000,10,4200},{"Skylands",-5000,550,2500},{"Prison",5000,10,1000},{"Colosseum",-1500,100,-3000},{"Magma",-5200,10,5000},{"Underwater",-3700,100,6000},{"Fountain",-5000,100,4000}},sea2={{"Kingdom",200,10,3000},{"Cafe",-200,10,3000},{"Mansion",500,10,3000},{"Grave",5000,10,500},{"SnowMt",2000,200,-5000},{"HotCold",5000,10,-2000},{"Cursed",2000,10,5000},{"IceCastle",5000,100,-5000},{"Forgot",-3000,10,-4000},{"Green",200,10,-5000},{"Diamond",5000,10,-1500}},sea3={{"Port",-500,10,5000},{"Hydra",5000,10,2000},{"Tree",3000,100,-2000},{"Turtle",-1000,100,-5000},{"Castle",-5000,100,-5000},{"Treats",-2000,100,5000},{"CastleSea",-5000,100,-1000},{"PiratePort",-5000,100,5000},{"Sunflower",-1000,100,3000}}}
local function gs()return SEAS[game.PlaceId]or"sea1"end
local function tp(p)
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local v=Vector3.new(p[2],p[3],p[4])
local d=(v-h.Position).Magnitude
local du=math.clamp(d/800,0.5,6)
local st=math.max(1,math.ceil(du/1.5))
task.spawn(function() for i=1,st do
if not h.Parent then return end
local tg=h.Position:Lerp(v+Vector3.new(0,3,0),1/(st-i+1))
TS:Create(h,TweenInfo.new(du/st,Enum.EasingStyle.Linear),{CFrame=CFrame.new(tg)}):Play()
task.wait(du/st) end end) end
local function ib(p)return p:IsA("BasePart")and not p:FindFirstAncestorOfClass("Tool")and not p:FindFirstAncestorOfClass("Accessory")end
local BL={"Rip Indra","Dough King","Cursed Captain","Order","Longma","Darkbeard","Graybeard","Soul Reaper","Don Swan","Jeremy"}
local function isB(n)for _,b in ipairs(BL)do if string.find(n:lower(),b:lower(),1,true)then return true end end return false end
local function en(m)
if not m or not m.Parent or not m:IsA("Model")or m==plr.Character then return false end
local h=m:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 or m:FindFirstChildOfClass("ForceField")then return false end
if C.bs2 and not isB(m.Name)then return false end
local tp2=P:GetPlayerFromCharacter(m)
if tp2 and tp2.Team and plr.Team and tp2.Team==plr.Team then return false end
return true end
local function rt(m)return m and(m:FindFirstChild("HumanoidRootPart")or m:FindFirstChild("UpperTorso")or m.PrimaryPart)end
local function ct()
local l={}
for _,n in ipairs({"Enemies","NPCs","Mobs","Monsters"})do local f=W:FindFirstChild(n)if f then table.insert(l,f)end end
if #l==0 then table.insert(l,W)end return l end
local function sc()
local t=os.clock()if t-S.ls<C.sc then return S.c end
S.ls=t local f={} local c=plr.Character
if not c then S.c=f return f end
local mr=rt(c)if not mr then S.c=f return f end
local mp=mr.Position
for _,cc in ipairs(ct())do for _,o in ipairs(cc:GetChildren())do
if en(o)then local r=rt(o)
if r and math.abs(r.Position.Y-mp.Y)<=8 then local d=(r.Position-mp).Magnitude
if d<=C.r then table.insert(f,{m=o,r=r,d=d})end end end end end
table.sort(f,function(a,b)return a.d<b.d end)S.c=f return f end
local function eq()
local c=plr.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")if not h then return end
local cu=c:FindFirstChildOfClass("Tool")
if cu then for _,k in ipairs(C.kw)do if string.find(cu.Name:lower(),k:lower(),1,true)then return end end end
local bp=plr:FindFirstChild("Backpack")if not bp then return end
for _,t in ipairs(bp:GetChildren())do if t:IsA("Tool")then
for _,k in ipairs(C.kw)do if string.find(t.Name:lower(),k:lower(),1,true)then pcall(function()h:EquipTool(t)end)return end end end end end
local function atk()
local c=plr.Character local t=c and c:FindFirstChildOfClass("Tool")
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
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local mp=h.Position
for _,o in ipairs(W:GetChildren())do if o:IsA("Tool")and o:FindFirstChild("Handle")then
if (o.Handle.Position-mp).Magnitude<=C.pr then
TS:Create(h,TweenInfo.new(0.25),{CFrame=CFrame.new(o.Handle.Position)}):Play()return end end end end
-- BRING MOB (Auto Farm Level dùng phạm vi 250)
local function bm()
if not C.bm and not C.af then return end
local n=os.clock()
local interval=0.15
if C.af and not C.bm then interval=0.3 end
if n-S.lbr<interval then return end S.lbr=n
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local mp=h.Position
local range=C.bmr
if C.af then range=C.afR end
for _,cc in ipairs(ct())do for _,o in ipairs(cc:GetChildren())do
if en(o)then
local hh=o:FindFirstChildOfClass("Humanoid")
local r=rt(o)
if hh and r and (r.Position-mp).Magnitude<=range then
pcall(function()hh:MoveTo(mp)end)
end end end end end
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
local dodgeDir=(h2.Position-Vector3.new(0,h2.Position.Y,0)).Unit
local target=h2.Position+dodgeDir*60+Vector3.new(0,50,0)
TS:Create(h2,TweenInfo.new(0.3,Enum.EasingStyle.Linear),{CFrame=CFrame.new(target)}):Play()
S.lastHPLoss=0
return end
local sb,sd=fSea()
if sb and sd<C.dodgeR then
S.dodgeT=n
h2.AssemblyLinearVelocity=Vector3.new(0,120,0)
end end
local FK={"rocket","spin","chop","spring","bomb","smoke","spike","flame","falcon","ice","sand","dark","diamond","light","rubber","barrier","magma","door","quake","human","buddha","love","spider","sound","phoenix","portal","rumble","pain","blizzard","gravity","mammoth","trex","dough","shadow","venom","control","spirit","dragon","leopard","kitsune","yeti","gas","creation","revive","eagle","lightning"}
local function ifr(o)
if not o or not o:IsA("Tool")or not o:FindFirstChild("Handle")then return false end
local c=plr.Character if c and o:IsDescendantOf(c)then return false end
for _,k in ipairs(FK)do if string.find(o.Name:lower(),k,1,true)then return true end end return false end
local function sf()
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return{}end
local mp=h.Position local l={}
for _,o in ipairs(W:GetChildren())do if ifr(o)then
local hh=o:FindFirstChild("Handle")local d=(hh.Position-mp).Magnitude
if d<=C.frr then table.insert(l,{n=o.Name,d=d,p=hh.Position,o=o})end end end
table.sort(l,function(a,b)return a.d<b.d end)return l end
local function chl()for _,h in pairs(S.hls)do pcall(function()h:Destroy()end)end S.hls={}end
local function uhl(l)
chl()if not C.hl then return end
for _,f in ipairs(l)do if f.o and f.o.Parent then
local h=Instance.new("Highlight")h.FillColor=Color3.fromRGB(255,80,180)h.FillTransparency=0.5 h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Adornee=f.o h.Parent=f.o
S.hls[f.o]=h end end end
local function espCl()
for _,e in pairs(S.esps)do
if e.hl then pcall(function()e.hl:Destroy()end)end
if e.nm then pcall(function()e.nm:Destroy()end)end end
S.esps={}end
local espT=0
local function espUp()
if not C.esp then if next(S.esps)then espCl()end return end
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
local mp=h and h.Position
local dD=(os.clock()-espT>0.5)if dD then espT=os.clock()end
for _,p in ipairs(P:GetPlayers())do if p~=plr then
local c2=p.Character hh=c2 and c2:FindFirstChildOfClass("Humanoid")local ro=c2 and rt(c2)
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
local function scc(c,s)
for _,p in ipairs(c:GetDescendants())do if ib(p)then
if s==false then if CO[p]==nil then CO[p]=p.CanCollide end p.CanCollide=false
else local o=CO[p]p.CanCollide=(o==nil)and true or o CO[p]=nil end end end end
local function onc()
S.nco=true local c=plr.Character if not c then return end
scc(c,false)if S.nc then S.nc:Disconnect()end
S.nc=R.Heartbeat:Connect(function()
local c2=plr.Character if not c2 then return end
for _,p in ipairs(c2:GetDescendants())do if ib(p)and p.CanCollide then if CO[p]==nil then CO[p]=true end p.CanCollide=false end end end)end
local function dnc()
S.nco=false if S.nc then S.nc:Disconnect()S.nc=nil end
local c=plr.Character if not c then return end scc(c,true)end
plr.CharacterAdded:Connect(function()S.c={}S.ls=0 S.la=0 S.le=0 S.lsk=0 S.lbs=0 S.lkn=0 S.lpu=0 S.lbr=0 S.lfr=0 S.lhp=0 S.cbTime=0 S.ci=1 S.stuckTimer=0 S.lastHP=0
if S.nco then task.wait(0.5)if S.nco then onc()end end end)
local function us()
local c=plr.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart")local hm=c:FindFirstChildOfClass("Humanoid")
if not h then return end
h.Velocity=Vector3.zero h.AssemblyLinearVelocity=Vector3.zero h.AssemblyAngularVelocity=Vector3.zero h.Anchored=false
if hm then hm.PlatformStand=false pcall(function()hm:ChangeState(Enum.HumanoidStateType.GettingUp)end)end
h.CFrame=h.CFrame+Vector3.new(0,-3,0)task.wait(0.3)
if not h.Parent then return end
local ry=RaycastParams.new()ry.FilterType=Enum.RaycastFilterType.Exclude ry.FilterDescendantsInstances={c}
local hi=W:Raycast(h.Position,Vector3.new(0,-500,0),ry)
if hi then h.CFrame=CFrame.new(hi.Position+Vector3.new(0,4,0))end end
local CK={"daimon","demon","gold","chest"}
local function ic(o)
if not o or o:IsA("Player")or o:FindFirstChildOfClass("Humanoid")then return false end
for _,k in ipairs(CK)do if string.find(o.Name:lower(),k,1,true)then return o:IsA("Model")or o:IsA("BasePart")end end return false end
local function ctr(o)
local n=o.Name:lower()
if string.find(n,"daimon",1,true)or string.find(n,"demon",1,true)then return 3 end
if string.find(n,"gold",1,true)then return 2 end return 1 end
local function crt(o)if o:IsA("BasePart")then return o end return o:FindFirstChild("HumanoidRootPart")or o:FindFirstChild("Base")or o:FindFirstChild("Handle")or o.PrimaryPart end
local function fc()
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return nil end
local mp=h.Position local be,bt,bd=nil,0,math.huge
local fo={}
for _,n in ipairs({"Chests","Chest","Rewards"})do local f=W:FindFirstChild(n)if f then table.insert(fo,f)end end
if #fo==0 then table.insert(fo,W)end
for _,ff in ipairs(fo)do for _,o in ipairs(ff:GetChildren())do
if ic(o)then local r=crt(o)
if r and r.Parent then local d=(r.Position-mp).Magnitude
if d<=C.ct then local t=ctr(o)
if t>bt or(t==bt and d<bd)then be,bt,bd=o,t,d end end end end end end
return be end
local function gc()
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")hh=c and c:FindFirstChildOfClass("Humanoid")
if not h or not hh or hh.Health<=0 then return end
local c2=fc()if not c2 then return end
local r=crt(c2)if not r then return end
local tw=TS:Create(h,TweenInfo.new(0.4),{CFrame=CFrame.new(r.Position+Vector3.new(0,2,0))})
local dn=false tw.Completed:Once(function()dn=true end)tw:Play()
local t0=os.clock()while not dn and os.clock()-t0<2 do task.wait()end
task.wait(0.3)end
local function goFr()
if not C.fs or #S.fc==0 then return end
local n=os.clock()if n-S.frT<1 then return end S.frT=n
local f=S.fc[1]
if not f or not f.o or not f.o.Parent then return end
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local d=(f.p-h.Position).Magnitude
if d<5 then return end
local du=math.clamp(d/300,0.3,3)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(f.p)}):Play()end
local SKW={"terror shark","terror","shark","sea beast","seabeast","sea king","seaking","ghostship","ghost ship","pirate ship","pirate grand","rumbling","strong sea","kraken","leviathan","hydra","fishman"}
local function isSea(m)
if not m or not m.Parent or not m:IsA("Model")then return false end
local h=m:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 then return false end
local n=string.lower(m.Name)
for _,k in ipairs(SKW)do if string.find(n,k,1,true)then return true end end
return false end
local function fSea()
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return nil,0 end
local mp=h.Position local be,bd=nil,math.huge
local fo={W}
for _,fn in ipairs({"SeaBeasts","Sea","SeaEvents","Effects"})do local f=W:FindFirstChild(fn)if f then table.insert(fo,f)end end
for _,f in ipairs(fo)do for _,o in ipairs(f:GetChildren())do
if isSea(o)then local r=rt(o)
if r then local d=(r.Position-mp).Magnitude
if d<bd then be,bd=o,d end end end end end
return be,bd end
local SeaT=0
local function seaAct()
if not C.sea then return end
local n=os.clock()if n-SeaT<C.seaKd then return end SeaT=n
local sb,sd=fSea()
if not sb then return end
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
local sr=rt(sb)
if not h or not sr then return end
if sd>20 then
local du=math.clamp(sd/800,0.5,4)
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
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local d=(RPOS-h.Position).Magnitude
if d>15 then
local du=math.clamp(d/800,0.5,5)
local tw=TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(RPOS+Vector3.new(0,3,0))})
tw:Play()
local t0=os.clock()while tw.PlaybackState==Enum.PlaybackState.Playing and os.clock()-t0<du+1 do task.wait()end end end
local function raidBuy()
local f=Rm()if not f then return end
pcall(function()f:InvokeServer("RaidsNpc","Chip")end)
task.wait(0.5)
pcall(function()f:InvokeServer("RaidsNpc","Buy")end)end
local function raidStart()
local f=Rm()if not f then return end
pcall(function()f:InvokeServer("RaidsNpc","Select",C.raidType)end)
task.wait(0.4)
pcall(function()f:InvokeServer("RaidsNpc","Start")end)end
local function inRaid()
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return false end
return h.Position.Y>500 or h.Position.X<-9000 end
local function autoRaid()
if not C.raid then return end
local n=os.clock()
if n-S.raidCd<0.5 then return end S.raidCd=n
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
if inRaid()then
S.raidState="in_raid"
C.bm=true C.skillMode=2
if C.kaMode==0 then
S.kaBackup={dl=C.dl,r=C.r,skd=C.skd,bm=C.bm,sc=C.sc}
C.dl=0.05 C.r=50 C.skd=0.2 C.bm=true C.sc=0.3 C.kaMode=3
pcall(function()SV:SetCore("SendNotification",{Title="🌋 RAID",Text="Kill All MẠNH đã BẬT",Duration=3})end)
end
return
else
if C.kaMode==3 and S.kaBackup then
C.dl=S.kaBackup.dl C.r=S.kaBackup.r C.skd=S.kaBackup.skd C.bm=S.kaBackup.bm C.sc=S.kaBackup.sc C.kaMode=0
S.kaBackup=nil
pcall(function()SV:SetCore("SendNotification",{Title="🌋 RAID",Text="Kill All đã TẮT",Duration=3})end)
end
end
if S.raidState=="idle"then
S.raidState="moving"
task.spawn(function()
raidMove()
task.wait(0.8)
if C.raidBuyChip then raidBuy()task.wait(1)end
raidStart()
task.wait(2)
S.raidState="idle"
end)end end
local DP={[1]=Vector3.new(-1000,10,5000),[2]=Vector3.new(-2000,10,5000),[3]=Vector3.new(-3000,10,5000),[4]=Vector3.new(-4000,10,5000),[5]=Vector3.new(-5000,10,5000),[6]=Vector3.new(-6000,10,5000)}
local function goD(lv)
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local v=DP[lv]if not v then return end
local d=(v-h.Position).Magnitude local du=math.clamp(d/800,0.5,6)
TS:Create(h,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=CFrame.new(v)}):Play()
pcall(function()SV:SetCore("SendNotification",{Title="🌊 Sea",Text="Danger Lv "..lv,Duration=3})end)end
local BP={sea1=Vector3.new(-1200,15,3500),sea2=Vector3.new(200,15,3000),sea3=Vector3.new(-500,15,5000)}
local function buyB()
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")
if not h then return end
local bp=BP[gs()]
if bp then task.spawn(function()
TS:Create(h,TweenInfo.new(2,Enum.EasingStyle.Linear),{CFrame=CFrame.new(bp)}):Play()
task.wait(2.2)
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
local function svC()
pcall(function()
local d={r=C.r,dl=C.dl,skd=C.skd,skillMode=C.skillMode,kaMode=C.kaMode,autoFPS=C.autoFPS,af=C.af,raidType=C.raidType,raidBuyChip=C.raidBuyChip,bs=C.bs,kn=C.kn,dodge=C.dodge,stuck=C.stuck,fs=C.fs,frr=C.frr}
writefile("ds26_cfg.json",HS:JSONEncode(d))end)end
local function ldC()
local ok,d=pcall(function()if isfile and isfile("ds26_cfg.json")then return HS:JSONDecode(readfile("ds26_cfg.json"))end end)
if ok and d then
C.r=d.r or C.r C.dl=d.dl or C.dl C.skd=d.skd or C.skd C.skillMode=d.skillMode or C.skillMode C.kaMode=d.kaMode or C.kaMode C.autoFPS=d.autoFPS~=nil and d.autoFPS or C.autoFPS C.af=d.af~=nil and d.af or C.af C.raidType=d.raidType or C.raidType C.raidBuyChip=d.raidBuyChip~=nil and d.raidBuyChip or C.raidBuyChip C.bs=d.bs~=nil and d.bs or C.bs C.kn=d.kn~=nil and d.kn or C.kn C.dodge=d.dodge~=nil and d.dodge or C.dodge C.stuck=d.stuck~=nil and d.stuck or C.stuck C.fs=d.fs~=nil and d.fs or C.fs C.frr=d.frr or C.frr end end
local function chkSt()
if not C.stuck then return end
local c=plr.Character h=c and c:FindFirstChild("HumanoidRootPart")hh=c and c:FindFirstChildOfClass("Humanoid")
if not h or not hh or hh.Health<=0 then return end
local mv=(h.Position-S.lastPos).Magnitude
if mv<2 then S.stuckTimer=S.stuckTimer+1
if S.stuckTimer>=C.stuckT*60 then task.spawn(us)S.stuckTimer=0 end
else S.stuckTimer=0 S.lastPos=h.Position end end
local function applyKA()
if C.kaMode==0 then return end
if not S.kaBackup then
S.kaBackup={dl=C.dl,r=C.r,skd=C.skd,bm=C.bm,sc=C.sc}
end
if C.kaMode==1 then C.dl=0.15 C.r=30 C.skd=0.3 C.bm=true C.sc=0.6
elseif C.kaMode==2 then C.dl=0.1 C.r=40 C.skd=0.25 C.bm=true C.sc=0.4
elseif C.kaMode==3 then C.dl=0.05 C.r=50 C.skd=0.2 C.bm=true C.sc=0.3 end end
local flbl,ktxt
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
C.kaMode=0
end
bsu()kn()bm()dodge()espUp()seaAct()seaKill()autoRaid()
useSkill()chkSt()
if C.fr and n-S.lfr>=0.5 then
S.lfr=n local l=sf()S.fc=l
if C.hl then uhl(l)end
if C.nt then for _,f in ipairs(l)do if not S.fs[f.o]then S.fs[f.o]=true
pcall(function()SV:SetCore("SendNotification",{Title="🍎 Fruit!",Text=f.n.." "..math.floor(f.d).."m",Duration=5})end)end end end
if flbl then
if #l==0 then flbl.Text="🍎 Trống"else
local tx=""
for i,f in ipairs(l)do if i>5 then break end tx=tx.."🍎 "..f.n.." "..math.floor(f.d).."m\n"end
flbl.Text=tx end end
if C.fs and #l>0 then task.spawn(goFr)end end
if C.cf then
if S.cbTime>0 and n-S.cbTime>CT then S.cbTime=0 end
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
if ktxt then
local el=math.floor(os.clock()-S.t0)
ktxt.Text="💀 "..S.kc.." | ⏱ "..math.floor(el/60)..":"..string.format("%02d",el%60).." | FPS "..math.floor(S.fps)
end
return end end end
pu()end
local function st()if S.cn then S.cn:Disconnect()end S.run=true S.cn=R.Heartbeat:Connect(hb)end
local function sp()S.run=false if S.cn then S.cn:Disconnect()S.cn=nil end end
local function cl()
if S.cn then pcall(function()S.cn:Disconnect()end)end
if S.nc then pcall(function()S.nc:Disconnect()end)end
for _,c in ipairs(DG)do pcall(function()c:Disconnect()end)end
DG={}chl()espCl()
if _G.DS26 then pcall(function()_G.DS26:Destroy()end)_G.DS26=nil end end
local function bd(h,t)
local a,b
table.insert(DG,h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then a=i.Position b=t.Position end end))
table.insert(DG,U.InputChanged:Connect(function(i)if a and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement)then local d=i.Position-a t.Position=UDim2.new(b.X.Scale,b.X.Offset+d.X,b.Y.Scale,b.Y.Offset+d.Y)end end))
table.insert(DG,U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then a=nil end end))end
local function mkMenu(g,name,title)
local m=Instance.new("ScrollingFrame")
m.Name=name
m.Size=UDim2.new(0,190,0,420)m.Position=UDim2.new(0,8,0,20)
m.BackgroundColor3=Color3.fromRGB(22,22,28)m.BorderSizePixel=0
m.CanvasSize=UDim2.new(0,0,0,0)m.AutomaticCanvasSize=Enum.AutomaticSize.Y
m.ScrollBarThickness=4 m.ScrollBarImageColor3=Color3.fromRGB(80,120,255)
m.Active=false m.Parent=g m.Visible=false
Instance.new("UICorner",m).CornerRadius=UDim.new(0,10)
local o1=Instance.new("UIListLayout",m)o1.Padding=UDim.new(0,3)o1.SortOrder=Enum.SortOrder.LayoutOrder
local p1=Instance.new("UIPadding",m)p1.PaddingTop=UDim.new(0,4)p1.PaddingBottom=UDim.new(0,8)p1.PaddingLeft=UDim.new(0,4)p1.PaddingRight=UDim.new(0,4)
local tt=Instance.new("TextLabel",m)tt.Size=UDim2.new(1,0,0,26)
tt.BackgroundColor3=Color3.fromRGB(40,45,80)tt.BorderSizePixel=0
tt.Text=title tt.TextColor3=Color3.new(1,1,1)tt.TextSize=11 tt.Font=Enum.Font.GothamBold tt.LayoutOrder=1
Instance.new("UICorner",tt).CornerRadius=UDim.new(0,10)
local cT=Instance.new("TextButton",tt)cT.Size=UDim2.new(0,24,0,20)cT.Position=UDim2.new(1,-28,0,3)
cT.BackgroundColor3=Color3.fromRGB(255,180,60)cT.BorderSizePixel=0 cT.Text="👁"cT.TextSize=11 cT.Font=Enum.Font.GothamBold
Instance.new("UICorner",cT).CornerRadius=UDim.new(0,6)
local dS,dP
table.insert(DG,tt.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dS=i.Position dP=m.Position end end))
table.insert(DG,U.InputChanged:Connect(function(j)if dS and(j.UserInputType==Enum.UserInputType.Touch or j.UserInputType==Enum.UserInputType.MouseMovement)then local d=j.Position-dS m.Position=UDim2.new(dP.X.Scale,dP.X.Offset+d.X,dP.Y.Scale,dP.Y.Offset+d.Y)end end))
table.insert(DG,U.InputEnded:Connect(function(j)if j.UserInputType==Enum.UserInputType.Touch or j.UserInputType==Enum.UserInputType.MouseButton1 then dS=nil end end))
return m,tt,cT end
local function gG(m,n,ic,ord)
local w=Instance.new("Frame",m)w.Size=UDim2.new(1,0,0,22)w.BackgroundTransparency=1 w.AutomaticSize=Enum.AutomaticSize.Y w.LayoutOrder=ord
local w1=Instance.new("UIListLayout",w)w1.Padding=UDim.new(0,2)
local b=Instance.new("TextButton",w)b.Size=UDim2.new(1,0,0,22)
b.BackgroundColor3=Color3.fromRGB(50,60,100)b.BorderSizePixel=0
b.Text=ic.." "..n.." ▼"b.TextColor3=Color3.new(1,1,1)b.TextSize=10 b.Font=Enum.Font.GothamBold
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local inn=Instance.new("Frame",w)inn.Size=UDim2.new(1,0,0,0)inn.BackgroundTransparency=1 inn.AutomaticSize=Enum.AutomaticSize.Y inn.Visible=false
local i1=Instance.new("UIListLayout",inn)i1.Padding=UDim.new(0,2)
b.MouseButton1Click:Connect(function()inn.Visible=not inn.Visible b.Text=ic.." "..n..(inn.Visible and" ▲"or" ▼")end)
return inn end
local function gB(pa,t,co,cb,ord)
local b=Instance.new("TextButton",pa)b.Size=UDim2.new(1,0,0,22)
b.BackgroundColor3=co b.BorderSizePixel=0 b.Text=t b.TextColor3=Color3.new(1,1,1)b.TextSize=10 b.Font=Enum.Font.GothamBold
if ord then b.LayoutOrder=ord end
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(cb)
return b end
local function gui()
cl()
local g=Instance.new("ScreenGui")g.Name="DS26"g.ResetOnSpawn=false g.IgnoreGuiInset=true
pcall(function()g.Parent=game:GetService("CoreGui")end)if not g.Parent then g.Parent=plr:WaitForChild("PlayerGui")end
_G.DS26=g
local m,tt,cT=mkMenu(g,"Main","🐉 DS 2026 v13.5")
m.Visible=true
ktxt=Instance.new("TextLabel",m)ktxt.Size=UDim2.new(1,0,0,16)
ktxt.BackgroundColor3=Color3.fromRGB(30,30,40)ktxt.BorderSizePixel=0
ktxt.Text="💀 0 | ⏱ 0:00 | FPS 60"ktxt.TextColor3=Color3.fromRGB(255,220,120)ktxt.TextSize=10 ktxt.Font=Enum.Font.Code ktxt.LayoutOrder=2
Instance.new("UICorner",ktxt).CornerRadius=UDim.new(0,6)
local seaM,seaT,seaX=mkMenu(g,"SeaMenu","🌊 SEA EVENT")
seaX.Text="◀" seaX.BackgroundColor3=Color3.fromRGB(100,200,100)
local raidM,raidT,raidX=mkMenu(g,"RaidMenu","🌋 AUTO RAID")
raidX.Text="◀" raidX.BackgroundColor3=Color3.fromRGB(200,100,100)
local f1=gG(m,"CHIẾN ĐẤU","⚔",10)
local tg
tg=gB(f1,"⏸ DỪNG",Color3.fromRGB(200,70,70),function()
if S.run then sp()tg.Text="▶ CHẠY"tg.BackgroundColor3=Color3.fromRGB(70,180,100)
else st()tg.Text="⏸ DỪNG"tg.BackgroundColor3=Color3.fromRGB(200,70,70)
C.bm=true if bm2 then bm2.Text="🧲 Bring Mob: ON"bm2.BackgroundColor3=Color3.fromRGB(80,200,180)end end end)
local kaBtn
kaBtn=gB(f1,"💥 Kill All: OFF",Color3.fromRGB(60,40,60),function()
if C.kaMode==3 and S.kaBackup then
C.dl=S.kaBackup.dl C.r=S.kaBackup.r C.skd=S.kaBackup.skd C.bm=S.kaBackup.bm C.sc=S.kaBackup.sc
S.kaBackup=nil
end
if C.kaMode==0 then C.kaMode=1 kaBtn.Text="💥 Kill All: NHẸ"kaBtn.BackgroundColor3=Color3.fromRGB(120,60,60)
elseif C.kaMode==1 then C.kaMode=2 kaBtn.Text="💥 Kill All: VỪA"kaBtn.BackgroundColor3=Color3.fromRGB(180,80,60)
elseif C.kaMode==2 then C.kaMode=3 kaBtn.Text="💥 Kill All: MẠNH"kaBtn.BackgroundColor3=Color3.fromRGB(255,100,50)
else C.kaMode=0 kaBtn.Text="💥 Kill All: OFF"kaBtn.BackgroundColor3=Color3.fromRGB(60,40,60)end
applyKA()
end)
local skBtn
skBtn=gB(f1,"🎯 Auto Skill: OFF",Color3.fromRGB(60,40,60),function()
if C.skillMode==0 then C.skillMode=1 skBtn.Text="🎯 Auto Skill: THỨ TỰ"skBtn.BackgroundColor3=Color3.fromRGB(140,60,140)
elseif C.skillMode==1 then C.skillMode=2 skBtn.Text="🎯 Auto Skill: CÙNG LÚC"skBtn.BackgroundColor3=Color3.fromRGB(180,80,180)
else C.skillMode=0 skBtn.Text="🎯 Auto Skill: OFF"skBtn.BackgroundColor3=Color3.fromRGB(60,40,60)end end)
local bs3
bs3=gB(f1,"🔥 Buso: ON",Color3.fromRGB(180,50,50),function()C.bs=not C.bs bs3.Text="🔥 Buso: "..(C.bs and"ON"or"OFF")end)
local kn2
kn2=gB(f1,"👁 Ken: ON",Color3.fromRGB(100,180,100),function()C.kn=not C.kn kn2.Text="👁 Ken: "..(C.kn and"ON"or"OFF")end)
local bs4
bs4=gB(f1,"👹 Boss Only: OFF",Color3.fromRGB(180,80,30),function()C.bs2=not C.bs2 bs4.Text="👹 Boss Only: "..(C.bs2 and"ON"or"OFF")end)
local afBtn
afBtn=gB(f1,"🏃 Auto Farm Level: OFF",Color3.fromRGB(60,140,80),function()
C.af=not C.af
afBtn.Text="🏃 Auto Farm Level: "..(C.af and"ON"or"OFF")
afBtn.BackgroundColor3=C.af and Color3.fromRGB(80,200,100)or Color3.fromRGB(60,140,80)
-- Tự bật Bring Mob khi bật AF
if C.af then
C.bm=true
if bm2 then bm2.Text="🧲 Bring Mob: ON"bm2.BackgroundColor3=Color3.fromRGB(80,200,180)end
pcall(function()SV:SetCore("SendNotification",{Title="🏃 AF",Text="Bring Mob tự BẬT (250m)",Duration=3})end)
end
end)
local afBtn2
afBtn2=gB(f1,"⚡ Auto FPS: ON",Color3.fromRGB(60,120,120),function()C.autoFPS=not C.autoFPS afBtn2.Text="⚡ Auto FPS: "..(C.autoFPS and"ON"or"OFF")end)
local f2=gG(m,"DI CHUYỂN","🗺",11)
gB(f2,"🏝 Teleport Đảo",Color3.fromRGB(60,130,200),function()
if tpF and tpF.Parent then tpF.Visible=not tpF.Visible else
local f=Instance.new("Frame")f.Size=UDim2.new(0,170,0,360)f.Position=UDim2.new(0,205,0,20)f.BackgroundColor3=Color3.fromRGB(22,22,28)f.BorderSizePixel=0 f.Parent=g
Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
local t2=Instance.new("TextLabel",f)t2.Size=UDim2.new(1,0,0,26)t2.BackgroundColor3=Color3.fromRGB(40,80,120)t2.BorderSizePixel=0 t2.Text="🏝 "..gs():upper()t2.TextColor3=Color3.new(1,1,1)t2.TextSize=11 t2.Font=Enum.Font.GothamBold
Instance.new("UICorner",t2).CornerRadius=UDim.new(0,10)
local xb=Instance.new("TextButton",t2)xb.Size=UDim2.new(0,24,0,20)xb.Position=UDim2.new(1,-28,0,3)xb.BackgroundColor3=Color3.fromRGB(200,60,60)xb.BorderSizePixel=0 xb.Text="X"xb.TextColor3=Color3.new(1,1,1)xb.TextSize=11 xb.Font=Enum.Font.GothamBold
Instance.new("UICorner",xb).CornerRadius=UDim.new(0,6)
xb.MouseButton1Click:Connect(function()f.Visible=false end)
bd(t2,f)
local s2=Instance.new("ScrollingFrame",f)s2.Size=UDim2.new(1,-10,1,-32)s2.Position=UDim2.new(0,5,0,30)s2.BackgroundTransparency=1 s2.BorderSizePixel=0 s2.ScrollBarThickness=4 s2.CanvasSize=UDim2.new(0,0,0,0)
local yy=0
for _,i in ipairs(ISL[gs()]or{})do
local b2=Instance.new("TextButton",s2)b2.Size=UDim2.new(1,-10,0,24)b2.Position=UDim2.new(0,5,0,yy)b2.BackgroundColor3=Color3.fromRGB(60,90,140)b2.BorderSizePixel=0 b2.Text=i[1]b2.TextColor3=Color3.new(1,1,1)b2.TextSize=10 b2.Font=Enum.Font.GothamBold
Instance.new("UICorner",b2).CornerRadius=UDim.new(0,6)
b2.MouseButton1Click:Connect(function()task.spawn(function()tp(i)end)end)
yy=yy+28 end
s2.CanvasSize=UDim2.new(0,0,0,yy+10)
tpF=f end end)
gB(f2,"🆘 Chống Kẹt",Color3.fromRGB(220,140,40),function()task.spawn(us)end)
local nc
nc=gB(f2,"👻 Noclip: OFF",Color3.fromRGB(80,80,140),function()if not S.nco then onc()nc.Text="👻 Noclip: ON"else dnc()nc.Text="👻 Noclip: OFF"end end)
local dgBtn
dgBtn=gB(f2,"❤️ Né Đòn: OFF",Color3.fromRGB(200,80,120),function()
C.dodge=not C.dodge
dgBtn.Text="❤️ Né Đòn: "..(C.dodge and"ON"or"OFF")
dgBtn.BackgroundColor3=C.dodge and Color3.fromRGB(255,120,160)or Color3.fromRGB(200,80,120)
end)
local f3=gG(m,"FARM","🎒",12)
local ck
ck=gB(f3,"📦 Chest: OFF",Color3.fromRGB(90,70,50),function()C.cf=not C.cf ck.Text="📦 Chest: "..(C.cf and"ON"or"OFF")end)
bm2=gB(f3,"🧲 Bring Mob: OFF",Color3.fromRGB(60,140,140),function()C.bm=not C.bm bm2.Text="🧲 Bring Mob: "..(C.bm and"ON"or"OFF")bm2.BackgroundColor3=C.bm and Color3.fromRGB(80,200,180)or Color3.fromRGB(60,140,140)end)
local pu2
pu2=gB(f3,"💰 Pickup: ON",Color3.fromRGB(180,150,50),function()C.pu=not C.pu pu2.Text="💰 Pickup: "..(C.pu and"ON"or"OFF")end)
local seaBtn
seaBtn=gB(f3,"🌊 Sea Event ►",Color3.fromRGB(50,100,180),function()m.Visible=false seaM.Visible=true end)
local raidBtn
raidBtn=gB(f3,"🌋 Auto Raid ►",Color3.fromRGB(180,60,60),function()m.Visible=false raidM.Visible=true end)
local sk1
sk1=gB(f3,"🛡 Anti-Stuck: OFF",Color3.fromRGB(120,100,80),function()C.stuck=not C.stuck sk1.Text="🛡 Anti-Stuck: "..(C.stuck and"ON"or"OFF")sk1.BackgroundColor3=C.stuck and Color3.fromRGB(180,150,100)or Color3.fromRGB(120,100,80)end)
gB(f3,"💾 Save Config",Color3.fromRGB(80,120,80),function()svC()pcall(function()SV:SetCore("SendNotification",{Title="DS26",Text="Đã lưu",Duration=3})end)end)
gB(f3,"📂 Load Config",Color3.fromRGB(80,120,80),function()ldC()pcall(function()SV:SetCore("SendNotification",{Title="DS26",Text="Đã load",Duration=3})end)end)
local f4=gG(m,"FRUIT","🍎",13)
local ff
ff=gB(f4,"🍎 Fruit Finder: OFF",Color3.fromRGB(160,60,100),function()C.fr=not C.fr ff.Text="🍎 Fruit Finder: "..(C.fr and"ON"or"OFF")if not C.fr then chl()end if flbl then flbl.Visible=C.fr end end)
local fs2
fs2=gB(f4,"🍎 Auto Tween Fruit: OFF",Color3.fromRGB(200,100,150),function()
C.fs=not C.fs
fs2.Text="🍎 Auto Tween Fruit: "..(C.fs and"ON"or"OFF")
fs2.BackgroundColor3=C.fs and Color3.fromRGB(240,140,180)or Color3.fromRGB(200,100,150)
end)
local hl2
hl2=gB(f4,"✨ Highlight: OFF",Color3.fromRGB(120,60,180),function()C.hl=not C.hl hl2.Text="✨ Highlight: "..(C.hl and"ON"or"OFF")if not C.hl then chl()end end)
gB(f4,"🍎 TP Fruit Gần Nhất",Color3.fromRGB(200,60,140),function()task.spawn(goFr)end)
flbl=Instance.new("TextLabel",f4)flbl.Size=UDim2.new(1,0,0,60)
flbl.BackgroundColor3=Color3.fromRGB(30,20,30)flbl.BorderSizePixel=0 flbl.Text="🍎"
flbl.TextColor3=Color3.fromRGB(255,200,220)flbl.TextSize=9 flbl.Font=Enum.Font.Code
flbl.TextXAlignment=Enum.TextXAlignment.Left flbl.TextYAlignment=Enum.TextYAlignment.Top flbl.Visible=false
Instance.new("UICorner",flbl).CornerRadius=UDim.new(0,6)
local f5=gG(m,"ESP","👤",14)
local espb
espb=gB(f5,"👤 ESP Player: OFF",Color3.fromRGB(60,180,60),function()C.esp=not C.esp espb.Text="👤 ESP Player: "..(C.esp and"ON"or"OFF")espb.BackgroundColor3=C.esp and Color3.fromRGB(80,255,80)or Color3.fromRGB(60,180,60)if not C.esp then espCl()end end)
local closeB
closeB=gB(m,"❌ Đóng Menu",Color3.fromRGB(120,40,40),function()m.Visible=false ob.Visible=true end,20)
local sf1=gG(seaM,"DI CHUYỂN SEA","🌊",10)
gB(sf1,"🛒 Mua Thuyền",Color3.fromRGB(120,90,60),function()task.spawn(buyB)end)
gB(sf1,"🌊 Sea 2",Color3.fromRGB(60,140,200),function()tSea("sea2")end)
gB(sf1,"🌊 Sea 3",Color3.fromRGB(80,180,240),function()tSea("sea3")end)
local sf2=gG(seaM,"DANGER LEVEL","⚡",11)
gB(sf2,"⚡ Danger (Sea 3)",Color3.fromRGB(40,60,80),function()end)
for lv=1,6 do gB(sf2,"⚡ LV "..lv,Color3.fromRGB(50+lv*20,50+lv*10,120+lv*10),function()goD(lv)end)end
local sf3=gG(seaM,"AUTO SEA","🎯",12)
local seaEv
seaEv=gB(sf3,"🌊 Sea Event: OFF",Color3.fromRGB(50,100,180),function()
C.sea=not C.sea
seaEv.Text="🌊 Sea Event: "..(C.sea and"ON"or"OFF")
seaEv.BackgroundColor3=C.sea and Color3.fromRGB(80,160,240)or Color3.fromRGB(50,100,180)
end)
local sk1b
sk1b=gB(sf3,"⚔ Auto Kill: OFF",Color3.fromRGB(200,80,50),function()
C.seaKill=not C.seaKill
sk1b.Text="⚔ Auto Kill: "..(C.seaKill and"ON"or"OFF")
sk1b.BackgroundColor3=C.seaKill and Color3.fromRGB(255,120,60)or Color3.fromRGB(200,80,50)
end)
gB(seaM,"◀ Quay Lại",Color3.fromRGB(100,140,80),function()seaM.Visible=false m.Visible=true end,20)
seaX.MouseButton1Click:Connect(function()seaM.Visible=false m.Visible=true end)
local rf1=gG(raidM,"CHỌN LOẠI RAID","🔥",10)
local raidLbl
raidLbl=Instance.new("TextLabel",rf1)raidLbl.Size=UDim2.new(1,0,0,20)raidLbl.BackgroundColor3=Color3.fromRGB(60,40,40)raidLbl.BorderSizePixel=0 raidLbl.Text="Chọn: "..C.raidType raidLbl.TextColor3=Color3.new(1,1,1)raidLbl.TextSize=10 raidLbl.Font=Enum.Font.GothamBold
Instance.new("UICorner",raidLbl).CornerRadius=UDim.new(0,6)
local raidList={"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human","Buddha","Spider","Chop","Spring","Bomb","Smoke","Spike","Sand","Door","Rubber","Barrier","Revive","Phoenix"}
for _,rt2 in ipairs(raidList)do
gB(rf1,rt2,Color3.fromRGB(100,50,50),function()C.raidType=rt2 raidLbl.Text="Chọn: "..rt2 end)
end
local rf2=gG(raidM,"ĐIỀU KHIỂN","⚙",11)
local rc
rc=gB(rf2,"🛒 Mua Chip: ON",Color3.fromRGB(150,100,50),function()
C.raidBuyChip=not C.raidBuyChip
rc.Text="🛒 Mua Chip: "..(C.raidBuyChip and"ON"or"OFF")
end)
local ra
ra=gB(rf2,"▶ Bắt Đầu Raid",Color3.fromRGB(60,180,60),function()
C.raid=not C.raid
ra.Text=(C.raid and"⏸ Dừng Raid"or"▶ Bắt Đầu Raid")
ra.BackgroundColor3=C.raid and Color3.fromRGB(200,60,60)or Color3.fromRGB(60,180,60)
if C.raid then C.bm=true C.skillMode=2 end
end)
gB(raidM,"◀ Quay Lại",Color3.fromRGB(100,140,80),function()raidM.Visible=false m.Visible=true end,20)
raidX.MouseButton1Click:Connect(function()raidM.Visible=false m.Visible=true end)
ob=Instance.new("TextButton",g)ob.Size=UDim2.new(0,45,0,45)ob.Position=UDim2.new(1,-60,0,100)ob.BackgroundColor3=Color3.fromRGB(80,120,255)ob.BorderSizePixel=0 ob.Text="🐉"ob.TextSize=20 ob.Font=Enum.Font.GothamBold ob.Visible=false
Instance.new("UICorner",ob).CornerRadius=UDim.new(1,0)bd(ob,ob)
cT.MouseButton1Click:Connect(function()m.Visible=false seaM.Visible=false raidM.Visible=false ob.Visible=true end)
ob.MouseButton1Click:Connect(function()m.Visible=true seaM.Visible=false raidM.Visible=false ob.Visible=false end)
end
ldC() st() gui()