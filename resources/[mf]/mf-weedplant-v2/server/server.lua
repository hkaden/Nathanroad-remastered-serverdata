-- https://modit.store 
local a=string.byte;local h=string.char;local t=string.sub;local E=table.concat;local e=table.insert;local C=math.ldexp;local S=getfenv or function()return _ENV end;local T=setmetatable;local s=select;local d=unpack or table.unpack;local i=tonumber;local function A(a)local l,n,c="","",{}local o=256;local d={}for e=0,o-1 do d[e]=h(e)end;local e=1;local function f()local l=i(t(a,e,e),36)e=e+1;local n=i(t(a,e,e+l-1),36)e=e+l;return n end;l=h(f())c[1]=l;while e<#a do local e=f()if d[e]then n=d[e]else n=l..t(l,1,1)end;d[o]=l..t(n,1,1)c[#c+1],l,o=n,n,o+1 end;return table.concat(c)end;local f=A('26326527526526127625024Z25024P26526227623M23M27A25525424L26525T27624U25424P24W27R25824P25825B24X25426527427527H25A25824X24X27E27624E27C25024N25424Z27N28A24V25427V25423T25128J25825526526627626R27626526027624T24V27A27D27827524P24K24T28028Y27524T28528727727625324U24Y28G28226528F25A24Y27K28X27627K25B24O25628927525627R27A25724Y29R29524Y25228F28W27525X27625724O24Z25A24P25029J29F27524X24Y28Q26525P2762412AN25523Z25429I24O24V25A25424B25027Z26525N27624A27R24E2AY28J24Z24P2AV2AX2AZ25424325827T2B52B727R24324O24W2BF24Y2AY2B024027U25527V25826525Q2BN2BE2AW2BT2BH2BW27W2BY27W28127P24P29124Z29W28T27524W29P2CI2A927527F27524R25424V24U2AI28G25Z27629N29P25423M24Z25424Q26525V27623Y27R24524P24P24T24525824Z25527Z24V26525U2C32BS2BU25423X27V2512AK26525624U24O25B26526727626Q26Q2652642E22DU25727J2652CX27526Q28J2BG2B024U28S27P2DY2CM27621926A2E02792A329426524Y2982CW27P2CS2CR24V26R25A25729W2E62752DK26T27629O24O24X25527124Z24Y24P2712E92DH27127Q24V2F02F22F426P27125824O24P25127127A24R28625025528V29A26524X27A2AW2AP2CY2DH24T24Y29223M28Q25523M24P25A24T2E52762732GN27526Y2GQ26526F26525C28Z24Y24V2FI2FG2FI2A22AE2552FS2FU2FW2FY24Z2G02G72G326525R27623X2CS2A224V24W2DB2DD2AV24S24O2AW27D2GP2752512DC24T24U26F2E32CK25527C26R27K24R26Q24Q25425B25124Y2A624U2EE2542HQ2HS2DU23X24223Y23T2EJ2F72G92ET2GD2H029X2652GH2EF24U2642CM29L2A426524T2582502CT2DU2962982J327W27Y2802ET29H2AJ2EC29M2AF2D02D22D42652AB2752AD2AF2AH29J2F627525J28W2GX2JW2752HG2EQ2K12752EM28W2E12E12782ET2BM2E625R26B2892E12762GS2AB2J22412KH2EQ26Z25O2892AQ2E628T26124F2762KT2HF2KG27F2ET27125W28927F2G52JP2CC2A927F2K928W2E628Y2L228W2B62KE2L12EQ2KJ2L92KM2KO2E126Z2HG27F2LJ2CC2KW2762LV2GA2LF2CC2632692EQ28Y2E62KA2KX2752M62K62GN2KI27525K2762JW2AQ2762CM28J24S2IP2652EF2DU23U2J624P2K728W29L27T2FW29P2MO24A2482IO2JG29I29K2GB29O29Q2JJ2CZ27K2JN24Q2MV25024D2652L527524Q29124P25424528K28R2ET24W2DS2J32572AM2GZ2L92A524Z2BQ25B2CS2DU27Q2DH2D62EY24P2492BZ2DF2DH2DJ2672JW2MG2762ET2JA28029L24U2CE27A2CH27627Z24Z2MV2OK2OT2AT2GT2NI2JQ26524P24Y2OP2CF2562MV2EO2J32902922LA2652HK2NU27D29L23Q26W24U23K26F27126525Y27624C2FV2IC29128E2HE2G529C2862882DM2752442HB2G12FE24U25A29124T24P28V2ML2G92NK2652NM27C2NP2NR2DU2PH2DT2G52NX2ID2DK2P22P42O224W2O424V2NG2NI2ET2O72552K12NI2K22KG2E62K12GS2ME2AR2MD2KP2HG2E62742M72772M92CC2E62LX27526K2GN27126C2GT2CI2KN2RJ2E125V25M29F2RQ2R92RK2762S22L02GN2L823R2LM2762K328T29L2K32782CP28W2L82LA28Y2RG2OK2RL2SN2RO2C12GN25R25A29R2P22652KN2782LD2DL2EJ2KV27524C2GN28T2E12632CX2E625G2GN2RN2RL2TD2TF2LN2LK2EQ2QH25R2C02T82762PP2T32EB2HF2752782PR2K22MA2IV2762J22SJ2PE2MK2762E12SG28H2A92KA2ST2752E125S2CN28T2K52EQ2E12RN28W2S62KF2TL2SC2492EJ2ME2TR28T28T2CX2U82TX2TU29R2SI2U12CN2TZ2U22MO2U72TV2O92UA29F2TK2E62Q32652712JY2S32AQ2K32E12KR2752TR2LD2HG2SD2SS2TY29F25L2UG2DU2U62V42GT2KE2752VE2TQ2W32GN2OJ2W62S32MH2GT2WB2UI2W627526L28W23L2SB27526325F2EQ2782JW2SR2WP2MF2WB2K22SI2JW25R27F2RJ2762WJ2UK2U12WN2E12TB2SO2762X72SR2D72TK2E12CM2SU2EJ2KC2452UJ2GN2SR2RI2S72X32VO23N2XK28Y2LS2EQ2C22RH2S42752XW2XY26526S2ST2KG2E12SI27123V2XK2AB2VS2Y72MC28T2QH2VC2VX2KC2UD2VZ2VS2JJ2U82UT2V92TW2V028Y27O2VO2TZ28Y2UF2K32742D72LB2MO2V32V22TZ2V42ET2W229F2YP29F2782VF29R2RC2V92X32KC2E42XD2GT2712XR2LD2AQ26323S2MO2X025D2VZ2762ZV2V42XJ2LD2F62W82JW2TD2MC2A92NH2J92972ON2CD2P72GA2752AS28Q2DO2BH2B22B42VN2652FN2F026Q310O2CS26R24X24O2C02PZ2CF27D2UF2752FZ2Q72FJ2B32G92ME2AI2DU2EV2A82VF2B82C42EG2DQ2NV2B6275311D2BA24V2BC311E2C62B02BJ2BL2K3265310Q2EZ2CS311V2FO310S310U2C02ME24V2DZ2ET28P2NS27626V2Q12MO2OU2DU2OU2DZ2CM25324Q27D2ME2I32J329T29V2IV29Z2AH24Z2A22SB2G7312E2OZ2ME24P2522JC2A628F2EM2UR2752KQ2762682TE2Y1313A2TK2TP2LN2WS2RD2TP2LR2KR28T313D2XH2RL313N2UO2T42X12VY2HF2SV28Y2L82T628T28Y2T92WN28T2XC2X827531452SR2SN2UO2782SF313W2U02XJ2T02GQ31032SC2KG2782P227124B2ZC2NJ2YS2TT2VU2742UZ2V32UI2G52V82CC2YU2U328Y2742YZ265311028W314C2EQ2822782GP2S32SR315E2S731542SC2SV2742V22XJ3141314I2WU2VG2RT28Y2782D725R23P2892ZE2TZ2LC2VG2WL29R2MJ31642T12CO2V32TR2AB28T31662L92ZP31692AQ2AB2MJ27F2KR274316K2TU2Z92AB2VW2YV2L92AB2MG2K32L5316S3163314R2L52W8316F2EQ316O2C22YB2AA265316Z316B2L9316W2752L52S02A92AB316G2892B62SX317J2W5316U2652TD316O25H2O031692WQ28W24E2GN2TA2GN2NI315F2RL31832Y1317Z313E2U42GS313H2752XJ2TP3102315R21N314K313B2WL2WN2E62702GT2SR318O2VD2SB31812E62WZ2XL2RL318W318Q2Y42T72U12X72PR318427631952Y1318R2S72UL318L2GN319A2TV2RL319A2UO319C2VG2XR2S331542X72Y02TI2XZ318X276319I2R82PE318U2652S0319627531A0319931912XX2XQ313B27F319Y2ZV31A126531AB31A42RH2WN275319F31AF319L2GT2KL2X7315H319R265315H265314J2R7319231AV31682XG2YF28W2T62KU315B318M2Y2318P2RL2Y331AQ26V315Q2WF319B2SB2UO2T92TQ2ZO2EQ2CP2RW2XK31382E62S62CX2SR2S62SR26N31BC2GT319J31BF2Y52PQ28W31BM2LD31BO26531B22TT2SR31C731BY2ME31BG2WC31C32KP2KR2E631C731BR2RL31CA319W2WX31C02UZ263319A31C72M82PS319T2752KX318G31BD31CB318J2E131522SY2RE2LR2SN2XJ2E631CK27631D92Y124031A531BZ2EQ315831D52RX2652XU2E62432GN31DB27531DP31CZ31BX319W31CC31C02Z1310F31D631DM31CH26523O31DQ2Y131E5318S31DX2EQ2ZE31CF313K2GN31E831C82RL31EG2SR2SA31DU31CO2GN31DJ319Q2EQ2VL2WK2MC2UI2LD2LR2YK2DZ2E62AQ2SR31EZ2Y12SV31EM31D22T227631E52UH2SC2V9310M2K32SM2CN2E1315P2VS31602YH2VU28Y2C2314U2V028W2SE31ER2ZH2CN315P2A9314H31EX29F2EI31F02Y131G22Y127D31F631AV314H2LN28Y2EM2SZ31BN2KR27824N2GN31F12RL31GI31AQ24M31BW31EN2KB2U623Q2J327525P2Y32782VW29A31DF2782G52UO2742W82ZR2892S32CI2EP2Z627531HB2VY31HE2RC2572CC2X33156311I28W318W2A92742LD2TR2742742S02K32AB317U2VU2L531052MW314R2E12TR31A92652JY316X26525I2CN27F2L52AB2TR2L52742ZV2K32PR311T2TR27O27F2GX2762L527O31502CX31AH31702CX2CX25E2V02PR2TR2V027O318O2A92CX31IT2LA2CX21V313B2SR31JC2TK31982K22SV27O2HU318D31C12XP31AU27531DF2PR31522RS31572TT27227524631JV2E12DM2SR1H2RR2RT2KR2AQ31I82SV2C226X31B12652KR2C22T92CX2KR23931JD2RL31KK31AQ31K42E631JU31K731I7313V2SS26W28W2D731KF2TU2WM31KE26523731B727631L431AQ23331K52SS31K831KU2MG26Z31KD2C22MG2KI2GS31KZ2VO2RT2C231LC2K32MG2GS2A931LH317A31702MG2AQ2ZV2TR31HV2GW3170317U2C231IQ2WT317U2RC27O2W82TR31LX31KT2K32S031KW2A931M42CN2MG317U2B62822MG1S31L527531MQ31AQ1Q31LA2S031LP2PR2TD31LF2A92JY31FP28W2S02JY31HY2752B631N82762MG317H315S319Z2GA31LZ317U2TD2VW2GX2712PP2JY2MG31IQ2T631N62LM2GS2PR31NE2M331JV23J31KL27631O02RH2CX2PR1931O127531O72TK2UF2WX2SV2D72F931DC31K031GP318J2UF2Y331JI2O931BB2WL2ZS2DM2X331HA315R26531HE2KC31HE28W25R23U2GA26U31FC31L22YG2VU2CC2MJ2HG2KR2E131PA2SS316D2TY26P2RR319S317931PE2AB31LO2TY26O31C131PE28V31D42YY2WC31BD2SX2OL310A2PE2P62OR2PB310Y31F82652Q52HC2G22712P42A724Z2PO317V2P431Q22CG2DU24323S2412KN315227Q27S27U2JD2B42G531QC28F2RC31HM31CD2RA2EJ2K12KN31EW31DM2HG31K12RE2SR2DM2ZL2XF2SV313S2S731H22U12NI28Y319831AQ31982XG315J2RD31FZ2752DM2UV2AK31002K42WT31D031C02V231IB2CM31G32EJ2AB2K12YJ2VZ31S82ZG2A92JW2J231PZ2JB2UZ24E28J27K2BD2502862EI31QV27X31QU27623T31332N727531QI29W2ET27A27C31MI2K82V42K32WA2V031682WB31C42W62KZ2KV2RL2KZ31BY31EN31682ZN2XK29431ED31R631EO2S82Y131OC2Y131TF31DW31BI31JD2Y12SN26523Y31PW265313131T631D52YK314227631A3319G31U831LA31SD31JM2RJ31G831FR26526H31SC2E031GT2K525P24A2WD310E2YK31UK31P02YK2MV31FB31FY2WB31H72MB2WA31OZ2KY31GX29F29A2802UB2ZL2G531TJ2LD31HT2ZS318F2GQ31HE2K131RW31JO315R');local o=bit and bit.bxor or function(e,n)local l,o=1,0 while e>0 and n>0 do local c,t=e%2,n%2 if c~=t then o=o+l end e,n,l=(e-c)/2,(n-t)/2,l*2 end if e<n then e=n end while e>0 do local n=e%2 if n>0 then o=o+l end e,l=(e-n)/2,l*2 end return o end local function n(l,e,n)if n then local e=(l/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(l%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local l,n,t,c=a(f,e,e+3);l=o(l,221)n=o(n,221)t=o(t,221)c=o(c,221)e=e+4;return(c*16777216)+(t*65536)+(n*256)+l;end;local function i()local l=o(a(f,e,e),221);e=e+1;return l;end;local function c()local l,n=a(f,e,e+2);l=o(l,221)n=o(n,221)e=e+2;return(n*256)+l;end;local function A()local o=l();local e=l();local t=1;local o=(n(e,1,20)*(2^32))+o;local l=n(e,21,31);local e=((-1)^n(e,32));if(l==0)then if(o==0)then return e*0;else l=1;t=0;end;elseif(l==2047)then return(o==0)and(e*(1/0))or(e*(0/0));end;return C(e,l-1023)*(t+(o/(2^52)));end;local C=l;local function R(l)local n;if(not l)then l=C();if(l==0)then return'';end;end;n=t(f,e,e+l-1);e=e+l;local l={}for e=1,#n do l[e]=h(o(a(t(n,e,e)),221))end return E(l);end;local e=l;local function h(...)return{...},s('#',...)end local function K()local a={};local o={};local e={};local f={a,o,nil,e};local e=l()local t={}for n=1,e do local l=i();local e;if(l==1)then e=(i()~=0);elseif(l==3)then e=A();elseif(l==0)then e=R();end;t[n]=e;end;f[3]=i();for e=1,l()do o[e-1]=K();end;for f=1,l()do local e=i();if(n(e,1,1)==0)then local o=n(e,2,3);local d=n(e,4,6);local e={c(),c(),nil,nil};if(o==0)then e[3]=c();e[4]=c();elseif(o==1)then e[3]=l();elseif(o==2)then e[3]=l()-(2^16)elseif(o==3)then e[3]=l()-(2^16)e[4]=c();end;if(n(d,1,1)==1)then e[2]=t[e[2]]end if(n(d,2,2)==1)then e[3]=t[e[3]]end if(n(d,3,3)==1)then e[4]=t[e[4]]end a[f]=e;end end;return f;end;local function C(e,f,a)local l=e[1];local n=e[2];local e=e[3];return function(...)local o=l;local R=n;local t=e;local i=h local l=1;local c=-1;local K={};local E={...};local h=s('#',...)-1;local A={};local n={};for e=0,h do if(e>=t)then K[e-t]=E[e+1];else n[e]=E[e+1];end;end;local e=h-t+1 local e;local t;while true do e=o[l];t=e[1];if t<=53 then if t<=26 then if t<=12 then if t<=5 then if t<=2 then if t<=0 then local a;local c;local f;local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]f={n[t](d(n,t+1,e[3]))};c=0;for e=t,e[4]do c=c+1;n[e]=f[c];end l=l+1;e=o[l];t=e[2];a=n[e[3]];n[t+1]=a;n[t]=a[e[4]];l=l+1;e=o[l];n[e[2]]=n[e[3]]+e[4];l=l+1;e=o[l];n[e[2]]=n[e[3]]-e[4];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2];a=n[e[3]];n[t+1]=a;n[t]=a[e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]f={n[t](d(n,t+1,e[3]))};c=0;for e=t,e[4]do c=c+1;n[e]=f[c];end l=l+1;e=o[l];if n[e[2]]then l=l+1;else l=e[3];end;elseif t>1 then local t;n[e[2]]=f[e[3]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;else local e=e[2]n[e]=n[e](d(n,e+1,c))end;elseif t<=3 then do return n[e[2]]end elseif t>4 then n[e[2]]=n[e[3]][e[4]];else local l=e[2]local o,e=i(n[l]())c=e+l-1 local e=0;for l=l,c do e=e+1;n[l]=o[e];end;end;elseif t<=8 then if t<=6 then n[e[2]]=n[e[3]]+e[4];elseif t==7 then a[e[3]]=n[e[2]];else local e=e[2]local o,l=i(n[e](d(n,e+1,c)))c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;end;elseif t<=10 then if t>9 then if not n[e[2]]then l=l+1;else l=e[3];end;else local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]][n[e[3]]]=n[e[4]];l=l+1;e=o[l];l=e[3];end;elseif t==11 then local t;local a;local c;n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];c=e[2]a={n[c](d(n,c+1,e[3]))};t=0;for e=c,e[4]do t=t+1;n[e]=a[t];end l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];else do return n[e[2]]end end;elseif t<=19 then if t<=15 then if t<=13 then n[e[2]][e[3]]=n[e[4]];elseif t>14 then local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;else local o=e[2]local t={n[o](d(n,o+1,e[3]))};local l=0;for e=o,e[4]do l=l+1;n[e]=t[l];end end;elseif t<=17 then if t==16 then n[e[2]][n[e[3]]]=n[e[4]];else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t>18 then local t;t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=22 then if t<=20 then n[e[2]]=e[3];elseif t>21 then if not n[e[2]]then l=l+1;else l=e[3];end;else do return end;end;elseif t<=24 then if t==23 then if(e[2]<n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]=n[e[3]]+e[4];end;elseif t>25 then local h;local s,E;local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]s,E=i(n[t](n[t+1]))c=E+t-1 h=0;for e=t,c do h=h+1;n[e]=s[h];end;l=l+1;e=o[l];t=e[2]s,E=i(n[t](d(n,t+1,c)))c=E+t-1 h=0;for e=t,c do h=h+1;n[e]=s[h];end;l=l+1;e=o[l];t=e[2]n[t](d(n,t+1,c))l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];f[e[3]]=n[e[2]];l=l+1;e=o[l];do return end;else local l=e[2]n[l](d(n,l+1,e[3]))end;elseif t<=39 then if t<=32 then if t<=29 then if t<=27 then local t;n[e[2]]={};l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=f[e[3]];l=l+1;e=o[l];t=e[2];do return n[t](d(n,t+1,e[3]))end;l=l+1;e=o[l];t=e[2];do return d(n,t,c)end;l=l+1;e=o[l];do return end;elseif t==28 then n[e[2]]=f[e[3]];else local t;local d;local c;n[e[2]]={};l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];c=e[2]d={n[c](n[c+1])};t=0;for e=c,e[4]do t=t+1;n[e]=d[t];end l=l+1;e=o[l];l=e[3];end;elseif t<=30 then if n[e[2]]then l=l+1;else l=e[3];end;elseif t>31 then n[e[2]]=n[e[3]]-e[4];else local t=e[2];local c=e[4];local o=t+2 local t={n[t](n[t+1],n[o])};for e=1,c do n[o+e]=t[e];end;local t=t[1]if t then n[o]=t l=e[3];else l=l+1;end;end;elseif t<=35 then if t<=33 then if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;elseif t==34 then n[e[2]]={};else n[e[2]]=(e[3]~=0);l=l+1;end;elseif t<=37 then if t>36 then n[e[2]]();else local l=e[2];do return n[l](d(n,l+1,e[3]))end;end;elseif t==38 then local e=e[2]local o,l=i(n[e](n[e+1]))c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;else n[e[2]]=n[e[3]];end;elseif t<=46 then if t<=42 then if t<=40 then n[e[2]]=C(R[e[3]],nil,a);elseif t==41 then n[e[2]][e[3]]=n[e[4]];else local e=e[2];do return d(n,e,c)end;end;elseif t<=44 then if t>43 then if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;else local o=e[2];local l=n[e[3]];n[o+1]=l;n[o]=l[e[4]];end;elseif t>45 then local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;else local e=e[2]n[e](d(n,e+1,c))end;elseif t<=49 then if t<=47 then local e=e[2];do return d(n,e,c)end;elseif t>48 then n[e[2]]=a[e[3]];else n[e[2]]=(e[3]~=0);end;elseif t<=51 then if t==50 then local d=R[e[3]];local c;local t={};c=T({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==63 then t[c-1]={n,e[3]};else t[c-1]={f,e[3]};end;A[#A+1]=t;end;n[e[2]]=C(d,c,a);else n[e[2]]();end;elseif t==52 then n[e[2]]={};else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=80 then if t<=66 then if t<=59 then if t<=56 then if t<=54 then local l=e[2]local t={n[l](n[l+1])};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end elseif t>55 then a[e[3]]=n[e[2]];else local e=e[2]n[e]=n[e]()end;elseif t<=57 then local o=e[2];local l=n[e[3]];n[o+1]=l;n[o]=l[e[4]];elseif t>58 then for e=e[2],e[3]do n[e]=nil;end;else n[e[2]]=n[e[3]]-e[4];end;elseif t<=62 then if t<=60 then local t=e[2];local c=e[4];local o=t+2 local t={n[t](n[t+1],n[o])};for e=1,c do n[o+e]=t[e];end;local t=t[1]if t then n[o]=t l=e[3];else l=l+1;end;elseif t==61 then do return end;else n[e[2]]=a[e[3]];end;elseif t<=64 then if t>63 then local o=n[e[4]];if not o then l=l+1;else n[e[2]]=o;l=e[3];end;else n[e[2]]=n[e[3]];end;elseif t==65 then local l=e[2]n[l]=n[l](d(n,l+1,e[3]))else l=e[3];end;elseif t<=73 then if t<=69 then if t<=67 then if(e[2]<n[e[4]])then l=l+1;else l=e[3];end;elseif t>68 then local e=e[2]n[e]=n[e](d(n,e+1,c))else local h;local E,s;local t;n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=f[e[3]];l=l+1;e=o[l];t=e[2]E,s=i(n[t](n[t+1]))c=s+t-1 h=0;for e=t,c do h=h+1;n[e]=E[h];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,c))l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](d(n,t+1,e[3]))end;elseif t<=71 then if t==70 then local h;local s;local f;local E,C;local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];t=e[2]E,C=i(n[t]())c=C+t-1 f=0;for e=t,c do f=f+1;n[e]=E[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,c))l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];s=e[3];h=n[s]for e=s+1,e[4]do h=h..n[e];end;n[e[2]]=h;l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];if not n[e[2]]then l=l+1;else l=e[3];end;else n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]={};l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]={};end;elseif t>72 then local e=e[2]local o,l=i(n[e]())c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;else local e=e[2]n[e](n[e+1])end;elseif t<=76 then if t<=74 then f[e[3]]=n[e[2]];elseif t==75 then local l=e[2]local t={n[l](n[l+1])};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else local e=e[2]n[e]=n[e](n[e+1])end;elseif t<=78 then if t==77 then for e=e[2],e[3]do n[e]=nil;end;else local e=e[2]n[e]=n[e](n[e+1])end;elseif t>79 then local e=e[2]n[e]=n[e]()else n[e[2]][n[e[3]]]=n[e[4]];end;elseif t<=93 then if t<=86 then if t<=83 then if t<=81 then local l=e[2]n[l]=n[l](d(n,l+1,e[3]))elseif t>82 then n[e[2]]=(e[3]~=0);l=l+1;else if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=84 then local e=e[2]n[e](n[e+1])elseif t>85 then local h;local E,s;local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=f[e[3]];l=l+1;e=o[l];t=e[2]E,s=i(n[t](n[t+1]))c=s+t-1 h=0;for e=t,c do h=h+1;n[e]=E[h];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,c))l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]E,s=i(n[t](n[t+1]))c=s+t-1 h=0;for e=t,c do h=h+1;n[e]=E[h];end;l=l+1;e=o[l];t=e[2]E,s=i(n[t](d(n,t+1,c)))c=s+t-1 h=0;for e=t,c do h=h+1;n[e]=E[h];end;l=l+1;e=o[l];t=e[2]n[t](d(n,t+1,c))l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];l=e[3];else local d=R[e[3]];local c;local t={};c=T({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==63 then t[c-1]={n,e[3]};else t[c-1]={f,e[3]};end;A[#A+1]=t;end;n[e[2]]=C(d,c,a);end;elseif t<=89 then if t<=87 then local t;n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]={};l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];t=e[2]n[t](d(n,t+1,e[3]))l=l+1;e=o[l];do return end;elseif t==88 then local c;local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];t=e[2];c=n[e[3]];n[t+1]=c;n[t]=c[e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]={};l=l+1;e=o[l];t=e[2];c=n[e[3]];n[t+1]=c;n[t]=c[e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=f[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];f[e[3]]=n[e[2]];l=l+1;e=o[l];l=e[3];else local t;n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t<=91 then if t==90 then n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=f[e[3]];l=l+1;e=o[l];if n[e[2]]then l=l+1;else l=e[3];end;else n[e[2]]=C(R[e[3]],nil,a);end;elseif t>92 then local o=n[e[4]];if not o then l=l+1;else n[e[2]]=o;l=e[3];end;else n[e[2]]=f[e[3]];end;elseif t<=100 then if t<=96 then if t<=94 then n[e[2]]=n[e[3]][e[4]];elseif t>95 then f[e[3]]=n[e[2]];else local e=e[2]n[e](d(n,e+1,c))end;elseif t<=98 then if t==97 then local h;local s,E;local t;n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=f[e[3]];l=l+1;e=o[l];t=e[2]s,E=i(n[t](n[t+1]))c=E+t-1 h=0;for e=t,c do h=h+1;n[e]=s[h];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,c))l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](d(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];l=e[3];else local e=e[2]local o,l=i(n[e](d(n,e+1,c)))c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;end;elseif t>99 then if n[e[2]]then l=l+1;else l=e[3];end;else n[e[2]]=e[3];end;elseif t<=103 then if t<=101 then local l=e[2]n[l](d(n,l+1,e[3]))elseif t>102 then local l=e[2];do return n[l](d(n,l+1,e[3]))end;else local f;local i;local c;local t;t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];t=e[2];c=n[e[3]];n[t+1]=c;n[t]=c[e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];t=e[2];c=n[e[3]];n[t+1]=c;n[t]=c[e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]i={n[t](d(n,t+1,e[3]))};f=0;for e=t,e[4]do f=f+1;n[e]=i[f];end l=l+1;e=o[l];t=e[2];c=n[e[3]];n[t+1]=c;n[t]=c[e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]]-e[4];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](d(n,t+1,e[3]))l=l+1;e=o[l];if not n[e[2]]then l=l+1;else l=e[3];end;end;elseif t<=105 then if t>104 then local o=e[2]local t={n[o](d(n,o+1,e[3]))};local l=0;for e=o,e[4]do l=l+1;n[e]=t[l];end else l=e[3];end;elseif t>106 then n[e[2]]=(e[3]~=0);else local e=e[2]local o,l=i(n[e](n[e+1]))c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;end;l=l+1;end;end;end;return C(K(),{},S())();