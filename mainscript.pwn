#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <streamer>
#include <Dudb>
#include <foreach>
#include <AutoAFK>
#include <a_mysql>
#include <dth_vehspeed>

#define     gmText            "W-RP (Pre-Alpha)"

#define    MYSQL_HOST        "localhost"
#define    MYSQL_USER        "root"
#define    MYSQL_DATABASE    "samptest"
//#define    MYSQL_PASSWORD    ""
#define    MYSQL_PASSWORD    "6rR8JrfG"

#define     COLOR_GREY        0x808080FF
#define     COLOR_WHITE       0xFFFFFFFF
#define     COLOR_YELLOW      0xFFFF00FF
#define     COLOR_GREEN       0x088A08FF
#define     COLGREEN          0x009900FF
#define     COLRED            0xFF0000FF
#define     COLME             0xC2A2DAFF
#define     COLOR_LIGHTRED    0xFF6347FF
#define     COL_WHITE         "{FFFFFF}"
#define     COL_RED           "{F81414}"
#define     FAC_INF_MSG       0x50DAF2FF
#define     COL_GREEN         "{00FF22}"
#define     COL_LIGHTBLUE     0x00CED1FF
#define     COLOR_PDRAD       0x2B88BBFF

#define COLOR_SCRIPTER 0xFA58ACFF
#define COLOR_ADMWARN 0xFF8000FF
#define COLOR_RED 0xFF0606FF
#define COLOR_ADUTY 0xFF8000FF
#define COLOR_HDUTY 0x4F710FFF

#define COLOR_INT 0x01A9DBFF
#define COLOR_PURPLE 0xC2A2DAFF

#define DIALOG_REGISTER         1
#define DIALOG_LOGIN            2
#define DIALOG_SUCCESS_1        3
#define DIALOG_SUCCESS_2        4
#define DIALOG_SKIN             5
#define DIALOG_CLOTHES          6
#define DIALOG_EQSD_LOCKERS     7
#define DIALOG_LOCKERS_DUTY     8
#define DIALOG_SHOP             9
#define DIALOG_DEALERSHIP       10
#define DIALOG_DMV              11
#define DIALOG_REGISTER_AGE     12
#define DIALOG_REGISTER_GENDER  13
#define DIALOG_DRUGINV       	14
#define DIALOG_DRUGINV_MENU  	15
#define DIALOG_DRUGINV_DROP  	16
#define DIALOG_DRUGINV_GIVE1 	17
#define DIALOG_DRUGINV_GIVE2 	18
#define DIALOG_DRUGINV_USE   	19
#define DIALOG_LOCKER_EDIT_MAIN 20
#define DIALOG_LOCKER_EDIT_WEAP 21
#define DIALOG_SASMD_ELEVATOR   22
#define DIALOG_GYM_LOCKER   	23
#define DIALOG_MDC_MAIN         24
#define DIALOG_MDC_INPUT        25
#define DIALOG_MDC_BOLO_CHOICE  26
#define DIALOG_MDC_BOLO_INPUT   27
#define DIALOG_MDC_BOLO_LIST    28
#define DIALOG_MDC_BOLO_CHOICE2 29
#define DIALOG_MDC_BOLO_LIST_CH 30
#define DIALOG_MDC_BOLO_LIST1   31
#define DIALOG_MDC_BOLO_INFO    32
#define DIALOG_LOTTERY_TICKET   33
#define DIALOG_FLAGS_LIST       34
#define DIALOG_FLAGS_LIST_CH    35
#define DIALOG_REG_DOB_DAY		36
#define DIALOG_REG_NATIONALITY	37
#define DIALOG_REG_HEIGHT		38
#define DIALOG_REG_WEIGHT		39
#define DIALOG_REG_HAIRCOLOR	40
#define DIALOG_REG_EYECOLOR		41
#define DIALOG_DRINKS			42
#define DIALOG_REG_DOB_MONTH	43
#define DIALOG_REG_DOB_YEAR		44
#define DIALOG_INJURES 			45

#define     MAX_FACTIONS    	10
#define     MAX_DOORS       	200
#define 	MAX_CUSTOM_VEHICLES 200
#define 	MAX_OPTABLES        30
#define     PAY_CHECK       	100
#define     MAX_HOUSES          100
#define     MAX_WEAPONS         200
#define     MAX_BIZ             50
#define     MAX_BOLOS           100
#define     EX_SPLITLENGTH      90
#define     MAX_GASTATIONS      40
#define 	MAX_PLANTS 			100

#define     VEH_RENT_PRICE  	25
#define     TYPA_PRICE      	100
#define     TYPB_PRICE      	150
#define     TYPC_PRICE      	50

#define WeaponColtPrice      80
#define WeaponDeaglePrice    120
#define WeaponShotgunPrice   200
#define WeaponUZIPrice       240
#define WeaponTecPrice       250
#define WeaponAKPrice        500
#define WeaponM4Price        570
#define WeaponSniperPrice    800
#define WeaponKevlarPrice    110

#define WeaponColtAmmo       50
#define WeaponDeagleAmmo     50
#define WeaponShotgunAmmo    20
#define WeaponUZIAmmo        100
#define WeaponTecAmmo        100
#define WeaponAKAmmo         75
#define WeaponM4Ammo         75
#define WeaponSniperAmmo     20

#define SPECIAL_ACTION_PISSING 68

#pragma unused ret_memcpy
#pragma dynamic 94831

new daysInMonth[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};
forward AdminLog(logstring[]);
public AdminLog(logstring[])
{
    new entry[256],time[6],timestr[60];
	gettime(time[0], time[1], time[2]);
	getdate(time[3], time[4], time[5]);
	format(timestr,60,"[%02d.%02d|%02d:%02d] ",time[5],time[4], time[0], time[1]);
    format(entry, sizeof(entry), "%s%s\r\n",timestr,logstring);
    new File:hFile = fopen("/Logs/admin.log", io_append);
    fwrite(hFile, entry);
    fclose(hFile);
}
forward CharityLog(logstring[]);
public CharityLog(logstring[])
{
    new entry[256],time[6],timestr[60];
	gettime(time[0], time[1], time[2]);
	getdate(time[3], time[4], time[5]);
	format(timestr,60,"[%02d.%02d|%02d:%02d] ",time[5],time[4], time[0], time[1]);
    format(entry, sizeof(entry), "%s%s\r\n",timestr,logstring);
    new File:hFile = fopen("/Logs/charity.log", io_append);
    fwrite(hFile, entry);
    fclose(hFile);
}
forward KickB(playerid);
public KickB(playerid) return SetTimerEx("KickPla",100,false,"i",playerid);
forward KickPla(playerid);
public KickPla(playerid) return Kick(playerid);

enum wpInfo
{
	wpID,
    Float:wpX,
    Float:wpY,
	Float:wpZ,
	wpVW,
	wpInt,
	wpTime
};
new PlantInfo[MAX_PLANTS][wpInfo];

forward LoadPlant(id);
public LoadPlant(id)
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
	{
		cache_get_value_name_int(0, "ID", PlantInfo[id][wpID]);
		cache_get_value_name_float(0, "x", PlantInfo[id][wpX]);
		cache_get_value_name_float(0, "y", PlantInfo[id][wpY]);
		cache_get_value_name_float(0, "z", PlantInfo[id][wpZ]);
		cache_get_value_name_int(0, "vw", PlantInfo[id][wpVW]);
		cache_get_value_name_int(0, "interior", PlantInfo[id][wpInt]);
		cache_get_value_name_int(0, "time", PlantInfo[id][wpTime]);
	}
	return 1;
}

enum dInfo 
{
	Float:dox,//enter x
	Float:doy,// y
	Float:doz,// z
	Float:doa,//facing angle
	doi,
	dow,//interior, worldid
	Float:dix,//exit x
	Float:diy,//y
	Float:diz,//z
	Float:dia,//facing angle
	dii,
	diw,
	dlocked,//interior, worldid, locked[save]
	Text3D:dtext,
	dlabel[256],//text label obj[no save], label text[save]
	dtexton,//text on [save]
	dcolor,
	
}
new DoorInfo[MAX_DOORS][dInfo];
new DoorCreated[MAX_DOORS];

enum NoteBookInfo
{
	Note1[10],
	Note2[10],
	Note3[10],
	Note4[10],
	Note5[10],
	Note6[10],
	Note7[10],
	Note8[10],
	Note9[10],
	Note10[10],
	Note11[10],
	Note12[10],
	Note13[10],
	Note14[10],
	Note15[10],
	Note16[10],
	Note17[10],
	Note18[10],
	Note19[10],
	Note20[10]
};
new NoteInfo[MAX_PLAYERS][NoteBookInfo];

enum wInfo
{
	WeaponObject,
	WeaponID,
	WeaponAmmo,
	WeaponTime,
	Float:WeaponX,
	Float:WeaponY,
	Float:WeaponZ,
	WeaponVW,
	WeaponInt
};
new WeaponInfo[MAX_WEAPONS][wInfo];

enum gsInfo
{
    Text3D:gsLabel,
    gsOwner,
    gsPrice,
    Float:gsX,
    Float:gsY,
    Float:gsZ,
	gsInt,
	gsVW,
};
new GasStationInfo[MAX_GASTATIONS][gsInfo];

enum hInfo
{
	Text3D:hLabel,
    hOwner,
    hLocked,
    hPrice,
    Float:hOX,
    Float:hOY,
    Float:hOZ,
    Float:hIX,
    Float:hIY,
    Float:hIZ,
	hOInt,
	hOVW,
	hIInt,
    hIVW,
    hOwnerName[36],
    hLights,
};
new HouseInfo[MAX_HOUSES][hInfo];

enum bInfo
{
	Text3D:bLabel,
	Text3D:bBLabel,
	bName[30],
    bOwner,
    bLocked,
    bPrice,
    bType,
    bTypeShow,
    bMoney,
    Float:bOX,
    Float:bOY,
    Float:bOZ,
    Float:bIX,
    Float:bIY,
    Float:bIZ,
    Float:bBX,
    Float:bBY,
    Float:bBZ,
	bOInt,
	bOVW,
	bIInt,
    bIVW,
};
new BizInfo[MAX_BIZ][bInfo];

enum otInfo
{
	Text3D:OTable,
	Float:OTX,
	Float:OTY,
	Float:OTZ,
	OpVW,
};
new OTableInfo[MAX_OPTABLES][otInfo];

enum addBOLO
{
	BOLOID,
	BOLOtype,
	BOLOdate[20],
	BOLOmodel[40],
	BOLOcolor1[20],
	BOLOcolor2[20],
	BOLOplate[10],
	BOLOperson[30],
	BOLOlastseen[30],
	BOLOcreator[30],
	BOLOstatus,
};
new BOLOAdd[MAX_BOLOS][addBOLO], PlayerBOLOAdding[MAX_PLAYERS];

enum shotInfo
{
	 Chest,
	 Crotch,
	 LArm,
	 RArm,
	 LLeg,
	 RLeg,
	 Head,
	 Misc
}
new sInfo[MAX_PLAYERS][shotInfo];

forward ClosestOTable(playerid);
public ClosestOTable(playerid)
{
	for(new table=1; table<MAX_OPTABLES; table++)
 	{
    	if(IsPlayerInRangeOfPoint(playerid, 2, OTableInfo[table][OTX], OTableInfo[table][OTY], OTableInfo[table][OTZ]) && GetPlayerVirtualWorld(playerid) == OTableInfo[table][OpVW])
     	{
			return table;
    	}
 	}
	return 0;
}

enum fInfo {     Name[120],     Type,     Badges,     Chat,     Money,
Weapon_Colt,     Weapon_Deagle,     Weapon_Shotgun,     Weapon_UZI,
Weapon_Tec,     Weapon_AK,     Weapon_M4,     Weapon_Sniper,
Weapon_Kevlar,     FacDealer1,     FacDealer2,     FacDealer3,
Text3D:Lockers,     LockerName[120],     Float:LockerX,     Float:LockerY,
Float:LockerZ,     LockerVW, }; new FactionInfo[MAX_FACTIONS][fInfo];

forward ChatLog(logstring[]);
public ChatLog(logstring[])
{
    new entry[256],time[6],timestr[60];
	gettime(time[0], time[1], time[2]);
	getdate(time[3], time[4], time[5]);
	format(timestr,60,"[%02d.%02d|%02d:%02d] ",time[5],time[4], time[0], time[1]);
    format(entry, sizeof(entry), "%s | %s\r\n",timestr,logstring);
    new File:hFile = fopen("/Logs/chats.log", io_append);
    fwrite(hFile, entry);
    fclose(hFile);
}
forward FacLog(faction,logstring[]);
public FacLog(faction,logstring[])
{
    new entry[256],time[6],timestr[60];
	gettime(time[0], time[1], time[2]);
	getdate(time[3], time[4], time[5]);
	format(timestr,60,"[%02d.%02d|%02d:%02d] ",time[5],time[4], time[0], time[1]);
    format(entry, sizeof(entry), "%s | [%s] %s\r\n",timestr,FactionInfo[faction][Name],logstring);
    new File:hFile = fopen("/Logs/factions.log", io_append);
    fwrite(hFile, entry);
    fclose(hFile);
}

new ac[MAX_PLAYERS],
	aduty[MAX_PLAYERS],
	hduty[MAX_PLAYERS],
	newp[MAX_PLAYERS],
	maskon[MAX_PLAYERS],
	timerupdate[MAX_PLAYERS],
	timerminutes[MAX_PLAYERS],
	timenothit[MAX_PLAYERS],
	IsLogged[MAX_PLAYERS],
	IsRenting[MAX_PLAYERS],
	HasWeapon[MAX_PLAYERS],
	OfferFrisk[MAX_PLAYERS],
	OfferFrisker[MAX_PLAYERS],
	Tooling[MAX_PLAYERS],
	HasTazer[MAX_PLAYERS],
	Tazed[MAX_PLAYERS],
	BeingCalled[MAX_PLAYERS],
	InCall[MAX_PLAYERS],
	PhonePower[MAX_PLAYERS],
	PhoneVib[MAX_PLAYERS],
	EQSDGate1,
	Gate1,
	EQSDGate2,
	Gate2,
	EQSDGate3,
	Gate3,
	EQSDGate4,
	Gate4,
	EQSDGate5,
	Gate5,
	EQSDGate6,
	Gate6,
	EQSDGate7,
	Gate7,
	threeseconds,
	Tracing[MAX_PLAYERS],
	Patching[MAX_PLAYERS],
	BeingOperated[MAX_PLAYERS],
	Tabbed[MAX_PLAYERS],
	TabbedTimer[MAX_PLAYERS],
	LockEdit[MAX_PLAYERS],
	Hotwire[MAX_PLAYERS],
	Float:positionxdead[MAX_PLAYERS],
	Float:positionydead[MAX_PLAYERS],
	Float:positionzdead[MAX_PLAYERS],
	vwDead[MAX_PLAYERS],
	intDead[MAX_PLAYERS],
	Seatbelt[MAX_PLAYERS],
	PhoneWitheld[MAX_PLAYERS],
	Spectating[MAX_PLAYERS],
	SpecVW[MAX_PLAYERS],
	SpecInt[MAX_PLAYERS],
	Ticketed[MAX_PLAYERS],
	TicketPrice[MAX_PLAYERS],
	RubberBullets[MAX_PLAYERS],
	AdminHideCmds[MAX_PLAYERS],
	DeathPlayer[MAX_PLAYERS],
	TappingPhone[MAX_PLAYERS][MAX_PLAYERS],
	InformSpec[MAX_PLAYERS][MAX_PLAYERS],
	BeingDragged[MAX_PLAYERS],
	Text:fueltext[MAX_PLAYERS],
	Text:fuelstate[MAX_PLAYERS],
	secondplayerupdate[MAX_PLAYERS],
	MDCchoice[MAX_PLAYERS],
	BOLOchoice[MAX_PLAYERS],
	DrugInvSelect[MAX_PLAYERS],
	DrugChoose[MAX_PLAYERS],
	UsingWeed[MAX_PLAYERS],
	UsingCocaine[MAX_PLAYERS],
	InfoBoxTimer[MAX_PLAYERS],
	StatBoxTimer[MAX_PLAYERS],
	JustJoined[MAX_PLAYERS],
	PlayerBB[MAX_PLAYERS],
	PlayerBBObject[MAX_PLAYERS],
	Text3D:PlayerBBLabel[MAX_PLAYERS],
	PlayerBBUrl[MAX_PLAYERS][256],
	PlayerBBPUrl[MAX_PLAYERS][256],
	AllowedToSpec[MAX_PLAYERS],
	SpeedLimit[MAX_PLAYERS],
	SpeedLS[MAX_PLAYERS],
	SpeedLSTimer[MAX_PLAYERS],
	PlayerBBMOn[MAX_PLAYERS],
	PlayerText:speedo0[MAX_PLAYERS],
	PlayerText:speedo1[MAX_PLAYERS],
	PlayerText:speedo2[MAX_PLAYERS],
	PlayerText:speedo3[MAX_PLAYERS],
	PlayerText:speedo4[MAX_PLAYERS];
	
enum vfInfo
{
	vUID,
    dID,
    dModel,
    Float:vHealth,
    vFuel,
    vFuelTimer,
    Float:dX,
    Float:dY,
    Float:dZ,
    Float:dA,
    dColor1,
    dColor2,
    vWindows,
    vFaction,
    vLocked,
    vRental,
    vRenter,
    vRadio[124],
    vRadioOn,
    vBulletproof,
	vJob,
	vDMV,
    vOwner,
    vPlate[6],
	vSlots,
};
new idoffile[MAX_PLAYERS],
	DVehicles[MAX_CUSTOM_VEHICLES][vfInfo];

enum pInfo
{
    ORM:ORM_ID,
	pID,
    Float:pLastX,
	Float:pLastY,
	Float:pLastZ,
	Float:pLastA,
	pVW,
	pInterior,
	Float:pHealth,
	Float:pArmor,
    pPass,
    pAdmin,
    pMod,
    pBetaTester,
    pHours,
	pMinutes,
	pGender,
    pMats,
    pMoney,
    pBMoney,
    pSkin,
    pAccent[20],
    pJob,
    pLotteryTicket,
    pDetective,
    pPhone,
    pDeathTime,
	pDonator, //Not for now, later
    pLoggedIn,
    pFac,
    pFacRank[120],
    pDuty,
    pOffSkin,
    pBadge,
	pTier,
	pRealName[MAX_PLAYER_NAME],
    pMaskID,
    pMask,
    pRadio,
	pRadio1,
	pRadio2,
    pToolkit,
    pMedikit,
    pScrewdriver,
    pGasCan,
    pTakingTest,
    pDLicense,
    pFLicense,
	pGun1,
    pGunAmmo1,
    pGun2,
    pGunAmmo2,
    pGun3,
    pGunAmmo3,
    pGun4,
    pGunAmmo4,
    pGunHold,
    pGunHoldAmmo,
    pBanned,
    pBReason[126],
    pBanner[126],
    InPrison,
    pPrisonTime,
	pReleased,
	pAJail,
	pFightStyle,
	pBoombox,
	pSync,
	pCocaine,
	pCrack,
    pWeed,
    pSeeds,
    pDOB[11],
    pNationality[20],
    pHeight,
    pWeight,
    pHairColor[20],
    pEyeColor[20],
//  Variables that are not for saving
    pPayCheck,
    pPInterest,
    pPPastBank,
    pPRent,
    pAge,
    pDOBMonth[3],
    pDOBDay[3],
};

new PlayerText:playerHP[MAX_PLAYERS],PlayerText:playerAP[MAX_PLAYERS],PlayerText:InfoBox[MAX_PLAYERS];

new Text:Timet, Text:Date, PlayerText:DeathText[MAX_PLAYERS], PlayerText:DeathTextt[MAX_PLAYERS], PlayerText:PickingText[MAX_PLAYERS], PlayerText:PickText[MAX_PLAYERS],Text:o,
 	Text:enginetext[MAX_PLAYERS],Text:a[MAX_PLAYERS],Text:enginestate[MAX_PLAYERS],Text:doorss[MAX_PLAYERS],Text:BETA_TEXT,PlayerText:InfoBoxHead[MAX_PLAYERS],PlayerText:InfoBoxText[MAX_PLAYERS],
 	PlayerText:StatBoxHead[MAX_PLAYERS],PlayerText:StatBoxLeftText[MAX_PLAYERS],PlayerText:StatBoxCenterText[MAX_PLAYERS];

forward settime();

new PlayerInfo[MAX_PLAYERS][pInfo];

//Forwards
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);

main(){}

new Text3D:label[30],Text3D:adutylabl[60],Text3D:hdutylabl[60],MySQL:connection;

public OnGameModeInit()
{
	printf("%d",udb_hash("changeme"));
    mysql_log(ALL);
    connection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);
	SetGameModeText(gmText);
	if(connection && mysql_errno(connection) == 0)
	{
		printf("[MySQL]: Connection to database successfully established!");
	}
	else
	{
		printf("[MySQL]: Connection to database failed!");
	}
	Create3DTextLabel("Hospital\n/enter", -1, -1514.747431, 2518.928095, 56.035937, 10.0, 0, 1);
	Create3DTextLabel("{00FF22}The Bank Of San Andreas\n{FFFFFF}/enter", -1, -2485.5010,2272.7756,4.9844, 10.0, 0, 1);
	Create3DTextLabel("/withdraw /deposit /balance\n/transfer", -1, 2308.8992, -13.4960, 26.7422, 10.0, 0, 1);
	Create3DTextLabel("Materials Pickup\n{FFFFFF}Type /getmats to aquire materials", 0x008080FF, -1519.286499, 2560.106445, 55.840278, 10.0, 0, 1);
	Create3DTextLabel("Delivery Job\n{FFFFFF}/takejob", 0x008080FF, -1536.0004,2564.1389,55.8359, 10.0, 0, 1);
	Create3DTextLabel("Mechanic Job\n{FFFFFF}/takejob", 0x008080FF, -1507.5129,2560.5530,55.8359, 10.0, 0, 1);
    //Create3DTextLabel("{D6914D}San Andreas State Troopers\n{FFFFFF}/enter", -1, -2454.5938,2254.0781,4.9801,   10.0, 0, 1);
    Create3DTextLabel("{00FF22}Licensing Company\n{FFFFFF}/enter", -1, -1471.5673,2592.1096,55.8359,   10.0, 0, 1);
    Create3DTextLabel("{00FF22}El Quebrados Hotel\n{FFFFFF}/enter", -1, -1465.578002,2611.536376,56.179687,   10.0, 0, 1);
    Create3DTextLabel("Licensing Company\n{FFFFFF}/taketest", 0x008080FF, 1490.5454,1305.7091,1093.2964,   10.0, 0, 1);
    Create3DTextLabel("Prison\n/enter", -1, -1206.8391,1825.7917,41.7188,   10.0, 0, 1);
    Create3DTextLabel("{00FF22}Vehicle Dealership\n{FFFFFF}/dealership", -1, -1438.9114,2591.2102,55.8359,   10.0, 0, 1);
	Create3DTextLabel("{00FF22}Faggio Rentals", -1, -1486,2619.2627,57.3,   10.0, 0, 1);
	Create3DTextLabel("SAST Elevator\n/elevator", -1, 1948.9642,-2236.6240,14.6328,   10.0, 3, 1);
	Create3DTextLabel("SAST Elevator\n/elevator", -1, 1378.5524,395.9639,3383.7585,   10.0, 0, 1);
	Create3DTextLabel("{00FF22}The Gym\n{FFFFFF}/enter", -1, -2492.3667,2363.2014,10.2772, 10.0, 0, 1);
	Create3DTextLabel("{00FF22}Gym Lockers\n{FFFFFF}/changefs", -1, 770.9821,-59.1260,1000.6563, 10.0, 0, 1);
    CreatePickup(1239, 1, -1536.0004,2564.1389,55.8359, 0);
    CreatePickup(1239, 1, -1507.5129,2560.5530,55.8359, 0);
    SetTimer("ServerHints", 1200000, true); // 20 Minutes
    SendRconCommand("reloadfs mappings");
    ShowNameTags(0);
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
    ManualVehicleEngineAndLights();
    EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
    EnableVehicleFriendlyFire();

    SetTimer("SecondUpdate",1000,true);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    enginetext[i] = TextDrawCreate(530,400,"Engine:");
	    TextDrawSetOutline(enginetext[i], 1);
		TextDrawFont(enginetext[i],1);
		TextDrawLetterSize(enginetext[i],0.3,1.1);
		TextDrawColor(enginetext[i],0xA94AFFFF);
		TextDrawBackgroundColor(enginetext[i],350);
		TextDrawUseBox(enginetext[i],1);
		TextDrawBoxColor(enginetext[i], 0xFFFFFF20);
		fueltext[i] = TextDrawCreate(530,413.3,"Fuel:");
	    TextDrawSetOutline(fueltext[i], 1);
		TextDrawFont(fueltext[i],1);
	 	TextDrawLetterSize(fueltext[i],0.3,1.1);
		TextDrawColor(fueltext[i],0xA94AFFFF);
		TextDrawBackgroundColor(fueltext[i],350);
		TextDrawUseBox(fueltext[i],1);
		TextDrawBoxColor(fueltext[i], 0xFFFFFF20);
		fuelstate[i] = TextDrawCreate(570,413.3,"100%");
	    TextDrawSetOutline(fuelstate[i], 1);
		TextDrawFont(fuelstate[i],1);
	 	TextDrawLetterSize(fuelstate[i],0.3,1.1);
		TextDrawColor(fuelstate[i],0xFFFFFFFF);
		TextDrawBackgroundColor(fuelstate[i],350);
		enginestate[i] = TextDrawCreate(570,400,"Off");
	    TextDrawSetOutline(enginestate[i], 1);
		TextDrawFont(enginestate[i],1);
	 	TextDrawLetterSize(enginestate[i],0.3,1.1);
		TextDrawColor(enginestate[i],0xFFFFFFFF);
		TextDrawBackgroundColor(enginestate[i],350);
		doorss[i] = TextDrawCreate(570,386.7,"Unlocked");
	    TextDrawSetOutline(doorss[i], 1);
		TextDrawFont(doorss[i],1);
	 	TextDrawLetterSize(doorss[i],0.3,1.1);
		TextDrawColor(doorss[i],0xFFFFFFFF);
		TextDrawBackgroundColor(doorss[i],350);
		a[i] = TextDrawCreate(530,386.7,"Doors:");
	    TextDrawSetOutline(a[i], 1);
		TextDrawFont(a[i],1);
	 	TextDrawLetterSize(a[i],0.3,1.1);
		TextDrawColor(a[i],0xA94AFFFF);
		TextDrawBackgroundColor(a[i],350);
		TextDrawUseBox(a[i],1);
		TextDrawBoxColor(a[i], 0xFFFFFF20);
	}
    BETA_TEXT = TextDrawCreate(527,96.5,"BETA");

	TextDrawFont(BETA_TEXT,3);
    TextDrawLetterSize(BETA_TEXT,0.7 ,1.6);
    TextDrawColor(BETA_TEXT,0xffffffff);
    TextDrawSetShadow(BETA_TEXT, 0);
    TextDrawSetOutline(BETA_TEXT, 1);
    TextDrawFont(BETA_TEXT, 1);

	Date = TextDrawCreate(547.000000,11.000000,"--");

	TextDrawFont(Date,3);
    TextDrawLetterSize(Date,0.399999,1.600000);
    TextDrawColor(Date,0xffffffff);
    TextDrawSetShadow(Date, 0);
    TextDrawSetOutline(Date, 1);

    Timet = TextDrawCreate(547.000000,28.000000,"--");
    TextDrawFont(Timet,3);
    TextDrawLetterSize(Timet,0.399999,1.600000);
    TextDrawColor(Timet,0xffffffff);
    TextDrawSetShadow(Timet, 0);
    TextDrawSetOutline(Timet, 1);

    o = TextDrawCreate(21,430,"www.westwoodroleplay.com");
	TextDrawFont(o,3);
 	TextDrawLetterSize(o,0.3,0.9);
	TextDrawColor(o,0xC9C9C9FF);
	TextDrawSetOutline(o,1);
	TextDrawBackgroundColor(o,288);
	TextDrawUseBox(o,0);
	
	EQSDGate1 = CreateDynamicObject(968, -1415.08, 2638.8, 55.50000, 0.00000, 90.00000, 90);
 	EQSDGate2 = CreateDynamicObject(19302, 1370.40295, 389.31790, 3383.99878, 0.00000, 0.00000, 90);
 	EQSDGate3 = CreateDynamicObject(19303,1935.625122,-2262.674072,13.822796,0.000000,0.000000,270.000000,2,1);
 	EQSDGate4 = CreateDynamicObject(19303,1939.767944,-2262.684814,13.822796,0.000000,0.000000,270.000000,2,1);
 	EQSDGate5 = CreateDynamicObject(986,-1196.739257,1838.392700,41.559131,0.000000,0.000000,-44.799980,0,0);
 	EQSDGate6 = CreateDynamicObject(19302,1942.059204,-2241.208007,14.872814,0.000000,0.000000,0.000000,3,1);
 	EQSDGate7 = CreateDynamicObject(19303,1957.269409,-2274.750244,13.822794,0.000000,0.000000,0.000000,2,1);

 	for(new b = 1; b < sizeof(DVehicles); b++)
	{
		new Query[80];
		format(Query,sizeof(Query),"SELECT * FROM `vehicles` WHERE `vID` = '%d'",b);
		mysql_tquery(connection,Query,"LoadVehicle","i",b);
	}
	for(new i = 1; i < MAX_FACTIONS; i++)
	{
	    new Query[120];
		format(Query,sizeof(Query),"SELECT * FROM `factions` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadFaction","i",i);
	}
	for(new i = 1; i < MAX_OPTABLES; i++)
	{
		new Query[80];
		format(Query,sizeof(Query),"SELECT * FROM `optables` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadOpTable","i",i);
	}
	for(new i = 1; i < MAX_HOUSES; i++)
	{
	    new Query[80];
		format(Query,sizeof(Query),"SELECT * FROM `houses` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadHouse","i",i);
	}
	for(new i = 1; i < MAX_GASTATIONS; i++)
	{
		new Query[80];
		format(Query,sizeof(Query),"SELECT * FROM `gasstations` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadGasStation","i",i);
	}
	for(new i = 0; i < MAX_BOLOS; i++)
	{
	    new Query[120];
		format(Query,sizeof(Query),"SELECT * FROM `bolos` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadBOLO","i",i);
	}
	for(new i = 0; i < MAX_PLANTS; i++)
	{
	    new Query[120];
		format(Query,sizeof(Query),"SELECT * FROM `plants` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadPlant","i",i);
	}
	for(new i = 1; i < MAX_BIZ; i++)
	{
		new Query[120];
		format(Query,sizeof(Query),"SELECT * FROM `bizs` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadBiz","i",i);
	}
	for(new i = 1; i < MAX_DOORS; i++)
	{
		new Query[120];
		format(Query,sizeof(Query),"SELECT * FROM `doors` WHERE `ID` = '%d'",i);
		mysql_tquery(connection,Query,"LoadDoor","i",i);
	}
	return 1;
}

public OnGameModeExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++) OnPlayerDisconnect(i, 1);
	for(new i; i<MAX_DOORS; i++)
	{
	    if(DoorCreated[i] != 0) {SaveDoor(i); Delete3DTextLabel(DoorInfo[i][dtext]);}
	}
	SendRconCommand("unloadfs mappings");
	for(new fileid = 1; fileid < sizeof(DVehicles);)
    {
        if(DVehicles[fileid][dModel] != 0){SaveVehicle(fileid);}
        DVehicles[fileid][dModel] = 0;
        DVehicles[fileid][vHealth] = 1000;
        DVehicles[fileid][vBulletproof] = 0;
        DVehicles[fileid][dX] = 0;
        DVehicles[fileid][dA] = 0;
        DVehicles[fileid][dY] = 0;
        DVehicles[fileid][dZ] = 0;
        DVehicles[fileid][dColor1] = 0;
        DVehicles[fileid][dColor2] = 0;
        DVehicles[fileid][vFaction] = 0;
        DVehicles[fileid][vLocked] = 0;
        DVehicles[fileid][vRental] = 0;
        DVehicles[fileid][vRenter] = 1111;
        DVehicles[fileid][vJob] = 0;
        DVehicles[fileid][vDMV] = 0;
        DVehicles[fileid][vOwner] = 0;
        fileid++;
    }
    for(new i = 1; i < MAX_HOUSES; i++)
	{
		if(HouseInfo[i][hOX] != 0) {SaveHouse(i); Delete3DTextLabel(HouseInfo[i][hLabel]);}
	}
	for(new i = 1; i < MAX_GASTATIONS; i++)
	{
		if(GasStationInfo[i][gsX] != 0) {SaveGasStation(i); Delete3DTextLabel(GasStationInfo[i][gsLabel]);}
	}
	for(new i = 1; i < MAX_BIZ; i++)
	{
		if(BizInfo[i][bOX] != 0) {SaveBiz(i); Delete3DTextLabel(BizInfo[i][bLabel]); Delete3DTextLabel(BizInfo[i][bBLabel]);}
	}
	for(new i = 1; i < MAX_WEAPONS; i++)
	{
		if(WeaponInfo[i][WeaponX] == 0)
		{
		    WeaponInfo[i][WeaponID] = 0;
			WeaponInfo[i][WeaponAmmo] = 0;
			WeaponInfo[i][WeaponTime] = 0;
			WeaponInfo[i][WeaponX] = 0;
			WeaponInfo[i][WeaponY] = 0;
			WeaponInfo[i][WeaponZ] = 0;
			WeaponInfo[i][WeaponVW] = 0;
			WeaponInfo[i][WeaponInt] = 0;
			DestroyDynamicObject(WeaponInfo[i][WeaponObject]);
		}
	}
	for(new i = 1; i < MAX_FACTIONS; i++)
	{
	    SaveFaction(i);
	}
	mysql_close(connection);
    return 1;
}

new serverhintcount;

forward ServerHints();
public ServerHints()
{
	switch(serverhintcount)
	{
		case 0: SendClientMessageToAll(COL_LIGHTBLUE, "[HINT] Type in /help to see all the available commands.");
		case 1: SendClientMessageToAll(COL_LIGHTBLUE, "[HINT] Need help? Use /requesthelp to get a Helper assigned to you.");
	}
	serverhintcount++;
	if(serverhintcount >= 2) serverhintcount = 0;
	return 1;
}

forward WeaponTimerUpdate(weaponid);
public WeaponTimerUpdate(weaponid)
{
WeaponInfo[weaponid][WeaponTime] = WeaponInfo[weaponid][WeaponTime] - 1;
if(WeaponInfo[weaponid][WeaponTime] <= 0)
{
WeaponInfo[weaponid][WeaponID] = 0;
WeaponInfo[weaponid][WeaponAmmo] = 0;
WeaponInfo[weaponid][WeaponTime] = 0;
WeaponInfo[weaponid][WeaponX] = 0;
WeaponInfo[weaponid][WeaponY] = 0;
WeaponInfo[weaponid][WeaponZ] = 0;
WeaponInfo[weaponid][WeaponVW] = 0;
WeaponInfo[weaponid][WeaponInt] = 0;
DestroyDynamicObject(WeaponInfo[weaponid][WeaponObject]);
}
return 1;
}

forward OnPlayerServerJoin(playerid);
public OnPlayerServerJoin(playerid)
{
SetPlayerCameraPos(playerid,-2635.9746,2558.1101,76.6872);
SetPlayerCameraLookAt(playerid,-2419.9797,2333.0029,43.9209);
new rows;
cache_get_row_count(rows);
if(rows)
{
	cache_get_value_name_int(0,"ID",PlayerInfo[playerid][pID]);
	cache_get_value_name_int(0,"password",PlayerInfo[playerid][pPass]);
	cache_get_value_name_int(0,"level",PlayerInfo[playerid][pHours]);
	cache_get_value_name_int(0,"money",PlayerInfo[playerid][pMoney]);
 	cache_get_value_name_float(0,"X",PlayerInfo[playerid][pLastX]);
	cache_get_value_name_float(0,"Y",PlayerInfo[playerid][pLastY]);
	cache_get_value_name_float(0,"Z",PlayerInfo[playerid][pLastZ]);
	cache_get_value_name_float(0,"A",PlayerInfo[playerid][pLastA]);
	cache_get_value_name_int(0,"VW",PlayerInfo[playerid][pVW]);
	cache_get_value_name_int(0,"Interior",PlayerInfo[playerid][pInterior]);
	cache_get_value_name_int(0,"Admin",PlayerInfo[playerid][pAdmin]);
	cache_get_value_name_int(0,"Moderator",PlayerInfo[playerid][pMod]);
	cache_get_value_name_int(0,"Donator",PlayerInfo[playerid][pDonator]);
	cache_get_value_name_float(0,"Health",PlayerInfo[playerid][pHealth]);
	cache_get_value_name_float(0,"Armor",PlayerInfo[playerid][pArmor]);
	cache_get_value_name_int(0,"Skin",PlayerInfo[playerid][pSkin]);
	cache_get_value_name_int(0,"Minutes",PlayerInfo[playerid][pMinutes]);
	cache_get_value_name_int(0,"Gender",PlayerInfo[playerid][pGender]);
	cache_get_value_name(0,"DOB",PlayerInfo[playerid][pDOB],11);
    cache_get_value_name(0,"Nationality",PlayerInfo[playerid][pNationality],20);
    cache_get_value_name_int(0,"Height",PlayerInfo[playerid][pHeight]);
    cache_get_value_name_int(0,"Weight",PlayerInfo[playerid][pWeight]);
    cache_get_value_name(0,"HairColor",PlayerInfo[playerid][pHairColor],20);
    cache_get_value_name(0,"EyeColor",PlayerInfo[playerid][pEyeColor],20);
	cache_get_value_name_int(0,"Bank",PlayerInfo[playerid][pBMoney]);
	cache_get_value_name_int(0,"Faction",PlayerInfo[playerid][pFac]);
	cache_get_value_name(0,"FacRank",PlayerInfo[playerid][pFacRank],120);
	cache_get_value_name_int(0,"Tier",PlayerInfo[playerid][pTier]);
	cache_get_value_name_int(0,"Duty",PlayerInfo[playerid][pDuty]);
	cache_get_value_name_int(0,"Offskin",PlayerInfo[playerid][pOffSkin]);
	cache_get_value_name_int(0,"Badge",PlayerInfo[playerid][pBadge]);
	cache_get_value_name_int(0,"Mask",PlayerInfo[playerid][pMask]);
	cache_get_value_name_int(0,"MaskID",PlayerInfo[playerid][pMaskID]);
	cache_get_value_name_int(0,"Phone",PlayerInfo[playerid][pPhone]);
	cache_get_value_name_int(0,"Job",PlayerInfo[playerid][pJob]);
	cache_get_value_name_int(0,"DeathTime",PlayerInfo[playerid][pDeathTime]);
	cache_get_value_name_int(0,"Radio",PlayerInfo[playerid][pRadio]);
	cache_get_value_name_int(0,"Channel1",PlayerInfo[playerid][pRadio1]);
	cache_get_value_name_int(0,"Channel2",PlayerInfo[playerid][pRadio2]);
	cache_get_value_name_int(0,"Toolkits",PlayerInfo[playerid][pToolkit]);
	cache_get_value_name_int(0,"Medikits",PlayerInfo[playerid][pMedikit]);
	cache_get_value_name_int(0,"Screwdrivers",PlayerInfo[playerid][pScrewdriver]);
	cache_get_value_name_int(0,"GasCans",PlayerInfo[playerid][pGasCan]);
	cache_get_value_name_int(0,"Mats",PlayerInfo[playerid][pMats]);
	cache_get_value_name_int(0,"DLicense",PlayerInfo[playerid][pDLicense]);
	cache_get_value_name_int(0,"FLicense",PlayerInfo[playerid][pFLicense]);
	cache_get_value_name_int(0,"BetaTester",PlayerInfo[playerid][pBetaTester]);
	cache_get_value_name_int(0,"LotteryTicket",PlayerInfo[playerid][pLotteryTicket]);
	cache_get_value_name_int(0,"Detective",PlayerInfo[playerid][pDetective]);
	cache_get_value_name_int(0,"DMVTest",PlayerInfo[playerid][pTakingTest]);
	cache_get_value_name_int(0,"Gun1",PlayerInfo[playerid][pGun1]);
	cache_get_value_name_int(0,"GunAmmo1",PlayerInfo[playerid][pGunAmmo1]);
	cache_get_value_name_int(0,"Gun2",PlayerInfo[playerid][pGun2]);
	cache_get_value_name_int(0,"GunAmmo2",PlayerInfo[playerid][pGunAmmo2]);
	cache_get_value_name_int(0,"Gun3",PlayerInfo[playerid][pGun3]);
	cache_get_value_name_int(0,"GunAmmo3",PlayerInfo[playerid][pGunAmmo3]);
	cache_get_value_name_int(0,"Gun",PlayerInfo[playerid][pGunHold]);
	cache_get_value_name_int(0,"GunAmmo",PlayerInfo[playerid][pGunHoldAmmo]);
	cache_get_value_name_int(0,"PrisonTime",PlayerInfo[playerid][pPrisonTime]);
	cache_get_value_name_int(0,"AJail",PlayerInfo[playerid][pAJail]);
	cache_get_value_name_int(0,"Banned",PlayerInfo[playerid][pBanned]);
	cache_get_value_name(0,"Reason",PlayerInfo[playerid][pBReason],126);
	cache_get_value_name(0,"Banner",PlayerInfo[playerid][pBanner],126);
	cache_get_value_name_int(0,"FightStyle",PlayerInfo[playerid][pFightStyle]);
	cache_get_value_name_int(0,"Boombox",PlayerInfo[playerid][pBoombox]);
	cache_get_value_name_int(0,"Cocaine",PlayerInfo[playerid][pCocaine]);
	cache_get_value_name_int(0,"Crack",PlayerInfo[playerid][pCrack]);
	cache_get_value_name_int(0,"Weed",PlayerInfo[playerid][pWeed]);
	cache_get_value_name_int(0,"Seeds",PlayerInfo[playerid][pSeeds]);
	PlayerInfo[playerid][pAge] = GetAgeFromDOB(PlayerInfo[playerid][pDOB]);
	if(PlayerInfo[playerid][pBanned] != 0)
  	{
    	new string[128];
		SendClientMessage(playerid,-1,"{989898}---------------------------------------------------------------------------------------------");
		SendClientMessage(playerid,-1,"{989898}Either your account or IP address is banned from Westwood Roleplay.");
		format(string,sizeof(string),"{989898}Account Name: %s",GetPlayerNameEx(playerid));
		SendClientMessage(playerid,-1,string);
		format(string,sizeof(string),"{989898}Banned By: %s",PlayerInfo[playerid][pBanner]);
		SendClientMessage(playerid,-1,string);
		format(string,sizeof(string),"{989898}Reason: %s",PlayerInfo[playerid][pBReason]);
		SendClientMessage(playerid,-1,string);
		SendClientMessage(playerid,-1,"{989898}---------------------------------------------------------------------------------------------");
		return SetTimerEx("KickPlayer",100,false,"i",playerid);
 	}
	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_WHITE"Login",""COL_WHITE"Type your password below to login.","Login","Quit");
    SendClientMessage(playerid,-1, "{4DB3C5}---------------------------------------------------------------------------------------------");
	SendClientMessage(playerid,-1, "{989898}Welcome back to Westwood Roleplay. Enter your");
	SendClientMessage(playerid,-1, "{989898}password and click 'Login' to get back to the game!");
	SendClientMessage(playerid,-1, "{4DB3C5}---------------------------------------------------------------------------------------------");
}
else
{
	/*ErrorMessage(playerid,"You do not have the approval to access the server.");
	return KickB(playerid);*/
	ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,""COL_WHITE"Registering...",""COL_WHITE"Type your password below to register a new account.","Register","Quit");
    SendClientMessage(playerid,-1, "{4DB3C5}---------------------------------------------------------------------------------------------");
	SendClientMessage(playerid,-1, "{989898}Welcome to Westwood Roleplay. Enter your");
	SendClientMessage(playerid,-1, "{989898}password and click 'Register' to create your character!");
	SendClientMessage(playerid,-1, "{4DB3C5}---------------------------------------------------------------------------------------------");
}
if(PlayerInfo[playerid][pAdmin] >= 1) {ac[playerid] = 1;}
if(PlayerInfo[playerid][pAdmin] == 0) {ac[playerid] = 0;}
return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerWorldBounds(playerid, 99999.9, -99999.9,99999.9, -99999.9);
    label[playerid] = Create3DTextLabel(RPN(playerid,0), -1, 30.0, 40.0, 50.0, 4.0, 0);
    Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
    SetPlayerColor(playerid, 0x808080FF);
    SetPlayerCameraPos(playerid, -1346, 2569, 88.6);
    SetPlayerPos(playerid, -1346, 2569, 88.6);
   	TogglePlayerControllable(playerid, 0);
   	new query[90];
	format(query,sizeof(query),"SELECT * FROM `users` WHERE `username` = '%s' LIMIT 1;",GetPlayerNameEx(playerid));
	mysql_tquery(connection,query,"OnPlayerServerJoin","i",playerid);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(weaponid == 23 && HasTazer[issuerid] == 1)
		{
		    TogglePlayerControllable(playerid, 0);
		    ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
		    Tazed[playerid] = 10;
		    ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
			MeMessage(playerid, "has been tazed.");
		}
   	    if(weaponid == 0 || weaponid == 1 || weaponid == 2 || weaponid == 3 || weaponid == 4 || weaponid == 5 ||
		    weaponid == 6 || weaponid == 7 || weaponid == 8 || weaponid == 15)
   	    {
   			sInfo[playerid][Misc] += 1;
   		}
	  	if(bodypart == 3)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][Chest] += 1;
			}
	   	}
	  	if(bodypart == 4)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][Crotch] += 1;
			}
	   	}
	  	if(bodypart == 5)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][LArm] += 1;
			}
	   	}
	  	if(bodypart == 6)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][RArm] += 1;
			}
	   	}
	  	if(bodypart == 7)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][LLeg] += 1;
			}
	   	}
	  	if(bodypart == 8)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][RLeg] += 1;
			}
	   	}
	  	if(bodypart == 9)
	  	{
	   		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 ||
			    weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || weaponid == 32 || weaponid == 33 || weaponid == 34)
	   		{
	   			sInfo[playerid][Head] += 1;
			}
	   	}
		if(weaponid == WEAPON_SHOTGUN)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 67; // Torso
		    else if(bodypart == 4) amount = 74; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 38; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 43; // Left Leg & Right Leg
		}
		if(weaponid == WEAPON_M4)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 54; // Torso
		    else if(bodypart == 4) amount = 65; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 38; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 43; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_AK47)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 53; // Torso
		    else if(bodypart == 4) amount = 58; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 33; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 38; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_UZI || weaponid == WEAPON_TEC9)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 25; // Torso
		    else if(bodypart == 4) amount = 25; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 10; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 12; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_MP5)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 42; // Torso
		    else if(bodypart == 4) amount = 57; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 26; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 28; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_SNIPER || weaponid == WEAPON_CHAINSAW || weaponid == WEAPON_KATANA)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 100; // Torso
		    else if(bodypart == 4) amount = 100; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 78; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 83; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_SPRAYCAN || weaponid == WEAPON_FIREEXTINGUISHER || weaponid == 0 || weaponid == WEAPON_DILDO || weaponid == WEAPON_DILDO2 || weaponid == WEAPON_VIBRATOR || weaponid == WEAPON_VIBRATOR2 || weaponid == WEAPON_FLOWER) amount = 0;
		else if(weaponid == WEAPON_BRASSKNUCKLE)
		{
		    if(bodypart == 9) amount = 28; // Head
		    else if(bodypart == 3) amount = 23; // Torso
		    else if(bodypart == 4) amount = 26; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 12; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 16; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_NITESTICK || weaponid == WEAPON_BAT || weaponid == WEAPON_GOLFCLUB || weaponid == WEAPON_SHOVEL || weaponid == WEAPON_POOLSTICK || weaponid == WEAPON_CANE)
		{
		    if(bodypart == 9) amount = 37; // Head
		    else if(bodypart == 3) amount = 28; // Torso
		    else if(bodypart == 4) amount = 31; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 23; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 25; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_KNIFE || weaponid == WEAPON_COLT45 || weaponid == WEAPON_SILENCED)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 41; // Torso
		    else if(bodypart == 4) amount = 49; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 28; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 31; // Left Leg & Right Leg
		}
		else if(weaponid == WEAPON_DEAGLE)
		{
		    if(bodypart == 9) amount = 100; // Head
		    else if(bodypart == 3) amount = 56; // Torso
		    else if(bodypart == 4) amount = 59; // Chest
		    else if(bodypart == 5 || bodypart == 6) amount = 32; // Left Arm & Right Arm
		    else if(bodypart == 7 || bodypart == 8) amount = 37; // Left Leg & Right Leg
		}
		if(DVehicles[GetPlayerVehicleID(playerid)][vBulletproof] != 0) amount = 0;
		if(aduty[playerid] != 0) amount = 0;
		if(RubberBullets[issuerid] != 0)
		{
		    if(amount <= PlayerInfo[playerid][pArmor])
		    {
				amount = PlayerInfo[playerid][pArmor] - amount;
				SetPArmour(playerid,amount);
		    }
		    else if(amount >= PlayerInfo[playerid][pArmor])
		    {
		        SetPArmour(playerid,0);
			    ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
			    FreezePlayer(playerid,10000);
			    ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
		    }
		    amount = 0;
		}
		if(DVehicles[GetPlayerVehicleID(playerid)][vBulletproof] != 0) amount = 0;
		if(aduty[playerid] != 0 || HasTazer[issuerid] == 1) amount = 0;
		if(amount >= PlayerInfo[playerid][pArmor])
		{
		    amount = amount - PlayerInfo[playerid][pArmor];
		    SetPArmour(playerid,0);
		    if(PlayerInfo[playerid][pHealth] <= amount)
		    {
		        if(PlayerInfo[playerid][pDeathTime] != -1) return Died(playerid);
		        if(IsPlayerInAnyVehicle(playerid)) DestroyVehicleScreen(playerid);
				new string[264], gunname[32];
				for(new i = 0; i < 50; i++) SendClientMessage(playerid, -1," ");
				GetWeaponName(weaponid,gunname,sizeof(gunname));
				SendClientMessage(playerid, 0x088A08FF, "==========================================");
			    SendClientMessage(playerid, -1, "You were fataly injured!");
			    SendClientMessage(playerid, -1, "If you don't survive you won't remember anything");
			    SendClientMessage(playerid, -1, "that happened in the scene of your death.");
			    SendClientMessage(playerid, 0x088A08FF, "==========================================");
			    format(string, sizeof(string), "{989898}(( %s has been injured by %s (%s). ))",RPN(playerid,1), RPN(issuerid,1), gunname);
			    if(IsPlayerInAnyVehicle(issuerid)) format(string, sizeof(string), "{989898}(( %s has been injured by %s (Vehicle). ))",RPN(playerid,1), RPN(issuerid,1));
			    SendClientMessage(playerid, -1, string);
			    SendClientMessage(issuerid, -1, string);
			    format(string, sizeof(string), "%s{%d} has been injured by %s{%d} (%s).",RPN(playerid,0),playerid, RPN(issuerid,0),issuerid, gunname);
			    if(IsPlayerInAnyVehicle(issuerid)) format(string, sizeof(string), "%s{%d} has been injured by %s{%d} (Vehicle).",RPN(playerid,0),playerid, RPN(issuerid,0),issuerid);
			    SendAdminWarnMessage(string);
			    PlayerInfo[playerid][pDeathTime] = 180;
			    SendClientMessage(playerid,-1,"");
			    DeathText[playerid] = CreatePlayerTextDraw(playerid,350,28,"160");
				PlayerTextDrawShow(playerid, DeathText[playerid]);
			    DeathTextt[playerid] = CreatePlayerTextDraw(playerid,320,18,"Death Timer");
			    PlayerTextDrawShow(playerid, DeathTextt[playerid]);
			    TogglePlayerControllable(playerid, 0);
			    Delete3DTextLabel(label[playerid]);
			    label[playerid] = Create3DTextLabel(RPN(playerid,1), COLOR_LIGHTRED, 30.0, 40.0, 50.0, 5.0, 0);
		    	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
		    	ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
			    SetCameraBehindPlayer(playerid);
			    amount = 0;
			}
			new Float:healthi;
			healthi = PlayerInfo[playerid][pHealth] - amount;
			SetPHealth(playerid,healthi);
		}
		else if(amount < PlayerInfo[playerid][pArmor])
		{
			new Float:armori;
			armori = PlayerInfo[playerid][pArmor] - amount;
		    SetPArmour(playerid,armori);
		}
	}
	return 1;
}

forward GetPlayerDoB(playerid);
public GetPlayerDoB(playerid) return PlayerInfo[playerid][pDOB];

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == 2)
	{
	    new Float:vehHealth,amount;
	    GetVehicleHealth(hitid,vehHealth);
	    if(weaponid == WEAPON_M4 || weaponid == WEAPON_AK47) amount = 44;
	    else if(weaponid == WEAPON_UZI || weaponid == WEAPON_TEC9) amount = 25;
	    else if(weaponid == WEAPON_MP5) amount = 32;
	    else if(weaponid == WEAPON_SNIPER) amount = 76;
	    else if(weaponid == WEAPON_COLT45 || weaponid == WEAPON_SILENCED) amount = 23;
        else if(weaponid == WEAPON_DEAGLE) amount = 31;
        if(vehHealth-260 < amount) SetVehicleHealth(hitid,270);
        else SetVehicleHealth(hitid,vehHealth-amount);
	}
    return 1;
}

forward Operated(playerid);
public Operated(playerid)
{
	new op = randomEx(0,100);
	new msg[126];
	if(op < 81 && op > 0){
    SendClientMessage(playerid, 0x088A08FF, "==========================================");
    SendClientMessage(playerid, -1, "You were successfully operated!");
    SendClientMessage(playerid, -1, "Now you remember everything that");
    SendClientMessage(playerid, -1, "happened in the past scene.");
    SendClientMessage(playerid, 0x088A08FF, "==========================================");
	TogglePlayerControllable(playerid, 1);
	format(msg,sizeof(msg),"The operation on %s was a success!",RPN(playerid,1));}
	else if(op > 80 && op < 101)
	{
		Died(playerid);
		format(msg,sizeof(msg),"The operation on %s was a failure.");
	}
	SendFactionInfoMessage(1,msg);
	return 1;
}

public OnPlayerText(playerid, text[])
{
    new message[128],name[128],message1[128];
    format(name,sizeof(name),RPN(playerid,1));
    /*if(PlayerInfo[playerid][pAccent] != 0 || !strcmp(PlayerInfo[playerid][pAccent], "none", true, 4)){
	    format(name, sizeof(name), "(%s Accent) %s", PlayerInfo[playerid][pAccent], RPN(playerid,1));}*/
    if(InCall[playerid] == 911){
        format(message, sizeof(message), "[Cellphone] %s says: %s", name, text);
	    if(IsPlayerInAnyVehicle(playerid)){
		    if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
		    if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
			    format(message, sizeof(message), "(Windows Up) [Cellphone] %s says: %s", name, text);
			    ChatLog(message);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
					{
						SendSplitMessage(i, -1, message);
					}
				}}
			else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
	        format(message, sizeof(message), "(Windows Down) [Cellphone] %s says: %s", name, text);
			ChatLog(message);}}
		}
		ProxDetector(6.0, playerid,message, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
        SendClientMessage(playerid,-1,"{4DB3C5}OP:{989898} Thank you for your call, we have alerted all available units.");
		SendFactionMessage(1,-1,"{4DB3C5}|--------------------Emergency Call--------------------|");
		format(message, sizeof(message), "Phone Number: %d",PlayerInfo[playerid][pPhone]);
		SendFactionMessage(1,-1,message);
		format(message, sizeof(message), "Message: %s",text);
		SendFactionMessage(1,-1,message);
		SendFactionMessage(1,-1,"{4DB3C5}|--------------------------------------------------------|");
		InCall[playerid] = -1;
		SendClientMessage(playerid,-1,"{989898}The other side hung up.");
		return 0;}
    if(InCall[playerid] != -1){
        format(message, sizeof(message), "[Phone %d] %s says: %s",PlayerInfo[playerid][pPhone], name, text);
        format(message1, sizeof(message1), "[Phone %d] %s says: %s",PlayerInfo[InCall[playerid]][pPhone], name, text);
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(TappingPhone[i][playerid] == 1) SendSplitMessage(i, -1, message);
			if(TappingPhone[InCall[playerid]][i] == 1) SendSplitMessage(i, -1, message1);
		}
		format(message, sizeof(message), "[Cellphone] %s says: %s", name, text);
		if(IsPlayerInAnyVehicle(playerid)){
		    if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
		    if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
			    format(message, sizeof(message), "(Windows Up) [Cellphone] %s says: %s", name, text);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
					{
						SendSplitMessage(i, -1, message);
					}
				}}
			else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
	        format(message, sizeof(message), "(Windows Down) [Cellphone] %s says: %s", name, text);}}
		}
		ProxDetector(6.0, playerid,message, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
		if(InCall[InCall[playerid]] != -1) {format(message, sizeof(message), "[Cellphone] %s says: %s", name, text); SendSplitMessage(InCall[playerid],0xFFFF00FF,message);}
		ChatLog(message);
		return 0;}
	if(IsPlayerInAnyVehicle(playerid)){
	    if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
	    if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
		    format(message, sizeof(message), "(Windows Up) %s says: %s", name, text);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
				{
					SendSplitMessage(i, -1, message);
				}
			}
			ChatLog(message);
			return 0;}
		else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
        format(message, sizeof(message), "(Windows Down) %s says: %s", name, text);
		ProxDetector(6.0, playerid,message, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
		ChatLog(message);
		return 0;}}
	}
	format(message, sizeof(message), "%s says: %s", name, text);
	ProxDetector(6.0, playerid,message, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
	ChatLog(message);
	return 0;
}

public OnPlayerPause(playerid)
{
    Tabbed[playerid] = 0;
	TabbedTimer[playerid] = 1;
	Delete3DTextLabel(label[playerid]);
 	label[playerid] = Create3DTextLabel(RPN(playerid,1), COLOR_GREY, 30.0, 40.0, 50.0, 4.0, 0);
 	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
	return 1;
}

public OnPlayerResume(playerid)
{
    TabbedTimer[playerid] = 0;
    Tabbed[playerid] = 0;
    Delete3DTextLabel(label[playerid]);
 	label[playerid] = Create3DTextLabel(RPN(playerid,1), -1, 30.0, 40.0, 50.0, 4.0, 0);
 	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
    return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success) ErrorMessage(playerid,"The command you have entered does not exist.");
	return 1;
}

public OnPlayerConnect(playerid)
{
    for(new i = 0; i < MAX_PLAYERS; i++) TappingPhone[playerid][i] = 0;
    InfoBoxHead[playerid] = CreatePlayerTextDraw(playerid, 120,125, "Info");
	InfoBoxText[playerid] = CreatePlayerTextDraw(playerid, 120,137, "Info");
	PlayerTextDrawFont(playerid, InfoBoxHead[playerid], 1);
    PlayerTextDrawSetShadow(playerid, InfoBoxHead[playerid], 0);
    PlayerTextDrawSetOutline(playerid, InfoBoxHead[playerid], 1);
    PlayerTextDrawLetterSize(playerid, InfoBoxHead[playerid], 0.3 ,0.8);
    PlayerTextDrawUseBox(playerid, InfoBoxHead[playerid], 1);
    PlayerTextDrawTextSize(playerid, InfoBoxHead[playerid], 500, 190);
    PlayerTextDrawAlignment(playerid, InfoBoxHead[playerid], 2);
    PlayerTextDrawLetterSize(playerid, InfoBoxHead[playerid], 0.25 ,1);
    PlayerTextDrawBoxColor(playerid, InfoBoxHead[playerid], 0x323232FF); // Set the background color of MyTextdraw to white
    PlayerTextDrawFont(playerid, InfoBoxText[playerid], 1);
    PlayerTextDrawSetShadow(playerid, InfoBoxText[playerid], 0);
    PlayerTextDrawSetOutline(playerid, InfoBoxText[playerid], 1);
    PlayerTextDrawLetterSize(playerid, InfoBoxText[playerid], 0.3 ,0.8);
    PlayerTextDrawUseBox(playerid, InfoBoxText[playerid], 1);
    PlayerTextDrawTextSize(playerid, InfoBoxText[playerid], 500, 190);
    PlayerTextDrawAlignment(playerid, InfoBoxText[playerid], 2);
    PlayerTextDrawLetterSize(playerid, InfoBoxText[playerid], 0.2 ,1);
    StatBoxHead[playerid] = CreatePlayerTextDraw(playerid, 540,105, "sm");
    PlayerTextDrawFont(playerid, StatBoxHead[playerid], 1);
    PlayerTextDrawSetShadow(playerid, StatBoxHead[playerid], 0);
    PlayerTextDrawSetOutline(playerid, StatBoxHead[playerid], 1);
    PlayerTextDrawLetterSize(playerid, StatBoxHead[playerid], 0.3 ,0.8);
    PlayerTextDrawUseBox(playerid, StatBoxHead[playerid], 1);
    PlayerTextDrawTextSize(playerid, StatBoxHead[playerid], 500, 190);
    PlayerTextDrawAlignment(playerid, StatBoxHead[playerid], 2);
    PlayerTextDrawLetterSize(playerid, StatBoxHead[playerid], 0.25 ,1);
    PlayerTextDrawBoxColor(playerid, StatBoxHead[playerid], 0x323232FF); // Set the background color of MyTextdraw to white
    StatBoxLeftText[playerid] = CreatePlayerTextDraw(playerid, 445,117, "sm");
    PlayerTextDrawFont(playerid, StatBoxLeftText[playerid], 1);
    PlayerTextDrawSetShadow(playerid, StatBoxLeftText[playerid], 0);
    PlayerTextDrawSetOutline(playerid, StatBoxLeftText[playerid], 1);
    PlayerTextDrawLetterSize(playerid, StatBoxLeftText[playerid], 0.3 ,0.8);
    PlayerTextDrawUseBox(playerid, StatBoxLeftText[playerid], 1);
    PlayerTextDrawTextSize(playerid, StatBoxLeftText[playerid], 635, 190);
    PlayerTextDrawAlignment(playerid, StatBoxLeftText[playerid], 1);
    PlayerTextDrawLetterSize(playerid, StatBoxLeftText[playerid], 0.2 ,1);
    StatBoxCenterText[playerid] = CreatePlayerTextDraw(playerid, 540,117, "sm");
    PlayerTextDrawFont(playerid, StatBoxCenterText[playerid], 1);
    PlayerTextDrawSetShadow(playerid, StatBoxCenterText[playerid], 0);
    PlayerTextDrawSetOutline(playerid, StatBoxCenterText[playerid], 1);
    PlayerTextDrawLetterSize(playerid, StatBoxCenterText[playerid], 0.3 ,0.8);
    PlayerTextDrawUseBox(playerid, StatBoxCenterText[playerid], 1);
    PlayerTextDrawTextSize(playerid, StatBoxCenterText[playerid], 500, 190);
    PlayerTextDrawAlignment(playerid, StatBoxCenterText[playerid], 2);
    PlayerTextDrawLetterSize(playerid, StatBoxCenterText[playerid], 0.2 ,1);
    PickingText[playerid] = CreatePlayerTextDraw(playerid,320,19,"120");
    PlayerTextDrawSetOutline(playerid, PickingText[playerid], 1);
	PlayerTextDrawFont(playerid,PickingText[playerid],1);
	PlayerTextDrawLetterSize(playerid,PickingText[playerid],0.3,1.1);
	PlayerTextDrawColor(playerid,PickingText[playerid],0xFFFFFFFF);
	PlayerTextDrawBackgroundColor(playerid,PickingText[playerid],350);
	PlayerTextDrawUseBox(playerid,PickingText[playerid],0);
    PickText[playerid] = CreatePlayerTextDraw(playerid,320,18,"Pick Locking");
    PlayerTextDrawSetOutline(playerid, PickText[playerid], 1);
	PlayerTextDrawFont(playerid,PickText[playerid],1);
	PlayerTextDrawLetterSize(playerid,PickText[playerid],0.3,1.1);
	PlayerTextDrawColor(playerid,PickText[playerid],0xFFFFFFFF);
	PlayerTextDrawBackgroundColor(playerid,PickText[playerid],350);
	PlayerTextDrawUseBox(playerid,PickText[playerid],0);
	ResetInjures(playerid);
	SpeedLimit[playerid] = 0;
	SpeedLS[playerid] = 0;
	SpeedLSTimer[playerid] = 0;
	AllowedToSpec[playerid] = 1;
	PlayerBBObject[playerid] = -1;
	PlayerBB[playerid] = 0;
	PlayerBBMOn[playerid] = 0;
	PlayerBBUrl[playerid] = "none";
	PlayerBBPUrl[playerid] = "none";
	DeletePVar(playerid, "PlayerBBArea");
	DrugInvSelect[playerid] = 0;
	JustJoined[playerid] = 0;
	DrugChoose[playerid] = 0;
	UsingWeed[playerid] = 0;
	UsingCocaine[playerid] = 0;
	BeingDragged[playerid] = -1;
	DeathPlayer[playerid] = -1;
    NoteInfo[playerid][Note1] = 0;
    NoteInfo[playerid][Note2] = 0;
    NoteInfo[playerid][Note3] = 0;
    NoteInfo[playerid][Note4] = 0;
    NoteInfo[playerid][Note5] = 0;
    NoteInfo[playerid][Note6] = 0;
    NoteInfo[playerid][Note7] = 0;
    NoteInfo[playerid][Note8] = 0;
    NoteInfo[playerid][Note9] = 0;
    NoteInfo[playerid][Note10] = 0;
    NoteInfo[playerid][Note11] = 0;
    NoteInfo[playerid][Note12] = 0;
    NoteInfo[playerid][Note13] = 0;
    NoteInfo[playerid][Note14] = 0;
    NoteInfo[playerid][Note15] = 0;
    NoteInfo[playerid][Note16] = 0;
    NoteInfo[playerid][Note17] = 0;
    NoteInfo[playerid][Note18] = 0;
    NoteInfo[playerid][Note19] = 0;
    NoteInfo[playerid][Note20] = 0;
	AdminHideCmds[playerid] = 0;
	Tazed[playerid] = -1;
    Hotwire[playerid] = -1;
    RubberBullets[playerid] = 0;
    Ticketed[playerid] = -1;
    TicketPrice[playerid] = 0;
    SpecInt[playerid] = 0;
    SpecVW[playerid] = 0;
    Spectating[playerid] = -1;
    PhoneWitheld[playerid] = 0;
    Seatbelt[playerid] = 0;
    positionxdead[playerid] = 0;
	positionydead[playerid] = 0;
	positionzdead[playerid] = 0;
	vwDead[playerid] = 0;
	intDead[playerid] = 0;
    LockEdit[playerid] = 0;
    Tabbed[playerid] = 0;
	TabbedTimer[playerid] = 0;
    Patching[playerid] = -1;
    newp[playerid] = 0;
    ac[playerid] = 0;
    aduty[playerid] = 0;
    maskon[playerid] = 0;
    IsLogged[playerid] = 0;
    timerminutes[playerid] = 0;
    HasWeapon[playerid] = 0;
    OfferFrisk[playerid] = 0;
    OfferFrisker[playerid] = 0;
    Tooling[playerid] = 0;
	Tracing[playerid] = -1;
    IsLogged[playerid] = 0;
    IsRenting[playerid] = 1111;
    idoffile[playerid] = -1;
    BeingCalled[playerid] = 0;
	InCall[playerid] = -1;
	PhonePower[playerid] = 1;
	PhoneVib[playerid] = 0;
	aduty[playerid] = 0;
	hduty[playerid] = 0;
	BeingOperated[playerid] = 0;
	PlayerInfo[playerid][pAJail] = -1;
    PlayerInfo[playerid][pLastX] = 0;
    PlayerInfo[playerid][pLastY] = 0;
    PlayerInfo[playerid][pLastZ] = 0;
    PlayerInfo[playerid][pLastA] = 0;
    PlayerInfo[playerid][pPass] = 0;
    PlayerInfo[playerid][pVW] = 0;
    PlayerInfo[playerid][pInterior] = 0;
    PlayerInfo[playerid][pHealth] = 100;
    PlayerInfo[playerid][pArmor] = 0;
    PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pMod] = 0;
    PlayerInfo[playerid][pDonator] = 0;
    PlayerInfo[playerid][pHours] = 0;
    PlayerInfo[playerid][pMinutes] = 0;
    PlayerInfo[playerid][pMoney] = 200;
    PlayerInfo[playerid][pBMoney] = 0;
    PlayerInfo[playerid][pSkin] = 0;
    PlayerInfo[playerid][pAccent] = 0;
    PlayerInfo[playerid][pJob] = 0;
    PlayerInfo[playerid][pPhone] = 0;
    PlayerInfo[playerid][pDeathTime] = -1;
    PlayerInfo[playerid][pMats] = 0;
    PlayerInfo[playerid][pFac] = 0;
    PlayerInfo[playerid][pFacRank] = 0;
    PlayerInfo[playerid][pTier] = 0;
    PlayerInfo[playerid][pDuty] = 0;
    PlayerInfo[playerid][pOffSkin] = 0;
    PlayerInfo[playerid][pRealName] = 0;
    PlayerInfo[playerid][pMaskID] = 0;
    PlayerInfo[playerid][pMask] = 0;
    PlayerInfo[playerid][pRadio] = 0;
    PlayerInfo[playerid][pRadio1] = 0;
    PlayerInfo[playerid][pRadio2] = 0;
    PlayerInfo[playerid][pToolkit] = 0;
    PlayerInfo[playerid][pTakingTest] = 0;
    PlayerInfo[playerid][pDLicense] = 0;
    PlayerInfo[playerid][pFLicense] = 0;
    PlayerInfo[playerid][pGun1] = 0;
    PlayerInfo[playerid][pGunAmmo1] = 0;
    PlayerInfo[playerid][pGun2] = 0;
    PlayerInfo[playerid][pGunAmmo2] = 0;
    PlayerInfo[playerid][pGun3] = 0;
    PlayerInfo[playerid][pGunAmmo3] = 0;
    PlayerInfo[playerid][pGun4] = 0;
    PlayerInfo[playerid][pGunAmmo4] = 0;
    PlayerInfo[playerid][pGunHold] = 0;
    PlayerInfo[playerid][pGunHoldAmmo] = 0;
    PlayerInfo[playerid][pBanned] = 0;
    PlayerInfo[playerid][pBReason] = 0;
	PlayerInfo[playerid][pBanner] = 0;
	PlayerInfo[playerid][pPrisonTime] = -1;
 	PlayerInfo[playerid][InPrison] = 0;
	PlayerInfo[playerid][pReleased] = 1;
	PlayerInfo[playerid][pScrewdriver] = 0;
	PlayerInfo[playerid][pGasCan] = 0;
	PlayerInfo[playerid][pLotteryTicket] = 0;
	PlayerInfo[playerid][pFightStyle] = 0;
	PlayerInfo[playerid][pBoombox] = 0;
	PlayerInfo[playerid][pSync] = 0;
	PlayerInfo[playerid][pCocaine] = 0;
	PlayerInfo[playerid][pCrack] = 0;
	PlayerInfo[playerid][pWeed] = 0;
	PlayerInfo[playerid][pSeeds] = 0;
	PlayerInfo[playerid][pPayCheck] = 0;
    PlayerInfo[playerid][pPInterest] = 0;
    PlayerInfo[playerid][pPPastBank] = 0;
    PlayerInfo[playerid][pPRent] = 0;
    PlayerInfo[playerid][pDOB] = 0;
    PlayerInfo[playerid][pNationality] = 0;
	PlayerInfo[playerid][pHeight] = 0;
	PlayerInfo[playerid][pWeight] = 0;
	PlayerInfo[playerid][pHairColor] = 0;
	PlayerInfo[playerid][pEyeColor] = 0;
	PlayerInfo[playerid][pSync] = -1;
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 998);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 998);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 998);
	for(new i = 0; i < 50; i++)
	SendClientMessage(playerid, -1," ");
	if(NameValidator(playerid) == 0){
	SendClientMessage(playerid,-1,"{989898}---------------------------------------------------------------------------------------------");
	SendClientMessage(playerid,-1,"{989898}The name you are using is not a roleplay name!");
	SendClientMessage(playerid,-1,"{989898}Use something like 'John_Smith'.");
	SendClientMessage(playerid,-1,"{989898}---------------------------------------------------------------------------------------------");
	KickB(playerid);}
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	StopAudioStreamForPlayer(playerid);
    Delete3DTextLabel(label[playerid]);
	if(IsLogged[playerid] != 1) return 1;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(BeingDragged[i] == playerid) BeingDragged[i] = -1;
	    for(new b = 0; b < MAX_PLAYERS; b++)
		{
			TappingPhone[i][b] = 0;
		}
	}
	KillTimer(secondplayerupdate[playerid]);
	IsLogged[playerid] = 0;
    new string2[128];
    switch(reason)
	{
	    case 0: format(string2, sizeof(string2), "{989898}(( %s has left the server. (Timeout) ))", RPN(playerid,1));
	    case 1: format(string2, sizeof(string2), "{989898}(( %s has left the server. (Leaving) ))", RPN(playerid,1));
	    case 2: format(string2, sizeof(string2), "{989898}(( %s has left the server. (Kicked/Banned) ))", RPN(playerid,1));
	}
	ProxDetector(30.0, playerid, string2, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW);
	switch(reason)
	{
	    case 0: format(string2, sizeof(string2), "%s has left the server. (Timeout)", RPN(playerid,0));
	    case 1: format(string2, sizeof(string2), "%s has left the server. (Leaving)", RPN(playerid,0));
	    case 2: format(string2, sizeof(string2), "%s has left the server. (Kicked/Banned)", RPN(playerid,0));
	}
    SendAdminInfoMessage(string2);
    SaveUser(playerid);
	TextDrawHideForPlayer(playerid, Timet), TextDrawHideForPlayer(playerid, Date), TextDrawHideForPlayer(playerid, o),TextDrawHideForPlayer(playerid, BETA_TEXT);
    PlayerTextDrawHide(playerid, InfoBox[playerid]);
    if (IsRenting[playerid] != 1111) {SetVehicleToRespawn(IsRenting[playerid]); IsRenting[playerid] = 1111;}
    if(PlayerBB[playerid] != 0)
    {
	    DestroyDynamicObject(PlayerBBObject[playerid]);
		Delete3DTextLabel(Text3D:PlayerBBLabel[playerid]);
		PlayerBBObject[playerid] = -1;
		PlayerBB[playerid] = 0;
		PlayerBBMOn[playerid] = 0;
		PlayerBBUrl[playerid] = "none";
		PlayerBBPUrl[playerid] = "none";
		DeletePVar(playerid, "PlayerBBArea");
	}
    return 1;
}
new tenseconds,weaponanticheat[MAX_PLAYERS];
forward PlayerSecondUpdate(playerid);
public PlayerSecondUpdate(playerid)
{
	new string[260],fuel[60];
	if(threeseconds >= 3) threeseconds = 0;
	threeseconds = threeseconds + 1;
	if(tenseconds >= 10) tenseconds = 0;
	tenseconds = tenseconds + 1;
	timenothit[playerid]++;
	if(timenothit[playerid] >= 1200) ResetInjures(playerid);
	if(IsLogged[playerid] == 1)
	{
		CheckBoomBox(playerid);
		if(PlayerInfo[playerid][pAdmin] != 0)
		{
		    if(Spectating[playerid] != -1)
		    {
		        if(GetPlayerInterior(playerid) != GetPlayerInterior(Spectating[playerid])) SetPlayerInterior(playerid,GetPlayerInterior(Spectating[playerid]));
		        if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(Spectating[playerid])) SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(Spectating[playerid]));
		    }
		}
 		if(BeingDragged[playerid] != -1)
    	{
    		new Float:x, Float:y, Float:z;
			GetPlayerPos(BeingDragged[playerid], x, y, z);
			SetPlayerInterior(playerid,GetPlayerInterior(BeingDragged[playerid]));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(BeingDragged[playerid]));
			SetPlayerPos(playerid, x+0.5, y+0.5, z);
    	}
		if(Tazed[playerid] >= 1) Tazed[playerid] = Tazed[playerid] - 1;
		else if(Tazed[playerid] == 0) {TogglePlayerControllable(playerid, 1); Tazed[playerid] = -1;}
		if(TabbedTimer[playerid] != 0) Tabbed[playerid] = Tabbed[playerid] + 1;
		if(PlayerInfo[playerid][pDeathTime] == 0)
		{
			PlayerTextDrawSetString(playerid,DeathText[playerid], "0");
			Died(playerid);
		}
		else if(PlayerInfo[playerid][pDeathTime] != -1)
		{
		    PlayerInfo[playerid][pDeathTime] = PlayerInfo[playerid][pDeathTime] - 1;
			format(string, sizeof(string), "%d", PlayerInfo[playerid][pDeathTime]);
			PlayerTextDrawSetString(playerid,DeathText[playerid], string);
			PlayerTextDrawShow(playerid,DeathText[playerid]);
			ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
		}
		timerminutes[playerid] = timerminutes[playerid] + 1;
		if(timerminutes[playerid] >= 60) {timerminutes[playerid] = 0; PlayerTimeMinutes(playerid);}
		if(BeingOperated[playerid] >= 1) UpdateOP(playerid);
		if(threeseconds == 3) {TraceUpdate(playerid); PatchingUp(playerid);}
		if(Tooling[playerid] != 0)
		{
			format(fuel, sizeof(fuel), "%d", Tooling[playerid]);
			PlayerTextDrawSetString(playerid,PickingText[playerid], fuel);
			PlayerTextDrawShow(playerid, PickingText[playerid]);
			InfoMessage(playerid,"being called");
			Tooling[playerid]--;
			if(Tooling[playerid] <= 0)
			{
			    MeMessage(playerid, "breaks the vehicle's lock");
			    PlayerTextDrawSetString(playerid,PickingText[playerid], "0");
			    PlayerTextDrawHide(playerid,PickingText[playerid]);
				PlayerTextDrawHide(playerid,PickText[playerid]);
				TogglePlayerControllable(playerid, 1);
				new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
		    	vehicleid = GetClosestVehicle(playerid, 3);
		    	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
		        for(new owner=0; owner<MAX_PLAYERS; owner++)
			 	{
			    	if(IsLogged[owner] == 1 && PlayerInfo[owner][pID] == DVehicles[vehicleid][vOwner])
			     	{
			     	    new msg[164];
			     	    format(msg,sizeof(msg),"((SMS)) Your %s has been broken into!, From: WITHELD",GetVehicleName(vehicleid));
						SendClientMessage(owner,COLOR_YELLOW,msg);
			    	}
			 	}
			 	Tooling[playerid] = 0;
			}
		}
		if(Hotwire[playerid] >= 1) Hotwire[playerid] = Hotwire[playerid] - 1;
		if(Hotwire[playerid] == 0) HotwireVeh(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
		    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		    {
		        UpdatePlayerSpeedo(playerid);
		    }
		}
		if(!IsPlayerInAnyVehicle(playerid)) DestroyVehicleScreen(playerid);
		//Anti-cheat
		if(GetPlayerWeapon(playerid) != 0)
		{
			if(HasWeapon[playerid] != 1)
			{
			    new gunname[32],ammo,gun;
				GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),gun,ammo);
				GetWeaponName(GetPlayerWeapon(playerid),gunname,sizeof(gunname));
				format(string,sizeof(string),"%s might be hacking a %s (%d Ammo).",RPN(playerid,0),gunname,ammo);
				if(ammo != 0)
				{
				    if(weaponanticheat[playerid] >= 5)
				    {
				        new worked;
					    for(new i = 0; i < MAX_PLAYERS; i++)
						{
						    if(i != playerid)
						    {
							    if(IsPlayerConnected(playerid))
							    {
									if(PlayerInfo[i][pAdmin] != 0)
									{
									    if(Tabbed[i] != 0) worked = 1;
									}
								}
							}
						}
						if(worked == 1) BanPlayer(playerid,-1,"Weapon Hacks");
				    }
					AntiCheatMessage(string);
					weaponanticheat[playerid]++;
				}
			}
		}
	}
	return 1;
}
forward SecondUpdate();
public SecondUpdate()
{
 	for(new i = 1; i < MAX_WEAPONS; i++)
	{
		if(WeaponInfo[i][WeaponID] == 0)
		{
		    WeaponTimerUpdate(i);
		}
	}
	new engine, lights, alarm, doors, bonnet, boot, objective;
	for(new i = 0; i < MAX_CUSTOM_VEHICLES; i++)
	{
		if(DVehicles[i][dModel] != 0)
		{
		    new Float:health;
		    GetVehicleHealth(i, health);
		    if(health < 270)
			{
			    SetVehicleHealth(i,270);
			    SetVehicleParamsEx(i, 0, lights, alarm, doors, bonnet, boot, objective);
			    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
				{
    				if(GetPlayerVehicleID(playerid) == i && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) InfoMessage(playerid,"The engine of the vehicle broke down.");
   				}
			}
		    if(DVehicles[i][vFuel] != 0)
		    {
	 			GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnet, boot, objective);
			    if(engine == 1)
			    {
			        DVehicles[i][vFuelTimer] += 1;
			        if(DVehicles[i][vFuelTimer] >= 30)
			        {
			            DVehicles[i][vFuel] -= 1;
			            DVehicles[i][vFuelTimer] = 0;
						if(DVehicles[i][vFuel] <= 0)
						{
						    SetVehicleParamsEx(i, 0, lights, alarm, doors, bonnet, boot, objective);
						    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
 							{
 							    if(GetPlayerVehicleID(playerid) == i && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) InfoMessage(playerid,"The engine of the vehicle ran out of fuel.");
						    }
						}
			        }
			    }
		    }
		}
	}
	if(tenseconds >= 10)
	{
		for(new i = 1; i < MAX_FACTIONS; i++)
		{
			FactionInfo[i][Money] = FactionInfo[i][Money] + 2;
		}
	}
	settime();
	return 1;
}

public settime()
{
	new string[256],year,month,day,hours,minutes,seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
	format(string, sizeof string, "%d/%s%d/%s%d", day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year);
	TextDrawSetString(Date, string);
	format(string, sizeof string, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(Timet, string);
}

public OnPlayerRequestSpawn(playerid)
{
    if(IsLogged[playerid] != 1) return 0;
    return 1;
}

forward PatchingUp(playerid);
public PatchingUp(playerid)
{
	if(Patching[playerid] != -1)
	{
		new playerb = Patching[playerid];
		if(PlayerInfo[playerb][pDeathTime] == -1) return 1;
		TogglePlayerControllable(playerid,1);
		PlayerInfo[playerb][pDeathTime] = PlayerInfo[playerb][pDeathTime] + 60;
		Patching[playerid] = -1;
		if(PlayerInfo[playerid][pFac] == 1 && PlayerInfo[playerid][pDuty] == 1) return 1;
		PlayerInfo[playerid][pMedikit] = PlayerInfo[playerid][pMedikit] - 1;
	}
	return 1;
}

forward OnAKARecord(playerid);
public OnAKARecord(playerid)
{
new rows;
cache_get_row_count(rows);
if(rows) return 1;
new plrIP[16],query[130];
GetPlayerIp(playerid,plrIP,sizeof(plrIP));
format(query,sizeof(query),"INSERT INTO `AKA` (Username,IP) VALUES ('%s','%s')",GetPlayerNameEx(playerid),plrIP);
mysql_query(connection,query);
return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsLogged[playerid] != 1) return 1;
	else if(IsLogged[playerid] == 1)
	{
	    new plrIP[16],query[130];
	    if(PlayerInfo[playerid][pSync] != 1)
	    {
	    	GetPlayerIp(playerid,plrIP,sizeof(plrIP));
			format(query,sizeof(query),"SELECT * FROM `AKA` WHERE `username` = '%s' AND `IP` = '%s'",GetPlayerNameEx(playerid),plrIP);
			mysql_tquery(connection,query,"OnAKARecord","i",playerid);
	    }
	    if(Spectating[playerid] != -1)
	    {
	        SetPSkin(playerid, PlayerInfo[playerid][pSkin]);
		    SetPlayerPos(playerid, PlayerInfo[playerid][pLastX], PlayerInfo[playerid][pLastY], PlayerInfo[playerid][pLastZ]);
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGunHold],PlayerInfo[playerid][pGunHoldAmmo]);
		    SetCameraBehindPlayer(playerid);
		    Spectating[playerid] = -1;
	    }
	    TextDrawShowForPlayer(playerid, Timet), TextDrawShowForPlayer(playerid, Date), TextDrawShowForPlayer(playerid, o), TextDrawShowForPlayer(playerid, BETA_TEXT);
	    if(newp[playerid] == 1)
	    {
	        PlayerInfo[playerid][pHealth] = 100;
	        ShowPlayerDialog(playerid, DIALOG_SKIN, DIALOG_STYLE_INPUT,"Choose a skin","Choose your skin","Choose","Quit");
	        SetPlayerPos(playerid,-1513.8988,2523.1270,55.6552);
	        SetCameraBehindPlayer(playerid);
		}
		else if(newp[playerid] != 1)
		{
		    SetPSkin(playerid, PlayerInfo[playerid][pSkin]);
		    SetPlayerPos(playerid, PlayerInfo[playerid][pLastX], PlayerInfo[playerid][pLastY], PlayerInfo[playerid][pLastZ]);
		    SetPlayerFacingAngle(playerid,PlayerInfo[playerid][pLastA]);
		    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);
		    SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
		    SetCameraBehindPlayer(playerid);
		    SetPlayerFightingStyle(playerid, PlayerInfo[playerid][pFightStyle]);
		    if(PlayerInfo[playerid][pGunHold] != 0){
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGunHold],PlayerInfo[playerid][pGunHoldAmmo]);
			HasWeapon[playerid] = 1;
			SetCameraBehindPlayer(playerid);}
		}
		if(PlayerInfo[playerid][pDeathTime] != -1)
		{
		    SetPlayerPos(playerid,positionxdead[playerid],positionydead[playerid],positionzdead[playerid]);
		    SetPlayerInterior(playerid,intDead[playerid]);
		    SetPlayerVirtualWorld(playerid,vwDead[playerid]);
		    TogglePlayerControllable(playerid, 0);
		    Delete3DTextLabel(label[playerid]);
		    label[playerid] = Create3DTextLabel(RPN(playerid,1), COLOR_LIGHTRED, 30.0, 40.0, 50.0, 5.0, 0);
	    	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
	    	ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
		    SetPSkin(playerid,PlayerInfo[playerid][pSkin]);
		    SetCameraBehindPlayer(playerid);
		}
		SetPlayerColor(playerid, -1);
		SetPlayerTeam(playerid, 1);
		if(JustJoined[playerid] == 1)
		{
			new armor[4],health[4];
			SetUpPlayerText(playerid);
			format(health, 4, "%d",floatround(PlayerInfo[playerid][pHealth]));
			format(armor, 4, "%d",floatround(PlayerInfo[playerid][pArmor]));
			playerHP[playerid] = CreatePlayerTextDraw(playerid, 576.5, 67.3, health);
	        PlayerTextDrawFont(playerid, playerHP[playerid], 1);
	        PlayerTextDrawSetShadow(playerid, playerHP[playerid], 0);
	        PlayerTextDrawSetOutline(playerid, playerHP[playerid], 1);
	        PlayerTextDrawLetterSize(playerid, playerHP[playerid], 0.3 ,0.8);
	        PlayerTextDrawAlignment(playerid, playerHP[playerid], 2);
	        PlayerTextDrawShow(playerid, playerHP[playerid]);
	        playerAP[playerid] = CreatePlayerTextDraw(playerid, 576.5, 45.3, armor);
	        PlayerTextDrawFont(playerid, playerAP[playerid], 1);
	        PlayerTextDrawSetShadow(playerid, playerAP[playerid], 0);
	        PlayerTextDrawSetOutline(playerid, playerAP[playerid], 1);
	        PlayerTextDrawLetterSize(playerid, playerAP[playerid], 0.3 ,0.8);
	        PlayerTextDrawAlignment(playerid, playerAP[playerid], 2);
	        PlayerTextDrawShow(playerid, playerAP[playerid]);
		   	for(new i = 0; i < 50; i++)
			SendClientMessage(playerid, -1," ");
		    SendClientMessage(playerid, 0x088A08FF, "==========================================");
		    SendClientMessage(playerid, -1, "Welcome to our server! The server is currently");
		    SendClientMessage(playerid, -1, "in developement so expect frequent restarts");
		    SendClientMessage(playerid, -1, "and bugs/missing features. Thank you for your");
		    SendClientMessage(playerid, -1, "patience.     ~ W-RP Developement Team");
		    SendClientMessage(playerid, 0x088A08FF, "==========================================");
		    if(PlayerInfo[playerid][pBetaTester] != 1){
		    InfoMessage(playerid, "Your account has been marked as a 'Beta Tester'. Use /bt to talk to the staff.");
		    PlayerInfo[playerid][pBetaTester] = 1;}
		    new string[264];
		    format(string, sizeof(string), "%s{%d} has connected to the server.", RPN(playerid,0),playerid);
		    SendAdminInfoMessage(string);
		    secondplayerupdate[playerid] = SetTimerEx("PlayerSecondUpdate",1000,true,"i",playerid);
		    JustJoined[playerid] = 0;
		    TextDrawShowForPlayer(playerid, BETA_TEXT);
		    TextDrawShowForPlayer(playerid, Timet);
		    TextDrawShowForPlayer(playerid, o);
	    }
	    if(PlayerInfo[playerid][pInterior] != 0) 
	    {
	    	SetTimerEx("UnFreezeP",1500,false,"i",playerid);
			TogglePlayerControllable(playerid, 0);
	    }
	    new houseid;
		for(new i = 0; i < MAX_HOUSES; i++)
		{
			if(HouseInfo[i][hIVW] == GetPlayerVirtualWorld(playerid))
			{
				houseid = i;
				break;
			}
		}
		if(houseid != 0)
		{
			if(HouseInfo[houseid][hLights] == 1) SetPlayerTime(playerid, 0, 0);
			else SetPlayerTime(playerid, 12, 0);
		}
	    if(PlayerInfo[playerid][pSync] == 1) PlayerInfo[playerid][pSync] = 0;
    }
    return 1;
}

forward deaded(playerid);

public OnPlayerDeath(playerid, killerid)
{
	if(IsPlayerInAnyVehicle(playerid)) DestroyVehicleScreen(playerid);
	new string[264];
	for(new i = 0; i < 50; i++)
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, 0x088A08FF, "==========================================");
	SendClientMessage(playerid, -1, "You were fataly injured!");
	SendClientMessage(playerid, -1, "If you don't survive you won't remember anything");
	SendClientMessage(playerid, -1, "that happened in the scene of your death.");
	SendClientMessage(playerid, 0x088A08FF, "==========================================");
	format(string, sizeof(string), "{989898}(( %s has been injured by SERVER. ))",RPN(playerid,1));
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "%s{%d} has been injured by SERVER.",RPN(playerid,0),playerid);
	SendAdminWarnMessage(string);
	PlayerInfo[playerid][pDeathTime] = 180;
	SendClientMessage(playerid,-1,"");
	DeathText[playerid] = CreatePlayerTextDraw(playerid,350,28,"160");
	PlayerTextDrawShow(playerid, DeathText[playerid]);
	DeathTextt[playerid] = CreatePlayerTextDraw(playerid,320,18,"Death Timer");
	PlayerTextDrawShow(playerid, DeathTextt[playerid]);
	TogglePlayerControllable(playerid, 0);
	Delete3DTextLabel(label[playerid]);
	label[playerid] = Create3DTextLabel(RPN(playerid,1), COLOR_LIGHTRED, 30.0, 40.0, 50.0, 5.0, 0);
	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
	ApplyAnimation(playerid,"CRACK","crckdeth2",4.0,0,0,0,1,1);
	SetCameraBehindPlayer(playerid);
	return 1;
}

forward UpdateOP(playerid);
public UpdateOP(playerid)
{
	if(BeingOperated[playerid] <= 0)
	{
		PlayerTextDrawSetString(playerid,DeathText[playerid], "0");
		PlayerTextDrawDestroy(playerid,DeathText[playerid]);
		PlayerTextDrawDestroy(playerid,DeathTextt[playerid]);
		Operated(playerid);
		return 1;
	}
	new string[260];
	format(string, sizeof(string), "%d", BeingOperated[playerid]);
	PlayerTextDrawSetString(playerid,DeathText[playerid], string);
	PlayerTextDrawSetShadow(playerid,DeathText[playerid], 0);
 	PlayerTextDrawSetShadow(playerid,DeathTextt[playerid], 0);
	BeingOperated[playerid] = BeingOperated[playerid] - 1;
	return 1;
}

forward PlayerTimeMinutes(playerid);
public PlayerTimeMinutes(playerid)
{
	if(IsLogged[playerid] == 0) return 1;
	PlayerInfo[playerid][pMinutes] = PlayerInfo[playerid][pMinutes] + 1;
	if(PlayerInfo[playerid][pAJail] > 0) PlayerInfo[playerid][pAJail] = PlayerInfo[playerid][pAJail] - 1;
	if(PlayerInfo[playerid][pPrisonTime] > 0 && PlayerInfo[playerid][pReleased] != 1) PlayerInfo[playerid][pPrisonTime] = PlayerInfo[playerid][pPrisonTime] - 1;
	if(PlayerInfo[playerid][pMinutes] >= 60)
	{
	    new rent;
	    for(new i = 1; i < MAX_CUSTOM_VEHICLES; i++)
		{
    	    if(DVehicles[i][vRenter] == playerid && DVehicles[i][dModel] != 0) rent += 15;
    	}
	    PlayerInfo[playerid][pMinutes] = 0;
	    PlayerInfo[playerid][pHours] = PlayerInfo[playerid][pHours] + 1;
	    SetPlayerScore(playerid,PlayerInfo[playerid][pHours]);
	    new pastbank = PlayerInfo[playerid][pBMoney];
	    new interest = (PlayerInfo[playerid][pBMoney]/100)*2;
	    
	    PlayerInfo[playerid][pBMoney] = PlayerInfo[playerid][pBMoney] + PAY_CHECK + interest;
	    if(rent != 0) PlayerInfo[playerid][pBMoney] -= rent;
		SendClientMessage(playerid,0xFFFF00FF,"((SMS)) Your paycheck has been delivered, From: SA BANK");
	    PlayerInfo[playerid][pPayCheck] = PAY_CHECK;
	    PlayerInfo[playerid][pPInterest] = interest;
	    PlayerInfo[playerid][pPPastBank] = pastbank;
	    PlayerInfo[playerid][pPRent] = rent;
	}
	if(PlayerInfo[playerid][pPrisonTime] == 0 && PlayerInfo[playerid][pReleased] != 1 && PlayerInfo[playerid][pAJail] == 0)
	{
	    SetPlayerInterior(playerid,0);
	    SetPlayerVirtualWorld(playerid,0);
	    SetPlayerPos(playerid,-1199.3590,1842.2963,41.4427);
	    SetPlayerFacingAngle(playerid,317.9047);
	    InfoMessage(playerid, "You have served your time in prison and are now released.");
	    PlayerInfo[playerid][pPrisonTime] = -1;
	    PlayerInfo[playerid][InPrison] = 0;
	    PlayerInfo[playerid][pReleased] = 1;
	}
	if(PlayerInfo[playerid][pAJail] == 0)
	{
	    SetPlayerInterior(playerid,0);
	    SetPlayerVirtualWorld(playerid,0);
	    SetPlayerPos(playerid,-1513.8988,2523.1270,55.6552);
	    InfoMessage(playerid, "You have served your time in admin jail and are now released.");
	    PlayerInfo[playerid][pAJail] = -1;
	}
	return 1;
}

forward Died(playerid);
public Died(playerid)
{
    SendClientMessage(playerid, 0x088A08FF, "==========================================");
    SendClientMessage(playerid, -1, "You died and do not remember what");
    SendClientMessage(playerid, -1, "happened in the previous RP scene.");
    SendClientMessage(playerid, 0x088A08FF, "==========================================");
	SetPlayerPos(playerid, -1514.747431, 2518.928095, 56.035937);
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	PlayerTextDrawDestroy(playerid,DeathText[playerid]);
	PlayerTextDrawDestroy(playerid,DeathTextt[playerid]);
	label[playerid] = Create3DTextLabel(RPN(playerid,1), -1, 30.0, 40.0, 50.0, 4.0, 0);
	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
	PlayerInfo[playerid][pDeathTime] = -1;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 0);
	return 1;
}

new MechCheck[2], DeliveryJob[60], DMVTest[60];

public OnPlayerEnterCheckpoint(playerid)
{
if (MechCheck[playerid] == 1)
	{
	MechCheck[playerid] = 0;
	DisablePlayerCheckpoint(playerid);
	return 1;
	}
if(DVehicles[GetPlayerVehicleID(playerid)][vJob] == 1)
     {
		if(DeliveryJob[playerid] == 1){
        	DeliveryJob[playerid] = 2;
        	SetPlayerCheckpoint(playerid,-1446.5594,2588.5432,55.8340,5);
        	return 1;
         }
		if(DeliveryJob[playerid] == 2){
         	DeliveryJob[playerid] = 3;
	     	SetPlayerCheckpoint(playerid,-1513.3544,2615.0186,55.9036,5);
	     	return 1;
         }
		if(DeliveryJob[playerid] == 3){
         	DeliveryJob[playerid] = 4;
	     	SetPlayerCheckpoint(playerid,-1464.8588,2587.0852,55.8219,5);
	     	return 1;
         }
		if(DeliveryJob[playerid] == 4){
         	DeliveryJob[playerid] = 5;
	     	SetPlayerCheckpoint(playerid,-1501.0911,2526.1992,55.7813,5);
	     	return 1;
         }
 		if(DeliveryJob[playerid] == 5){
         	DeliveryJob[playerid] = 6;
	     	SetPlayerCheckpoint(playerid,-1532.4236,2569.2742,55.9298,5);
	     	return 1;
         }
		if(DeliveryJob[playerid] == 6){
         	DeliveryJob[playerid] = 0;
	     	DisablePlayerCheckpoint(playerid);
	     	InfoMessage(playerid, "You have finished your job! Here is your $35");
	     	GivePMoney(playerid,35);// Reward price here
         }
     }
if(DVehicles[GetPlayerVehicleID(playerid)][vDMV] != 0)
     {
		if(DMVTest[playerid] == 1){
        	DMVTest[playerid] = 2;
        	SetPlayerCheckpoint(playerid,-1482.7618,2598.7036,55.5645,5);
        	return 1;
         }
		if(DMVTest[playerid] == 2){
         	DMVTest[playerid] = 3;
	     	SetPlayerCheckpoint(playerid,-1423.8843,2615.1436,55.5622,5);
	     	return 1;
         }
		if(DMVTest[playerid] == 3){
         	DMVTest[playerid] = 4;
	     	SetPlayerCheckpoint(playerid,-1441.3284,2673.0042,55.5625,5);
	     	return 1;
         }
		if(DMVTest[playerid] == 4){
         	DMVTest[playerid] = 5;
	     	SetPlayerCheckpoint(playerid,-1531.2183,2674.0466,55.5624,5);
	     	return 1;
         }
 		if(DMVTest[playerid] == 5){
         	DMVTest[playerid] = 6;
	     	SetPlayerCheckpoint(playerid,-1548.7883,2614.9771,55.5624,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 6){
         	DMVTest[playerid] = 7;
	     	SetPlayerCheckpoint(playerid,-1510.0472,2599.3184,55.5633,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 7){
         	DMVTest[playerid] = 8;
	     	SetPlayerCheckpoint(playerid,-1508.6963,2553.7683,55.5623,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 8){
         	DMVTest[playerid] = 9;
	     	SetPlayerCheckpoint(playerid,-1543.2883,2588.2957,55.5594,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 9){
         	DMVTest[playerid] = 10;
	     	SetPlayerCheckpoint(playerid,-1532.4751,2668.3977,55.5624,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 10){
         	DMVTest[playerid] = 11;
	     	SetPlayerCheckpoint(playerid,-1498.5118,2658.1731,55.5641,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 11){
         	DMVTest[playerid] = 12;
	     	SetPlayerCheckpoint(playerid,-1482.8029,2598.9666,55.5648,5);
	     	return 1;
         }
        if(DMVTest[playerid] == 12){
         	DMVTest[playerid] = 13;
	     	SetPlayerCheckpoint(playerid,-1465.0266,2567.9287,55.6165,5);
	     	return 1;
         }
		if(DMVTest[playerid] == 13){
         	DMVTest[playerid] = 0;
	     	DisablePlayerCheckpoint(playerid);
	     	InfoMessage(playerid, "You have finished the test! Here is your drivers license.");
	     	PlayerInfo[playerid][pDLicense] = 1;
	     	PlayerInfo[playerid][pTakingTest] = 0;
	     	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
         }
     }
DisablePlayerCheckpoint(playerid);
return 1;
}

forward TraceUpdate(playerid);
public TraceUpdate(playerid)
{
	if(Tracing[playerid] != -1)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(Tracing[playerid],x,y,z);
		SetPlayerCheckpoint(playerid, x, y, z, 5.0);
	}
	return 1;
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(DVehicles[vehicleid][vRadioOn] == 1){
	PlayAudioStreamForPlayer(playerid, DVehicles[vehicleid][vRadio]);}
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	if(doors == 1) return TogglePlayerControllable(playerid, true);
	if(DVehicles[vehicleid][vJob] == 1)
	{
	    if(PlayerInfo[playerid][pJob] != 1) return 1;
		InfoMessage(playerid, "Use /startdelivery to start the Delivery Job!");
		return 1;
	}
	if(DVehicles[vehicleid][vDMV] != 0)
	{
	    if(PlayerInfo[playerid][pTakingTest] != 0){
		InfoMessage(playerid, "Use /starttest to start the DMV test!");
		return 1;}
	}
	if(DVehicles[vehicleid][vRental] != 0)
	{
		if (DVehicles[vehicleid][vRenter] != 1111 && DVehicles[vehicleid][vRenter] != playerid) return 1;
		new string[160];
		SendClientMessage(playerid,-1, "{00FFEE}------------------------------------------------------");
		SendClientMessage(playerid,-1, "{989898}You have entered a rentable vehicle.");
		format(string,sizeof(string),"{989898}You can rent it with /rentveh for $%d.", VEH_RENT_PRICE);
		SendClientMessage(playerid,-1, string);
		SendClientMessage(playerid,-1, "{00FFEE}------------------------------------------------------");
		return 1;
	}
    if(engine != 1 && ispassenger == 0 && VehicleHasEngine(vehicleid) == 0) SendClientMessage(playerid,0x4B8C42FF,"The engine of this vehicle is off. Use /engine to turn it on or to hotwire it.");
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
new rows;
cache_get_row_count(rows);
if(rows) cache_get_value_int(0,"ID",PlayerInfo[playerid][pID]);
return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if (!response) return KickB(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""COL_WHITE"Registering...",""COL_RED"You have entered an invalid password.\n"COL_WHITE"Type your password below to register a new account.","Register","Quit");
                PlayerInfo[playerid][pPass] = udb_hash(inputtext);
                ShowPlayerDialog(playerid, DIALOG_REGISTER_GENDER, DIALOG_STYLE_LIST, "Choose your gender", "Male\nFemale", "Select", "Quit");
       		}
        }
        case DIALOG_LOGIN:
        {
            if ( !response ) return KickB(playerid);
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    SetPSkin(playerid, PlayerInfo[playerid][pSkin]);
                    SetPlayerScore(playerid,PlayerInfo[playerid][pHours]);
                    ShowPlayerDialog(playerid, DIALOG_SUCCESS_2, DIALOG_STYLE_MSGBOX,""COL_WHITE"Success!",""COL_GREEN"You have successfully logged in!","Ok","");
                    IsLogged[playerid] = 1;
                    newp[playerid] = 0;
                    SetPHealth(playerid,PlayerInfo[playerid][pHealth]);
					SetPArmour(playerid,PlayerInfo[playerid][pArmor]);
					JustJoined[playerid] = 1;
                    SpawnPlayer(playerid);
                }
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_WHITE"Login",""COL_RED"You have entered an incorrect password.\n"COL_WHITE"Type your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
        case DIALOG_SKIN:
        {
           if(response)
                {
                    new skinid, message[64];
                    skinid = strval(inputtext);
                    if(skinid < 0 || skinid > 299)
                    {
                    	ErrorMessage(playerid, "Skin ID may be between 0 and 299.");
                    }
                    else
                    {
                        if(SkinGender(skinid) == 3) {ErrorMessage(playerid, "This skin is locked."); ShowPlayerDialog(playerid, DIALOG_SKIN, DIALOG_STYLE_INPUT,"Choose a skin","Choose your skin","Choose","Quit"); return 1;}
						if(PlayerInfo[playerid][pGender] == 1 && SkinGender(skinid) == 2) {ErrorMessage(playerid,"Invalid skin gender."); ShowPlayerDialog(playerid, DIALOG_SKIN, DIALOG_STYLE_INPUT,"Choose a skin","Choose your skin","Choose","Quit"); return 1;}
						else if(PlayerInfo[playerid][pGender] == 2 && SkinGender(skinid) == 1) {ErrorMessage(playerid,"Invalid skin gender."); ShowPlayerDialog(playerid, DIALOG_SKIN, DIALOG_STYLE_INPUT,"Choose a skin","Choose your skin","Choose","Quit"); return 1;}
                    	SetPSkin(playerid, skinid);
                     	format(message, sizeof(message), "You have changed your skin id to %d.", skinid);
                      	InfoMessage(playerid, message);
                      	newp[playerid] = 0;
					}
           		}
		}
		case DIALOG_CLOTHES:
		{
		    if(response)
      		{
	  		    new skinid, message[64];
         		skinid = strval(inputtext);
                if(skinid < 0 || skinid > 311) return ErrorMessage(playerid, "Skin ID may be between 0 and 311.");
				if(GetPlayerMoney(playerid) < 20) return ErrorMessage(playerid, "You don't have enough money.");
				if(SkinGender(skinid) == 3) return ErrorMessage(playerid, "This skin is locked.");
				if(PlayerInfo[playerid][pGender] == 1 && SkinGender(skinid) == 2) return ErrorMessage(playerid,"Invalid skin gender.");
				else if(PlayerInfo[playerid][pGender] == 2 && SkinGender(skinid) == 1) return ErrorMessage(playerid,"Invalid skin gender.");
				if(PlayerInfo[playerid][pGender] != 1 && PlayerInfo[playerid][pGender] != 2) return ErrorMessage(playerid,"Variable error detected, contact the developer.");
   				SetPSkin(playerid, skinid);
   				GivePMoney(playerid, -20);
      			format(message, sizeof(message), "You have changed your clothes to %d.", skinid);
                InfoMessage(playerid, message);
			}
		}
		case DIALOG_EQSD_LOCKERS:
    	{
        	if(response)
        	{
            	switch(listitem)
            	{
                 	case 0: EQSD_CASE0(playerid);
                	case 1: FAC_FIRSTAID(playerid);
                	case 2: FAC_KEVLAR(playerid);
                	case 3: FAC_WEAPON(playerid,WEAPON_SPRAYCAN,9999999);
                	case 4: FAC_WEAPON(playerid,WEAPON_DEAGLE,60);
                	case 5: FAC_WEAPON(playerid,WEAPON_SHOTGUN,30);
                	case 6: FAC_WEAPON(playerid,WEAPON_M4,120);
                	case 7: FAC_WEAPON(playerid,WEAPON_SNIPER,30);
                	case 8: FAC_WEAPON(playerid,WEAPON_SHOTGSPA, 40);
                	case 9: FAC_WEAPON(playerid,WEAPON_MP5,120);
            	}
        	}
        	return 1;
		}
    	case DIALOG_LOCKERS_DUTY:
    	{
    	    if(FactionInfo[PlayerInfo[playerid][pFac]][Type] > 2) return 1;
        	if(response)
        	{
            	switch(listitem)
            	{
                	case 0: LOCKER_DUTY(playerid,282);
                	case 1: LOCKER_DUTY(playerid,283);
                	case 2: LOCKER_DUTY(playerid,284);
                	case 3: LOCKER_DUTY(playerid,285);
                	case 4: LOCKER_DUTY(playerid,288);
                	case 5: LOCKER_DUTY(playerid,306);
                	case 6: LOCKER_DUTY(playerid,309);
            	}
        	}
        	new string[60];
        	format(string,sizeof(string),"%s Lockers",FactionInfo[PlayerInfo[playerid][pFac]][Name]);
        	ShowPlayerDialog(playerid, DIALOG_EQSD_LOCKERS, DIALOG_STYLE_LIST, string, "Duty\nFirst Aid\nKevlar\nDeagle\nShotgun\nM4\nSniper Rifle\nCombat Shotgun\nMP5", "Select", "Exit");
    	}
    	case DIALOG_SHOP:
    	{
        	if(response)
        	{
            	switch(listitem)
            	{
                	case 0: SHOP_BUYMASK(playerid);
                	case 1: SHOP_TOOLKIT(playerid);
                	case 2: SHOP_CAMERA(playerid);
                	case 3: SHOP_PHONE(playerid);
                	case 4: SHOP_RADIO(playerid);
                	case 5: SHOP_MEDIKIT(playerid);
                	case 6: SHOP_LOTTERYTICKET(playerid);
                	case 7: SHOP_SCREWDRIVER(playerid);
                	case 8: SHOP_GASCAN(playerid);
                	case 9: SHOP_BOOMBOX(playerid);
            	}
        	}
        	return 1;
    	}
    	case DIALOG_DEALERSHIP:
        {
            if(response)
        	{
            	switch(listitem)
            	{
            	    case 0: BuyDealerVeh(playerid,-85,481);
            	    case 1: BuyDealerVeh(playerid,-100,510);
            	    case 2: BuyDealerVeh(playerid,-300,462);
            	    case 3: BuyDealerVeh(playerid,-500,468);
            	    case 4: BuyDealerVeh(playerid,-525,461);
            	    case 5: BuyDealerVeh(playerid,-610,478);
                	case 6: BuyDealerVeh(playerid,-750,542);
                	//-
                	case 7: BuyDealerVeh(playerid,-775,404);
                	case 8: BuyDealerVeh(playerid,-825,400);
            	}
        	}
        	return 1;
        }
        case DIALOG_REGISTER_GENDER:
        {
            if (!response) return KickB(playerid);
            if(response)
        	{
        	    switch(listitem)
            	{
	        	    case 0: PlayerInfo[playerid][pGender] = 1;
	        	    case 1: PlayerInfo[playerid][pGender] = 2;
				}
				ShowPlayerDialog(playerid, DIALOG_REG_DOB_MONTH, DIALOG_STYLE_LIST,"Character Date of Birth (Month)","1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12","Next","Quit");
        	}
        	return 1;
        }
        case DIALOG_REG_DOB_MONTH:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		if(listitem+1 < 10) format(PlayerInfo[playerid][pDOBMonth],3,"0%d",listitem+1);
        		else format(PlayerInfo[playerid][pDOBMonth],3,"%d",listitem+1);
        		new string[364];
        		format(string,sizeof(string),"1");
        		for(new i=2; i<daysInMonth[listitem+1]; i++)
        		{
        			format(string,sizeof(string),"%s\n%d",string,i);
        		}
        		ShowPlayerDialog(playerid, DIALOG_REG_DOB_DAY, DIALOG_STYLE_LIST,"Character Date of Birth (Day)",string,"Next","Quit");
        	}
        }
        case DIALOG_REG_DOB_DAY:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		if(listitem+1 < 10) format(PlayerInfo[playerid][pDOBDay],3,"0%d",listitem+1);
        		else format(PlayerInfo[playerid][pDOBDay],3,"%d",listitem+1);
        		new string[860],time[3];
        		format(string,sizeof(string),"1940");
        		getdate(time[0], time[1], time[2]);
        		for(new i=1920; i<time[0]-15; i++)
        		{
        			format(string,sizeof(string),"%s\n%d",string,i);
        		}
        		ShowPlayerDialog(playerid, DIALOG_REG_DOB_YEAR, DIALOG_STYLE_LIST,"Character Date of Birth (Year)",string,"Next","Quit");
        	}
        }
        case DIALOG_REG_DOB_YEAR:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		format(PlayerInfo[playerid][pDOB],11,"%s/%s/%d",PlayerInfo[playerid][pDOBDay],PlayerInfo[playerid][pDOBMonth],listitem+1918);
        		PlayerInfo[playerid][pAge] = GetAgeFromDOB(PlayerInfo[playerid][pDOB]);
        		ShowPlayerDialog(playerid, DIALOG_REG_NATIONALITY, DIALOG_STYLE_INPUT,"Character Country of origin","Type in your character's country of origin. (Example: America, Italy, Greece, etc.)","Next","Quit");
        	}
        }
        case DIALOG_REG_NATIONALITY:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		format(PlayerInfo[playerid][pNationality],20,"%s",inputtext);
        		ShowPlayerDialog(playerid, DIALOG_REG_HEIGHT, DIALOG_STYLE_INPUT,"Character Height","Type in your character's height in centimeters. (Only numbers)","Next","Quit");
        	}
        }
        case DIALOG_REG_HEIGHT:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		PlayerInfo[playerid][pHeight] = strval(inputtext);
        		ShowPlayerDialog(playerid, DIALOG_REG_WEIGHT, DIALOG_STYLE_INPUT,"Character Weight","Type in your character's weight in kilograms. (Only numbers)","Next","Quit");
        	}
        }
        case DIALOG_REG_WEIGHT:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		PlayerInfo[playerid][pWeight] = strval(inputtext);
        		ShowPlayerDialog(playerid, DIALOG_REG_HAIRCOLOR, DIALOG_STYLE_INPUT,"Character Hair Color","Type in your character's hair color.","Next","Quit");
        	}
        }
        case DIALOG_REG_HAIRCOLOR:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		format(PlayerInfo[playerid][pHairColor],20,"%s",inputtext);
        		ShowPlayerDialog(playerid, DIALOG_REG_EYECOLOR, DIALOG_STYLE_INPUT,"Character Eye Color","Type in your character's eye color.","Finish","Quit");
        	}
        }
        case DIALOG_REG_EYECOLOR:
        {
        	if(!response) return KickB(playerid);
        	if(response)
        	{
        		format(PlayerInfo[playerid][pEyeColor],20,"%s",inputtext);
        		new query[546];
				format(query,sizeof(query),"INSERT INTO `users` (username,password,DOB,Nationality,Height,Weight,HairColor,EyeColor) VALUES ('%s','%d','%s','%d','%s','%d','%s','%s')",
											GetPlayerNameEx(playerid),PlayerInfo[playerid][pPass],PlayerInfo[playerid][pDOB],PlayerInfo[playerid][pNationality],PlayerInfo[playerid][pHeight],
											PlayerInfo[playerid][pWeight],PlayerInfo[playerid][pHairColor],PlayerInfo[playerid][pEyeColor]);
				mysql_query(connection,query);
				format(query,sizeof(query),"SELECT * FROM `users` WHERE `username` = '%s' LIMIT 1;",GetPlayerNameEx(playerid));
				mysql_tquery(connection,query,"OnPlayerRegister","i",playerid);
        		JustJoined[playerid] = 1;
        		SetSpawnInfo(playerid, 0, 26, -1513.8988,2523.1270,55.6552,0.7955, 0, 0, 0, 0, 0, 0);
                newp[playerid] = 1;
                IsLogged[playerid] = 1;
                SetPlayerScore(playerid,PlayerInfo[playerid][pHours]);
                SpawnPlayer(playerid);
        	}
        }
        case DIALOG_LOCKER_EDIT_MAIN:
        {
            if(response)
        	{
        	    ShowPlayerDialog(playerid, DIALOG_LOCKER_EDIT_WEAP, DIALOG_STYLE_LIST, "Choose the weapon", "M4", "Select", "Back");
        	}
        	return 1;
        }
        case DIALOG_SASMD_ELEVATOR:
    	{
        	if(response)
        	{
            	switch(listitem)
            	{
                 	case 0: SASMD_STAFFLOOR(playerid);
                	case 1: SASMD_LOBBY(playerid);
            	}
        	}
        	return 1;
		}
		case DIALOG_GYM_LOCKER:
    	{
        	if(response)
        	{
            	switch(listitem)
            	{
                 	case 0: {SetPlayerFightingStyle(playerid, 4); PlayerInfo[playerid][pFightStyle] = 4; InfoMessage(playerid,"Fighting style successfully changed to Normal.");}
                	case 1: {SetPlayerFightingStyle(playerid, 5); PlayerInfo[playerid][pFightStyle] = 5; InfoMessage(playerid,"Fighting style successfully changed to Boxing.");}
                	case 2: {SetPlayerFightingStyle(playerid, 6); PlayerInfo[playerid][pFightStyle] = 6; InfoMessage(playerid,"Fighting style successfully changed to Kung Fu.");}
                	case 3: {SetPlayerFightingStyle(playerid, 7); PlayerInfo[playerid][pFightStyle] = 7; InfoMessage(playerid,"Fighting style successfully changed to Knee-Head.");}
                	case 4: {SetPlayerFightingStyle(playerid, 15); PlayerInfo[playerid][pFightStyle] = 15; InfoMessage(playerid,"Fighting style successfully changed to Grab-Kick.");}
                	case 5: {SetPlayerFightingStyle(playerid, 16); PlayerInfo[playerid][pFightStyle] = 16; InfoMessage(playerid,"Fighting style successfully changed to Elbow.");}
            	}
        	}
        	return 1;
		}
		case DIALOG_MDC_MAIN:
    	{
        	if(response)
        	{
            	switch(listitem) 
            	{
                 	case 0: 
                 	{
                 		ShowPlayerDialog(playerid, DIALOG_MDC_INPUT, DIALOG_STYLE_INPUT,"Search Name","Enter the full name of the person.","Confirm","Back");
                 		MDCchoice[playerid] = 1;
                 	}
                	case 1: 
                	{
                		ShowPlayerDialog(playerid, DIALOG_MDC_INPUT, DIALOG_STYLE_INPUT,"Search Vehicle Plate","Enter the vehicle's plate.","Confirm","Back");
                		MDCchoice[playerid] = 2;
                	}
                	case 2: 
                	{
                		ShowPlayerDialog(playerid, DIALOG_MDC_INPUT, DIALOG_STYLE_INPUT,"Search Address","Enter the address.","Confirm","Back"); 
                		MDCchoice[playerid] = 3; 
                	}
                	case 3: 
                	{
                		ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE, DIALOG_STYLE_LIST,"BOLOs Database","Add BOLO\nDatabase","Select","Back"); 
                	}
            	}
        	}
		}
		case DIALOG_MDC_BOLO_CHOICE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE2, DIALOG_STYLE_LIST,"Add BOLO","Add BOLO for a person\nAdd BOLO for a car","Select","Back");
					case 1:
					{
						BOLOchoice[playerid] = 99;
						ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_LIST, DIALOG_STYLE_LIST, "BOLO List", "Open BOLOs\nClosed BOLOs", "Select", "Back");
					}
				}
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Digital Computer", "Search Name\nSearch Vehicle Plate\nSearch Address\nBOLOs", "Select", "Exit");
		}
		case DIALOG_MDC_BOLO_LIST:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:	mysql_tquery(connection,"SELECT * FROM `bolos` WHERE `status` = '1'","DisplayBOLOs","ii",playerid,1);
					case 1: mysql_tquery(connection,"SELECT * FROM `bolos` WHERE `status` = '2'","DisplayBOLOs","ii",playerid,2);
				}
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE, DIALOG_STYLE_LIST,"BOLOs Database","Add BOLO\nDatabase","Select","Back"); 
		}
		case DIALOG_MDC_BOLO_LIST1:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:	ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_LIST_CH, DIALOG_STYLE_INPUT,"Open BOLOs","Enter the ID of the BOLO.","Confirm","Back"); 
					case 1: ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_LIST_CH, DIALOG_STYLE_INPUT,"Closed BOLOs","Enter the ID of the BOLO.","Confirm","Back"); 
				}
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE, DIALOG_STYLE_LIST,"BOLOs Database","Add BOLO\nDatabase","Select","Back"); 
		}
		case DIALOG_MDC_BOLO_LIST_CH:
		{
			if(response)
			{
				new bolo = strval(inputtext),boloidd;
				for(new i = 0; i < MAX_BOLOS; i++)
				{
					if(BOLOAdd[i][BOLOstatus] == 0 && BOLOAdd[i][BOLOID] == bolo) return ErrorMessage(playerid,"BOLO ID not found.");
					else if(BOLOAdd[i][BOLOID] == bolo) {boloidd = i; break;}
				}
				new Query[120];
				format(Query,sizeof(Query),"SELECT * FROM `bolos` WHERE `ID` = '%d'",bolo);
				mysql_tquery(connection,Query,"DisplayBOLO","ii",playerid,boloidd);
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE, DIALOG_STYLE_LIST,"BOLOs Database","Add BOLO\nDatabase","Select","Back"); 
		}
		case DIALOG_MDC_BOLO_CHOICE2:
		{
			if(response)
			{
				for(new i = 0; i < MAX_BOLOS; i++)
	            {
	            	if(BOLOAdd[i][BOLOstatus] == 0)
	            	{
	            		PlayerBOLOAdding[playerid] = i;
	            		break;
	            	}
	            }
				BOLOchoice[playerid] = 1;
				switch(listitem)
				{
					case 0: {BOLOAdd[PlayerBOLOAdding[playerid]][BOLOtype] = 1; ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter person's name. If unknown, leave blank.","Next","Back");}
					case 1: {BOLOAdd[PlayerBOLOAdding[playerid]][BOLOtype] = 2; ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter vehicle's model number ((Model ID)). If unknown, leave blank.","Next","Back");}	
				}
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE, DIALOG_STYLE_LIST,"BOLOs Database","Add BOLO\nDatabase","Select","Back"); 
		}
		case DIALOG_MDC_BOLO_INPUT:
		{
			if(response)
			{
				switch(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOtype])
				{
					case 1: 
					{
						switch(BOLOchoice[playerid])
						{
							case 1:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOperson],30,inputtext);
								ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter person's last seen location. If unknown, leave blank.","Finish","Cancel");
							}
							case 2:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOlastseen],30,inputtext);
								new string[280];
								format(string,sizeof(string),"BOLO added for person '%s', last seen at '%s'",BOLOAdd[PlayerBOLOAdding[playerid]][BOLOperson],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOlastseen]);
								InfoMessage(playerid,string);
								new time[6];
								gettime(time[0], time[1], time[2]);
								getdate(time[3], time[4], time[5]);
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOdate],20,"%02d:%02d %02d/%02d/%02d",time[0],time[1],time[5],time[4],time[3]);
								new query[280];
								format(query,sizeof(query),"INSERT INTO `bolos` (creator,type,date,person,lastseen) VALUES ('%s','%d','%s','%s','%s')",GetPlayerNameEx(playerid),BOLOAdd[PlayerBOLOAdding[playerid]][BOLOtype],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOdate],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOperson],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOlastseen]);
								mysql_query(connection,query);
								//ResetBOLOData(playerid);
							}
						}
					}
					case 2:
					{
						switch(BOLOchoice[playerid])
						{
							case 1:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOmodel],40,inputtext);
								ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter vehicle's primary color. If unknown, leave blank.","Next","Cancel");
							}
							case 2:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOcolor1],20,inputtext);
								ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter vehicle's secondary color. If unknown, leave blank.","Next","Cancel");
							}
							case 3:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOcolor2],20,inputtext);
								ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter vehicle's plate. If unknown, leave blank.","Next","Cancel");
							}
							case 4:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOplate],10,inputtext);
								ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_INPUT, DIALOG_STYLE_INPUT,"Add BOLO","Enter vehicle's last seen location. If unknown, leave blank.","Finish","Cancel");
							}
							case 5:
							{
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOlastseen],30,inputtext);
								new string[280];
								new fileid = CreateVehicle(strval(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOmodel]),0,0,0,0,0,0,0,0);
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOmodel],40,"%s",GetVehicleName(fileid));
								DestroyVehicle(fileid);
								format(string,sizeof(string),"BOLO added for vehicle model '%s', primary color '%s', with the plates '%s', which was last seen at '%s'",BOLOAdd[PlayerBOLOAdding[playerid]][BOLOmodel],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOcolor1],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOplate],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOlastseen]);
								InfoMessage(playerid,string);
								new time[6];
								gettime(time[0], time[1], time[2]);
								getdate(time[3], time[4], time[5]);
								format(BOLOAdd[PlayerBOLOAdding[playerid]][BOLOdate],20,"%02d/%02d/%02d %02d:%02d ",time[5],time[4],time[3], time[0], time[1]);
								new query[380];
								format(query,sizeof(query),"INSERT INTO `bolos` (creator,type,date,model,color1,color2,plate,lastseen) VALUES ('%s','%d','%s','%s','%s','%s','%s','%s')",
															GetPlayerNameEx(playerid),BOLOAdd[PlayerBOLOAdding[playerid]][BOLOtype],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOdate],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOmodel],
															BOLOAdd[PlayerBOLOAdding[playerid]][BOLOcolor1],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOcolor2],BOLOAdd[PlayerBOLOAdding[playerid]][BOLOplate],
															BOLOAdd[PlayerBOLOAdding[playerid]][BOLOlastseen]);
								mysql_query(connection,query);
								//LoadBOLO(PlayerBOLOAdding[playerid]);
								//ResetBOLOData(playerid);
							}
						}
					}
				}
				BOLOchoice[playerid]++;
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_CHOICE2, DIALOG_STYLE_LIST,"Add BOLO","Add BOLO for a person\nAdd BOLO for a car","Select","Back");
		}
		case DIALOG_MDC_INPUT:
		{
			if(response)
			{
				new Query[140];
				switch(MDCchoice[playerid])
				{
					case 1:
					{
						for(new i = 0; i < MAX_PLAYERS; i++)
                 		{
                 			if(IsLogged[i] == 1)
                 			{
                 				new ppname[MAX_PLAYER_NAME];
                 				GetPlayerName(i, ppname, MAX_PLAYER_NAME);
                 				if(strcmp(inputtext, ppname, true) == 0)
                 				{
                 					new string[224],ggender[20],prison,pprison[20];
                 					format(ggender,20,"Male");
									if(PlayerInfo[i][pGender] == 2) format(ggender,20,"Female");
									format(pprison,20,"No");
									if(PlayerInfo[i][pPrisonTime] != -1) format(pprison,20,"Yes");
									else if(PlayerInfo[i][pPrisonTime] == -1) prison = 0;
									format(string,sizeof(string)," Age: %d~n~ Gender: %s~n~ Date of birth: %s~n~ Nationality: %s~n~ Height: %d cm~n~ Weight: %d kg~n~ In Prison: %s (%d)",
																PlayerInfo[i][pAge],ggender,PlayerInfo[i][pDOB],PlayerInfo[i][pNationality],PlayerInfo[i][pHeight],PlayerInfo[i][pWeight],pprison,prison);
									CreatePlayerStatBox(playerid,RPN(i,0),string,1);
									return 1;
                 				}
                 			}
                 		}
						format(Query,sizeof(Query),"SELECT * FROM `users` WHERE `Username` = '%s' LIMIT 1;",inputtext);
						mysql_tquery(connection,Query,"PersonSearchResult","i",playerid);
						return 1;
					}
					case 2:
					{
						for(new b = 0; b < MAX_CUSTOM_VEHICLES; b++)
						{
							if(DVehicles[b][dModel] != 0)
							{
							    if(strval(DVehicles[b][vPlate]) == strval(inputtext))
							    {

									if(DVehicles[b][vFaction] != 0)
									{
										new string[126],str2[20];
										format(str2,sizeof(str2),"Plate %s",inputtext);
										format(string,sizeof(string)," Model: %s~n~ Owner: %s~n~ Tickets: 0",GetVehicleName(b),FactionInfo[DVehicles[b][vFaction]][Name]);
										CreatePlayerStatBox(playerid,str2,string,1);
										return 1;
									}
									new query[124];
							        format(query,sizeof(query),"SELECT * FROM `users` WHERE `ID` = '%d'",DVehicles[b][vOwner]);
									mysql_tquery(connection,query,"PlateSearchResult","ii",playerid,b);
							        return 1;
							    }
							}
						}
						return ErrorMessage(playerid,"Plate number not found.");
					}
					case 3:
					{
						new msg[124],textt[250],owner[65],house = strval(inputtext);
						if(HouseInfo[house][hOX] == 0) return ErrorMessage(playerid, "That house doesn't exist!");
						format(owner,65,"None");
						if(HouseInfo[house][hOwner] != 0) format(owner,65,"%s",HouseInfo[house][hOwnerName]);
						format(msg,sizeof(msg),"{989898}House %d",house);
						format(textt,sizeof(textt),"{989898}Owner: %s",HouseInfo[house][hPrice], owner);
						CreatePlayerStatBox(playerid,"msg","textt",1);
					}
				}
			}
			else return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Digital Computer", "Search Name\nSearch Vehicle Plate\nSearch Address\nBOLOs", "Select", "Exit");
		}
		case DIALOG_LOTTERY_TICKET:
    	{
        	if(response)
        	{
            	new Query[200];
            	new ticket = strval(inputtext);
				format(Query,sizeof(Query),"SELECT * FROM `users` WHERE `LotteryTicket` = '%d'",ticket);
				mysql_tquery(connection,Query,"GetAvailableTicket","ii",playerid,ticket);
        	}
		}
		case DIALOG_DRUGINV:
        {
            if(response)
        	{
            	switch(listitem)
            	{
                 	case 0: DRUGS_INV(playerid,1);
                	case 1: DRUGS_INV(playerid,2);
                	case 2: DRUGS_INV(playerid,3);
            	}
        	}
        }
        case DIALOG_DRUGINV_MENU:
        {
            if(response)
        	{
            	switch(listitem)
            	{
                 	case 0: DRUGS_INV_MENU(playerid,DrugInvSelect[playerid],1);
                	case 1: DRUGS_INV_MENU(playerid,DrugInvSelect[playerid],2);
                	case 2: DRUGS_INV_MENU(playerid,DrugInvSelect[playerid],3);
                	case 3: DRUGS_INV_MENU(playerid,DrugInvSelect[playerid],4);
            	}
            	return 1;
        	}
        	new string[164];
        	format(string,sizeof(string),"Cocaine\t%d\nWeed\t%d\nSeeds\t%d",PlayerInfo[playerid][pCocaine],PlayerInfo[playerid][pWeed],PlayerInfo[playerid][pSeeds]);
        	ShowPlayerDialog(playerid, DIALOG_DRUGINV, DIALOG_STYLE_LIST, "Drugs Inventory", string, "Select", "Exit");
        }
        case DIALOG_DRUGINV_DROP:
        {
            if(response)
        	{
        	    new amount = strval(inputtext);
        	    new string[164];
				if(DrugInvSelect[playerid] == 1) {
					if(PlayerInfo[playerid][pCocaine] < amount) return ErrorMessage(playerid,"You don't have that much Cocaine!");
                    PlayerInfo[playerid][pCocaine] = PlayerInfo[playerid][pCocaine] - amount;
                    format(string,sizeof(string),"You have dropped %d Cocaine.", amount);
                    InfoMessage(playerid,string);
                    return 1;
					}
				else if(DrugInvSelect[playerid] == 2) {
					if(PlayerInfo[playerid][pWeed] < amount) return ErrorMessage(playerid,"You don't have that much Weed!");
                    PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed] - amount;
                    format(string,sizeof(string),"You have dropped %d Weed.", amount);
                    InfoMessage(playerid,string);
                    return 1;
					}
				else if(DrugInvSelect[playerid] == 3) {
					if(PlayerInfo[playerid][pSeeds] < amount) return ErrorMessage(playerid,"You don't have that much Seeds!");
                    PlayerInfo[playerid][pSeeds] = PlayerInfo[playerid][pSeeds] - amount;
                    format(string,sizeof(string),"You have dropped %d Seeds.", amount);
                    InfoMessage(playerid,string);
                    return 1;
					}
                return 1;
        	}
        	DRUGS_INV(playerid,DrugInvSelect[playerid]);
        }
        case DIALOG_DRUGINV_GIVE1:
        {
            if(response)
        	{
        	    DrugChoose[playerid] = strval(inputtext);
        	    ShowPlayerDialog(playerid, DIALOG_DRUGINV_GIVE2, DIALOG_STYLE_INPUT, "Give", "Type to who would you like to give the drugs to.", "Confirm", "Back");
                return 1;
        	}
        	DRUGS_INV(playerid,DrugInvSelect[playerid]);
        }
        case DIALOG_DRUGINV_GIVE2:
        {
            if(response)
        	{
        	    new playerb = strval(inputtext);
        	    new string[164];
        	    if(!IsPlayerConnected(playerb)) return ErrorMessage(playerid, "Invalid player id.");
        	    if(!IsPlayerNearPlayer(playerid, playerb, 3)) return ErrorMessage(playerid, "You are not in range of that player.");
				if(DrugInvSelect[playerid] == 1) {
					if(PlayerInfo[playerid][pCocaine] < DrugChoose[playerid]) return ErrorMessage(playerid,"You don't have that much Cocaine!");
                    PlayerInfo[playerid][pCocaine] = PlayerInfo[playerid][pCocaine] - DrugChoose[playerid];
                    PlayerInfo[playerb][pCocaine] = PlayerInfo[playerb][pCocaine] + DrugChoose[playerid];
                    format(string,sizeof(string),"You have given %s %d Cocaine.",RPN(playerb,1), DrugChoose[playerid]);
                    InfoMessage(playerid,string);
                    format(string,sizeof(string),"You have received %d Cocaine from %s.",DrugChoose[playerid], RPN(playerb,1));
                    InfoMessage(playerb,string);
                    return 1;
					}
				else if(DrugInvSelect[playerid] == 2) {
					if(PlayerInfo[playerid][pWeed] < DrugChoose[playerid]) return ErrorMessage(playerid,"You don't have that much Weed!");
                    PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed] - DrugChoose[playerid];
                    PlayerInfo[playerb][pWeed] = PlayerInfo[playerb][pWeed] + DrugChoose[playerid];
                    format(string,sizeof(string),"You have given %s %d Weed.",RPN(playerb,1), DrugChoose[playerid]);
                    InfoMessage(playerid,string);
                    format(string,sizeof(string),"You have received %d Cocaine from %s.",DrugChoose[playerid], RPN(playerb,1));
                    InfoMessage(playerb,string);
                    return 1;
					}
				else if(DrugInvSelect[playerid] == 3) {
					if(PlayerInfo[playerid][pSeeds] < DrugChoose[playerid]) return ErrorMessage(playerid,"You don't have that much Seeds!");
                    PlayerInfo[playerid][pSeeds] = PlayerInfo[playerid][pSeeds] - DrugChoose[playerid];
                    PlayerInfo[playerb][pSeeds] = PlayerInfo[playerb][pSeeds] + DrugChoose[playerid];
                    format(string,sizeof(string),"You have given %s %d Seeds.",RPN(playerb,1), DrugChoose[playerid]);
                    InfoMessage(playerid,string);
                    format(string,sizeof(string),"You have received %d Cocaine from %s.",DrugChoose[playerid], RPN(playerb,1));
                    InfoMessage(playerb,string);
                    return 1;
					}
                return 1;
        	}
        	DRUGS_INV(playerid,DrugInvSelect[playerid]);
        }
        case DIALOG_DRUGINV_USE:
        {
            if(response)
        	{
        	    new amount = strval(inputtext);
				if(DrugInvSelect[playerid] == 1) {
					if(PlayerInfo[playerid][pCocaine] < amount) return ErrorMessage(playerid,"You don't have that much Cocaine!");
					DrugUse(playerid,1,amount);
					}
				else if(DrugInvSelect[playerid] == 2) {
					if(PlayerInfo[playerid][pWeed] < amount) return ErrorMessage(playerid,"You don't have that much Weed!");
					DrugUse(playerid,2,amount);
					}
                return 1;
        	}
        	DRUGS_INV(playerid,DrugInvSelect[playerid]);
        }
        case DIALOG_FLAGS_LIST: if(response) ShowPlayerDialog(playerid, DIALOG_FLAGS_LIST_CH, DIALOG_STYLE_INPUT,"Player Flags","Enter the ID of the flag.","Confirm","Back"); 
		case DIALOG_FLAGS_LIST_CH:
		{
			if(response)
			{
				new flagid = strval(inputtext);
				new Query[120];
				format(Query,sizeof(Query),"SELECT * FROM `playerflags` WHERE `ID` = '%d'",flagid);
				mysql_tquery(connection,Query,"DisplayFlag","ii",playerid,flagid);
			}
		}
		case DIALOG_DRINKS:
    	{
        	if(response)
        	{
            	DRINKBUY(playerid,listitem+1);
        	}
        	return 1;
    	}
    }
    return 1;
}


stock DRINKBUY(playerid,item)
{
	new biz;
	for(new i = 1; i < MAX_BIZ; i++)
	{
		if(BizInfo[i][bOX] != 0)
		{
			if(IsPlayerInRangeOfPoint(playerid,1.5,BizInfo[i][bBX],BizInfo[i][bBY],BizInfo[i][bBZ])  && GetPlayerVirtualWorld(playerid) == BizInfo[i][bIVW] && GetPlayerInterior(playerid) == BizInfo[i][bIInt])
			{
			    biz = i;
			    break;
			}
		}
	}
	switch (item)
	{
		case 1:
		{
			if(PlayerInfo[playerid][pMoney] < 3) return ErrorMessage(playerid,"You don't have enough money for that.");
			GivePMoney(playerid,-3);
			BizInfo[biz][bMoney] += 3;
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
			InfoMessage(playerid,"You have just bought a can of soda.");
		}
		case 2:
		{
			if(PlayerInfo[playerid][pMoney] < 5) return ErrorMessage(playerid,"You don't have enough money for that.");
			GivePMoney(playerid,-5);
			BizInfo[biz][bMoney] += 5;
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
			InfoMessage(playerid,"You have just bought a beer bottle.");
		}
		case 3:
		{
			if(PlayerInfo[playerid][pMoney] < 20) return ErrorMessage(playerid,"You don't have enough money for that.");
			GivePMoney(playerid,-20);
			BizInfo[biz][bMoney] += 20;
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
			InfoMessage(playerid,"You have just bought a bottle of wine.");
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    SetVehicleHealth(vehicleid,DVehicles[vehicleid][vHealth]);
    SetVehicleNumberPlate(vehicleid, DVehicles[vehicleid][vPlate]);
    return 1;
}

stock GivePMoney(playerid,amount)
{
PlayerInfo[playerid][pMoney] += amount;
GivePlayerMoney(playerid,amount);
}

stock SASMD_STAFFLOOR(playerid)
{
SetPlayerInterior(playerid,1);
SetPlayerVirtualWorld(playerid,0);
SetPlayerPos(playerid,1378.5524,395.9639,3383.7585);
FreezePlayer(playerid,500);
}

stock SASMD_LOBBY(playerid)
{
SetPlayerInterior(playerid,1);
SetPlayerVirtualWorld(playerid,3);
SetPlayerPos(playerid,1948.9642,-2236.6240,14.6328);
FreezePlayer(playerid,500);
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(DVehicles[vehicleid][vRadioOn] == 1) StopAudioStreamForPlayer(playerid);
	if(DeliveryJob[playerid] > 0)
	{
	    DeliveryJob[playerid] = 0;
	    InfoMessage(playerid, "You have left the van, your progress is lost.");
	    DisablePlayerCheckpoint(playerid);
	}
	if(DVehicles[vehicleid][vJob] != 0) return SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
	if(DVehicles[vehicleid][vDMV] == 1) return SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
	if(Seatbelt[playerid] != 0)
	{
	    new string[164];
		format(string, sizeof(string), "* %s takes their seatbelt off.", RPN(playerid,1));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s takes their seatbelt off.", RPN(playerid,1));
		SendClientMessage(playerid, COLME, string);
		Seatbelt[playerid] = 0;
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new weapon, ammo;
 	GetPlayerWeaponData(playerid, GetWeaponSlot(GetPlayerWeapon(playerid)), weapon, ammo);
  	SetPlayerArmedWeapon(playerid, weapon);
  	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
        for(new i = 0; i < MAX_PLAYERS; i++) if(PlayerInfo[i][pAdmin] != 0) if(Spectating[i] == playerid) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
    	new engine, lights, alarm, doors, bonnet, boot, objective, Float:health;
    	new vehicleid = GetPlayerVehicleID(playerid);
    	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		GetVehicleHealth(vehicleid, health);
		if(health < 270)
		{
			SetVehicleHealth(vehicleid,270);
			SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
			InfoMessage(playerid,"The engine of the vehicle broke down.");
		}
        ShowPlayerSpeedo(playerid, 1);

    }
    else if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_PASSENGER)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PlayerInfo[i][pAdmin] != 0)
			{
				if(Spectating[i] == playerid)
				{
					PlayerSpectatePlayer(i, playerid);
				}
			}
		}
	}
	else if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) // Player entered a vehicle as a driver
    {
        for(new i = 0; i < MAX_PLAYERS; i++) {if(PlayerInfo[i][pAdmin] != 0){ if(Spectating[i] == playerid) {PlayerSpectatePlayer(i, playerid);}}}
        ShowPlayerSpeedo(playerid, 0);
    }
    return 1;
}

stock DestroyVehicleScreen(playerid)
{
	TextDrawHideForPlayer(playerid,enginetext[playerid]);
	TextDrawHideForPlayer(playerid,a[playerid]);
	TextDrawHideForPlayer(playerid,enginestate[playerid]);
	TextDrawHideForPlayer(playerid,doorss[playerid]);
	TextDrawHideForPlayer(playerid,fueltext[playerid]);
	TextDrawHideForPlayer(playerid,fuelstate[playerid]);
	return 1;
}

new counttttt[MAX_PLAYERS];
public OnPlayerUpdate(playerid)
{
	if(IsLogged[playerid] == 1)
	{
		if(GetPlayerWeapon(playerid) == 0) {if(HasWeapon[playerid] == 1) {GivePlayerWeapon(playerid, PlayerInfo[playerid][pGunHold],0);}}
		else if(GetPlayerWeapon(playerid) != 0){
			GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGunHold],PlayerInfo[playerid][pGunHoldAmmo]);
			if(PlayerInfo[playerid][pGunHoldAmmo] == 0) counttttt[playerid]++;
			if(counttttt[playerid] == 4) {ResetPlayerWeapons(playerid); HasWeapon[playerid] = 0; counttttt[playerid] = 0; PlayerInfo[playerid][pGunHold] = 0; PlayerInfo[playerid][pGunHoldAmmo] = 0;}}
	    if(GetPlayerMoney(playerid) != PlayerInfo[playerid][pMoney])
		{
	 		new reset = GetPlayerMoney(playerid) - PlayerInfo[playerid][pMoney];
			new string[124];
			GivePlayerMoney(playerid,-reset);
			format(string,sizeof(string),"%s has hacked in money ($%d), resetting to $%d.",RPN(playerid,0),GetPlayerMoney(playerid),PlayerInfo[playerid][pMoney]);
			if(GetPlayerMoney(playerid) != PlayerInfo[playerid][pMoney]) AntiCheatMessage(string);
		}
		if(SpeedLimit[playerid] != 0 && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
		    SpeedLimit[playerid] = 0;
		    SpeedLS[playerid] = 0;
		    KillTimer(SpeedLSTimer[playerid]);
		    SendClientMessage(playerid, -1, "Speed limit off 2");
		}
		SetPlayerHealth(playerid,900);
		SetPlayerArmour(playerid,900);
	}
    return 1;
}

stock BanPlayer(playerid,banner,reason[60])
{
	new name[60],string[164];
	format(name,60,RPN(banner,0));
	if(banner == -1) {format(name,60,"Dr. Pepper");}
    format(string, sizeof(string), "%s has been banned by %s, reason: %s", RPN(playerid,0), name, reason);
    SendClientMessageToAll(COLOR_LIGHTRED, string);
    AdminLog(string);
    print(string);
    PlayerInfo[playerid][pBanned] = 1;
    format(PlayerInfo[playerid][pBReason],126,reason);
    format(PlayerInfo[playerid][pBanner],MAX_PLAYER_NAME,name);
    KickB(playerid);
    return 1;
}

//****************************************************************************************************************************************************************
//******************************************************COMMANDS**************************************************************************************************
//****************************************************************************************************************************************************************
//====================================================================ADMIN=======================================================================================
CMD:ah(playerid) return cmd_ahelp(playerid);
CMD:ahelp(playerid)
{
if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
if(PlayerInfo[playerid][pMod] != 0)
{
    SendClientMessage(playerid, COLOR_YELLOW, "Junior Mod: {FFFFFF}/c /gotoid /goto /hduty /b");
    if(PlayerInfo[playerid][pMod] == 1) return SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
    SendClientMessage(playerid, COLOR_YELLOW, "Standard Mod: {FFFFFF}/gethere /sethp /setarmor /kick /slap");
    if(PlayerInfo[playerid][pMod] == 2) return SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
    SendClientMessage(playerid, COLOR_YELLOW, "Senior Mod: {FFFFFF}To be made");
}
if(PlayerInfo[playerid][pAdmin] != 0)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/sethp /sethpall /setarmor /setarmorall /healnear /freezenear");
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/kick /ban /freeze /healall /togooc /ao /a /inviteac /aduty");
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/unfreezenear /gotocords /behindmask /obehindmask /setskin");
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/uninviteac /gotoid /gethere /checkdrugs /agivedrugs /respawnall");
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/getinveh /spec /stopspec /check /gotohouse /goinhouse /setvw");
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/ajail /arelease /repair /setint /checkweapons /slap /aka");
	SendClientMessage(playerid, COLOR_YELLOW, "Junior Admin: {FFFFFF}/arefuel /aengine /sync /flag /flags /unban");
	if(PlayerInfo[playerid][pAdmin] == 1) return SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
	SendClientMessage(playerid, COLOR_YELLOW, "Standard Admin: {FFFFFF}/ann /givemoney /agivelicense /atakelicense /sethours /setage");
	SendClientMessage(playerid, COLOR_YELLOW, "Standard Admin: {FFFFFF}/takeweapons /createveh /destroyveh /editveh /setgender");
	SendClientMessage(playerid, COLOR_YELLOW, "Standard Admin: {FFFFFF}/giveweapon /checkhouse /ocheck /jetpack /editdesc");
	if(PlayerInfo[playerid][pAdmin] == 2) return SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
	SendClientMessage(playerid, COLOR_YELLOW, "Senior Admin: {FFFFFF}/createhouse /edithouse /deletehouse /editfac /changename /deleteflag");
	SendClientMessage(playerid, COLOR_YELLOW, "Senior Admin: {FFFFFF}/makeleader /setminutes /createoptable /makedetective /takedetective");
	SendClientMessage(playerid, COLOR_YELLOW, "Senior Admin: {FFFFFF}/createdoor /deletedoor /editdoor /nearbydoors");
	if(PlayerInfo[playerid][pAdmin] == 3) return SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
	SendClientMessage(playerid, COLOR_YELLOW, "Management: {FFFFFF}/makeadmin /takeadmin /makemod /takemod /editlocker /adminhide");
	SendClientMessage(playerid, COLOR_YELLOW, "Management: {FFFFFF}/informspec /uninformspec /restartserver /editbiz /createbiz /deletebiz");
	SendClientMessage(playerid, COLOR_YELLOW, "Management: {FFFFFF}/restrictspec");
	SendClientMessage(playerid, COLOR_GREEN, "==================================================================");
}
return 1;
}
CMD:createdoor(playerid, params[])
{
	if(DoorCount() == MAX_DOORS) return ErrorMessage(playerid, "The maximum door limit is already reached.");
	new Float:x, Float:y, Float:z, Float:angle, id;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	id = EmptyDoor();
	DoorInfo[id][dox] = x;
	DoorInfo[id][doy] = y;
	DoorInfo[id][doz] = z;
	DoorInfo[id][doa] = angle;
	DoorInfo[id][doi] = GetPlayerInterior(playerid);
	DoorInfo[id][dow] = GetPlayerVirtualWorld(playerid);
	DoorInfo[id][dix] = 0;
	DoorInfo[id][diy] = 0;
	DoorInfo[id][diz] = 0;
	DoorInfo[id][dia] = 0;
	DoorInfo[id][dii] = GetPlayerInterior(playerid);
	DoorInfo[id][diw] = GetPlayerVirtualWorld(playerid);
	DoorInfo[id][dlocked] = 1;
	DoorCreated[id] = 1;
	DoorInfo[id][dtexton] = 1;
	new str[256];
	format(str, sizeof(str), "Created door ID %d",id);
	InfoMessage(playerid,str);
	new query[245];
	format(query,sizeof(query),"INSERT INTO `doors` (ID,ox,oy,oz,oa,oi,ow) VALUES ('%d','%f','%f','%f','%f','%d','%d')",id,DoorInfo[id][dox],DoorInfo[id][doy],DoorInfo[id][doz],DoorInfo[id][doa],DoorInfo[id][doi],DoorInfo[id][dow]);
	mysql_query(connection,query);
	format(query,sizeof(query),"SELECT * FROM `doors` WHERE `ID` = '%d'",id);
	mysql_tquery(connection,query,"LoadDoor","i",id);
	return 1;
}

CMD:editdoor(playerid, params[])
{
	new Float:x, Float:y, Float:z, Float:angle, st[256];
	new temp[256], id;if(sscanf(params, "ds[256]", id, temp)) return SendClientMessage(playerid, -1, "Usage: /editdoor [doorid] [option] [input] (inside/outside/locked/text/textshow)");
	sscanf(params, "ds[256]s[256]", id, temp, st);
	if(DoorCreated[id] == 0) return SendClientMessage(playerid, -1, "invalid door id");
	if(!strcmp(temp, "inside"))
	{
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);
		DoorInfo[id][dix] = x;
		DoorInfo[id][diy] = y;
		DoorInfo[id][diz] = z;
		DoorInfo[id][dia] = angle;
		DoorInfo[id][dii] = GetPlayerInterior(playerid);
		DoorInfo[id][diw] = GetPlayerVirtualWorld(playerid);
		InfoMessage(playerid, "Door inside position has been edited.");
	}
	else if(!strcmp(temp, "outside"))
	{
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);
		DoorInfo[id][dox] = x;
		DoorInfo[id][doy] = y;
		DoorInfo[id][doz] = z;
		DoorInfo[id][doa] = angle;
		DoorInfo[id][doi] = GetPlayerInterior(playerid);
		DoorInfo[id][dow] = GetPlayerVirtualWorld(playerid);
		Delete3DTextLabel(DoorInfo[id][dtext]);
		new str[256];format(str, sizeof(str), "{FFFF00}%s\n{FFFFFF}/enter",  DoorInfo[id][dlabel]);
		if(DoorInfo[id][dtexton] != 0) DoorInfo[id][dtext] = Create3DTextLabel(str, 0xFFFFFFEE, x, y, z, 10.0, 0, 1);
		InfoMessage(playerid, "Door outside position has been edited.");
	}
	else if(!strcmp(temp, "locked"))
	{
	    if(DoorInfo[id][dlocked] != 0)
	    {
	        DoorInfo[id][dlocked] = 0;
	        InfoMessage(playerid, "Door has been unlocked.");
	    }
	    else 
	    {
	        DoorInfo[id][dlocked] = 1;
	        InfoMessage(playerid, "Door has been locked.");
	    }
	}
	else if(!strcmp(temp, "textshow"))
	{
	    if(DoorInfo[id][dtexton] != 0)
	    {
	        DoorInfo[id][dtexton] = 0;
	        Delete3DTextLabel(DoorInfo[id][dtext]);
	        InfoMessage(playerid, "Door 3D Text Label is now invisable.");
	    }
	    else
	    {
	        DoorInfo[id][dtexton] = 1;
	        new str[256];format(str, sizeof(str), "{FFFF00}%s\n{FFFFFF}/enter",  DoorInfo[id][dlabel]);
			DoorInfo[id][dtext] = Create3DTextLabel(str, 0xFFFFFFEE, DoorInfo[id][dox], DoorInfo[id][doy], DoorInfo[id][doz], 10.0, 0, 1);
	        InfoMessage(playerid, "Door 3D Text Label is now visable.");
	    }
	}
	else if(!strcmp(temp, "text"))
	{
	    format(DoorInfo[id][dlabel], 256, st);
	    new str[256];format(str, sizeof(str), "{FFFF00}%s\n{FFFFFF}/enter",  DoorInfo[id][dlabel]);
		Update3DTextLabelText(DoorInfo[id][dtext], -1, str);
		InfoMessage(playerid, "Door text has been edited.");
	}
	else return UsageMessage(playerid, "/editdoor [doorid] [option] (inside/outside/locked/text/textshow)");
	return 1;
}
CMD:deletedoor(playerid, params[])
{
	new id; if(sscanf(params, "d", id)) return UsageMessage(playerid, "/deletedoor (doorid)");
	if(DoorCreated[id] == 0) return ErrorMessage(playerid, "Invalid door id.");
	DoorInfo[id][dox] = 0;
	DoorInfo[id][doy] = 0;
	DoorInfo[id][doz] = 0;
	DoorInfo[id][doa] = 0;
	DoorInfo[id][doi] = 0;
	DoorInfo[id][dow] = 0;
	DoorInfo[id][dix] = 0;
	DoorInfo[id][diy] = 0;
	DoorInfo[id][diz] = 0;
	DoorInfo[id][dia] = 0;
	DoorInfo[id][dii] = 0;
	DoorInfo[id][diw] = 0;
	DoorInfo[id][dlocked] = 0;
	DoorCreated[id] = 0;
	new query[146];
	format(query,sizeof(query),"DELETE FROM `doors` WHERE `ID` = '%d'",id);
	mysql_query(connection,query);
	Delete3DTextLabel(DoorInfo[id][dtext]);
	InfoMessage(playerid, "Door has been deleted.");
	return 1;
}

CMD:nearbydoors(playerid, params[])
{
	if(DoorCount() == 0) return ErrorMessage(playerid, "No doors created yet");
	new str[256], id, Float:x, Float:y, Float:z;
	for(new i; i<MAX_DOORS; i++)
	{
	    id = i;
	    if(DoorCreated[i] != 0)
	    {
            if(IsPlayerInRangeOfPoint(playerid, 30.0, DoorInfo[id][dox], DoorInfo[id][doy], DoorInfo[id][doz]) && GetPlayerInterior(playerid) == DoorInfo[id][doi] && GetPlayerVirtualWorld(playerid) == DoorInfo[id][dow])
            {
                GetPlayerPos(playerid, x, y, z);
				format(str, sizeof(str), "ID: %d | Text: {FF0000}%s {FFFFFF} | Locked: %d | TextShow: %d | Distance: %.1f {FFFF00}m", id, DoorInfo[id][dlabel], DoorInfo[id][dlocked], DoorInfo[id][dtexton], GetDistance(x, y, z, DoorInfo[id][dox], DoorInfo[id][doy], DoorInfo[id][doz]));
				SendClientMessage(playerid, -1, str);
            }
	    }
	}
	return 1;
}
CMD:restrictspec(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb;
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/restrictspec (playerid)");
if(IsLogged[playerid] != 1) return ErrorMessage(playerid, "That player is not logged in!");
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid,"That player is not an admin.");
if(AllowedToSpec[playerb] == 1)
{
	AllowedToSpec[playerb] = 0;
	InfoMessage(playerid,"The admin is no longer allowed to spectate.");
}
else
{
	AllowedToSpec[playerb] = 1;
	InfoMessage(playerid,"The admin is now allowed to spectate.");
}
return 1;
}
CMD:restartserver(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] != 0) SaveUser(i);
}
SendRconCommand("gmx");
return 1;
}
CMD:editdesc(playerid,params[])
{
new playerb,input[20];
if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(isnull(params)) {UsageMessage(playerid, "/editdesc (option) (playerid)"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: dob | nationality | height | weight | haircol | eyecol"); return 1;}
if(!strcmp(params, "dob", true, 3))
{
    if(sscanf(params, "s[32]us[20]",params,playerb,input)) return UsageMessage(playerid, "/editdesc dob (playerid) (dd/mm/yyyy)");
    format(PlayerInfo[playerb][pDOB],11,"%s",input);
    PlayerInfo[playerid][pAge] = GetAgeFromDOB(PlayerInfo[playerid][pDOB]);
	InfoMessage(playerid,"Player's date of birth changed successfully.");
}
else if(!strcmp(params, "nationality", true, 11))
{
    if(sscanf(params, "s[32]us[20]",params,playerb,input)) return UsageMessage(playerid, "/editdesc nationality (playerid) (nationality)");
    format(PlayerInfo[playerb][pNationality],20,"%s",input);
	InfoMessage(playerid,"Player's nationality changed successfully.");
}
else if(!strcmp(params, "height", true, 6))
{
	if(sscanf(params, "s[32]us[20]",params,playerb,input)) return UsageMessage(playerid, "/editdesc height (playerid) (height)");
    PlayerInfo[playerb][pHeight] = strval(input);
	InfoMessage(playerid,"Player's height changed successfully.");
}
else if(!strcmp(params, "weight", true, 6))
{
	if(sscanf(params, "s[32]us[20]",params,playerb,input)) return UsageMessage(playerid, "/editdesc weight (playerid) (weight)");
    PlayerInfo[playerb][pWeight] = strval(input);
	InfoMessage(playerid,"Player's weight changed successfully.");
}
else if(!strcmp(params, "haircol", true, 7))
{
    if(sscanf(params, "s[32]us[20]",params,playerb,input)) return UsageMessage(playerid, "/editdesc haircol (playerid) (hair color)");
    format(PlayerInfo[playerb][pHairColor],20,"%s",input);
	InfoMessage(playerid,"Player's hair color changed successfully.");
}
else if(!strcmp(params, "eyecol", true, 6))
{
    if(sscanf(params, "s[32]us[20]",params,playerb,input)) return UsageMessage(playerid, "/editdesc eyecol (playerid) (eye color)");
    format(PlayerInfo[playerb][pEyeColor],20,"%s",input);
	InfoMessage(playerid,"Player's eye color changed successfully.");
}
return 1;
}
CMD:flag(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
	new playerb,flag[120];
	if(sscanf(params, "us[120]", playerb, flag)) return UsageMessage(playerid, "/flag (playerid) (flag text)");
	if(IsLogged[playerid] != 1) return ErrorMessage(playerid, "That player is not logged in!");
	new time[8],date[20];
	gettime(time[0], time[1], time[2]);
	getdate(time[3], time[4], time[5]);
	format(date,20,"%02d:%02d %02d/%02d/%02d",time[0],time[1],time[5],time[4],time[3]);
	new query[126],string[126];
	format(query,sizeof(query),"INSERT INTO `playerflags` (`playerID`, `date`, `text`, `creator`) VALUES ('%d','%s','%s','%s')",PlayerInfo[playerb][pID],date,flag,GetPlayerNameEx(playerid));
	mysql_query(connection,query);
	format(string, sizeof(string), "%s has flagged %s 's account.", RPN(playerid,0), RPN(playerb,0));
	if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
	return 1;
}
CMD:flags(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
	new playerb;
	if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/flags (playerid)");
	new query[126];
	format(query,sizeof(query),"SELECT * FROM `playerflags` WHERE `playerID` = '%d'",PlayerInfo[playerb][pID]);
	mysql_tquery(connection,query,"DisplayPlayerFlags","i",playerid);
	return 1;
}
CMD:deleteflag(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
	new flagid;
	if(sscanf(params, "i", flagid)) return UsageMessage(playerid, "/deleteflag (flagid)");
	new query[126];
	format(query,sizeof(query),"SELECT * FROM `playerflags` WHERE `ID` = '%d'",flagid);
	mysql_tquery(connection,query,"DeleteFlag","ii",playerid,flagid);
	return 1;
}
CMD:sync(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
	new playerb;
	if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/sync (playerid)");
	PlayerInfo[playerid][pSync] = 1;
	SpawnPlayer(playerb);
	return 1;
}
CMD:arefuel(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
	new vehicleid = GetPlayerVehicleID(playerid);
	DVehicles[vehicleid][vFuel] = 100;
	return 1;
}
CMD:aengine(playerid)
{
	new string[146];
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMessage(playerid, "You need to be in the drivers seat!");
    new vehicleid = GetPlayerVehicleID(playerid);
    if(VehicleHasEngine(vehicleid) == 1) return 1;
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
    if(engine == 1)
	{
		SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
		format(string, sizeof(string), "* %s twists their key in the ignition, turning the engine of the %s off.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s twists their key in the ignition, turning the engine of the %s off.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
		TextDrawSetString(enginestate[playerid], "Off");
	}
    else
    {
    	SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		format(string, sizeof(string), "* %s twists their key in the ignition, turning the engine of the %s on.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s twists their key in the ignition, turning the engine of the %s on.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
		TextDrawSetString(enginestate[playerid], "On");
	}
	return 1;
}
CMD:jetpack(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}
CMD:aka(playerid,params[])
{
new playerb;
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/aka (playerid)");
if(IsLogged[playerid] != 1) return ErrorMessage(playerid, "That player is not logged in!");
new query[126];
format(query,sizeof(query),"SELECT * FROM `AKA` WHERE `username` = '%s'",GetPlayerNameEx(playerb));
mysql_tquery(connection,query,"OnAKALookup","ii",playerid,playerb);
return 1;
}
forward OnAKALookup(playerid,playerb);
public OnAKALookup(playerid,playerb)
{
new IP[16],string[146];
GetPlayerIp(playerb,IP,16);
format(string,sizeof(string),"%s - %s: ",RPN(playerb,0),IP);
new rows;
cache_get_row_count(rows);
for(new i=0; i<rows; i++)
{
	cache_get_value_name(i,"IP",IP);
	if(i == 0) format(string,sizeof(string),"%s%s",string,IP);
	else if(i != 0) format(string,sizeof(string),"%s, %s",string,IP);
}
InfoMessage(playerid,string);
return 1;
}
CMD:slap(playerid,params[])
{
new playerb;
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/slap (playerid)");
if(IsLogged[playerid] != 1) return ErrorMessage(playerid, "That player is not logged in!");
new Float:x,Float:y,Float:z,string[128];
GetPlayerPos(playerb,x,y,z);
SetPlayerPos(playerb,x,y,z+4);
format(string,sizeof(string),"%s has been slapped!",RPN(playerb,0));
InfoMessage(playerid,string);
format(string,sizeof(string),"%s has slapped you!",RPN(playerid,0));
InfoMessage(playerb,string);
return 1;
}
CMD:checkhouse(playerid,params[])
{
new house;
if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "i", house)) return UsageMessage(playerid, "/checkhouse (house)");
if(HouseInfo[house][hOX] == 0) return ErrorMessage(playerid, "That house doesn't exist!");
new msg[124],owner[65];
format(owner,65,"None");
if(HouseInfo[house][hOwner] != 0) format(owner,65,"%s",HouseInfo[house][hOwnerName]);
format(msg,sizeof(msg),"_______________________HOUSE ID %d_______________________",house);
SendClientMessage(playerid,0xFF8C00AA,msg);
format(msg,sizeof(msg),"{989898}OX: %f | OY: %f | OZ: %f | OVW: %d | OInt: %d",HouseInfo[house][hOX], HouseInfo[house][hOY], HouseInfo[house][hOZ], HouseInfo[house][hOVW], HouseInfo[house][hOInt]);
SendClientMessage(playerid,-1,msg);
format(msg,sizeof(msg),"{989898}IX: %f | IY: %f | IZ: %f | IVW: %d | IInt: %d",HouseInfo[house][hIX], HouseInfo[house][hIY], HouseInfo[house][hIZ], HouseInfo[house][hIVW], HouseInfo[house][hIInt]);
SendClientMessage(playerid,-1,msg);
format(msg,sizeof(msg),"{989898}Price: %d | Owner: %s",HouseInfo[house][hPrice], owner);
SendClientMessage(playerid,-1,msg);
SendClientMessage(playerid,-1,"__________________________________________________________");
return 1;
}
CMD:checkweapons(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,string[164],gunname[60];
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/checkweapons (ID/name)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
format(string, sizeof(string), "{989898}==========[%s's Weapons]==========", RPN(playerb,0));
SendClientMessage(playerid, -1, string);
GetWeaponName(PlayerInfo[playerb][pGun1],gunname,sizeof(gunname));
format(string, sizeof(string), "{989898}Slot 1: %s (%d ammo)", gunname, PlayerInfo[playerb][pGunAmmo1]);
SendClientMessage(playerid, -1, string);
GetWeaponName(PlayerInfo[playerb][pGun2],gunname,sizeof(gunname));
format(string, sizeof(string), "{989898}Slot 2: %s (%d ammo)", gunname, PlayerInfo[playerb][pGunAmmo2]);
SendClientMessage(playerid, -1, string);
GetWeaponName(PlayerInfo[playerb][pGun3],gunname,sizeof(gunname));
format(string, sizeof(string), "{989898}Slot 3: %s (%d ammo)", gunname, PlayerInfo[playerb][pGunAmmo3]);
SendClientMessage(playerid, -1, string);
GetWeaponName(PlayerInfo[playerb][pGunHold],gunname,sizeof(gunname));
format(string, sizeof(string), "{989898}Holding: %s (%d ammo)", gunname, PlayerInfo[playerb][pGunHoldAmmo]);
SendClientMessage(playerid, -1, string);
return 1;
}
CMD:informspec(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,string[164];
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/informspec (ID/name)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
InformSpec[playerid][playerb] = 1;
format(string, sizeof(string), "You are now being informed if %s is being spectated.", RPN(playerb,0));
InfoMessage(playerid,string);
return 1;
}
CMD:uninformspec(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,string[164];
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/uninformspec (ID/name)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
InformSpec[playerid][playerb] = 0;
format(string, sizeof(string), "You are no longer being informed if %s is being spectated.", RPN(playerb,0));
InfoMessage(playerid,string);
return 1;
}
CMD:makedetective(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,string[164];
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/makedetective (ID/name)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
PlayerInfo[playerb][pDetective] = 1;
format(string, sizeof(string), "%s has made you a Detective.", RPN(playerid,0));
InfoMessage(playerb,string);
format(string, sizeof(string), "%s has made %s a Detective.", RPN(playerid,0), RPN(playerb,0));
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:takedetective(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,string[164];
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/takedetective (ID/name)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
PlayerInfo[playerb][pDetective] = 0;
format(string, sizeof(string), "%s has taken your Detective status.", RPN(playerid,0));
InfoMessage(playerb,string);
format(string, sizeof(string), "%s has taken %s's Detective status.", RPN(playerid,0), RPN(playerb,0));
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:repair(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You must be inside a vehicle!");
RepairVehicle(GetPlayerVehicleID(playerid));
SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
InfoMessage(playerid,"Vehicle successfully repaired.");
return 1;
}
CMD:adminhide(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(AdminHideCmds[playerid] == 0)
{
	AdminHideCmds[playerid] = 1;
	InfoMessage(playerid,"You have now hidden any administrative actions from yourself.");
}
else
{
    AdminHideCmds[playerid] = 0;
    InfoMessage(playerid,"You are now showing all administrative actions from yourself.");
}
return 1;
}
CMD:ajail(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,input,reason[60],string[164];
if(sscanf(params, "uis[60]",playerb,input,reason)) return UsageMessage(playerid, "/ajail (ID/name) (minutes) (reason)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
PlayerInfo[playerb][pAJail] = PlayerInfo[playerb][pAJail] + input;
SetPlayerVirtualWorld(playerb,playerb);
SetPlayerInterior(playerb,1);
SetPlayerPos(playerb,-1509.958496,2526.090820,5923.475097);
FreezePlayer(playerb,500);
format(string, sizeof(string), "%s has been admin jailed by %s, reason: %s", RPN(playerb,0), RPN(playerid,0), reason);
SendClientMessageToAll(COLOR_LIGHTRED, string);
AdminLog(string);
return 1;
}
CMD:arelease(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,reason[60],string[164];
if(sscanf(params, "us[60]",playerb,reason)) return UsageMessage(playerid, "/arelease (ID/name) (reason)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
if(PlayerInfo[playerb][pAJail] == -1) return ErrorMessage(playerid, "That player is not admin jailed!");
SetPlayerVirtualWorld(playerb,0);
SetPlayerInterior(playerb,0);
PlayerInfo[playerb][pAJail] = -1;
SetPlayerPos(playerb,-1513.8988,2523.1270,55.6552);
format(string, sizeof(string), "%s has been released by %s, reason: %s", RPN(playerb,0), RPN(playerid,0), reason);
SendClientMessageToAll(COLOR_LIGHTRED, string);
AdminLog(string);
return 1;
}
CMD:setvw(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,input;
if(sscanf(params, "ui", playerb,input)) return UsageMessage(playerid, "/setvw (ID/name) (vw)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
SetPlayerVirtualWorld(playerb,input);
return 1;
}
CMD:setint(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,input;
if(sscanf(params, "ui", playerb,input)) return UsageMessage(playerid, "/setint (ID/name) (int)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
SetPlayerInterior(playerb,input);
return 1;
}
CMD:getinhouse(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new house;
if(sscanf(params, "i", house)) return UsageMessage(playerid, "/getinhouse (house)");
if(HouseInfo[house][hOX] == 0) return ErrorMessage(playerid, "That house doesn't exist!");
if(HouseInfo[house][hIX] == 0) return ErrorMessage(playerid, "That house doesn't have an interior!");
SetPlayerPos(playerid,HouseInfo[house][hIX],HouseInfo[house][hIY],HouseInfo[house][hIZ]);
SetPlayerInterior(playerid,HouseInfo[house][hIInt]);
SetPlayerVirtualWorld(playerid,HouseInfo[house][hIVW]);
return 1;
}
CMD:gotohouse(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new house;
if(sscanf(params, "i", house)) return UsageMessage(playerid, "/gotohouse (house)");
if(HouseInfo[house][hOX] == 0) return ErrorMessage(playerid, "That house doesn't exist!");
SetPlayerPos(playerid,HouseInfo[house][hOX],HouseInfo[house][hOY],HouseInfo[house][hOZ]);
SetPlayerInterior(playerid,HouseInfo[house][hOInt]);
SetPlayerVirtualWorld(playerid,HouseInfo[house][hOVW]);
return 1;
}
CMD:editgasstation(playerid,params[])
{
new gasid,input;
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(isnull(params)) {UsageMessage(playerid, "/editgasstation (option) (gasid)"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: pos | price | owner"); return 1;}
if(!strcmp(params, "pos", true, 3))
{
    if(sscanf(params, "s[32]i",params,gasid)) return UsageMessage(playerid, "/edithouse pos (gasid)");
    new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	GasStationInfo[gasid][gsX] = x;
	GasStationInfo[gasid][gsY] = y;
	GasStationInfo[gasid][gsZ] = z;
	GasStationInfo[gasid][gsVW] = GetPlayerVirtualWorld(playerid);
	GasStationInfo[gasid][gsInt] = GetPlayerInterior(playerid);
	Delete3DTextLabel(GasStationInfo[gasid][gsLabel]);
	new string[60];
	format(string,sizeof(string),"Gas Station\nGas Price: $%d",input);
	GasStationInfo[gasid][gsLabel] = Create3DTextLabel(string, 0x00D700FF, GasStationInfo[gasid][gsX], GasStationInfo[gasid][gsY], GasStationInfo[gasid][gsZ], 10.0, 0, 1);
	InfoMessage(playerid,"Gas Station position set to your location.");
}
else if(!strcmp(params, "price", true, 5))
{
    if(sscanf(params, "s[32]ii",params,gasid,input)) return UsageMessage(playerid, "/editgasstation price (gasid) (price)");
	GasStationInfo[gasid][gsPrice] = input;
	Delete3DTextLabel(GasStationInfo[gasid][gsLabel]);
	new string[60];
	format(string,sizeof(string),"Gas Station\nGas Price: $%d",input);
	GasStationInfo[gasid][gsLabel] = Create3DTextLabel(string, 0x00D700FF, GasStationInfo[gasid][gsX], GasStationInfo[gasid][gsY], GasStationInfo[gasid][gsZ], 10.0, 0, 1);
	InfoMessage(playerid,"Gas Station gas price changed successfully.");
}
else if(!strcmp(params, "owner", true, 5))
{
	new playerb;
    if(sscanf(params, "s[32]ii",params,gasid,playerb)) return UsageMessage(playerid, "/editgasstation owner (gasid) (playerid)");
	GasStationInfo[gasid][gsOwner] = PlayerInfo[playerb][pID];
	InfoMessage(playerid,"Gas Station owner changed successfully.");
}
return 1;
}
CMD:deletegasstation(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new gasid,string[128];
if(sscanf(params, "i", gasid)) return UsageMessage(playerid, "/deletegasstation (gas station)");
if(GasStationInfo[gasid][gsX] == 0) return ErrorMessage(playerid, "That gas station doesn't exist!");
GasStationInfo[gasid][gsPrice] = 0;
GasStationInfo[gasid][gsX] = 0;
GasStationInfo[gasid][gsY] = 0;
GasStationInfo[gasid][gsZ] = 0;
GasStationInfo[gasid][gsVW] = 0;
GasStationInfo[gasid][gsInt] = 0;
GasStationInfo[gasid][gsOwner] = 0;
Delete3DTextLabel(GasStationInfo[gasid][gsLabel]);
format(string,sizeof(string),"Gas Station ID %d successfully deleted.",gasid);
InfoMessage(playerid,string);
format(string, sizeof(string), "%s has deleted Gas Station ID %d.", RPN(playerid,0), gasid);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:deletehouse(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new house,string[128];
if(sscanf(params, "i", house)) return UsageMessage(playerid, "/deletehouse (house)");
if(HouseInfo[house][hOX] == 0) return ErrorMessage(playerid, "That house doesn't exist!");
HouseInfo[house][hLocked] = 0;
HouseInfo[house][hPrice] = 0;
HouseInfo[house][hOX] = 0;
HouseInfo[house][hOY] = 0;
HouseInfo[house][hOZ] = 0;
HouseInfo[house][hOVW] = 0;
HouseInfo[house][hOInt] = 0;
HouseInfo[house][hIX] = 0;
HouseInfo[house][hIY] = 0;
HouseInfo[house][hIZ] = 0;
HouseInfo[house][hIVW] = 0;
HouseInfo[house][hIInt] = 0;
HouseInfo[house][hOwner] = 0;
Delete3DTextLabel(HouseInfo[house][hLabel]);
format(string,sizeof(string),"House ID %d successfully deleted.",house);
InfoMessage(playerid,string);
format(string, sizeof(string), "%s has deleted House ID %d.", RPN(playerid,0), house);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
new query[245];
format(query,sizeof(query),"DELETE FROM `houses` WHERE `ID` = '%d'",house);
mysql_query(connection,query);
return 1;
}
CMD:edithouse(playerid,params[])
{
new house,input;
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(isnull(params)) {UsageMessage(playerid, "/edithouse (option) (houseid)"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: inside | outside | price"); return 1;}
if(!strcmp(params, "inside", true, 6))
{
    if(sscanf(params, "s[32]i",params,house)) return UsageMessage(playerid, "/edithouse inside (houseid)");
    for(new i = 1; i < MAX_HOUSES; i++)	if(HouseInfo[i][hIVW] == GetPlayerVirtualWorld(playerid)) return ErrorMessage(playerid, "This Virtual World is used by another house. (/setvw for a new Virtual World)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	HouseInfo[house][hIX] = x;
	HouseInfo[house][hIY] = y;
	HouseInfo[house][hIZ] = z;
	HouseInfo[house][hIVW] = GetPlayerVirtualWorld(playerid);
	HouseInfo[house][hIInt] = GetPlayerInterior(playerid);
	InfoMessage(playerid,"House interior set to your location.");
}
else if(!strcmp(params, "outside", true, 7))
{
    if(sscanf(params, "s[32]i",params,house)) return UsageMessage(playerid, "/edithouse outside (houseid)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	HouseInfo[house][hOX] = x;
	HouseInfo[house][hOY] = y;
	HouseInfo[house][hOZ] = z;
	HouseInfo[house][hOVW] = GetPlayerVirtualWorld(playerid);
	HouseInfo[house][hOInt] = GetPlayerInterior(playerid);
	Delete3DTextLabel(HouseInfo[house][hLabel]);
	new string[60];
	format(string,sizeof(string),"[House %d]",house);
	if(HouseInfo[house][hOwner] == 0) format(string,sizeof(string),"[House %d]\nPrice: $%d",house,HouseInfo[house][hPrice]);
	HouseInfo[house][hLabel] = Create3DTextLabel(string, 0x00D700FF, HouseInfo[house][hOX], HouseInfo[house][hOY], HouseInfo[house][hOZ], 10.0, 0, 1);
	InfoMessage(playerid,"House exterior set to your location.");
}
else if(!strcmp(params, "price", true, 5))
{
    if(sscanf(params, "s[32]ii",params,house,input)) return UsageMessage(playerid, "/edithouse price (houseid) (price)");
	HouseInfo[house][hPrice] = input;
	Delete3DTextLabel(HouseInfo[house][hLabel]);
	new string[60];
	format(string,sizeof(string),"[House %d]",house);
	if(HouseInfo[house][hOwner] == 0) format(string,sizeof(string),"[House %d]\nPrice: $%d",house,HouseInfo[house][hPrice]);
	HouseInfo[house][hLabel] = Create3DTextLabel(string, 0x00D700FF, HouseInfo[house][hOX], HouseInfo[house][hOY], HouseInfo[house][hOZ], 10.0, 0, 1);
	InfoMessage(playerid,"House price changed successfully.");
}
return 1;
}
CMD:creategasstation(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new gasid,Float:x,Float:y,Float:z;
for(new i = 1; i < MAX_GASTATIONS; i++)
{
	if(GasStationInfo[i][gsX] == 0)
	{
	    gasid = i;
	    i = MAX_GASTATIONS;
	}
}
GetPlayerPos(playerid,x,y,z);
GasStationInfo[gasid][gsX] = x;
GasStationInfo[gasid][gsY] = y;
GasStationInfo[gasid][gsZ] = z;
GasStationInfo[gasid][gsVW] = GetPlayerVirtualWorld(playerid);
GasStationInfo[gasid][gsInt] = GetPlayerInterior(playerid);
new string[124];
format(string,sizeof(string),"Gas Station\nGas Price: $%d",GasStationInfo[gasid][gsPrice]);
GasStationInfo[gasid][gsLabel] = Create3DTextLabel(string, 0x00D700FF, x, y, z, 10.0, 0, 1);
format(string, sizeof(string), "%s has created Gas Station ID %d.", RPN(playerid,0), gasid);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
new query[245];
format(query,sizeof(query),"INSERT INTO `gasstations` (ID) VALUES ('%d')",gasid);
mysql_query(connection,query);
return 1;
}
CMD:createhouse(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new house,Float:x,Float:y,Float:z;
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] == 0)
	{
	    house = i;
	    i = MAX_HOUSES;
	}
}
GetPlayerPos(playerid,x,y,z);
HouseInfo[house][hOX] = x;
HouseInfo[house][hOY] = y;
HouseInfo[house][hOZ] = z;
HouseInfo[house][hOVW] = GetPlayerVirtualWorld(playerid);
HouseInfo[house][hOInt] = GetPlayerInterior(playerid);
new string[60];
format(string,sizeof(string),"[House %d]",house);
if(HouseInfo[house][hOwner] == 0) format(string,sizeof(string),"[House %d]\nPrice: $%d",house,HouseInfo[house][hPrice]);
HouseInfo[house][hLabel] = Create3DTextLabel(string, 0x00D700FF, HouseInfo[house][hOX], HouseInfo[house][hOY], HouseInfo[house][hOZ], 10.0, 0, 1);
format(string, sizeof(string), "%s has created House ID %d.", RPN(playerid,0), house);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
new query[245];
format(query,sizeof(query),"INSERT INTO `houses` (ID) VALUES ('%d')",house);
mysql_query(connection,query);
return 1;
}
CMD:createbiz(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
new biz,Float:x,Float:y,Float:z,string[146];
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] == 0)
	{
	    biz = i;
	    i = MAX_BIZ;
	}
}
GetPlayerPos(playerid,x,y,z);
BizInfo[biz][bOX] = x;
BizInfo[biz][bOY] = y;
BizInfo[biz][bOZ] = z;
BizInfo[biz][bOVW] = GetPlayerVirtualWorld(playerid);
BizInfo[biz][bOInt] = GetPlayerInterior(playerid);
format(string, sizeof(string), "%s has created Business ID %d.", RPN(playerid,0), biz);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
new query[245];
format(query,sizeof(query),"INSERT INTO `bizs` (ID,ox,oy,oz,oint,ovw) VALUES ('%d','%f','%f','%f','%d','%d')",biz,BizInfo[biz][bOX],BizInfo[biz][bOY],BizInfo[biz][bOZ],BizInfo[biz][bOInt],BizInfo[biz][bOVW]);
mysql_query(connection,query);
format(query,sizeof(query),"SELECT * FROM `bizs` WHERE `ID` = '%d'",biz);
mysql_tquery(connection,query,"LoadBiz","i",biz);
return 1;
}
CMD:deletebiz(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new biz;
if(sscanf(params, "i", biz)) return UsageMessage(playerid, "/deletebiz (bizid)");
if(BizInfo[biz][bOX] == 0) return ErrorMessage(playerid, "That business doesn't exist!");
BizInfo[biz][bLocked] = 0;
BizInfo[biz][bPrice] = 0;
BizInfo[biz][bOX] = 0;
BizInfo[biz][bOY] = 0;
BizInfo[biz][bOZ] = 0;
BizInfo[biz][bOVW] = 0;
BizInfo[biz][bOInt] = 0;
BizInfo[biz][bIX] = 0;
BizInfo[biz][bIY] = 0;
BizInfo[biz][bIZ] = 0;
BizInfo[biz][bIVW] = 0;
BizInfo[biz][bIInt] = 0;
BizInfo[biz][bOwner] = 0;
BizInfo[biz][bType] = 0;
BizInfo[biz][bTypeShow] = 0;
BizInfo[biz][bMoney] = 0;
Delete3DTextLabel(BizInfo[biz][bLabel]);
new query[146];
format(query,sizeof(query),"DELETE FROM `bizs` WHERE `ID` = '%d'",biz);
mysql_query(connection,query);
return 1;
}
CMD:nearbiz(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
	for(new i = 1; i < MAX_BIZ; i++)
	{
		if(BizInfo[i][bOX] != 0)
		{
		    if(IsPlayerInRangeOfPoint(playerid,5,BizInfo[i][bOX],BizInfo[i][bOY],BizInfo[i][bOZ])  && GetPlayerVirtualWorld(playerid) == BizInfo[i][bOVW] && GetPlayerInterior(playerid) == BizInfo[i][bOInt])
		    {
		    	new string[124];
		    	format(string,sizeof(string),"ID: %d | Name: %s | Type: %s",i,BizInfo[i][bName],GetBusinessType(BizInfo[i][bType]));
		        SendClientMessage(playerid, COLOR_WHITE, string);
		    }
		}
	}
	return 1;
}
stock GetBusinessType(typeid)
{
	new type[120];
	format(type,sizeof(type),"N/A");
	if(typeid == 1) format(type,sizeof(type),"24/7");
	else if(typeid == 2) format(type,sizeof(type),"Clothes Store");
	else if(typeid == 3) format(type,sizeof(type),"Bar");
	else if(typeid == 4) format(type,sizeof(type),"Restourant");
	else if(typeid == 5) format(type,sizeof(type),"Club");
	else if(typeid == 6) format(type,sizeof(type),"Fast Food");
	else if(typeid == 7) format(type,sizeof(type),"Weapon Store");
	else if(typeid == 8) format(type,sizeof(type),"Licensing Department");
	return type;
}
CMD:editbiz(playerid,params[])
{
new biz,input[30];
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(isnull(params)) {UsageMessage(playerid, "/editbiz (option) (bizid)"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: inside | outside | price | type | showtype | buypos | name"); return 1;}
if(!strcmp(params, "inside", true, 6))
{
    if(sscanf(params, "s[32]i",params,biz)) return UsageMessage(playerid, "/editbiz inside (bizid)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	BizInfo[biz][bIX] = x;
	BizInfo[biz][bIY] = y;
	BizInfo[biz][bIZ] = z;
	BizInfo[biz][bIVW] = GetPlayerVirtualWorld(playerid);
	BizInfo[biz][bIInt] = GetPlayerInterior(playerid);
	InfoMessage(playerid,"Business interior set to your location.");
}
else if(!strcmp(params, "outside", true, 7))
{
    if(sscanf(params, "s[32]i",params,biz)) return UsageMessage(playerid, "/editbiz outside (bizid)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	BizInfo[biz][bOX] = x;
	BizInfo[biz][bOY] = y;
	BizInfo[biz][bOZ] = z;
	BizInfo[biz][bOVW] = GetPlayerVirtualWorld(playerid);
	BizInfo[biz][bOInt] = GetPlayerInterior(playerid);
	Delete3DTextLabel(BizInfo[biz][bLabel]);
	new string[60];
	format(string,sizeof(string),"%s\n{FFFFFF}/enter",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n{FFFFFF}Commands: /enter /buy",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n{FFFFFF}Commands: /enter /buy",GetBusinessType(BizInfo[biz][bType]),BizInfo[biz][bPrice]);
	BizInfo[biz][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[biz][bOX], BizInfo[biz][bOY], BizInfo[biz][bOZ], 10.0, 0, 1);
	BizInfo[biz][bBLabel] = Create3DTextLabel("Commands:\n{FFFFFF}/buy", 0x00D700FF, BizInfo[biz][bBX], BizInfo[biz][bBY], BizInfo[biz][bBZ], 10.0, 0, 1);
	InfoMessage(playerid,"Business exterior set to your location.");
}
else if(!strcmp(params, "price", true, 5))
{
    if(sscanf(params, "s[32]is[30]",params,biz,input)) return UsageMessage(playerid, "/editbiz price (bizid) (price)");
	BizInfo[biz][bPrice] = strval(input);
	Delete3DTextLabel(BizInfo[biz][bLabel]);
	new string[60];
	format(string,sizeof(string),"%s\n{FFFFFF}/enter",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n{FFFFFF}Commands: /enter /buy",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n{FFFFFF}Commands: /enter /buy",GetBusinessType(BizInfo[biz][bType]),BizInfo[biz][bPrice]);
	BizInfo[biz][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[biz][bOX], BizInfo[biz][bOY], BizInfo[biz][bOZ], 10.0, 0, 1);
	BizInfo[biz][bBLabel] = Create3DTextLabel("Commands:\n{FFFFFF}/buy", 0x00D700FF, BizInfo[biz][bBX], BizInfo[biz][bBY], BizInfo[biz][bBZ], 10.0, 0, 1);
	format(string,sizeof(string),"Business %d's price set to $%d.",biz,strval(input));
	InfoMessage(playerid,string);
}
else if(!strcmp(params, "type", true, 4))
{
    if(sscanf(params, "s[32]is[30]",params,biz,input)) {UsageMessage(playerid, "/editbiz type (bizid) (type)"); SendClientMessage(playerid, -1, "{989898}[TYPES]: [1] 24/7 | [2] Clothes Store | [3] Bar | [4] Restourant | [5] Club | [6] Fast Food | [7] Weapon Store"); return 1;}
	BizInfo[biz][bType] = strval(input);
	Delete3DTextLabel(BizInfo[biz][bLabel]);
	new string[60];
	format(string,sizeof(string),"%s\n{FFFFFF}/enter",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n{FFFFFF}Commands: /enter /buy",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n{FFFFFF}Commands: /enter /buy",GetBusinessType(BizInfo[biz][bType]),BizInfo[biz][bPrice]);
	BizInfo[biz][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[biz][bOX], BizInfo[biz][bOY], BizInfo[biz][bOZ], 10.0, 0, 1);
	BizInfo[biz][bBLabel] = Create3DTextLabel("Commands:\n{FFFFFF}/buy", 0x00D700FF, BizInfo[biz][bBX], BizInfo[biz][bBY], BizInfo[biz][bBZ], 10.0, 0, 1);
	format(string,sizeof(string),"Business %d's type set to %d.",biz,strval(input));
	InfoMessage(playerid,string);
}
else if(!strcmp(params, "showtype", true, 8))
{
    if(sscanf(params, "s[32]is[30]",params,biz,input)) return UsageMessage(playerid, "/editbiz showtype (bizid) (1 = Type shown | 0 = Type hidden)");
	BizInfo[biz][bTypeShow] = strval(input);
	Delete3DTextLabel(BizInfo[biz][bLabel]);
	new string[60];
	format(string,sizeof(string),"%s\n{FFFFFF}/enter",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n{FFFFFF}Commands: /enter /buy",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n{FFFFFF}Commands: /enter /buy",GetBusinessType(BizInfo[biz][bType]),BizInfo[biz][bPrice]);
	BizInfo[biz][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[biz][bOX], BizInfo[biz][bOY], BizInfo[biz][bOZ], 10.0, 0, 1);
	BizInfo[biz][bBLabel] = Create3DTextLabel("Commands:\n{FFFFFF}/buy", 0x00D700FF, BizInfo[biz][bBX], BizInfo[biz][bBY], BizInfo[biz][bBZ], 10.0, 0, 1);
	format(string,sizeof(string),"Business %d's type show set to %d.",biz,strval(input));
	InfoMessage(playerid,string);
}
else if(!strcmp(params, "buypos", true, 6))
{
    if(sscanf(params, "s[32]i",params,biz)) return UsageMessage(playerid, "/editbiz buypos (bizid)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	BizInfo[biz][bBX] = x;
	BizInfo[biz][bBY] = y;
	BizInfo[biz][bBZ] = z;
	Delete3DTextLabel(BizInfo[biz][bBLabel]);
	BizInfo[biz][bBLabel] = Create3DTextLabel("Commands:\n/buy", 0x00D700FF, BizInfo[biz][bBX], BizInfo[biz][bBY], BizInfo[biz][bBZ], 10.0, 0, 1);
	InfoMessage(playerid,"Business buy position set to your location.");
}
else if(!strcmp(params, "name", true, 4))
{
    if(sscanf(params, "s[32]is[30]",params,biz,input)) return UsageMessage(playerid, "/editbiz name (bizid) (name)");
	format(BizInfo[biz][bName],30,input);
	Delete3DTextLabel(BizInfo[biz][bLabel]);
	new string[60];
	format(string,sizeof(string),"%s\n{FFFFFF}/enter",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n{FFFFFF}Commands: /enter /buy",BizInfo[biz][bName],GetBusinessType(BizInfo[biz][bType]));
	if(BizInfo[biz][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n{FFFFFF}Commands: /enter /buy",GetBusinessType(BizInfo[biz][bType]),BizInfo[biz][bPrice]);
	BizInfo[biz][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[biz][bOX], BizInfo[biz][bOY], BizInfo[biz][bOZ], 10.0, 0, 1);
	BizInfo[biz][bBLabel] = Create3DTextLabel("Commands:\n{FFFFFF}/buy", 0x00D700FF, BizInfo[biz][bBX], BizInfo[biz][bBY], BizInfo[biz][bBZ], 10.0, 0, 1);
	format(string,sizeof(string),"Business %d's name set to %s.",biz,input);
	InfoMessage(playerid,string);
}
return 1;
}
CMD:spec(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb,msg[124];
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/spec (ID/name)");
if(IsLogged[playerb] != 1 || PlayerInfo[playerb][pAdmin] >= 4) return ErrorMessage(playerid, "Invalid player ID.");
if(Spectating[playerid] == -1){
GetPlayerPos(playerid,PlayerInfo[playerid][pLastX],PlayerInfo[playerid][pLastY],PlayerInfo[playerid][pLastZ]);
GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pLastA]);
SpecVW[playerid] = GetPlayerVirtualWorld(playerid);
SpecInt[playerid] = GetPlayerInterior(playerid);
GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGunHold],PlayerInfo[playerid][pGunHoldAmmo]);}
TogglePlayerSpectating(playerid, 1);
if(!IsPlayerInAnyVehicle(playerb)) PlayerSpectatePlayer(playerid, playerb);
if(IsPlayerInAnyVehicle(playerb)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerb));
SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(playerb));
SetPlayerInterior(playerid,GetPlayerInterior(playerb));
format(msg,sizeof(msg),"Now spectating %s.",RPN(playerb,0));
InfoMessage(playerid,msg);
format(msg,sizeof(msg),"%s {%d} is now spectating %s {%d}.",RPN(playerid,0),playerid,RPN(playerb,0),playerb);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] != 0)
	{
		if(InformSpec[i][playerid] == 1) InfoMessage(i,msg);
	}
}
Spectating[playerid] = playerb;
return 1;
}
CMD:stopspec(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(Spectating[playerid] == -1) return ErrorMessage(playerid, "You are not spectating anyone!");
new msg[124];
new playerb = Spectating[playerid];
TogglePlayerSpectating(playerid, 0);
SetPlayerInterior(playerid,SpecInt[playerid]);
SetPlayerVirtualWorld(playerid,SpecVW[playerid]);
format(msg,sizeof(msg),"%s {%d} is no longer spectating %s {%d}.",RPN(playerid,0),playerid,RPN(playerb,0),playerb);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] != 0)
	{
		if(InformSpec[i][playerid] == 1) InfoMessage(i,msg);
	}
}
return 1;
}
CMD:editfac(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
new facid,input[60];
if(isnull(params)) {UsageMessage(playerid, "/editfac [option] [facid]"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: name | type | badges"); return 1;}
if(!strcmp(params, "name", true, 4))
{
	if(sscanf(params, "s[32]is[20]",params,facid,input)) return UsageMessage(playerid, "/editfac name (faction) (name)");
	format(FactionInfo[facid][Name],120,input);
	new string[124];
	format(string,sizeof(string),"Faction name set to '%s'.",input);
	InfoMessage(playerid, string);
}
else if(!strcmp(params, "type", true, 4))
{
	if(sscanf(params, "s[32]is[20]",params,facid,input)) {UsageMessage(playerid, "/editfac type (faction) (type)"); SendClientMessage(playerid,-1,"{989898}1 = LEO, 2 = Criminal, 3 = Legal"); return 1;}
	FactionInfo[facid][Type] = strval(input);
	new string[124];
	format(string,sizeof(string),"Faction type set to %s.",input);
	InfoMessage(playerid, string);
}
else if(!strcmp(params, "badges", true, 6))
{
	if(sscanf(params, "s[32]is[20]",params,facid,input)) return UsageMessage(playerid, "/editfac badges (faction) (1 = YES | 0 = NO)");
	FactionInfo[facid][Badges] = strval(input);
	new string[124];
	format(string,sizeof(string),"Faction badges set to %s.",input);
	InfoMessage(playerid, string);
}
return 1;
}

CMD:editlocker(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
new facid,input[60];
if(isnull(params)) {UsageMessage(playerid, "/editlocker [option] [faction]"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: name | pos | delete"); return 1;}
if(!strcmp(params, "name", true, 4))
{
	if(sscanf(params, "s[32]is[20]",params,facid,input)) return UsageMessage(playerid, "/editlocker name (faction) (name)");
	format(FactionInfo[facid][LockerName],120,input);
	new string[124];
	format(string,sizeof(string),"Faction locker name set to '%s'.",input);
	InfoMessage(playerid, string);
	Delete3DTextLabel(FactionInfo[facid][Lockers]);
	format(string,sizeof(string),"%s\n{FFFFFF}/lockers",FactionInfo[facid][LockerName]);
	FactionInfo[facid][Lockers] = Create3DTextLabel(string, 0x008080FF, FactionInfo[facid][LockerX], FactionInfo[facid][LockerY], FactionInfo[facid][LockerZ], 10.0, 0, 1);
}
else if(!strcmp(params, "pos", true, 3))
{
	if(sscanf(params, "s[32]i",params,facid)) return UsageMessage(playerid, "/editlocker pos (faction)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	FactionInfo[facid][LockerX] = x;
	FactionInfo[facid][LockerY] = y;
	FactionInfo[facid][LockerZ] = z;
	FactionInfo[facid][LockerVW] = GetPlayerVirtualWorld(playerid);
	new string[124];
	format(string,sizeof(string),"Faction locker position set.");
	InfoMessage(playerid, string);
	Delete3DTextLabel(FactionInfo[facid][Lockers]);
	format(string,sizeof(string),"%s\n{FFFFFF}/lockers",FactionInfo[facid][LockerName]);
	FactionInfo[facid][Lockers] = Create3DTextLabel(string, 0x008080FF, FactionInfo[facid][LockerX], FactionInfo[facid][LockerY], FactionInfo[facid][LockerZ], 10.0, 0, 1);
}
else if(!strcmp(params, "delete", true, 6))
{
	if(sscanf(params, "s[32]i",params,facid)) return UsageMessage(playerid, "/editlocker delete (faction)");
	FactionInfo[facid][LockerX] = 0;
	FactionInfo[facid][LockerY] = 0;
	FactionInfo[facid][LockerZ] = 0;
	FactionInfo[facid][LockerVW] = 0;
	new string[124];
	format(string,sizeof(string),"Faction locker deleted.");
	InfoMessage(playerid, string);
	Delete3DTextLabel(FactionInfo[facid][Lockers]);
}
return 1;
}

CMD:factions(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new string[164];
for(new i = 1; i < MAX_FACTIONS; i++)
{
	format(string,sizeof(string),"ID%d | %s",i,FactionInfo[i][Name]);
	SendClientMessage(playerid,-1,string);
}
return 1;
}
CMD:takeweapons(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb, string[128];
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/takeweapons (ID/name)");
HasWeapon[playerb] = 0;
ResetPlayerWeapons(playerb);
format(string, sizeof(string), "%s has taken %s's weapons.", RPN(playerid,0), RPN(playerb,0));
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:createoptable(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new Float:x,Float:y,Float:z,string[128],picked,table;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_OPTABLES; i++)
{
	if(picked != 1)
	{
		if(OTableInfo[i][OTX] == 0)
		{
		    table = i;
		    picked = 1;
		}
	}
	
}
OTableInfo[table][OTX] = x;
OTableInfo[table][OTY] = y;
OTableInfo[table][OTZ] = z;
format(string, sizeof(string), "%s has created a operation table (ID%d).", RPN(playerid,0), table);
OTableInfo[table][OTable] = Create3DTextLabel("/operate", -1, OTableInfo[table][OTX], OTableInfo[table][OTY], OTableInfo[table][OTZ], 10.0, 0, 1);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
new query[245];
format(query,sizeof(query),"INSERT INTO `optables` (ID) VALUES ('%d')",table);
mysql_query(connection,query);
return 1;
}
CMD:deleteoptable(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
new table,string[124];
if(sscanf(params,"d",table)) return UsageMessage(playerid, "/deleteoptable (tableid)");
if(OTableInfo[table][OTX] == 0) return ErrorMessage(playerid, "That table doesn't exist!");
Delete3DTextLabel(OTableInfo[table][OTable]);
OTableInfo[table][OTX] = 0;
OTableInfo[table][OTY] = 0;
OTableInfo[table][OTZ] = 0;
InfoMessage(playerid,"Table successfully deleted.");
format(string, sizeof(string), "%s has deleted a operation table (ID%d).", RPN(playerid,0), table);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:opnear(playerid)
{
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(ClosestOTable(playerid) == 0) return ErrorMessage(playerid, "You are not near any operation table!");
new msg[164];
format(msg,sizeof(msg),"Closest OP Table: %d",ClosestOTable(playerid));
InfoMessage(playerid,msg);
return 1;
}
CMD:getinveh(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new vehid;
if(sscanf(params,"d",vehid)) return UsageMessage(playerid, "/getinveh (vehID)");
if(DVehicles[vehid][dModel] == 0) return ErrorMessage(playerid, "Invalid vehicle ID.");
PutPlayerInVehicle(playerid,vehid,0);
return 1;
}
CMD:giveweapon(playerid, params[])
{
new playerb, weapon,ammo, string[128],gunname[60];
if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params,"uii",playerb,weapon,ammo)) return UsageMessage(playerid, "/giveweapon (ID/name) (weaponid) (ammo)");
if(GetPlayerWeapon(playerb) != 0) return ErrorMessage(playerid, "That player has a weapon in hand!");
HasWeapon[playerb] = 1;
GivePlayerWeapon(playerb,weapon,ammo);
GetWeaponName(weapon,gunname,60);
format(string, sizeof(string), "%s has gave %s a %s with %d ammo.", RPN(playerid,0),RPN(playerb,0),gunname,ammo);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:setminutes(playerid, params[])
{
new playerb, mins, string[128];
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params,"ui",playerb,mins)) return UsageMessage(playerid, "/setminutes (ID/name) (minutes)");
if(mins < 0 || 60 > mins) return ErrorMessage(playerid, "The command ranges from 0 to 60.");
PlayerInfo[playerb][pMinutes] = mins;
format(string, sizeof(string), "%s has set %s's minutes to %d.", RPN(playerid,0), RPN(playerb,0), mins);
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
PlayerTimeMinutes(playerb);
AdminLog(string);
return 1;
}
CMD:changename(playerid, params[])
{
new playerb, name[60];
if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params,"us[60]",playerb,name)) return UsageMessage(playerid, "/changename (ID/name) (name)");
new Query[80];
format(Query,sizeof(Query),"SELECT * FROM `users` WHERE `username` = '%s'",name);
mysql_tquery(connection,Query,"OnPlayerNameChange","isi",playerid,name,playerb);
return 1;
}

forward OnPlayerNameChange(playerid,name[60],playerb);
public OnPlayerNameChange(playerid,name[60],playerb)
{
	new rows,string[164];
	cache_get_row_count(rows);
	if(rows) return ErrorMessage(playerid,"That name is already in use.");
	format(string, sizeof(string), "UPDATE `users` SET `username` = '%s' WHERE `ID` = '%d'", name, PlayerInfo[playerb][pID]);
	mysql_query(connection, string);
	format(string, sizeof(string), "%s has changed %s's name to %s.", RPN(playerid,0), RPN(playerb,0), name);
	format(PlayerInfo[playerb][pRealName],MAX_PLAYER_NAME,"%s",name);
	SetPlayerName(playerb, PlayerInfo[playerb][pRealName]);
	Delete3DTextLabel(label[playerb]);
	label[playerb] = Create3DTextLabel(RPN(playerb,1), -1, 30.0, 40.0, 50.0, 4.0, 0);
	Attach3DTextLabelToPlayer(label[playerb], playerb, 0.0, 0.0, 0.15);
	if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
	AdminLog(string);
	return 1;
}

CMD:setgender(playerid, params[])
{
new playerb, gender, string[128];
if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params,"ui",playerb,gender)) return UsageMessage(playerid, "/setgender (ID/name) (1 = Male | 2 = Female)");
PlayerInfo[playerb][pGender] = gender;
if(gender == 1) format(string, sizeof(string), "%s has set %s's gender to Male.", RPN(playerid,0), RPN(playerb,0));
if(gender == 2) format(string, sizeof(string), "%s has set %s's gender to Female.", RPN(playerid,0), RPN(playerb,0));
if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
AdminLog(string);
return 1;
}
CMD:revive(playerid, params[])
{
	new playerb, string[128];
	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/revive (ID/name)");
	PlayerInfo[playerb][pDeathTime] = -1;
	TogglePlayerControllable(playerb, 1);
	ClearAnimations(playerb);
	ApplyAnimation(playerb,"ON_LOOKERS","wave_loop",4.0,1,0,0,0,1);
	KillTimer(timerupdate[playerb]);
	PlayerTextDrawDestroy(playerb,DeathText[playerb]);
	PlayerTextDrawDestroy(playerb,DeathTextt[playerb]);
	Delete3DTextLabel(label[playerb]);
	label[playerb] = Create3DTextLabel(RPN(playerb,1), -1, 30.0, 40.0, 50.0, 4.0, 0);
	Attach3DTextLabelToPlayer(label[playerb], playerb, 0.0, 0.0, 0.15);
    format(string, sizeof(string), "%s has revived %s.", RPN(playerid,0), RPN(playerb,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
	return 1;
}
CMD:gotocords(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
new Float: x, Float: y, Float: z, in;
if(sscanf(params, "fffd", x, y, z, in)) return UsageMessage(playerid, "/gotocords (PosX) (PosY) (PosZ) (Int)");
SetPlayerPos(playerid, x, y, z);
SetPlayerInterior(playerid, in);
return 1;
}
new oocstatus;
CMD:togooc(playerid, params[])
{
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(oocstatus == 0)
{
	oocstatus = 1;
	SendClientMessageToAll(-1, "OOC Chat has been disabled by an Admin.");
}
else if(oocstatus == 1)
{
	oocstatus = 0;
	SendClientMessageToAll(-1, "OOC Chat has been enabled by an Admin.");
}
return 1;
}
CMD:makeadmin(playerid, params[])
{
	new playerb, level, string[128], ltext[60];
	if(PlayerInfo[playerid][pAdmin] < 4 && !IsPlayerAdmin(playerid)) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"ui",playerb,level)) return UsageMessage(playerid, "/makeadmin (ID/name) (level)");
    if(level < 1 || level > 4) return ErrorMessage(playerid, "An admin level ranges from 1 to 4.");
	PlayerInfo[playerb][pAdmin] = level;
	PlayerInfo[playerb][pMod] = 0;
	if(level == 1) {ltext = "Junior Administrator";}
	if(level == 2) {ltext = "Standard Administrator";}
	if(level == 3) {ltext = "Senior Administrator";}
	if(level == 4) {ltext = "Management Member";}
    format(string, sizeof(string), "%s has made %s a %s.", RPN(playerid,0), RPN(playerb,0), ltext);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
	return 1;
}
CMD:makemod(playerid, params[])
{
	new playerb, level, string[128], ltext[60];
	if(PlayerInfo[playerid][pAdmin] < 4 && !IsPlayerAdmin(playerid)) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"ui",playerb,level)) return UsageMessage(playerid, "/makemod (ID/name) (level)");
    if(PlayerInfo[playerb][pAdmin] != 0) return ErrorMessage(playerid, "An Administrator can't be a moderator in the same time!");
    if(level < 1 || level > 3) return ErrorMessage(playerid, "A mod level ranges from 1 to 3.");
	PlayerInfo[playerb][pMod] = level;
	if(level == 1) {ltext = "Junior";}
	if(level == 2) {ltext = "Standard";}
	if(level == 3) {ltext = "Senior";}
    format(string, sizeof(string), "%s has made %s a %s Moderator.", RPN(playerid,0), RPN(playerb,0), ltext);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    if(AdminHideCmds[playerid] == 0)SendModMessage(COLOR_LIGHTRED, string);
    AdminLog(string);
	return 1;
}
CMD:takemod(playerid, params[])
{
	new playerb,string[128];
	if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/takemod (ID/name)");
    format(string, sizeof(string), "%s has removed %s from being a Moderator.", RPN(playerid,0), RPN(playerb,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    if(AdminHideCmds[playerid] == 0)SendModMessage(COLOR_LIGHTRED, string);
    PlayerInfo[playerb][pMod] = 0;
    AdminLog(string);
	return 1;
}
CMD:takeadmin(playerid, params[])
{
	new playerb, string[128];
	if(PlayerInfo[playerid][pAdmin] < 4) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/takeadmin (ID/name)");
    format(string, sizeof(string), "%s has removed %s from being an Administrator.", RPN(playerid,0), RPN(playerb,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    PlayerInfo[playerb][pAdmin] = 0;
    AdminLog(string);
	return 1;
}
CMD:sethours(playerid, params[])
{
	new playerb, level, string[128];
	if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"ui",playerb,level)) return UsageMessage(playerid, "/sethours (ID/name) (hours)");
	SetPlayerScore(playerb, level);
    format(string, sizeof(string), "%s has set %s's hours to %d.", RPN(playerid,0), RPN(playerb,0), level);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
	return 1;
}
CMD:agivelicense(playerid, params[])
{
	new playerb,type, string[128];
	if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"ud",playerb,type)) return UsageMessage(playerid, "/agivelicense (ID/name) (type)");
    new ttext[60];
    if(type == 1) {PlayerInfo[playerid][pDLicense] = 1; ttext = "Driving";}
    else if(type == 2) {PlayerInfo[playerid][pFLicense] = 1; ttext = "Flying";}
    format(string, sizeof(string), "%s has given %s a %s license.", RPN(playerid,0), RPN(playerb,0),ttext);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
	return 1;
}
CMD:atakelicense(playerid, params[])
{
	new playerb,type, string[128];
	if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params,"ud",playerb,type)) return UsageMessage(playerid, "/atakelicense (ID/name) (type)");
	new ttext[60];
    if(type == 1) {PlayerInfo[playerid][pDLicense] = 0; ttext = "Driving";}
    else if(type == 2) {PlayerInfo[playerid][pFLicense] = 0; ttext = "Flying";}
    format(string, sizeof(string), "%s has taken %s's %s license.", RPN(playerid,0), RPN(playerb,0),ttext);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
	return 1;
}
CMD:check(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new playerb;
if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/check (ID/name)");
new string[128], jobtext[60],mask[60], mins,gender[60],tester[60],plrIP[16];
GetPlayerIp(playerb, plrIP, sizeof(plrIP));
if (PlayerInfo[playerb][pJob] == 0){ jobtext = "None"; }
else if (PlayerInfo[playerb][pJob] == 1){ jobtext = "Delivery Guy"; }
else if (PlayerInfo[playerb][pJob] == 2){ jobtext = "Mechanic"; }
if (PlayerInfo[playerb][pMask] == 0){ mask = "No"; }
else if (PlayerInfo[playerb][pMask] == 1){ mask = "Yes"; }
if (PlayerInfo[playerb][pGender] == 1){ gender = "Male"; }
else if (PlayerInfo[playerb][pGender] == 2){ gender = "Female"; }
if (PlayerInfo[playerb][pBetaTester] == 1){ tester = "Yes"; }
else if (PlayerInfo[playerb][pBetaTester] == 2){ tester = "No"; }
mins = 60 - PlayerInfo[playerb][pMinutes];
SendClientMessage(playerid,-1, "{00FFEE}---------------------------------------------------------------------------------------------------------------------------------------");
format(string, sizeof(string), "{989898}[HP: %f] [Armor: %f] [IP: %s] [Tester: %s]",PlayerInfo[playerb][pHealth],PlayerInfo[playerb][pArmor],plrIP,tester);
SendClientMessage(playerid, -1, string);
format(string, sizeof(string), "{989898}[Name: %s] [Hours: %d] [Cash: $%d] [Bank: $%d] [Age: %d] [Gender: %s]", RPN(playerb,0), GetPlayerScore(playerb), GetPlayerMoney(playerb), PlayerInfo[playerb][pBMoney], PlayerInfo[playerb][pAge], gender);
SendClientMessage(playerid, -1, string);
format(string, sizeof(string), "{989898}[Job: %s] [Mask: %s] [Mask ID: %d] [Faction: %s] [Rank: %s] [Tier: %d]",jobtext, mask, PlayerInfo[playerb][pMaskID], FactionInfo[PlayerInfo[playerb][pFac]][Name], PlayerInfo[playerb][pFacRank], PlayerInfo[playerb][pTier]);
SendClientMessage(playerid, -1, string);
format(string, sizeof(string), "{989898}[Toolkits: %d] [Phone: %d] [Medikits: %d]", PlayerInfo[playerb][pToolkit], PlayerInfo[playerb][pPhone],PlayerInfo[playerb][pMedikit]);
SendClientMessage(playerid, -1, string);
format(string, sizeof(string), "His next paycheck will be in %d minutes.", mins);
SendClientMessage(playerid, COLOR_YELLOW, string);
SendClientMessage(playerid,-1, "{00FFEE}---------------------------------------------------------------------------------------------------------------------------------------");
return 1;
}

forward OnOCheck(playerid);
public OnOCheck(playerid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
	new vars[26],Float:hp,Float:ap,Float:x,Float:y,Float:z,name[30],gender[10],mask[5],jobtext[15],tester[5],gunname[20],dlic[5],flic[5],string[128],facrank[30];
	cache_get_value_name(0,"username",name);
	cache_get_value_name_int(0,"level",vars[0]);
	cache_get_value_name_int(0,"money",vars[1]);
	cache_get_value_name_float(0,"X",x);
	cache_get_value_name_float(0,"Y",y);
	cache_get_value_name_float(0,"Z",z);
	cache_get_value_name_int(0,"VW",vars[2]);
	cache_get_value_name_int(0,"Interior",vars[3]);
	cache_get_value_name_int(0,"Admin",vars[4]);
	cache_get_value_name_int(0,"Moderator",vars[5]);
	cache_get_value_name_float(0,"Health",hp);
	cache_get_value_name_float(0,"Armor",ap);
	cache_get_value_name_int(0,"Skin",vars[6]);
	cache_get_value_name_int(0,"Age",vars[7]);
	cache_get_value_name_int(0,"Gender",vars[8]);
	cache_get_value_name_int(0,"Bank",vars[9]);
	cache_get_value_name_int(0,"Faction",vars[10]);
	cache_get_value_name(0,"FacRank",facrank);
	cache_get_value_name_int(0,"Tier",vars[11]);
	cache_get_value_name_int(0,"Mask",vars[12]);
	cache_get_value_name_int(0,"MaskID",vars[13]);
	cache_get_value_name_int(0,"Phone",vars[14]);
	cache_get_value_name_int(0,"Job",vars[15]);
	cache_get_value_name_int(0,"DeathTime",vars[16]);
	cache_get_value_name_int(0,"Toolkits",vars[17]);
	cache_get_value_name_int(0,"Medikits",vars[18]);
	cache_get_value_name_int(0,"DLicense",vars[19]);
	cache_get_value_name_int(0,"FLicense",vars[20]);
	cache_get_value_name_int(0,"BetaTester",vars[21]);
	cache_get_value_name_int(0,"Gun",vars[22]);
	cache_get_value_name_int(0,"GunAmmo",vars[23]);
	cache_get_value_name_int(0,"PrisonTime",vars[24]);
	cache_get_value_name_int(0,"AJail",vars[25]);
	GetWeaponName(vars[22],gunname,sizeof(gunname));
	if (vars[15] == 0){ jobtext = "None"; }
	else if (vars[15] == 1){ jobtext = "Delivery Guy"; }
	else if (vars[15] == 2){ jobtext = "Mechanic"; }
	if (vars[19] == 0){ dlic = "No"; }
	else if (vars[19] == 1){ dlic = "Yes"; }
	if (vars[20] == 0){ flic = "No"; }
	else if (vars[20] == 1){ flic = "Yes"; }
	if (vars[12] == 0){ mask = "No"; }
	else if (vars[12] == 1){ mask = "Yes"; }
	if (vars[8] == 1){ gender = "Male"; }
	else if (vars[8] == 2){ gender = "Female"; }
	if (vars[21] == 1){ tester = "Yes"; }
	else if (vars[21] == 2){ tester = "No"; }
	SendClientMessage(playerid,-1, "{00FFEE}---------------------------------------------------------------------------------------------------------------------------------------");
	format(string, sizeof(string), "{989898}[HP: %f] [Armor: %f] [Tester: %s] [Admin: %d] [Moderator: %d]",hp,ap,tester,vars[4],vars[5]);
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "{989898}[Name: %s] [Hours: %d] [Cash: $%d] [Bank: $%d] [Age: %d] [Gender: %s]", name, vars[0], vars[1], vars[9], vars[7], gender);
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "{989898}[Job: %s] [Mask: %s] [Mask ID: %d] [Faction: %s] [Rank: %s] [Tier: %d]",jobtext, mask, vars[13], FactionInfo[vars[10]][Name], facrank, vars[11]);
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "{989898}[Toolkits: %d] [Phone: %d] [Medikits: %d] [Skin: %d] [DeathTime: %d]", vars[17], vars[14], vars[18], vars[6], vars[16]);
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "{989898}[AJail: %d] [Prison: %d] [Weapon: %s (%d)] [D Lic: %s] [F Lic: %s]", vars[25], vars[24], gunname, vars[23], dlic, flic);
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "{989898}[LastX: %f] [LastY: %f] [LastZ: %f] [VW: %d] [Interior: %d]", x, y, z, vars[2], vars[3]);
	SendClientMessage(playerid, -1, string);
	SendClientMessage(playerid,-1, "{00FFEE}---------------------------------------------------------------------------------------------------------------------------------------");
	return 1;
}
ErrorMessage(playerid,"Name not found.");
return 1;
}

CMD:ocheck(playerid,params[])
{
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new name[120];
if(sscanf(params,"s[120]",name)) return UsageMessage(playerid, "/ocheck (name)");
new Query[120];
format(Query,sizeof(Query),"SELECT * FROM `users` WHERE `username` = '%s' LIMIT 1;",name);
mysql_tquery(connection,Query,"OnOCheck","i",playerid);
return 1;
}
CMD:aduty(playerid)
{
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if (aduty[playerid] == 0)
{
	aduty[playerid] = 1;
	SendClientMessage(playerid, COLOR_LIGHTRED, "You have gone ON Administrator Duty.");
	SetPlayerColor(playerid, COLOR_ADUTY);
    adutylabl[playerid] = Create3DTextLabel("ADMIN (NOT HERE IN CHARACTER)", COLOR_ADUTY, 30.0, 40.0, 75.0, 20.0, 1);
    Attach3DTextLabelToPlayer(adutylabl[playerid], playerid, 0.0, 0.0, 0.25);
	return 1;
}
else
{
	aduty[playerid] = 0;
	SendClientMessage(playerid, COLOR_LIGHTRED, "You have gone OFF Administrator Duty.");
    Delete3DTextLabel(adutylabl[playerid]);
    SetPlayerColor(playerid, -1);
	return 1;
}
}
CMD:hduty(playerid)
{
if(PlayerInfo[playerid][pMod] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if (hduty[playerid] == 0)
{
	hduty[playerid] = 1;
	SendClientMessage(playerid, COLOR_LIGHTRED, "You have gone ON Moderator Duty.");
	SetPlayerColor(playerid, COLOR_HDUTY);
    hdutylabl[playerid] = Create3DTextLabel("MODERATOR (NOT HERE IN CHARACTER)", COLOR_HDUTY, 30.0, 40.0, 75.0, 20.0, 1);
    Attach3DTextLabelToPlayer(hdutylabl[playerid], playerid, 0.0, 0.0, 0.25);
	return 1;
}
else
{
	hduty[playerid] = 0;
	SendClientMessage(playerid, COLOR_LIGHTRED, "You have gone OFF Moderator Duty.");
    Delete3DTextLabel(hdutylabl[playerid]);
    SetPlayerColor(playerid, -1);
	return 1;
}
}
CMD:inviteac(playerid, params[])
{
	new playerb, string[128];
	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
	if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/inviteac (ID/name)");
	if(playerb == playerid) return ErrorMessage(playerid, "You can't invite yourself to a Admin Conversation!");
	format(string, sizeof(string), "You have invited %s to a admin conversation.", RPN(playerb,0));
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "%s has invited you to a admin conversation, use /ac to talk in it.", RPN(playerid,0));
	SendClientMessage(playerb, -1, string);
	ac[playerb] = 1;
	return 1;
}
CMD:uninviteac(playerid, params[])
{
	new playerb, string[128];
	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
	if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/uninviteac (ID/name)");
	if(playerb == playerid) return ErrorMessage(playerid, "You can't uninvite yourself from an Admin Conversation!");
	if(PlayerInfo[playerb][pAdmin] >= 1) return ErrorMessage(playerid, "You can't uninvite an admin from an Admin Conversation!");
	format(string, sizeof(string), "You have uninvited %s from the admin conversation.", RPN(playerb,0));
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "%s has uninvited you from the admin conversation.", RPN(playerid,0));
	SendClientMessage(playerb, -1, string);
	ac[playerb] = 0;
	return 1;
}
CMD:a(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "s[128]", string)) return UsageMessage(playerid,"/a (text)");
	format(string,sizeof(string),"(( {Admin Chat} %s: %s ))", RPN(playerid,0), params);
	SendAdminMessage(0xE67300FF,string);
	AdminLog(string);
	return 1;
}
CMD:bt(playerid, params[])
{
	if(PlayerInfo[playerid][pBetaTester] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "s[128]", params)) return UsageMessage(playerid,"/bt (text)");
	SendBetaTesterMessage(playerid,0x4B8C42FF,params);
	return 1;
}
CMD:c(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "s[128]", string)) return UsageMessage(playerid,"/c (text)");
	format(string,sizeof(string),"(( {Mod Chat} %s: %s ))", RPN(playerid,0), params);
	SendAdminMessage(0x249AC1FF,string);
	SendModMessage(0x249AC1FF,string);
	AdminLog(string);
	return 1;
}
CMD:ac(playerid, params[])
{
    new string[128];
    if(PlayerInfo[playerid][pAdmin] == 0 && ac[playerid] != 1) return ErrorMessage(playerid, "You are not in a Admin Conversation!");
    if(sscanf(params, "s[128]", string)) return UsageMessage(playerid,"/ac (text)");
	format(string,sizeof(string),"[Admin Conversation] %s: %s", RPN(playerid,0), params);
	SendAdminMessage(COLOR_ADUTY,string);
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, -1, string);
	AdminLog(string);
	return 1;
}
CMD:ao(playerid, params[])
{
new string[128];
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "s[128]", string))return UsageMessage(playerid, "/ao (text)");
format(string,sizeof(string),"{FFAF00}(( {Admin OOC} %s: %s ))", RPN(playerid,0), params);
SendClientMessageToAll(-1,string);
AdminLog(string);
return 1;
}
CMD:sethpall(playerid, params[])
{
	new amount, string[128];
    if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "i", amount)) return UsageMessage(playerid, "/sethpall (amount)");
    if(amount > 100) return ErrorMessage(playerid, "The amount cannot be higher than 100.");
    foreach(new i : Player)
    {
        if(IsLogged[i] == 1)
        {
                SetPHealth(i, amount);
        }
    }
    SendClientMessage(playerid, COLOR_WHITE, "Everyone's HP Successfully set.");
    format(string, sizeof(string), "%s has set everyone's HP to %d.", RPN(playerid,0), amount);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}
CMD:healnear(playerid, params[])
{
	new string[128];
 	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    foreach(new i : Player)
    {
        if(IsPlayerNearPlayer(playerid, i, 10))
        {
                SetPHealth(i, 100);
        }
    }
    format(string, sizeof(string), "%s has healed everyone near.", RPN(playerid,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}
CMD:givemoney(playerid, params[])
{
	new playerb, amount, string[128];
 	if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
  	if(sscanf(params, "ui", playerb, amount)) return UsageMessage(playerid, "/givemoney (playerid) (amount)");
    GivePMoney(playerb, amount);
    format(string, sizeof(string), " Administrator %s has gave you %d money", RPN(playerid,0), amount);
    SendClientMessage(playerb, COLOR_WHITE, string);
    format(string, sizeof(string), "%s has gave %s $%d.", RPN(playerid,0), RPN(playerb,0), amount);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}
CMD:freezenear(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    foreach(new i : Player)
    {
        if(IsPlayerNearPlayer(playerid, i, 10))
        {
            if(!IsPlayerAdmin(playerid))
                        TogglePlayerControllable(i, 0);
        }
    }
    format(string, sizeof(string), "%s has froze everyone near.", RPN(playerid,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}
CMD:unfreezenear(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    foreach(new i : Player)
    {
        if(IsPlayerNearPlayer(playerid, i, 10))
        {
                TogglePlayerControllable(i, 1);
        }
    }
    format(string, sizeof(string), "%s has unfroze everyone near.", RPN(playerid,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}
CMD:healall(playerid, params[])
{
	new amount, string[128];
    if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    foreach(new i : Player)
    {
        if(IsLogged[i] == 1)
        {
                SetPHealth(i, 100);
                SetPArmour(i, 100);
        }
    }
    format(string, sizeof(string), "%s has healed the HP & Armor for everyone.", RPN(playerid,0),  amount);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}

CMD:setarmorall(playerid, params[])
{
	new amount, string[128];
    if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "i", amount)) return UsageMessage(playerid, "/setarmorall (amount)");
    if(amount > 100) return ErrorMessage(playerid, "The amount cannot be higher than 100.");
    foreach(new i : Player)
    {
        if(IsLogged[i] == 1)
        {
                SetPArmour(i, amount);
        }
    }
    format(string, sizeof(string), "%s has set everybody's armor to %d.", RPN(playerid,0),  amount);
    if(AdminHideCmds[playerid] == 0) SendAdminWarnMessage(string);
    AdminLog(string);
    return 1;
}
CMD:sethp(playerid, params[])
{
	new playerb, amount, string[128];
 	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
  	if(sscanf(params, "ui", playerb, amount)) return UsageMessage(playerid, "/sethp (playerid) (amount)");
  	if(amount > 100) return ErrorMessage(playerid, "The amount cannot be higher than 100.");
    SetPHealth(playerb, amount);
    format(string, sizeof(string), " %s has set your health to %d", RPN(playerid,0), amount);
    SendClientMessage(playerb, COLOR_WHITE, string);
    format(string, sizeof(string), "%s has set %s's health to %d.", RPN(playerid,0), RPN(playerb,0), amount);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    if(AdminHideCmds[playerid] == 0)SendModMessage(COLOR_LIGHTRED, string);
    AdminLog(string);
    return 1;
}
CMD:setarmor(playerid, params[])
{
	new playerb, amount, string[128];
    if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "ui", playerb, amount)) return UsageMessage(playerid, "/setarmor (playerid) (amount)");
    if(amount > 100) return ErrorMessage(playerid, "The amount cannot be higher than 100.");
    SetPArmour(playerb, amount);
    format(string, sizeof(string), "%s has set %s's armor to %d.", RPN(playerid,0), RPN(playerb,0), amount);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    if(AdminHideCmds[playerid] == 0)SendModMessage(COLOR_LIGHTRED, string);
    AdminLog(string);
    return 1;
}
CMD:ann(playerid, params[])
{
	new string[128];
 	if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "s[128]", string)) return UsageMessage(playerid, "/ann (text)");
    format(string, sizeof(string), "%s", string);
    GameTextForAll(string, 10000, 5);
    format(string,sizeof(string), "%s has used the global announce command.", RPN(playerid,0));
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    return 1;
}
CMD:unfreeze(playerid, params[])
{
        new string[128], playerb;
        if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
        if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/unfreeze (playerid)");
        TogglePlayerControllable(playerb, 1);
        format(string, sizeof(string), "You have unfreezed %s.", RPN(playerb,0));
        InfoMessage(playerid, string);
        AdminLog(string);
        return 1;
}
CMD:freeze(playerid, params[])
{
        new string[128], playerb;
        if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
        if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/freeze (playerid)");
        TogglePlayerControllable(playerb, 0);
        format(string, sizeof(string), " You have freezed %s.", RPN(playerb,0));
        SendClientMessage(playerid, COLOR_WHITE, string);
        format(string, sizeof(string), " Administrator %s has freezed you.", RPN(playerid,0));
        SendClientMessage(playerb, COLOR_WHITE, string);
        AdminLog(string);
        return 1;
}
CMD:kick(playerid, params[])
{
    new playerb, string[128];
    if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "us[128]", playerb, params)) return UsageMessage(playerid, "/kick (playerid) (reason)");
    if(!IsPlayerConnected(playerb)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player id.");
    if(IsPlayerAdmin(playerb)) return SendClientMessage(playerid, COLOR_GREY, "You can't kick an admin");
    format(string, sizeof(string), "%s has been kicked by %s, reason: %s", RPN(playerb,0), RPN(playerid,0), params);
    SendClientMessageToAll(COLOR_LIGHTRED, string);
    KickB(playerb);
    AdminLog(string);
    return 1;
}
CMD:ban(playerid, params[])
{
    new playerb,reason[60];
    if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "us[60]", playerb, reason)) return UsageMessage(playerid, "/ban (playerid) (reason)");
    if(IsLogged[playerb] == 0) return SendClientMessage(playerid, COLOR_GREY, "Invalid player id.");
    if(IsPlayerAdmin(playerb)) return SendClientMessage(playerid, COLOR_GREY, "You can't ban an admin silly!");
    BanPlayer(playerb,playerid,reason);
    return 1;
}
CMD:unban(playerid, params[])
{
    new playerb[60],query[124];
    if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "s[60]", playerb)) return UsageMessage(playerid, "/unban (playername)");
    format(query,sizeof(query),"SELECT * FROM `users` WHERE `username` = '%s'",playerb);
    mysql_tquery(connection, query, "OnPlayerUnban", "i", playerid);
    return 1;
}

forward OnPlayerUnban(playerid);
public OnPlayerUnban(playerid)
{
	new rows,pid,banned,name[25];
	cache_get_row_count(rows);
	if(rows)
	{
		cache_get_value_name_int(0, "ID", pid);
		cache_get_value_name_int(0, "Banned", banned);
		cache_get_value_name(0, "username", name);
		if(banned == 0) return ErrorMessage(playerid,"That player isn't banned.");
		new query[164];
		format(query,sizeof(query),"UPDATE `users` SET `Banned` = '0', `Banner` = 'None', `Reason` = 'None' WHERE `ID` = '%d'",pid);
    	mysql_query(connection, query);
    	format(query,sizeof(query), "%s has unbanned %s's account.", RPN(playerid,0), NameWithoutUnderline(name));
    	if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(query);
    	InfoMessage(playerid,"Player unbanned successfully.");
    	return 1;
	}
	ErrorMessage(playerid,"Player not found.");
	return 1;
}
CMD:behindmask(playerid, params[])
{
new playerb, string[128];
if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "i", playerb)) return UsageMessage(playerid, "/behindmask (playerid)");
if(!IsPlayerConnected(playerb)) return ErrorMessage(playerid, "Invalid player id.");
if(PlayerInfo[playerb][pMask] == 0) return ErrorMessage(playerid, "That player doesn't have a mask.");
format(string, sizeof(string), "%d = %s", PlayerInfo[playerb][pMaskID], PlayerInfo[playerb][pRealName]);
SendClientMessage(playerid, -1, string);
return 1;
}
CMD:obehindmask(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(isnull(params)) return UsageMessage(playerid, "/obehindmask (player name)");
    new filename[MAX_PLAYER_NAME+18];
    format(filename, sizeof(filename), "/Users/%s.ini", params);
    if(!fexist(filename))return ErrorMessage(playerid, "That account doesn't exist!");
    new File:file = fopen(filename, io_read),
        string[128],
        TheName[20],
        Value[20],
        maskid;

    while(fread(file, string)) {
        if(!sscanf(string, "p<=>s[20]s[20]", TheName, Value))
		{
            if(!strcmp(TheName, "MaskID "))
			{
                maskid = strval(Value);
                break;
            }
        }
    }
    format(string, sizeof(string), "%d = %s", maskid, params);
    SendClientMessage(playerid, -1, string);
    return 1;
}
CMD:setskin(playerid, params[])
{
	new playerb, amount, string[128];
    if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    if(sscanf(params, "ui", playerb, amount)) return UsageMessage(playerid, "/setskin (playerid) (skinid)");
    SetPSkin(playerb, amount);
    format(string, sizeof(string), " Administrator %s has set your skin id to %d", RPN(playerid,0), amount);
    SendClientMessage(playerb, COLOR_WHITE, string);
    format(string, sizeof(string), "%s has set %s's skin id to %d.", RPN(playerid,0), RPN(playerb,0), amount);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    if(AdminHideCmds[playerid] == 0)SendModMessage(COLOR_LIGHTRED, string);
    AdminLog(string);
    return 1;
}

stock SetPSkin(playerid,skinid)
{
	PlayerInfo[playerid][pSkin] = skinid;
	SetPlayerSkin(playerid,skinid);
}

CMD:goto(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pMod] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
	new location[32], worked = 0, str[100], Float: x, Float: y, Float: z, world, interior;

	if( !sscanf(params, "s[32]", location) )
	{

		if( strcmp(location, "mafiahq", true) == 0 ) { worked = 1, x = 2802.1526, y = -1097.0723, z = -45.5658, world = 0, interior = 1; }
		else if( strcmp(location, "shedext", true) == 0 ) { worked = 1, x = -2794.9297, y = -1520.3019, z = 139.1708, world = 0, interior = 0; }
		else if( strcmp(location, "shedint", true) == 0 ) { worked = 1, x = -2825.9585, y = -1528.9202, z = -45.8510, world = 0, interior = 1; }
		else if( strcmp(location, "ap1st", true) == 0 ) { worked = 1, x = 1405.7031, y = -1160.5675, z = -89.4546, world = 0, interior = 1; }
		else if( strcmp(location, "warehouse", true) == 0 ) { worked = 1, x = 2428.0120, y = -2455.9058, z = 13.6277, world = 0, interior = 0; }
		else if( strcmp(location, "ganghq1", true) == 0 ) { worked = 1, x = 2153.0979, y = -1809.1134, z = 1627.6019, world = 0, interior = 1; }
		else if( strcmp(location, "spawn", true) == 0 ) { worked = 1, x = -1513.8988, y = 2523.1270, z = 55.6552, world = 0, interior = 0; }
		else if( strcmp(location, "sasmd", true) == 0 ) { worked = 1, x = 1374.324878, y = 394.925201, z = 3382.9, world = 0, interior = 1; }
		else if( strcmp(location, "prison", true) == 0 ) { worked = 1, x = -1206.6112, y = 1817.1830, z = 41.7188, world = 0, interior = 0; }
		if( worked )
		{
			format(str, 100, "You have been teleported to %s!", location);
			InfoMessage(playerid, str);
			SetPlayerInterior(playerid, interior);
			SetPlayerVirtualWorld(playerid, world);
			SetPlayerPos(playerid, x, y, z);
		}
		else
		{
			ErrorMessage(playerid,"This teleport doesn't exist.");
		}

	}
	else
	{
	    SendClientMessage(playerid, -1, "{00FFEE}-------------------------------------------------------------------------------------------------------------------");
		UsageMessage(playerid, "/goto (location)");
		SendClientMessage(playerid, -1, "{FFAF00}[LOC]{C3C3C3}: mafiahq | prison | shedext | shedint");
		SendClientMessage(playerid, -1, "{FFAF00}[LOC]{C3C3C3}: ap1st | warehouse | ganghq1 | spawn | sasmd");
	    SendClientMessage(playerid, -1, "{00FFEE}-------------------------------------------------------------------------------------------------------------------");
	}
	return 1;
}
CMD:gotoid(playerid, params[])
{
new playerb;
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/gotoid (id)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "Invalid player id.");
new Float:x, Float:y, Float:z;
GetPlayerPos(playerb, x, y, z);
SetPlayerInterior(playerid,GetPlayerInterior(playerb));
SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(playerb));
SetPlayerPos(playerid, x+1, y+1, z);
return 1;
}
CMD:gethere(playerid, params[])
{
new playerb;
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/gethere (id)");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "Invalid player id.");
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetPlayerInterior(playerb,GetPlayerInterior(playerid));
SetPlayerVirtualWorld(playerb,GetPlayerVirtualWorld(playerid));
SetPlayerPos(playerb, x+1, y+1, z);
return 1;
}
CMD:respawnall(playerid)
{
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
for(new oldfileid = 0; oldfileid < sizeof(DVehicles); oldfileid++)
    {
        if(DVehicles[oldfileid][dID] != 0) SetVehicleToRespawn(oldfileid);
    }
return 1;
}

CMD:editveh(playerid, params[])
{
new vehid,input;
if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(isnull(params)) {UsageMessage(playerid, "/editveh [option] [vehid]"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: faction | locked | rental | job | dmv | bulletproof | health | slots"); return 1;}
if(!strcmp(params, "faction", true, 7))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh faction (vehid) (faction)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vFaction] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "locked", true, 6))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh locked (vehid) (1 = YES, 0 = NO)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vLocked] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "rental", true, 6))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh rental (vehid) (1 = YES, 0 = NO)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vRental] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "job", true, 3))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh job (vehid) (jobid)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vJob] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "dmv", true, 3))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh dmv (vehid) (type)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vDMV] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "bulletproof", true, 11))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh bulletproof (vehid) (1 = YES | 0 = NO)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vBulletproof] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "health", true, 6))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh health (vehid) (health)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	SetVehicleHealth(vehid, input);
	DVehicles[vehid][vHealth] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
else if(!strcmp(params, "slots", true, 5))
{
	if(sscanf(params, "s[32]ii",params,vehid,input)) return UsageMessage(playerid, "/editveh slots (vehid) (slots)");
	if(DVehicles[vehid][dX] == 0) return ErrorMessage(playerid, "That vehicle does not exist!");
	DVehicles[vehid][vSlots] = input;
	InfoMessage(playerid, "Vehicle successfully updated.");
}
return 1;
}

CMD:createveh(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    new Float:X,Float:Y,Float:Z,fileid;
    GetPlayerPos(playerid, X,Y,Z);
    for(new b = 0; b < sizeof(DVehicles); b++) if(DVehicles[b][dModel] != 0) fileid = b+1;
    if(fileid > MAX_VEHICLES) return ErrorMessage(playerid, "Maximum amount of vehicles reached.");
    new model, color1, color2;
    if(sscanf(params, "iii", model, color1, color2)) return UsageMessage(playerid, "/createveh (Model ID) (Color1) (Color2)");
    fileid = CreateVehicle(411,0,0,0,0,0,0,0,0);
    DestroyVehicle(fileid);
    DVehicles[fileid][dModel] = model;
    DVehicles[fileid][dX] = X;
    DVehicles[fileid][dY] = Y;
    DVehicles[fileid][dZ] = Z;
    DVehicles[fileid][dColor1] = color1;
    DVehicles[fileid][dColor2] = color2;
    DVehicles[fileid][vHealth] = 1000;
    DVehicles[fileid][vFaction] = 0;
    DVehicles[fileid][vLocked] = 0;
    DVehicles[fileid][vRental] = 0;
    DVehicles[fileid][vRenter] = 1111;
    DVehicles[fileid][vFuel] = 100;
    DVehicles[fileid][vJob] = 0;
    DVehicles[fileid][vSlots] = 12;
    DVehicles[fileid][dID] = CreateVehicle(model, X,Y,Z,0, color1, color2, -1);
    new Query[240];
    format(Query,sizeof(Query),"INSERT INTO `vehicles` (vID,Model,X,Y,Z,Color1,Color2) VALUES ('%d','%d','%f','%f','%f','%d','%d')",fileid,model,X,Y,Z,color1,color2);
    mysql_query(connection,Query);
    new plate = randomEx(100000,999999);
	format(Query,sizeof(Query),"SELECT `Phone` FROM `users` WHERE `Phone` = '%d'",plate);
	mysql_tquery(connection,Query,"GetAvailablePlate","iiiii",1,DVehicles[fileid][dID],plate,playerid,fileid);
    return 1;
}

CMD:destroyveh(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
    new fileid;
    if(sscanf(params, "i", fileid)) return UsageMessage(playerid, "/destroyveh (VehID)");
    if(DVehicles[fileid][dX] == 0) return ErrorMessage(playerid, "That file does not exist!");
    for(new b = 0; b < MAX_PLAYERS; b++)
    {
        if(GetPlayerVehicleID(b) == fileid)
        {
            DestroyVehicleScreen(b);
        }
    }
    DestroyVehicle(DVehicles[fileid][dID]);
    DVehicles[fileid][dModel] = 0;
    DVehicles[fileid][dX] = 0.0;
    DVehicles[fileid][dY] = 0.0;
    DVehicles[fileid][dZ] = 0.0;
    DVehicles[fileid][dA] = 0.0;
    DVehicles[fileid][dColor1] = 0;
    DVehicles[fileid][dColor2] = 0;
    DVehicles[fileid][vFaction] = 0;
    DVehicles[fileid][vLocked] = 0;
    DVehicles[fileid][vRental] = 0;
    DVehicles[fileid][vOwner] = 0;
    DVehicles[fileid][vWindows] = 0;
    InfoMessage(playerid, "You have destroyed the vehicle.");
    new string[124];
    format(string, sizeof(string), "%s has deleted vehicle ID %d.", RPN(playerid,0), DVehicles[fileid][dID]);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    new query[245];
	format(query,sizeof(query),"DELETE FROM `vehicles` WHERE `vID` = '%d'",fileid);
	mysql_query(connection,query);
    return 1;
}
CMD:apark(playerid)
{
if(PlayerInfo[playerid][pAdmin] == 0) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You need to be in a vehicle to do this!");
new vehz = GetPlayerVehicleID(playerid);
new Float:X,Float:Y,Float:Z,Float:A;
GetVehicleZAngle(vehz, A);
GetPlayerPos(playerid, X,Y,Z);
DVehicles[vehz][dX] = X;
DVehicles[vehz][dY] = Y;
DVehicles[vehz][dZ] = Z;
DVehicles[vehz][dA] = A;
DestroyVehicle(vehz);
DVehicles[vehz][dID] = CreateVehicle(411, 0,0,0,0, 0, 0, -1);
DestroyVehicle(DVehicles[vehz][dID]);
SaveVehicle(vehz);
new Query[120];
format(Query,sizeof(Query),"SELECT * FROM `vehicles` WHERE `vID` = '%d'",DVehicles[vehz][dID]);
mysql_tquery(connection,Query,"LoadVehicle","i",DVehicles[vehz][dID]);
RemovePlayerFromVehicle(playerid);
InfoMessage(playerid, "Vehicle successfully parked.");
return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
if(newkeys & KEY_YES)
{
        return cmd_gate(playerid);
}
return 1;
}
CMD:checkdrugs(playerid,params[])
{
new playerb;
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(!IsPlayerConnected(playerb)) return ErrorMessage(playerid, "Invalid player id.");
if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/checkdrugs (playerid)");
new string[164];
format(string,sizeof(string),"{989898}|__ %s's Drugs Inventory __|",RPN(playerb,0));
SendClientMessage(playerid,-1,string);
format(string,sizeof(string),"{989898}Cocaine: %d | Weed: %d | Seeds: %d",PlayerInfo[playerb][pCocaine],PlayerInfo[playerb][pWeed],PlayerInfo[playerb][pSeeds]);
SendClientMessage(playerid,-1,string);
return 1;
}

CMD:agivedrug(playerid,params[])
{
new playerb,amount,string[164],drug,drugs[60];
if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(!IsPlayerConnected(playerb)) return ErrorMessage(playerid, "Invalid player id.");
if(sscanf(params,"uii",playerb,drug,amount)) return UsageMessage(playerid, "/agivedrug (playerid) (drug) (amount)");
if(drug < 1 || drug > 3) ErrorMessage(playerid, "Invalid drug.");
if(drug == 1) {format(drugs,60,"Cocaine"); PlayerInfo[playerb][pCocaine] = PlayerInfo[playerb][pCocaine] + amount;}
else if(drug == 2) {format(drugs,60,"Weed"); PlayerInfo[playerb][pWeed] = PlayerInfo[playerb][pWeed] + amount;}
else if(drug == 3) {format(drugs,60,"Seeds"); PlayerInfo[playerb][pSeeds] = PlayerInfo[playerb][pSeeds] + amount;}
format(string,sizeof(string),"You have given %d grams of %s to %s.",amount,drugs,RPN(playerb,0));
InfoMessage(playerid,string);
return 1;
}
//=====================================================ADMIN==================================================================
//***************************************************FACTION******************************************************************
CMD:makeleader(playerid, params[])
{
	new playerb,facid, string[128];
	if(PlayerInfo[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not authorized to use this command.");
    if(sscanf(params,"ui",playerb,facid)) return UsageMessage(playerid,"/makeleader (ID/name) (faction)");
    if(IsLogged[playerid] == 0) return ErrorMessage(playerid, "That player is not logged in!");
    format(string, sizeof(string), "%s has made %s a faction leader of %s.", RPN(playerid,0), RPN(playerb,0),FactionInfo[facid][Name]);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    PlayerInfo[playerb][pFac] = facid;
    PlayerInfo[playerb][pTier] = 3;
	return 1;
}
CMD:facbank(playerid)
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
new facid = PlayerInfo[playerid][pFac];
if(PlayerInfo[playerid][pTier] <= 1 && FactionInfo[facid][FacDealer1] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer2] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer3] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid,"You are not authorized to use this command!");
new string[124];
format(string,sizeof(string),"The faction's bank balance is: $%d",FactionInfo[facid][Money]);
InfoMessage(playerid,string);
return 1;
}
CMD:facguninv(playerid)
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
new string[124];
new facid = PlayerInfo[playerid][pFac];
if(FactionInfo[facid][Type] != 2) return ErrorMessage(playerid,"Your faction isn't a illegal one.");
if(PlayerInfo[playerid][pTier] <= 1 && FactionInfo[facid][FacDealer1] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer2] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer3] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid,"You are not authorized to use this command!");
format(string,sizeof(string),"{989898}1|Kevlar: %d ($%d) | 2|Colt: %d ($%d) | 3|Deagle: %d ($%d) | 4|Shotgun: %d ($%d)",FactionInfo[facid][Weapon_Kevlar],WeaponKevlarPrice,FactionInfo[facid][Weapon_Colt],WeaponColtPrice,FactionInfo[facid][Weapon_Deagle],WeaponDeaglePrice,FactionInfo[facid][Weapon_Shotgun],WeaponShotgunPrice);
SendClientMessage(playerid,-1,string);
format(string,sizeof(string),"{989898}5|UZI: %d ($%d) | 6|Tec-9: %d ($%d) | 7|AK-47: %d ($%d) | 8|M4: %d ($%d)",FactionInfo[facid][Weapon_UZI],WeaponUZIPrice,FactionInfo[facid][Weapon_Tec],WeaponTecPrice,FactionInfo[facid][Weapon_AK],WeaponAKPrice,FactionInfo[facid][Weapon_M4],WeaponM4Price);
SendClientMessage(playerid,-1,string);
format(string,sizeof(string),"{989898}9|Sniper: %d ($%d)",FactionInfo[facid][Weapon_Sniper],WeaponSniperPrice);
SendClientMessage(playerid,-1,string);
return 1;
}

CMD:buyfacgun(playerid,params[])
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
new string[124],gun,weapon[60],price;
new facid = PlayerInfo[playerid][pFac];
if(FactionInfo[facid][Type] != 2) return ErrorMessage(playerid,"Your faction isn't a illegal one.");
if(PlayerInfo[playerid][pTier] <= 1 && FactionInfo[facid][FacDealer1] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer2] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer3] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid,"You are not authorized to use this command!");
if(sscanf(params,"i",gun)) {UsageMessage(playerid, "/buyfacgun (weapon)");SendClientMessage(playerid,-1,"{989898}Use /facguninv to see the weapon prices."); return 1;}
if(gun <= 0 || gun >= 10) return ErrorMessage(playerid,"The weapon ID ranges from 1 to 9.");
if(gun == 1) {format(weapon,60,"Kevlar"); price = WeaponKevlarPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_Kevlar] += 1;}
else if(gun == 2) {format(weapon,60,"Colt"); price = WeaponColtPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_Colt] += 1;}
else if(gun == 3) {format(weapon,60,"Desert Eagle"); price = WeaponDeaglePrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_Deagle] += 1;}
else if(gun == 4) {format(weapon,60,"Shotgun"); price = WeaponShotgunPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_Shotgun] += 1;}
else if(gun == 5) {format(weapon,60,"UZI"); price = WeaponUZIPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_UZI] += 1;}
else if(gun == 6) {format(weapon,60,"Tec-9"); price = WeaponTecPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_Tec] += 1;}
else if(gun == 7) {format(weapon,60,"AK-47"); price = WeaponAKPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_AK] += 1;}
else if(gun == 8) {format(weapon,60,"M4"); price = WeaponM4Price; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_M4] += 1;}
else if(gun == 9) {format(weapon,60,"Sniper"); price = WeaponSniperPrice; if(price > FactionInfo[facid][Money]) return ErrorMessage(playerid,"Your faction doesn't have that much money in it's bank."); FactionInfo[facid][Weapon_Sniper] += 1;}
FactionInfo[facid][Money] -= price;
format(string,sizeof(string),"One %s has been successfully added to the faction's inventory. ($%d)",weapon,price);
InfoMessage(playerid,string);
return 1;
}

CMD:sellfacgun(playerid,params[])
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
new gun,ammo,playerb;
new facid = PlayerInfo[playerid][pFac];
if(FactionInfo[facid][Type] != 2) return ErrorMessage(playerid,"Your faction isn't a illegal one.");
if(PlayerInfo[playerid][pTier] <= 1 && FactionInfo[facid][FacDealer1] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer2] != PlayerInfo[playerid][pID] && FactionInfo[facid][FacDealer3] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid,"You are not authorized to use this command!");
if(sscanf(params,"ii",playerb,gun)) {UsageMessage(playerid, "/sellfacgun (playerid) (weapon)");SendClientMessage(playerid,-1,"{989898}Use /facguninv to see the weapons available."); return 1;}
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(gun <= 0 || gun >= 10) return ErrorMessage(playerid,"The weapon ID ranges from 1 to 9.");
if(HasWeapon[playerid] != 0) return ErrorMessage(playerid,"You can't hold more than two weapons in your hands.");
if(gun == 1) {gun = 1; if(1 > FactionInfo[facid][Weapon_Kevlar]) return ErrorMessage(playerid,"Your faction doesn't have that much Kevlar in it's inventory."); FactionInfo[facid][Weapon_Kevlar] -= 1;}
else if(gun == 2) {gun = 22; ammo = WeaponColtAmmo; if(1 > FactionInfo[facid][Weapon_Colt]) return ErrorMessage(playerid,"Your faction doesn't have that much Colts in it's inventory."); FactionInfo[facid][Weapon_Colt] -= 1;}
else if(gun == 3) {gun = 24; ammo = WeaponDeagleAmmo; if(1 > FactionInfo[facid][Weapon_Deagle]) return ErrorMessage(playerid,"Your faction doesn't have that much Deagles in it's inventory."); FactionInfo[facid][Weapon_Deagle] -= 1;}
else if(gun == 4) {gun = 25; ammo = WeaponShotgunAmmo; if(1 > FactionInfo[facid][Weapon_Shotgun]) return ErrorMessage(playerid,"Your faction doesn't have that much Shotguns in it's inventory."); FactionInfo[facid][Weapon_Shotgun] -= 1;}
else if(gun == 5) {gun = 28; ammo = WeaponUZIAmmo; if(1 > FactionInfo[facid][Weapon_UZI]) return ErrorMessage(playerid,"Your faction doesn't have that much UZIs in it's inventory."); FactionInfo[facid][Weapon_UZI] -= 1;}
else if(gun == 6) {gun = 32; ammo = WeaponTecAmmo; if(1 > FactionInfo[facid][Weapon_Tec]) return ErrorMessage(playerid,"Your faction doesn't have that much Tecs in it's inventory."); FactionInfo[facid][Weapon_Tec] -= 1;}
else if(gun == 7) {gun = 30; ammo = WeaponAKAmmo; if(1 > FactionInfo[facid][Weapon_AK]) return ErrorMessage(playerid,"Your faction doesn't have that much AKs in it's inventory."); FactionInfo[facid][Weapon_AK] -= 1;}
else if(gun == 8) {gun = 31; ammo = WeaponM4Ammo; if(1 > FactionInfo[facid][Weapon_M4]) return ErrorMessage(playerid,"Your faction doesn't have that much M4s in it's inventory."); FactionInfo[facid][Weapon_M4] -= 1;}
else if(gun == 9) {gun = 34; ammo = WeaponSniperAmmo; if(1 > FactionInfo[facid][Weapon_Sniper]) return ErrorMessage(playerid,"Your faction doesn't have that much Snipers in it's inventory."); FactionInfo[facid][Weapon_Sniper] -= 1;}
new string[160], gunname[60];
if(gun == 1)
{
SetPArmour(playerb,100);
format(string, sizeof(string), "passes a Kevlar to %s.",RPN(playerb,1));
AmeMessage(playerid,string);
return 1;
}
GetWeaponName(gun, gunname, sizeof(gunname));
format(string, sizeof(string), "passes a %s to %s.",gunname,RPN(playerb,1));
AmeMessage(playerid,string);
HasWeapon[playerb] = 1;
GivePlayerWeapon(playerb,gun,ammo);
return 1;
}

CMD:makefacdealer(playerid,params[])
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
new facid = PlayerInfo[playerid][pFac];
if(FactionInfo[facid][Type] != 2) return ErrorMessage(playerid,"Your faction isn't a illegal one.");
if(PlayerInfo[playerid][pTier] != 3) return ErrorMessage(playerid,"You aren't authorized to use this command!");
new playerb,string[124];
if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/makefacdealer (playerid)");
if(!IsPlayerConnected(playerb)) return ErrorMessage(playerid, "Invalid player id.");
if(PlayerInfo[playerb][pFac] != PlayerInfo[playerid][pFac]) return ErrorMessage(playerid,"This player is not a part of your faction!");
if(FactionInfo[facid][FacDealer1] == PlayerInfo[playerb][pID] || FactionInfo[facid][FacDealer2] == PlayerInfo[playerb][pID] || FactionInfo[facid][FacDealer3] == PlayerInfo[playerb][pID]) return ErrorMessage(playerid,"That player is already a dealer!");
if(FactionInfo[facid][FacDealer1] == 0) FactionInfo[facid][FacDealer1] = PlayerInfo[playerb][pID];
else if(FactionInfo[facid][FacDealer2] == 0) FactionInfo[facid][FacDealer2] = PlayerInfo[playerb][pID];
else if(FactionInfo[facid][FacDealer3] == 0) FactionInfo[facid][FacDealer3] = PlayerInfo[playerb][pID];
else return ErrorMessage(playerid,"All dealer slots have been taken.");
format(string,sizeof(string),"%s is now a faction dealer.",RPN(playerb,0));
InfoMessage(playerid,string);
return 1;
}

CMD:removefacdealer(playerid,params[])
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
new facid = PlayerInfo[playerid][pFac];
if(FactionInfo[facid][Type] != 2) return ErrorMessage(playerid,"Your faction isn't a illegal one.");
if(PlayerInfo[playerid][pTier] != 3) return ErrorMessage(playerid,"You aren't authorized to use this command!");
new slot;
if(sscanf(params,"i",slot)) return UsageMessage(playerid, "/removefacdealer (slot)");
if(slot < 1 || slot > 3) return ErrorMessage(playerid,"Slots range from 1 to 3.");
if(slot == 1) FactionInfo[facid][FacDealer1] = 0;
else if(slot == 2) FactionInfo[facid][FacDealer2] = 0;
else if(slot == 3) FactionInfo[facid][FacDealer3] = 0;
InfoMessage(playerid,"Dealer removed successfully.");
return 1;
}

CMD:factiondealers(playerid)
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid,"You aren't a member of any faction!");
if(FactionInfo[PlayerInfo[playerid][pFac]][Type] != 2) return ErrorMessage(playerid,"Your faction isn't a illegal one.");
new query[90];
format(query,sizeof(query),"SELECT * FROM `users` WHERE `ID` = '%d' OR `ID` = '%d' OR `ID` = '%d'",FacDealer1,FacDealer2,FacDealer3);
mysql_tquery(connection,query,"CheckFacDealers","ii",playerid,PlayerInfo[playerid][pFac]);
return 1;
}

forward CheckFacDealers(playerid,facid);
public CheckFacDealers(playerid,facid)
{
new rows,name[3][20],string[126];
cache_get_row_count(rows);
if(rows)
{
    cache_get_value_name(0,"username",name[0]);
    cache_get_value_name(1,"username",name[1]);
    cache_get_value_name(2,"username",name[2]);
}
format(string,sizeof(string),"{989898}Dealer 1: %s",name[0]);
SendClientMessage(playerid,-1,string);
format(string,sizeof(string),"{989898}Dealer 2: %s",name[1]);
SendClientMessage(playerid,-1,string);
format(string,sizeof(string),"{989898}Dealer 3: %s",name[2]);
SendClientMessage(playerid,-1,string);
return 1;
}

CMD:invite(playerid, params[])
{
	new playerb, string[128];
	if(PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You are not authorized to use this command.");
    if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/invite (ID/name)");
    if(IsLogged[playerid] == 0) return ErrorMessage(playerid, "That player is not logged in!");
    if(PlayerInfo[playerb][pFac] != 0) return ErrorMessage(playerid, "That player is already in a faction!");
 	format(string, sizeof(string), "%s has been invited by %s", RPN(playerb,0), RPN(playerid,0));
	PlayerInfo[playerb][pFac] = PlayerInfo[playerid][pFac];
	format(PlayerInfo[playerb][pFacRank], 120, "New Member");
	PlayerInfo[playerb][pTier] = 1;
	SendFactionInfoMessage(PlayerInfo[playerid][pFac],string);
	return 1;
}

CMD:mdc(playerid)
{
	if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
	if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
	ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Digital Computer", "Search Name\nSearch Vehicle Plate\nSearch Address\nBOLOs", "Select", "Exit");
	return 1;
}
CMD:closebolo(playerid,params[])
{
	if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
	if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
	new temp,boloid;
	if(sscanf(params,"i",temp)) return UsageMessage(playerid, "/closebolo (ID)");
	for(new b = 0; b < MAX_BOLOS; b++)
	{
		if(BOLOAdd[b][BOLOID] == temp)
		{
			boloid = b;
			break;
		}
	}
	if(boloid == 0 || BOLOAdd[boloid][BOLOstatus] == 2) return ErrorMessage(playerid, "That BOLO is either already closed or non existant.");
	BOLOAdd[boloid][BOLOstatus] = 2;
	new query[280];
	format(query,sizeof(query),"UPDATE `bolos` SET `status` = '2' WHERE `ID` = '%d'",temp);
	mysql_query(connection, query);
	InfoMessage(playerid,"BOLO has been closed.");
	return 1;
}
CMD:reopenbolo(playerid,params[])
{
	if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
	if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
	new temp,boloid;
	if(sscanf(params,"i",temp)) return UsageMessage(playerid, "/reopenbolo (ID)");
	for(new b = 0; b < MAX_BOLOS; b++)
	{
		if(BOLOAdd[b][BOLOID] == temp)
		{
			boloid = b;
			break;
		}
	}
	if(boloid == 0 || BOLOAdd[boloid][BOLOstatus] == 2) return ErrorMessage(playerid, "That BOLO is either already open or non existant.");
	BOLOAdd[boloid][BOLOstatus] = 1;
	new query[280];
	format(query,sizeof(query),"UPDATE `bolos` SET `status` = '1' WHERE `ID` = '%d'",temp);
	mysql_query(connection, query);
	InfoMessage(playerid,"BOLO has been re-opened.");
	return 1;
}
CMD:uninvite(playerid, params[])
{
	new playerb, string[128];
	if(PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You are not authorized to use this command.");
    if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/uninvite (ID/name)");
    if(IsLogged[playerid] == 0) return ErrorMessage(playerid, "That player is not logged in!");
    if(PlayerInfo[playerb][pFac] != PlayerInfo[playerid][pFac]) return ErrorMessage(playerid, "That player is not in your faction!");
 	format(string, sizeof(string), "%s has been uninvited by %s", RPN(playerb,0), RPN(playerid,0));
	SendFactionInfoMessage(PlayerInfo[playerid][pFac],string);
	PlayerInfo[playerb][pFac] = 0;
	format(PlayerInfo[playerb][pFacRank], 120, "None");
	PlayerInfo[playerb][pTier] = 0;
	return 1;
}
CMD:leavefaction(playerid, params[])
{
	new string[128];
    if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid, "You are not in any faction!");
 	format(string, sizeof(string), "%s has left the faction.", RPN(playerid,0));
	SendFactionInfoMessage(PlayerInfo[playerid][pFac],string);
	PlayerInfo[playerid][pFac] = 0;
	format(PlayerInfo[playerid][pFacRank], 120, "None");
	PlayerInfo[playerid][pTier] = 0;
	return 1;
}
CMD:settier(playerid, params[])
{
	new playerb, tier, string[128];
	if(PlayerInfo[playerid][pTier] < 3) return ErrorMessage(playerid, "You are not authorized to use this command.");
    if(sscanf(params,"ud",playerb,tier)) return UsageMessage(playerid, "/settier (ID/name) (tier)");
    if(tier < 1 || tier > 3) return ErrorMessage(playerid, "The tiers are only between 1 and 3.");
    if(PlayerInfo[playerb][pFac] != PlayerInfo[playerid][pFac]) return ErrorMessage(playerid, "That player is not in your faction!");
 	format(string, sizeof(string), "%s has set %s's tier to %d.", RPN(playerid,0), RPN(playerb,0), tier);
	SendFactionInfoMessage(PlayerInfo[playerid][pFac],string);
	PlayerInfo[playerb][pTier] = tier;
	return 1;
}
CMD:setbadge(playerid, params[])
{
	new playerb, tier, string[128];
	if(PlayerInfo[playerid][pTier] < 2 || FactionInfo[PlayerInfo[playerid][pFac]][Badges] != 1) return ErrorMessage(playerid, "You are not authorized to use this command.");
    if(sscanf(params,"ud",playerb,tier)) return UsageMessage(playerid, "/setbadge (ID/name) (number)");
    if(PlayerInfo[playerb][pFac] != PlayerInfo[playerid][pFac]) return ErrorMessage(playerid, "That player is not in your faction!");
    if(tier > 999 || 1 > tier) return ErrorMessage(playerid, "A badge number can be between 1 and 999 only!");
    PlayerInfo[playerb][pBadge] = tier;
 	format(string, sizeof(string), "%s has set %s's badge number to %s.", RPN(playerid,0), RPN(playerb,0), BadgeNumber(playerb));
	SendFactionInfoMessage(PlayerInfo[playerid][pFac],string);
	return 1;
}
CMD:operate(playerid,params[])
{
new playerb,msg[126];
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/operate (ID/name)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(ClosestOTable(playerid) == 0) return ErrorMessage(playerid,"You are not near any operation table!");
if(playerb == playerid) return ErrorMessage(playerid, "You can't operate yourself!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(PlayerInfo[playerb][pDeathTime] == -1) return ErrorMessage(playerid, "That player is not heavily injured!");
format(msg,sizeof(msg),"has placed %s on the operation table.",RPN(playerb,1));
MeMessage(playerid,msg);
PlayerInfo[playerb][pDeathTime] = -1;
ClearAnimations(playerb);
KillTimer(timerupdate[playerb]);
PlayerTextDrawDestroy(playerb,DeathText[playerid]);
PlayerTextDrawDestroy(playerb,DeathTextt[playerid]);
Delete3DTextLabel(label[playerb]);
label[playerb] = Create3DTextLabel(RPN(playerb,1), -1, 30.0, 40.0, 50.0, 20.0, 1);
Attach3DTextLabelToPlayer(label[playerb], playerb, 0.0, 0.0, 0.15);
DeathText[playerid] = CreatePlayerTextDraw(playerb,400,28,"10");
PlayerTextDrawShow(playerb, DeathText[playerid]);
DeathTextt[playerid] = CreatePlayerTextDraw(playerb,355.000000,18.000000,"Operation Timer");
PlayerTextDrawShow(playerb, DeathTextt[playerid]);
BeingOperated[playerb] = 120;
return 1;
}
CMD:trace(playerid,params[])
{
if(PlayerInfo[playerid][pFac] != 1 && PlayerInfo[playerid][pDetective] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
if(PlayerInfo[playerid][pDuty] == 0 && PlayerInfo[playerid][pFac] == 1) return ErrorMessage(playerid, "You can't use this command while off duty!");
new number;
if(sscanf(params, "d", number)) return UsageMessage(playerid, "/trace (number)");
if(number == 0){
InfoMessage(playerid,"You have stopped tracing this number.");
Tracing[playerid] = -1;
DisablePlayerCheckpoint(playerid);
return 1;}
new playerb = GetIDFromNumber(number);
if(playerb == -1 || number == 911 || PhonePower[playerb] == 0) return ErrorMessage(playerid, "This number is not recognized.");
Tracing[playerid] = playerb;
new Float:x,Float:y,Float:z;
GetPlayerPos(playerb,x,y,z);
SetPlayerCheckpoint(playerid, x, y, z, 5.0);
return 1;
}
CMD:tapphone(playerid,params[])
{
if(PlayerInfo[playerid][pDetective] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
new number,string[164];
if(sscanf(params, "d", number)) return UsageMessage(playerid, "/tapphone (number)");
new playerb = GetIDFromNumber(number);
if(playerb == -1 || number == 911) return ErrorMessage(playerid, "This number is not recognized.");
TappingPhone[playerb][playerid] = 1;
format(string,sizeof(string),"Now tapping phone number %d.",number);
InfoMessage(playerid,string);
return 1;
}
CMD:acceptticket(playerid)
{
if(Ticketed[playerid] == -1) return ErrorMessage(playerid, "Nobody offered you a ticket!");
if(!IsPlayerNearPlayer(playerid,Ticketed[playerid],3)) return ErrorMessage(playerid, "You are not near the player that ticketed you!");
if(GetPlayerMoney(playerid) < TicketPrice[playerid]) return ErrorMessage(playerid, "You cannot afford that!");
GivePMoney(playerid,-TicketPrice[playerid]);
InfoMessage(playerid,"You have paid the ticket.");
new msg[164];
format(msg,sizeof(msg),"%s has paid the ticket of $%d.",RPN(playerid,1),TicketPrice[playerid]);
InfoMessage(Ticketed[playerid],msg);
TicketPrice[playerid] = 0;
Ticketed[playerid] = -1;
return 1;
}
CMD:ticket(playerid,params[])
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid,"You are not authorized to use this command.");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
new playerb,price,msg[164];
if(sscanf(params, "di", playerb,price)) return UsageMessage(playerid, "/ticket (ID/name) (price)");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
format(msg,sizeof(msg),"%s has offered you a ticket of $%d. Type /acceptticket to pay it.",RPN(playerid,1),price);
InfoMessage(playerb,msg);
format(msg,sizeof(msg),"You have offered a ticket of $%d to %s. Wait for them to accept it.",price,RPN(playerb,1));
InfoMessage(playerid,msg);
Ticketed[playerb] = playerid;
TicketPrice[playerb] = price;
return 1;
}
CMD:setrank(playerid, params[])
{
    if(PlayerInfo[playerid][pFac] == 0 ||  PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You are not a authorized to use this command!");
 	new targetid, rank[60], string[128];//establishes a player to use the command on, the rank you want to set, and some words to tell the players the actions used on them.
 	if(sscanf(params, "us[60]", targetid, rank)) return UsageMessage(playerid, "/setrank (playerid) (rank)");//checks if the command was typed correctly
 	if(IsLogged[playerid] == 0) return ErrorMessage(playerid, "That player is not logged in!");//if the player id typed is not connected it will state that to you.
 	if(PlayerInfo[targetid][pFac] != PlayerInfo[playerid][pFac]) return ErrorMessage(playerid, "That player is not in your faction!");//if the player is not in the same faction it will not let him set the rank.
	format(PlayerInfo[targetid][pFacRank], 120, rank);//sets the players rank to the rank you choose
 	format(string, sizeof(string), "%s's rank has been changed to %s by %s.", RPN(targetid,0), rank, RPN(playerid,0));
 	SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);//states that the players rank was changed
    return 1;
}
CMD:medikit(playerid,params[])
{
if(PlayerInfo[playerid][pMedikit] == 0 && PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You don't have any medikits!");
new playerb;
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/medikit (playerid)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(Patching[playerid] != -1) return ErrorMessage(playerid, "You are already patching up someone else!");
if(playerb == playerid) return ErrorMessage(playerid, "You can't medikit yourself!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(PlayerInfo[playerb][pDeathTime] == -1) return ErrorMessage(playerid, "That player is not heavily injured!");
new msg[126];
format(msg,sizeof(msg),"starts patching up %s with their medikit.",RPN(playerb,1));
MeMessage(playerid,msg);
Patching[playerid] = playerb;
TogglePlayerControllable(playerid,0);
return 1;
}
CMD:frespawnall(playerid)
{
if(PlayerInfo[playerid][pFac] == 0 || PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
for (new i = 1; i < sizeof DVehicles; i++)
{
	if (DVehicles[i][vFaction] == PlayerInfo[playerid][pFac])
 	{
	    SetVehicleToRespawn(i);
    }
}
new msg[124];
format(msg,sizeof(msg),"%s has respawned all faction vehicles.",RPN(playerid,0));
SendFactionInfoMessage(PlayerInfo[playerid][pFac],msg);
return 1;
}
CMD:fpark(playerid)
{
if(PlayerInfo[playerid][pFac] == 0 || PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You need to be in a vehicle to do this!");
new string[164],vehz = GetPlayerVehicleID(playerid);
if (DVehicles[vehz][vFaction] != PlayerInfo[playerid][pFac]) return ErrorMessage(playerid, "This is not your faction's vehicle!");
new Float:X,Float:Y,Float:Z,Float:A;
DVehicles[vehz][dY] = Y;
DVehicles[vehz][dZ] = Z;
DVehicles[vehz][dA] = A;
DestroyVehicle(vehz);
CreateVehicle(DVehicles[vehz][dModel], DVehicles[vehz][dX],DVehicles[vehz][dY],DVehicles[vehz][dZ],DVehicles[vehz][dA], DVehicles[vehz][dColor1], DVehicles[vehz][dColor2], -1);
SaveVehicle(vehz);
RemovePlayerFromVehicle(playerid);
format(string, sizeof(string), "%s has parked a faction %s (ID: %d)", RPN(playerid,0), GetVehicleName(vehz), vehz);
SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);//states that the players rank was changedGetVehicleZAngle(vehz, A);
GetPlayerPos(playerid, X,Y,Z);
DVehicles[vehz][dX] = X;

return 1;
}
CMD:togfac(playerid)
{
if(PlayerInfo[playerid][pFac] == 0 || PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You are not authorized to use this command!");
new string[164];
if(FactionInfo[PlayerInfo[playerid][pFac]][Chat] != 1) {format(string, sizeof(string), "%s has turned on the faction chat.", RPN(playerid,0)); FactionInfo[PlayerInfo[playerid][pFac]][Chat] = 1;}
else if(FactionInfo[PlayerInfo[playerid][pFac]][Chat] != 0) {format(string, sizeof(string), "%s has turned off the faction chat.", RPN(playerid,0)); FactionInfo[PlayerInfo[playerid][pFac]][Chat] = 0;}
SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);//states that the players rank was changed
return 1;
}
CMD:lockers(playerid)
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid, "You are not a authorized to use this command!");
new facid = PlayerInfo[playerid][pFac];
if(!IsPlayerInRangeOfPoint(playerid, 3.0, FactionInfo[facid][LockerX],FactionInfo[facid][LockerY],FactionInfo[facid][LockerZ])) return ErrorMessage(playerid, "You are not near the lockers!");
new string[60];
format(string,sizeof(string),"%s Lockers",FactionInfo[PlayerInfo[playerid][pFac]][Name]);
ShowPlayerDialog(playerid, DIALOG_EQSD_LOCKERS, DIALOG_STYLE_LIST, string, "Duty\nFirst Aid\nKevlar\nPepper Spray\nDeagle\nShotgun\nM4\nSniper Rifle\nCombat Shotgun\nMP5", "Select", "Exit");
return 1;
}
CMD:gate(playerid)
{
if(IsPlayerInRangeOfPoint(playerid,10,-1415.08,2638.8,55.5)) return GATE_1(playerid);
else if(IsPlayerInRangeOfPoint(playerid,4,1370.40295,389.31790,3383.99878)) return GATE_2(playerid);
else if(IsPlayerInRangeOfPoint(playerid,2,1935.625122,-2262.674072,13.822796) && GetPlayerInterior(playerid) == 1 && GetPlayerVirtualWorld(playerid) == 2) return GATE_3(playerid);
else if(IsPlayerInRangeOfPoint(playerid,2,1939.767944,-2262.684814,13.822796) && GetPlayerInterior(playerid) == 1 && GetPlayerVirtualWorld(playerid) == 2) return GATE_4(playerid);
else if(IsPlayerInRangeOfPoint(playerid,12,-1196.739257,1838.392700,41.559131) && GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0) return GATE_5(playerid);
else if(IsPlayerInRangeOfPoint(playerid,3,1942.059204,-2241.208007,14.872814) && GetPlayerInterior(playerid) == 1 && GetPlayerVirtualWorld(playerid) == 3) return GATE_6(playerid);
else if(IsPlayerInRangeOfPoint(playerid,2,1957.269409,-2274.750244,13.822794) && GetPlayerInterior(playerid) == 1 && GetPlayerVirtualWorld(playerid) == 2) return GATE_7(playerid);
return 1;
}
CMD:factionhelp(playerid, params[])
{
if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(FactionInfo[PlayerInfo[playerid][pFac]][Type] == 1){
SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 1] /badge /f /r /d /lockers /takelicense /cuff /uncuff /prisoners");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 1] /tazer /release /arrest /ticket /m(egaphone) /trace /gate");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 1] /medikit /operate /mdc");
if(PlayerInfo[playerid][pTier] < 2) return SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 2] /setrank /invite /togfac /uninvite /setbadge /gov /fpark");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 2] /frespawnall /closebolo /reopenbolo");
if(PlayerInfo[playerid][pTier] < 3) return SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 3] /settier");
SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
return 1;}
if(FactionInfo[PlayerInfo[playerid][pFac]][Type] == 2){
SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 1] /f /r /gate /factiondealers");
if(PlayerInfo[playerid][pTier] < 2) return SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 2] /setrank /invite /togfac /uninvite /fpark /frespawnall");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 2] /facbank");
if(PlayerInfo[playerid][pTier] < 3) return SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
SendClientMessage(playerid,-1, "{A7A7A7}[Tier 3] /settier /makefacdealer /removefacdealer");
SendClientMessage(playerid, -1, "{00FFEE}----------------------------------------------------------------------------------------------");
return 1;}
SendClientMessage(playerid,-1, "{A7A7A7} Not made /factionhelp for Legal Factions.");
return 1;
}
CMD:takelicense(playerid, params[])
{
	new playerb,type, string[128];
	if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
	if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
    if(sscanf(params,"id",playerb,type)) return UsageMessage(playerid, "/takelicense (ID/name) (type)");
    playerb = GetPlayerIDFromMask(playerb);
	if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
    if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
    new ttext[60];
    if(type == 1) {PlayerInfo[playerb][pDLicense] = 0; ttext = "Driving";}
    else if(type == 2) {PlayerInfo[playerb][pFLicense] = 0; ttext = "Flying";}
	format(string,sizeof(string),"You have taken %s's %s license.", RPN(playerb,1),ttext);
	InfoMessage(playerid,string);
	format(string,sizeof(string),"%s has taken your %s license.", RPN(playerid,1),ttext);
	InfoMessage(playerid,string);
	return 1;
}
CMD:gov(playerid, params[])
{
if(PlayerInfo[playerid][pFac] == 0 || PlayerInfo[playerid][pTier] < 2 || FactionInfo[PlayerInfo[playerid][pFac]][Type] != 1) return ErrorMessage(playerid, "You are not authorized to use this command!");
new string[146], text[128];
if(sscanf(params, "s[128]", text)) return UsageMessage(playerid, "/gov (message)");
format(string,sizeof(string),"{50DAF2}[%s] %s",FactionInfo[PlayerInfo[playerid][pFac]][Name],text);
SendClientMessageToAll(-1, string);
return 1;
}
CMD:cuff(playerid, params[])
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
new playerb;
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/cuff (ID/name)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(playerb == playerid) return ErrorMessage(playerid, "You can't cuff yourself!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
SetPlayerSpecialAction(playerb,SPECIAL_ACTION_CUFFED);
AmeMessage(playerb, "has been cuffed.");
return 1;
}
CMD:bullets(playerid, params[])
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
if(HasWeapon[playerid] == 0) return ErrorMessage(playerid, "You aren't holding a weapon!");
if(RubberBullets[playerid] == 0){InfoMessage(playerid,"You have switched to rubber bullets."); RubberBullets[playerid] = 1;}
else if(RubberBullets[playerid] == 1){InfoMessage(playerid,"You have switched to real bullets."); RubberBullets[playerid] = 0;}
return 1;
}
CMD:arrest(playerid, params[])
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
if(PlayerInfo[playerid][InPrison] != 1) return ErrorMessage(playerid, "You must be inside the prison to use this command!");
new playerb,time,msg[164];
if(sscanf(params,"ii",playerb,time)) return UsageMessage(playerid, "/arrest (playerid) (minutes)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(playerb == playerid) return ErrorMessage(playerid, "You can't arrest yourself!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
PlayerInfo[playerb][pPrisonTime] = time;
PlayerInfo[playerb][pReleased] = 0;
format(msg,sizeof(msg),"You have successfully arrested %s. (Minutes: %d)",RPN(playerb,1),time);
InfoMessage(playerid,msg);
SendClientMessage(playerb,-1, "{00FFEE}---------------------------------------------------------------------------------------------------------------------------------------");
format(msg,sizeof(msg),"{989898}You have been arrested by [%s] %s %s for %d minutes.",BadgeNumber(playerid),PlayerInfo[playerid][pFacRank],RPN(playerid,1),time);
SendClientMessage(playerb,-1, msg);
SendClientMessage(playerb,-1, "{00FFEE}---------------------------------------------------------------------------------------------------------------------------------------");
format(msg,sizeof(msg),"[%s] %s %s has arrested %s for %d minutes.",BadgeNumber(playerid),PlayerInfo[playerid][pFacRank],RPN(playerid,0),RPN(playerb,0),time);
SendTierFacMessage(PlayerInfo[playerid][pFac],msg);
return 1;
}
CMD:prisontime(playerid)
{
if(PlayerInfo[playerid][pPrisonTime] == -1) return ErrorMessage(playerid, "You are not serving time in prison!");
new msg[164];
format(msg,sizeof(msg),"You are in prison for %d more minutes.",PlayerInfo[playerid][pPrisonTime]);
InfoMessage(playerid,msg);
return 1;
}
CMD:prisoners(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
new msg[164];
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] == 1 && PlayerInfo[i][pPrisonTime] != -1)
	{
	    format(msg,sizeof(msg),"%s | %d minutes",RPN(i,0),PlayerInfo[i][pPrisonTime]);
		SendClientMessage(i, -1, msg);
	}
}
return 1;
}
CMD:release(playerid, params[])
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
new playerb,msg[164];
if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/release (playerid)");
if(playerb == playerid) return ErrorMessage(playerid, "You can't release yourself!");
if(PlayerInfo[playerb][pPrisonTime] == 0) return ErrorMessage(playerid, "That player is not arrested!");
PlayerInfo[playerb][pPrisonTime] = -1;
PlayerInfo[playerb][pReleased] = 1;
format(msg,sizeof(msg),"You have successfully released %s.",RPN(playerb,1));
InfoMessage(playerid,msg);
format(msg,sizeof(msg),"[%s] %s %s has released %s from prison.",BadgeNumber(playerid),PlayerInfo[playerid][pFacRank],RPN(playerid,0),RPN(playerb,0));
SendTierFacMessage(PlayerInfo[playerid][pFac],msg);
return 1;
}
CMD:uncuff(playerid, params[])
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
new playerb;
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/uncuff (ID/name)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(playerb == playerid) return ErrorMessage(playerid, "You can't uncuff yourself!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(!SetPlayerAttachedObject(playerb, 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000))return ErrorMessage(playerid,"That player is not cuffed!");
SetPlayerSpecialAction(playerb,SPECIAL_ACTION_NONE);
RemovePlayerAttachedObject(playerb, 0);
AmeMessage(playerb, "has been uncuffed.");
return 1;
}
CMD:badge(playerid, params[])
{
new targetid;
if(PlayerInfo[playerid][pFac] == 0 || FactionInfo[PlayerInfo[playerid][pFac]][Type] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(sscanf(params, "u", targetid)) return UsageMessage(playerid, "/badge (playerid)");
if(!IsPlayerNearPlayer(playerid,targetid,3)) return ErrorMessage(playerid, "You are not near that player!");
new string[164];
format(string, sizeof(string), "shows their badge to %s.", RPN(targetid,1));
MeMessage(playerid, string);
SendClientMessage(targetid, -1, "{4DB3C5}|__________Badge__________|");
format(string, sizeof(string), "[Name] %s", RPN(playerid,0));
SendClientMessage(targetid, -1, string);
format(string, sizeof(string), "[Rank] %s", PlayerInfo[playerid][pFacRank]);
SendClientMessage(targetid, -1, string);
format(string, sizeof(string), "[Badge Num] %s", BadgeNumber(playerid));
if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 1) SendClientMessage(targetid, -1, string);
return 1;
}
CMD:f(playerid, params[])
{
    if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid, "You are not a authorized to use this command!");
    if(FactionInfo[PlayerInfo[playerid][pFac]][Chat] != 1) return ErrorMessage(playerid,"The faction chat is toggled off!");
	new string[128], text[128];
    if(sscanf(params, "s[128]", text)) return UsageMessage(playerid, "/f (message)");
    if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 1) format(string, sizeof(string), "{50DAF2}{ [ID%d] [%s] %s %s: %s }",playerid,BadgeNumber(playerid), PlayerInfo[playerid][pFacRank], RPN(playerid,0), text);
	else if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 0) format(string, sizeof(string), "{50DAF2}{ [ID%d] %s %s: %s }",playerid,PlayerInfo[playerid][pFacRank], RPN(playerid,0), text);
	SendFactionMessage(PlayerInfo[playerid][pFac],0x50DAF2FF, string);
	return 1;
}
CMD:r(playerid, params[]) return cmd_radio(playerid, params);
CMD:radio(playerid, params[])
{
    new string[128], text[128];
    if(PlayerInfo[playerid][pFac] == 0) return ErrorMessage(playerid, "You are not a authorized to use this command!");
    if(PlayerInfo[playerid][pDuty] == 0 && PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You can't use this command while off duty!");
    if(sscanf(params, "s[128]", text)) return UsageMessage(playerid, "/r(adio) (message)");
    if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 1) format(string, sizeof(string), "* (Radio) [%s] %s %s: %s *",BadgeNumber(playerid), PlayerInfo[playerid][pFacRank], RPN(playerid,1), text);
    else if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 0) format(string, sizeof(string), "* (Radio) %s %s: %s *",PlayerInfo[playerid][pFacRank], RPN(playerid,1), text);
	SendFactionMessage(PlayerInfo[playerid][pFac],COLOR_PDRAD, string);
	if(IsPlayerInAnyVehicle(playerid)){
	    if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
	    if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
		    format(string, sizeof(string), "(Windows Up) (Radio) %s says: %s", RPN(playerid,1), text);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
				{
					SendClientMessage(i, -1, string);
				}
			}
			return 1;}
		else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
        format(string, sizeof(string), "(Windows Down) (Radio) %s says: %s", RPN(playerid,1), text);
		ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
		return 1;}}
	}
    format(string, sizeof(string), "* (Radio) %s says: %s *", RPN(playerid,1), text);
	ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
    return 1;
}
CMD:d(playerid, params[])
{
    new string[128], text[128];
    if(PlayerInfo[playerid][pFac] == 0 || FactionInfo[PlayerInfo[playerid][pFac]][Type] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
    if(PlayerInfo[playerid][pDuty] == 0 && PlayerInfo[playerid][pTier] < 2) return ErrorMessage(playerid, "You can't use this command while off duty!");
    if(sscanf(params, "s[128]", text)) return UsageMessage(playerid, "/d (message)");
    if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 1) format(string, sizeof(string), "* (%s) [%s] %s %s: %s *",FactionInfo[PlayerInfo[playerid][pFac]][Name],BadgeNumber(playerid), PlayerInfo[playerid][pFacRank], RPN(playerid,1), text);
    else if(FactionInfo[PlayerInfo[playerid][pFac]][Badges] == 0) format(string, sizeof(string), "* (%s) %s %s: %s *",FactionInfo[PlayerInfo[playerid][pFac]][Name],PlayerInfo[playerid][pFacRank], RPN(playerid,1), text);
	SendDepartmentMessage(string);
	if(IsPlayerInAnyVehicle(playerid)){
	    if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
	    if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
		    format(string, sizeof(string), "(Windows Up) (Radio) %s says: %s", RPN(playerid,1), text);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
				{
					SendClientMessage(i, -1, string);
				}
			}
			return 1;}
		else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
        format(string, sizeof(string), "(Windows Down) (Radio) %s says: %s", RPN(playerid,1), text);
		ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
		return 1;}}
	}
    format(string, sizeof(string), "* (Radio) %s says: %s *", RPN(playerid,1), text);
	ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
    return 1;
}
CMD:m(playerid, params[]) return cmd_megaphone(playerid, params);
CMD:megaphone(playerid, params[])
{
    new string[128], text[128];
    if(PlayerInfo[playerid][pFac] == 0 || FactionInfo[PlayerInfo[playerid][pFac]][Type] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
    if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
    if(sscanf(params, "s[128]", text)) return UsageMessage(playerid, "/m(egaphone) (message)");
    format(string, sizeof(string), "%s o< %s", RPN(playerid,1), text);
    ProxDetector(35,playerid,string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
    return 1;
}
CMD:tazer(playerid)
{
if(PlayerInfo[playerid][pFac] == 0 || FactionInfo[PlayerInfo[playerid][pFac]][Type] != 1) return ErrorMessage(playerid, "You are not a authorized to use this command!");
if(PlayerInfo[playerid][pDuty] == 0) return ErrorMessage(playerid, "You can't use this command while off duty!");
new string[164];
if (HasTazer[playerid] == 0)
{
    if(GetPlayerWeapon(playerid) != 0) return ErrorMessage(playerid, "You can hold only one weapon in your hand!");
	GivePlayerWeapon(playerid, 23, 65500);
	HasTazer[playerid] = 1;
	HasWeapon[playerid] = 1;
	format(string, sizeof(string), "* %s unholsters their tazer from their duty belt.", RPN(playerid,1));
	SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
	format(string, sizeof(string), ">> %s unholsters their tazer from their duty belt.", RPN(playerid,1));
	SendClientMessage(playerid, COLME, string);
	return 1;
}
if (HasTazer[playerid] == 1)
{
	ResetPlayerWeapons(playerid);
	HasTazer[playerid] = 0;
	HasWeapon[playerid] = 0;
	format(string, sizeof(string), "* %s holsters their tazer into their duty belt.", RPN(playerid,1));
	SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
	format(string, sizeof(string), ">> %s holsters their tazer into their duty belt.", RPN(playerid,1));
	SendClientMessage(playerid, COLME, string);
	return 1;
}
return 1;
}
CMD:lock(playerid)
{
	if(GetClosestVehicle(playerid, 3) <= 0) return ErrorMessage(playerid, "You are not near a vehicle!");
    new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid,string[124];
    vehicleid = GetClosestVehicle(playerid, 3);
    if(IsPlayerInAnyVehicle(playerid)) vehicleid = GetPlayerVehicleID(playerid);
    if(DVehicles[vehicleid][vFaction] != 0 && PlayerInfo[playerid][pFac] != DVehicles[vehicleid][vFaction]) return ErrorMessage(playerid, "This is not your vehicle!");
    if(DVehicles[vehicleid][vRental] == 1 && DVehicles[vehicleid][vRenter] != playerid && DVehicles[vehicleid][vRenter] != 1111) return ErrorMessage(playerid, "This is not your vehicle!");
    if(DVehicles[vehicleid][vOwner] != 0 && DVehicles[vehicleid][vOwner] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid, "This is not your vehicle!");
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	if(doors == 1)
	{
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
		format(string, sizeof(string), "* %s uses a key which unlocks the doors of the %s.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s uses a key which unlocks the doors of the %s.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
		TextDrawSetString(doorss[playerid], "Unlocked");
		return 1;
	}
	else if(doors == 0)
	{
	 	SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
	  	format(string, sizeof(string), "* %s uses a key which locks the doors of the %s.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s uses a key which locks the doors of the %s.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
	  	TextDrawSetString(doorss[playerid], "Locked");
  	}
    return 1;
}
//*****************************************************************************************************************************
CMD:stats(playerid)
{
new string[600], jobtext[60],mask[60], mins,gender[60];
if (PlayerInfo[playerid][pJob] == 0){ jobtext = "None"; }
else if (PlayerInfo[playerid][pJob] == 1){ jobtext = "Delivery Guy"; }
else if (PlayerInfo[playerid][pJob] == 2){ jobtext = "Mechanic"; }
if (PlayerInfo[playerid][pMask] == 0){ mask = "No"; }
else if (PlayerInfo[playerid][pMask] == 1){ mask = "Yes"; }
if (PlayerInfo[playerid][pGender] == 1){ gender = "Male"; }
else if (PlayerInfo[playerid][pGender] == 2){ gender = "Female"; }
mins = 60 - PlayerInfo[playerid][pMinutes];
format(string, sizeof(string), " [Name: %s] [Hours: %d]~n~ [Cash: $%d] [Bank: $%d] [Age: %d]~n~ [Gender: %s]", RPN(playerid,0), GetPlayerScore(playerid), GetPlayerMoney(playerid), PlayerInfo[playerid][pBMoney], PlayerInfo[playerid][pAge], gender);
format(string, sizeof(string), "%s [Phone: %d] [Job: %s]~n~ [Mask: %s] [Mask ID: %d] [Faction: %s]~n~ [Rank: %s] [Tier: %d]",string,PlayerInfo[playerid][pPhone], jobtext, mask, PlayerInfo[playerid][pMaskID], FactionInfo[PlayerInfo[playerid][pFac]][Name], PlayerInfo[playerid][pFacRank], PlayerInfo[playerid][pTier]);
format(string, sizeof(string), "%s [Toolkits: %d]~n~ [Medikits: %d] [Screwdrivers: %d]",string,PlayerInfo[playerid][pToolkit],PlayerInfo[playerid][pMedikit],PlayerInfo[playerid][pScrewdriver]);
format(string, sizeof(string), "%s~n~~n~ Your next paycheck will be in %d minutes.",string,mins);
CreatePlayerStatBox(playerid,"Character Stats",string,2);
return 1;
}
CMD:hlights(playerid)
{
	new houseid;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(HouseInfo[i][hIVW] == GetPlayerVirtualWorld(playerid))
		{
			houseid = i;
			break;
		}
	}
	if(houseid == 0) return 1;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsLogged[i] == 1)
		{
			if(HouseInfo[houseid][hLights] == 1) SetPlayerTime(i, 0, 0);
			else SetPlayerTime(i, 12, 0);
		}
	}
	if(HouseInfo[houseid][hLights] == 1) HouseInfo[houseid][hLights] = 0;
	else HouseInfo[houseid][hLights] = 1;
	return 1;
}
CMD:lastpaycheck(playerid)
{
	if(PlayerInfo[playerid][pPayCheck] == 0) return ErrorMessage(playerid,"You have to wait for a paycheck first.");
	new string[146];
	format(string,sizeof(string)," PAYCHECK: ~g~+$%d ~w~|| INTEREST: ~g~+$%d~n~ ~w~OLD BALANCE: ~g~$%d ~w~|| NEW BALANCE: ~g~$%d",
								PlayerInfo[playerid][pPayCheck], PlayerInfo[playerid][pPInterest], PlayerInfo[playerid][pPPastBank], PlayerInfo[playerid][pBMoney]);
	if(PlayerInfo[playerid][pPRent] != 0)
	{
		format(string,sizeof(string)," PAYCHECK: ~g~+$%d ~w~|| INTEREST: ~g~+$%d~n~ ~w~RENT (Vehicle): ~r~-$%d~n~ ~w~OLD BALANCE: ~g~$%d ~w~|| NEW BALANCE: ~g~$%d",
								PlayerInfo[playerid][pPayCheck], PlayerInfo[playerid][pPInterest], PlayerInfo[playerid][pPRent], PlayerInfo[playerid][pPPastBank], PlayerInfo[playerid][pBMoney]);
	}
	CreatePlayerStatBox(playerid,"San Andreas Paycheck",string,1);
	return 1;
}
CMD:drugsinv(playerid)
{
new string[164];
DrugInvSelect[playerid] = 0;
format(string,sizeof(string),"Cocaine\t%d\nWeed\t%d\nSeeds\t%d",PlayerInfo[playerid][pCocaine],PlayerInfo[playerid][pWeed],PlayerInfo[playerid][pSeeds]);
ShowPlayerDialog(playerid, DIALOG_DRUGINV, DIALOG_STYLE_LIST, "Drugs Inventory", string, "Select", "Exit");
return 1;
}
CMD:removeplate(playerid)
{
	if(GetClosestVehicle(playerid, 3) <= 0) return ErrorMessage(playerid, "You are not near a vehicle!");
	if(PlayerInfo[playerid][pScrewdriver] <= 0) return ErrorMessage(playerid,"You don't have any screwdrivers!");
    new vehicleid = GetClosestVehicle(playerid, 3);
    if(IsPlayerInAnyVehicle(playerid)) vehicleid = GetPlayerVehicleID(playerid);
    if(DVehicles[vehicleid][vFaction] != 0) return ErrorMessage(playerid, "You can't do this on a faction vehicle!");
    if(DVehicles[vehicleid][vRental] == 1) return ErrorMessage(playerid, "You can't do this on a rental vehicle!");
    if(DVehicles[vehicleid][vOwner] != 0 && DVehicles[vehicleid][vOwner] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid, "This is not your vehicle!");
    SetVehicleNumberPlate(DVehicles[vehicleid][dID], "No Plate");
    InfoMessage(playerid,"Vehicle plate has been removed.");
    AmeMessage(playerid,"takes off the vehicle's plate.");
    return 1;
}
CMD:help(playerid, params[])
{
	if(isnull(params)) {UsageMessage(playerid, "/help (option)"); SendClientMessage(playerid, -1, "{989898}[OPTIONS]: general | chat | vehicle | house | phone | job | biz"); return 1;}
	SendClientMessage(playerid, -1, "{00FFEE}-------------------------------------------------------------------------------------------------------------------");
	if(!strcmp(params, "general", true, 7))
	{
	    SendClientMessage(playerid,-1, "{009C0B}[GENERAL]{C3C3C3}: /stats /help /clearchat /ping /mypos /ps /pt /animlist /stopanim");
		SendClientMessage(playerid,-1, "{009C0B}[GENERAL]{C3C3C3}: /removecp /balance /deposit /withdraw /myweps /report /frisk");
		SendClientMessage(playerid,-1, "{009C0B}[GENERAL]{C3C3C3}: /rentveh /unrent /acceptfrisk /requesthelp /setchannel /pr1 /pr2");
		SendClientMessage(playerid,-1, "{009C0B}[GENERAL]{C3C3C3}: /channels /drugsinv /transfer /createnote /deletenote /viewnotes");
		SendClientMessage(playerid,-1, "{009C0B}[GENERAL]{C3C3C3}: /charity /pt /ps /dropwep /nearwep /pickupwep /silencer /refuel");
		SendClientMessage(playerid,-1, "{009C0B}[GENERAL]{C3C3C3}: /lastpaycheck /drugsinv /changepass /description");
	}
	else if(!strcmp(params, "chat", true, 4))
	{
		SendClientMessage(playerid,-1, "{009C0B}[CHAT]{C3C3C3}: /o /b /me /do /shout /low /pm /ame");
	}
	else if(!strcmp(params, "vehicle", true, 7))
	{
		SendClientMessage(playerid,-1, "{009C0B}[VEHICLE]{C3C3C3}: /dealership /vw /vs /vt /park /checkveh /sb /checkbelt /myvehicles");
		SendClientMessage(playerid,-1, "{009C0B}[VEHICLE]{C3C3C3}: /lock /engine /lights /carradio /hotwire /toolkit /removeplate");
		SendClientMessage(playerid,-1, "{009C0B}[VEHICLE]{C3C3C3}: /carradio /speedlimit");
	}
	else if(!strcmp(params, "house", true, 5))
	{
		SendClientMessage(playerid,-1, "{009C0B}[HOUSE]{C3C3C3}: /buyhouse /lockhouse /myhouses /knock /findhouse /hlights");
	}
	else if(!strcmp(params, "phone", true, 5))
	{
		SendClientMessage(playerid,-1, "{009C0B}[CELLPHONE]{C3C3C3}: /call /sms /togphone /togvibrate /withold");
	}
	else if(!strcmp(params, "job", true, 3))
	{
		SendClientMessage(playerid,-1, "{009C0B}[JOB]{C3C3C3}: /takejob /quitjob");
	}
	else if(!strcmp(params, "biz", true, 3))
	{
		SendClientMessage(playerid,-1, "{009C0B}[BUSINESS]{C3C3C3}: /buybusiness /sellbusiness /lockbusiness /checkmybiz /bizwithdraw");
	}
	SendClientMessage(playerid, -1, "{00FFEE}-------------------------------------------------------------------------------------------------------------------");
	return 1;
}
//------------------------------------------------------------------------Animations (Start)------------------------------------------------------------------------
CMD:animlist(playerid)
{
    SendClientMessage(playerid,COLOR_WHITE,"{C3C3C3}/handsup, /dance (1-4), /rap (1-3), /wankoff, /wank, /strip (1-7), /spank (1-8), /bj (1-4), /cellin, /cellout, /lean, /piss");
    SendClientMessage(playerid,COLOR_WHITE,"/greet, /injured (1-2), /hitch, /bitchslap, /cpr, /gsign (1-5), /akick, /box, /cockgun, /follow, /gift, /getup, /win (1-2)");
    SendClientMessage(playerid,COLOR_WHITE,"{C3C3C3}/stand, /slapped, /slapass, /drunk, /walk (1-5), /celebrate (1-2), /benddown, /checkout, /die, /angry, /kiss (1-8)");
    SendClientMessage(playerid,COLOR_WHITE,"/yes, /deal (1-2) /thankyou, /sit (1-4), /scratch, /bomb, /getarrested, /laugh, /lookout, /robman, /exhausted, /bed (1-4)");
    SendClientMessage(playerid,COLOR_WHITE,"{C3C3C3}/crossarms (1-3), /lay (1-2), /vomit, /eat, /wave, /crack (1-2), /smoke (1-2), /bar (1-4), /liftup, /putdown");
    SendClientMessage(playerid,COLOR_WHITE,"/chat, /fucku, /taichi, /relax, /bat (1-5), /nod, /cry (1-2), /chant, /carsmoke, /aim (1-2), /basket (1-6), /ghand (1-5)");
    SendClientMessage(playerid,COLOR_WHITE,"{C3C3C3}/gang (1-7), /carsit (1-2), /stretch");
	return 1;
}
CMD:stopanim(playerid) return ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);

CMD:handsup(playerid) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);

CMD:dance(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/dance (1-4)");
	switch (choice)
	{
		case 1: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		case 3:	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		case 4:	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	}
	return 1;	
}

CMD:rap(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/rap (1-3)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.0,1,1,1,1,0);
		case 2: ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.0,1,1,1,1,0);
		case 3:	ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,1,1,1,0);
	}
	return 1;	
}

CMD:wankoff(playerid) return ApplyAnimation(playerid,"PAULNMAC","wank_in",4.0,1,1,1,1,0);

CMD:wank(playerid) return ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.0,1,1,1,1,0);

CMD:strip(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/strip (1-7)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"STRIP","strip_A",4.0,1,1,1,1,0);
		case 2: ApplyAnimation(playerid,"STRIP","strip_B",4.0,1,1,1,1,0);
		case 3:	ApplyAnimation(playerid,"STRIP","strip_C",4.0,1,1,1,1,0);
		case 4: ApplyAnimation(playerid,"STRIP","strip_D",4.0,1,1,1,1,0);
		case 5: ApplyAnimation(playerid,"STRIP","strip_E",4.0,1,1,1,1,0);
		case 6:	ApplyAnimation(playerid,"STRIP","strip_F",4.0,1,1,1,1,0);
		case 7: ApplyAnimation(playerid,"STRIP","strip_G",4.0,1,1,1,1,0);
	}
	return 1;	
}

CMD:spank(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/spank (1-8)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"SNM","SPANKING_IDLEW",4.1,0,1,1,1,1);
		case 2: ApplyAnimation(playerid,"SNM","SPANKING_IDLEP",4.1,0,1,1,1,1);
		case 3:	ApplyAnimation(playerid,"SNM","SPANKINGW",4.1,0,1,1,1,1);
		case 4: ApplyAnimation(playerid,"SNM","SPANKINGP",4.1,0,1,1,1,1);
		case 5: ApplyAnimation(playerid,"SNM","SPANKEDW",4.1,0,1,1,1,1);
		case 6:	ApplyAnimation(playerid,"SNM","SPANKEDP",4.1,0,1,1,1,1);
		case 7: ApplyAnimation(playerid,"SNM","SPANKING_ENDW",4.1,0,1,1,1,1);
		case 8: ApplyAnimation(playerid,"SNM","SPANKING_ENDP",4.1,0,1,1,1,1);
	}
	return 1;	
}

CMD:bj(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/bj (1-4)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_P",4.1,0,1,1,1,1);
		case 2: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_W",4.1,0,1,1,1,1);
		case 3:	ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",4.1,0,1,1,1,1);
		case 4: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",4.1,0,1,1,1,1);
	}
	return 1;	
}

CMD:cellin(playerid) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

CMD:cellout(playerid) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

CMD:lean(playerid) return ApplyAnimation(playerid,"GANGS","leanIDLE", 4.0, 1, 0, 0, 0, 0);

CMD:piss(playerid) return SetPlayerSpecialAction(playerid, 68);

CMD:follow(playerid) return ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.0,0,0,0,0,0);

CMD:greet(playerid) return ApplyAnimation(playerid,"WUZI","Wuzi_Greet_Wuzi",4.0,0,0,0,0,0);

CMD:stand(playerid) return ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop", 4.0, 1, 0, 0, 0, 0);

CMD:injured(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/injured (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"SWEET","Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"SWAT","gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:hitch(playerid) return ApplyAnimation(playerid,"MISC","Hiker_Pose", 4.0, 1, 0, 0, 0, 0);

CMD:bitchslap(playerid) return ApplyAnimation(playerid,"MISC","bitchslap",4.0,0,0,0,0,0);

CMD:cpr(playerid) return ApplyAnimation(playerid,"MEDIC","CPR", 4.0, 1, 0, 0, 0, 0);

CMD:gsign(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/gsign (1-5)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"GHANDS","gsign1",4.0,0,1,1,1,1);
		case 2: ApplyAnimation(playerid,"GHANDS","gsign2",4.0,0,1,1,1,1);
		case 3: ApplyAnimation(playerid,"GHANDS","gsign3",4.0,0,1,1,1,1);
		case 4: ApplyAnimation(playerid,"GHANDS","gsign4",4.0,0,1,1,1,1);
		case 5: ApplyAnimation(playerid,"GHANDS","gsign5",4.0,0,1,1,1,1);
	}
	return 1;	
}

CMD:gift(playerid) return ApplyAnimation(playerid,"KISSING","gift_give",4.0,0,0,0,0,0);

CMD:slapped(playerid) return ApplyAnimation(playerid,"SWEET","ho_ass_slapped",4.0,0,0,0,0,0);

CMD:slapass(playerid) return ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);

CMD:drunk(playerid) return ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);

CMD:walk(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/walk (1-5)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
		case 2: ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
		case 3:	ApplyAnimation(playerid,"ped","WOMAN_walksexy",4.1,1,1,1,1,1);
		case 4: ApplyAnimation(playerid,"ped","WALK_player",4.1,1,1,1,1,1);
		case 5: ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
	}
	return 1;	
}

CMD:eatsit(playerid) return ApplyAnimation(playerid,"FOOD","FF_Sit_Loop", 4.0, 1, 0, 0, 0, 0);

CMD:celebrate(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/celebrate (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"GYMNASIUM","gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:win(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/win (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"CASINO","cards_win", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"CASINO","Roulette_win", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:yes(playerid) return ApplyAnimation(playerid,"CLOTHES","CLO_Buy", 4.0, 1, 0, 0, 0, 0);

CMD:deal(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/deal (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"DEALER","DRUGS_BUY", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 3.0, 0, 0, 0, 0, 0); // Deal Drugs
	}
	return 1;	
}

CMD:thankyou(playerid) return ApplyAnimation(playerid,"FOOD","SHP_Thank", 4.0, 1, 0, 0, 0, 0);

CMD:sit(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/sit (1-4)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Type_Loop", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Male Sit
		case 4: ApplyAnimation(playerid,"BEACH", "ParkSit_F_loop", 4.0, 1, 0, 0, 0, 0); // Male Sit
	}
	return 1;	
}

CMD:scratch(playerid) return ApplyAnimation(playerid,"MISC","Scratchballs_01", 4.0, 1, 0, 0, 0, 0);

CMD:bomb(playerid) {ClearAnimations(playerid); ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); return 1;}

CMD:getarrested(playerid) return ApplyAnimation(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // Gun Arrest

CMD:laugh(playerid) return ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh

CMD:lookout(playerid) return ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout

CMD:robman(playerid) return ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob

CMD:crossarms(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/crossarms (1-3)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed
		case 2: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.0, 0, 1, 1, 1, -1); // Arms crossed 2
		case 3: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 0, 1, 1, 1, -1); // Arms crossed 3
	}
	return 1;	
}

CMD:lay(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/lay (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
		case 2: ApplyAnimation(playerid,"BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0); // Lay down
	}
	return 1;	
}

CMD:vomit(playerid) return ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit

CMD:eat(playerid) return ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger

CMD:wave(playerid) return ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave

CMD:crack(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/crack (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack
		case 2: ApplyAnimation(playerid, "CRACK", "crckidle2", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:smoke(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/smoke (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Smoke
		case 2: ApplyAnimation(playerid,"SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Smoke
	}
	return 1;	
}

CMD:chat(playerid) return ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,1,1,1,1,1);

CMD:fucku(playerid) return ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);

CMD:taichi(playerid) return ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0);

CMD:relax(playerid) return ApplyAnimation(playerid,"BEACH","Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0);

CMD:bat(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/bat (1-5)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"BASEBALL","Bat_IDLE", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"BASEBALL","Bat_M", 4.0, 1, 0, 0, 0, 0);
		case 3:	ApplyAnimation(playerid,"BASEBALL","BAT_PART", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0);
		case 5: ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:nod(playerid) return ApplyAnimation(playerid,"COP_AMBIENT","Coplook_nod",4.0,0,0,0,0,0);

CMD:gang(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/gang (1-7)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"GANGS","hndshkaa",4.0,0,0,0,0,0);
		case 2: ApplyAnimation(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
		case 3:	ApplyAnimation(playerid,"GANGS","hndshkca",4.0,0,0,0,0,0);
		case 4: ApplyAnimation(playerid,"GANGS","hndshkcb",4.0,0,0,0,0,0);
		case 5: ApplyAnimation(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
		case 6: ApplyAnimation(playerid,"GANGS","hndshkea",4.0,0,0,0,0,0);
		case 7: ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0);
	}
	return 1;	
}

CMD:cry(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/cry (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:bed(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/bed (1-4)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"INT_HOUSE","BED_In_L",4.1,0,1,1,1,1);
		case 2: ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1,0,1,1,1,1);
		case 3: ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_L", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_R", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:kiss(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/kiss (1-8)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"BD_FIRE","Grlfrd_Kiss_03",4.0,0,0,0,0,0);
		case 2: ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_01",4.0,0,0,0,0,0);
		case 3:	ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_02",4.0,0,0,0,0,0);
		case 4: ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_03",4.0,0,0,0,0,0);
		case 5: ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.0,0,0,0,0,0);
		case 6: ApplyAnimation(playerid,"KISSING","Playa_Kiss_02",4.0,0,0,0,0,0);
		case 7: ApplyAnimation(playerid,"KISSING","Playa_Kiss_03",4.0,0,0,0,0,0);
		case 8: ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0);
	}
	return 1;	
}

CMD:carsit(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/carsit (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"CAR","Tap_hand", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"LOWRIDER","Sit_relaxed", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:stretch(playerid) return ApplyAnimation(playerid,"PLAYIDLES","stretch",4.0,0,0,0,0,0);

CMD:chant(playerid) return ApplyAnimation(playerid,"RIOT","RIOT_CHANT", 4.0, 1, 0, 0, 0, 0);

CMD:angry(playerid) return ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.0,0,0,0,0,0);

CMD:ghand(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/ghand (1-5)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"GHANDS","gsign1LH",4.0,0,1,1,1,1);
		case 2: ApplyAnimation(playerid,"GHANDS","gsign2LH",4.0,0,1,1,1,1);
		case 3:	ApplyAnimation(playerid,"GHANDS","gsign3LH",4.0,0,1,1,1,1);
		case 4: ApplyAnimation(playerid,"GHANDS","gsign4LH",4.0,0,1,1,1,1);
		case 5: ApplyAnimation(playerid,"GHANDS","gsign5LH",4.0,0,1,1,1,1);
	}
	return 1;	
}

CMD:exhausted(playerid) return ApplyAnimation(playerid,"FAT","IDLE_tired", 4.0, 1, 0, 0, 0, 0);

CMD:carsmoke(playerid) return ApplyAnimation(playerid,"PED","Smoke_in_car", 4.0, 1, 0, 0, 0, 0);

CMD:aim(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/aim (1-2)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"PED","gang_gunstand", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
	}
	return 1;	
}

CMD:getup(playerid) return ApplyAnimation(playerid,"PED","getup",4.0,0,0,0,0,0);

CMD:basket(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/basket (1-6)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop", 4.0, 1, 0, 0, 0, 0);
		case 3:	ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
		case 4: ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
		case 5: ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.1,0,1,1,1,1);
		case 6: ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
	}
	return 1;	
}

CMD:akick(playerid) return ApplyAnimation(playerid,"FIGHT_E","FightKick",4.0,0,0,0,0,0);

CMD:box(playerid) return ApplyAnimation(playerid,"GYMNASIUM","gym_shadowbox",4.1,1,1,1,1,1);

CMD:cockgun(playerid) return ApplyAnimation(playerid, "SILENCED", "Silence_reload", 3.0, 0, 0, 0, 0, 0);

CMD:bar(playerid,params[])
{
	new choice;
	if(sscanf(params, "i", choice)) return UsageMessage(playerid, "/bar (1-4)");
	switch (choice)
	{
		case 1: ApplyAnimation(playerid, "BAR", "Barcustom_get", 3.0, 0, 0, 0, 0, 0);
		case 2: ApplyAnimation(playerid, "BAR", "Barcustom_order", 3.0, 0, 0, 0, 0, 0);
		case 3: ApplyAnimation(playerid, "BAR", "Barserve_give", 3.0, 0, 0, 0, 0, 0);
		case 4: ApplyAnimation(playerid, "BAR", "Barserve_glass", 3.0, 0, 0, 0, 0, 0);
	}
	return 1;	
}

CMD:liftup(playerid) return ApplyAnimation(playerid, "CARRY", "liftup", 3.0, 0, 0, 0, 0, 0);

CMD:putdown(playerid) return ApplyAnimation(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);

CMD:die(playerid) return ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1,0,1,1,1,1);

CMD:shakehead(playerid) return ApplyAnimation(playerid, "MISC", "plyr_shkhead", 3.0, 0, 0, 0, 0, 0);

CMD:benddown(playerid) return ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0);

CMD:checkout(playerid) return ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 0, 0, 0, 0, 0);

//-------------------------------------------------------------------------Animations (End)-------------------------------------------------------------------------
CMD:speedlimit(playerid, params[]){
	new speed;
	if(SpeedLimit[playerid] == 0){
		if(sscanf(params, "d", speed)) return SendClientMessage(playerid, -1, "Usage: /speedlimit [speed (km/h)]");
		SpeedLimit[playerid] = 1;
		SpeedLS[playerid] = speed;
		SpeedLSTimer[playerid] = SetTimerEx("SpeedLimitT", 500, 1, "d", playerid);
		SendClientMessage(playerid, -1, "Speed limit on");
	}else {
	    SpeedLimit[playerid] = 0;
	    SpeedLS[playerid] = 0;
	    KillTimer(SpeedLSTimer[playerid]);
	    SendClientMessage(playerid, -1, "Speed limit off 1");
	}
	return 1;
}
forward SpeedLimitT(playerid);
public SpeedLimitT(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && SpeedLimit[playerid] != 0)
	{
	    SetVehicleSpeed(GetPlayerVehicleID(playerid), SpeedLS[playerid], kmh);
	}
	else 
	{
	    SpeedLimit[playerid] = 0;
	    SpeedLS[playerid] = 0;
	    KillTimer(SpeedLSTimer[playerid]);
	    SendClientMessage(playerid, -1, "Speed limit off");
	}
	return 1;
}

CMD:placeboombox(playerid, params[]){
	if(PlayerBB[playerid] != 0) return SendClientMessage(playerid, -1, "You already have a boombox placed!");
	for(new i; i<MAX_PLAYERS; i++){
    	if(PlayerBB[i] != 0)
   		{
  			if(IsPlayerInRangeOfPoint(playerid, 65.0, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ")) && (GetPVarInt(i, "BBI") == GetPlayerInterior(playerid) && GetPVarInt(i, "BBW") == GetPlayerVirtualWorld(playerid)))
			{
   				SendClientMessage(playerid, -1, "You cannot place your boombox in here.");
			    return 1;
			}
		}
    }
    new string[256];
    SendClientMessage(playerid, -1, "You have placed down your boombox!");
 	new Float:x, Float:y, Float:z, Float:angle;
  	GetPlayerPos(playerid, x, y, z);
  	GetPlayerFacingAngle(playerid, angle);
 	ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_In", 4.0, 0, 0, 0, 0, 0, 1);
  	x += (2 * floatsin(-angle, degrees));
  	y += (2 * floatcos(-angle, degrees));
  	z -= 1.0;
  	PlayerBB[playerid] = 1;
  	PlayerBBObject[playerid] = CreateDynamicObject(2226, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
  	SetPVarFloat(playerid, "BBX", x); SetPVarFloat(playerid, "BBY", y); SetPVarFloat(playerid, "BBZ", z); SetPVarInt(playerid, "BBI", GetPlayerInterior(playerid)); SetPVarInt(playerid, "BBW", GetPlayerVirtualWorld(playerid));
  	format(string, sizeof(string), "{00FF00}Boombox Owner:{FFFFFF} %s", RPN(playerid,0));
  	PlayerBBLabel[playerid] = Create3DTextLabel(string, 0xFFFFFFEE, x, y, z+0.6, 5.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
  	SetPVarInt(playerid, "PlayerBBArea", CreateDynamicSphere(x, y, z, 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
	return 1;
}

CMD:playboombox(playerid, params[]){
 	if(PlayerBB[playerid] == 0) return SendClientMessage(playerid, -1, "You dont have have a boombox placed!");
	new url[256];
	if(sscanf(params, "s[256]", url)) return SendClientMessage(playerid, -1, "Usage: /playboombox [url]");
	format(PlayerBBUrl[playerid], 256, url);
	SendClientMessage(playerid, -1, "You have played a song on your boombox.");
	return 1;
}

CMD:pickupboombox(playerid, params[]){
    if(PlayerBB[playerid] == 0) return SendClientMessage(playerid, -1, "You dont have a boombox placed!");
    if(!IsPlayerInRangeOfPoint(playerid, 2.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")) || (GetPVarInt(playerid, "BBI") != GetPlayerInterior(playerid) || GetPVarInt(playerid, "BBW") != GetPlayerVirtualWorld(playerid)))
	{
		return SendClientMessage(playerid, -1, "You must be at your boombox to pick it up!");
	}
	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) return SendClientMessage(playerid, -1, " You must be crouched to pick your boombox!");
	DestroyDynamicObject(PlayerBBObject[playerid]);
	Delete3DTextLabel(Text3D:PlayerBBLabel[playerid]);
	SendClientMessage(playerid, -1, "You have picked up your boombox.");
	PlayerBBUrl[playerid] = "none";
	PlayerBB[playerid] = 0;
	SetPVarFloat(playerid, "BBX", 0); SetPVarFloat(playerid, "BBY", 0); SetPVarFloat(playerid, "BBZ", 0); SetPVarInt(playerid, "BBI", 0); SetPVarInt(playerid, "BBW", 0);
	for(new i; i<MAX_PLAYERS; i++){
 		if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "PlayerBBArea"))){
	        StopAudio(playerid);
			PlayerBBPUrl[playerid] = "none";
			PlayerBBMOn[playerid] = 0;
   		}
	}
	DeletePVar(playerid, "PlayerBBArea");
	return 1;
}

CMD:description(playerid,params[])
{
new playerb,string[124];
if(sscanf(params, "i", playerb)) return UsageMessage(playerid, "/description (playerid)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
new ggender[20];
format(ggender,20,"Male");
if(PlayerInfo[playerb][pGender] == 2) format(ggender,20,"Female");
format(string,sizeof(string)," Age: %d~n~ Gender: %s~n~ Height: %d cm~n~ Weight: %d kg~n~ Hair Color: %s~n~ Eye Color: %s",
					PlayerInfo[playerb][pAge],ggender,PlayerInfo[playerb][pHeight],PlayerInfo[playerb][pWeight],PlayerInfo[playerb][pHairColor],PlayerInfo[playerb][pEyeColor]);
CreatePlayerStatBox(playerid,RPN(playerb,0),string,1);
return 1;
}

new changepasscheck[MAX_PLAYERS];
CMD:changepass(playerid,params[])
{
new oldpass[124],pass[124];
if(sscanf(params, "s[124]s[124]",oldpass,pass)) return UsageMessage(playerid, "/changepass (old password) (new password)");
if(udb_hash(oldpass) != PlayerInfo[playerid][pPass]) return ErrorMessage(playerid,"Wrong password.");
changepasscheck[playerid] = 1;
UsageMessage(playerid,"/confirmps (new password)");
return 1;
}
CMD:confirmps(playerid,params[])
{
new pass[124];
if(sscanf(params, "s[124]",pass)) return UsageMessage(playerid, "/confirmps (new password)");
if(udb_hash(pass) == udb_hash(PlayerInfo[playerid][pPass])) return ErrorMessage(playerid,"Your new password can't be the same as the old one.");
PlayerInfo[playerid][pPass] = udb_hash(pass);
changepasscheck[playerid] = 0;
InfoMessage(playerid,"Your password has been changed successfully.");
return 1;
}
CMD:changefs(playerid)
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0,770.9821,-59.1260,1000.6563)) return ErrorMessage(playerid,"You are not near the gym lockers.");
	ShowPlayerDialog(playerid, DIALOG_GYM_LOCKER, DIALOG_STYLE_LIST, "Gym Lockers", "Normal\nBoxing\nKung Fun\nKnee-Head\nGrab-Kick\nElbow", "Select", "Exit");
	return 1;
}
CMD:refuel(playerid)
{
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMessage(playerid,"You must be driving a vehicle.");
new gasid,price,string[124];
new vehid = GetPlayerVehicleID(playerid);
for(new i = 1; i < MAX_GASTATIONS; i++)
{
	if(GasStationInfo[i][gsX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,3,GasStationInfo[i][gsX],GasStationInfo[i][gsY],GasStationInfo[i][gsZ]))
	    {
	        gasid = i;
	        i = MAX_GASTATIONS;
	    }
	}
}
if(gasid == 0)
{
	if(PlayerInfo[playerid][pGasCan] == 0) return 1;
	PlayerInfo[playerid][pGasCan] -= 1;
	DVehicles[vehid][vFuel] += 50;
	InfoMessage(playerid,"You have refueled your vehicle using your gas can.");
	return 1;
}
price = (100 - DVehicles[vehid][vFuel]) * GasStationInfo[gasid][gsPrice];
GivePMoney(playerid,-price);
DVehicles[vehid][vFuel] = 100;
format(string,sizeof(string),"You have paid $%d for fuel.",price);
InfoMessage(playerid,string);
return 1;
}
CMD:drop(playerid, params[])
{
new playerb,string[124];
if(sscanf(params, "i", playerb)) return UsageMessage(playerid, "/drop (playerid)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(BeingDragged[playerb] != playerid) return ErrorMessage(playerid,"That player isn't being dragged by you!");
BeingDragged[playerb] = -1;
format(string,sizeof(string),"stops dragging %s.",RPN(playerb,1));
AmeMessage(playerid,string);
return 1;
}
CMD:drag(playerid, params[])
{
new playerb;
if(sscanf(params, "i", playerb)) return UsageMessage(playerid, "/drag (playerid)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(playerb == playerid) return ErrorMessage(playerid,"You can't drag yourself!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(Tazed[playerb] == -1 && PlayerInfo[playerb][pDeathTime] == -1) return ErrorMessage(playerid,"That player isn't tazed or heavily injured!");
if(BeingDragged[playerb] != -1) return ErrorMessage(playerid,"That player is already being dragged by someone else!");
new Float:x, Float:y, Float:z,string[124];
GetPlayerPos(playerid, x, y, z);
SetPlayerInterior(playerb,GetPlayerInterior(playerid));
SetPlayerVirtualWorld(playerb,GetPlayerVirtualWorld(playerid));
SetPlayerPos(playerb, x+0.5, y+0.5, z);
BeingDragged[playerb] = playerid;
format(string,sizeof(string),"starts dragging %s.",RPN(playerb,1));
AmeMessage(playerid,string);
return 1;
}
CMD:knock(playerid)
{
new house;
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] != 0)
	{
 		if(IsPlayerInRangeOfPoint(playerid,1.5,HouseInfo[i][hOX],HouseInfo[i][hOY],HouseInfo[i][hOZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hOVW] && GetPlayerInterior(playerid) == HouseInfo[i][hOInt])
   		{
     		house = i;
       		i = MAX_HOUSES;
    	}
	}
}
if(house == 0) return 1;
MeMessage(playerid,"knocks on the house door.");
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsPlayerInRangeOfPoint(i,20,HouseInfo[house][hIX],HouseInfo[house][hIY],HouseInfo[house][hIZ]) && GetPlayerVirtualWorld(i) == HouseInfo[house][hIVW] && GetPlayerInterior(i) == HouseInfo[house][hIInt])
	{
		SendClientMessage(i,COLME,"** Somebody knocks on the house door **");
	}
}
return 1;
}


CMD:findhouse(playerid,params[])
{
new house;
if(sscanf(params, "i", house)) return UsageMessage(playerid, "/findhouse (house)");
if(HouseInfo[house][hOX] == 0) return ErrorMessage(playerid, "That house doesn't exist!");
InfoMessage(playerid,"House position has been marked on your map.");
SetPlayerCheckpoint(playerid,HouseInfo[house][hOX],HouseInfo[house][hOY],HouseInfo[house][hOZ],2.0);
return 1;
}
CMD:silencer(playerid)
{
if(HasWeapon[playerid] == 0) return ErrorMessage(playerid,"You aren't holding a weapon!");
new weaponid, weaponammo;
GetPlayerWeaponData(playerid, GetWeaponSlot(GetPlayerWeapon(playerid)), weaponid, weaponammo);
if(GetPlayerWeapon(playerid) != 22 && GetPlayerWeapon(playerid) != 23) return ErrorMessage(playerid,"You can't put a silencer on this weapon!");
if(GetPlayerWeapon(playerid) == 22)
{
GivePlayerWeapon(playerid,23,weaponammo);
AmeMessage(playerid,"puts a silencer on their handgun.");
}
else if (GetPlayerWeapon(playerid) == 23)
{
GivePlayerWeapon(playerid,22,weaponammo);
AmeMessage(playerid,"takes a silencer off their handgun.");
}
return 1;
}
CMD:createnote(playerid,params[])
{
new text[10];
if(sscanf(params, "s[10]",text)) return UsageMessage(playerid, "/createnote (text)");
if(NoteInfo[playerid][Note1] == 0){format(NoteInfo[playerid][Note1],10,"%s",text); InfoMessage(playerid,"Note 1 successfully created."); return 1;}
else if(NoteInfo[playerid][Note2] == 0){format(NoteInfo[playerid][Note2],10,"%s",text); InfoMessage(playerid,"Note 2 successfully created."); return 1;}
else if(NoteInfo[playerid][Note3] == 0){format(NoteInfo[playerid][Note3],10,"%s",text); InfoMessage(playerid,"Note 3 successfully created."); return 1;}
else if(NoteInfo[playerid][Note4] == 0){format(NoteInfo[playerid][Note4],10,"%s",text); InfoMessage(playerid,"Note 4 successfully created."); return 1;}
else if(NoteInfo[playerid][Note5] == 0){format(NoteInfo[playerid][Note5],10,"%s",text); InfoMessage(playerid,"Note 5 successfully created."); return 1;}
else if(NoteInfo[playerid][Note6] == 0){format(NoteInfo[playerid][Note6],10,"%s",text); InfoMessage(playerid,"Note 6 successfully created."); return 1;}
else if(NoteInfo[playerid][Note7] == 0){format(NoteInfo[playerid][Note7],10,"%s",text); InfoMessage(playerid,"Note 7 successfully created."); return 1;}
else if(NoteInfo[playerid][Note8] == 0){format(NoteInfo[playerid][Note8],10,"%s",text); InfoMessage(playerid,"Note 8 successfully created."); return 1;}
else if(NoteInfo[playerid][Note9] == 0){format(NoteInfo[playerid][Note9],10,"%s",text); InfoMessage(playerid,"Note 9 successfully created."); return 1;}
else if(NoteInfo[playerid][Note10] == 0){format(NoteInfo[playerid][Note10],10,"%s",text); InfoMessage(playerid,"Note 10 successfully created."); return 1;}
else if(NoteInfo[playerid][Note11] == 0){format(NoteInfo[playerid][Note11],10,"%s",text); InfoMessage(playerid,"Note 11 successfully created."); return 1;}
else if(NoteInfo[playerid][Note12] == 0){format(NoteInfo[playerid][Note12],10,"%s",text); InfoMessage(playerid,"Note 12 successfully created."); return 1;}
else if(NoteInfo[playerid][Note13] == 0){format(NoteInfo[playerid][Note13],10,"%s",text); InfoMessage(playerid,"Note 13 successfully created."); return 1;}
else if(NoteInfo[playerid][Note14] == 0){format(NoteInfo[playerid][Note14],10,"%s",text); InfoMessage(playerid,"Note 14 successfully created."); return 1;}
else if(NoteInfo[playerid][Note15] == 0){format(NoteInfo[playerid][Note15],10,"%s",text); InfoMessage(playerid,"Note 15 successfully created."); return 1;}
else if(NoteInfo[playerid][Note16] == 0){format(NoteInfo[playerid][Note16],10,"%s",text); InfoMessage(playerid,"Note 16 successfully created."); return 1;}
else if(NoteInfo[playerid][Note17] == 0){format(NoteInfo[playerid][Note17],10,"%s",text); InfoMessage(playerid,"Note 17 successfully created."); return 1;}
else if(NoteInfo[playerid][Note18] == 0){format(NoteInfo[playerid][Note18],10,"%s",text); InfoMessage(playerid,"Note 18 successfully created."); return 1;}
else if(NoteInfo[playerid][Note19] == 0){format(NoteInfo[playerid][Note19],10,"%s",text); InfoMessage(playerid,"Note 19 successfully created."); return 1;}
else if(NoteInfo[playerid][Note20] == 0){format(NoteInfo[playerid][Note20],10,"%s",text); InfoMessage(playerid,"Note 20 successfully created."); return 1;}
ErrorMessage(playerid,"No more note space! Delete some notes to free up space!");
return 1;
}

CMD:viewnotes(playerid)
{
new msg[124];
format(msg,124,"1: %s |2: %s |3: %s|4: %s",NoteInfo[playerid][Note1],NoteInfo[playerid][Note2],NoteInfo[playerid][Note3],NoteInfo[playerid][Note4]);
SendClientMessage(playerid,-1,msg);
format(msg,124,"5: %s |6: %s |7: %s|8: %s",NoteInfo[playerid][Note5],NoteInfo[playerid][Note6],NoteInfo[playerid][Note7],NoteInfo[playerid][Note8]);
SendClientMessage(playerid,-1,msg);
format(msg,124,"9: %s |10: %s |11: %s|12: %s",NoteInfo[playerid][Note9],NoteInfo[playerid][Note10],NoteInfo[playerid][Note11],NoteInfo[playerid][Note12]);
SendClientMessage(playerid,-1,msg);
format(msg,124,"13: %s |14: %s |15: %s|16: %s",NoteInfo[playerid][Note13],NoteInfo[playerid][Note14],NoteInfo[playerid][Note15],NoteInfo[playerid][Note16]);
SendClientMessage(playerid,-1,msg);
format(msg,124,"17: %s |18: %s |19: %s|20: %s",NoteInfo[playerid][Note17],NoteInfo[playerid][Note18],NoteInfo[playerid][Note19],NoteInfo[playerid][Note20]);
SendClientMessage(playerid,-1,msg);
return 1;
}

CMD:deletenote(playerid,params[])
{
new note,msg[124];
if(sscanf(params, "i",note)) return UsageMessage(playerid, "/deletenote (note)");
if(note > 20 || note < 0) return ErrorMessage(playerid, "Note number ranges from 1 to 20.");
if(note == 1) NoteInfo[playerid][Note1] = 0;
else if(note == 2) NoteInfo[playerid][Note2] = 0;
else if(note == 3) NoteInfo[playerid][Note3] = 0;
else if(note == 4) NoteInfo[playerid][Note4] = 0;
else if(note == 5) NoteInfo[playerid][Note5] = 0;
else if(note == 6) NoteInfo[playerid][Note6] = 0;
else if(note == 7) NoteInfo[playerid][Note7] = 0;
else if(note == 8) NoteInfo[playerid][Note8] = 0;
else if(note == 9) NoteInfo[playerid][Note9] = 0;
else if(note == 10) NoteInfo[playerid][Note10] = 0;
else if(note == 11) NoteInfo[playerid][Note11] = 0;
else if(note == 12) NoteInfo[playerid][Note12] = 0;
else if(note == 13) NoteInfo[playerid][Note13] = 0;
else if(note == 14) NoteInfo[playerid][Note14] = 0;
else if(note == 15) NoteInfo[playerid][Note15] = 0;
else if(note == 16) NoteInfo[playerid][Note16] = 0;
else if(note == 17) NoteInfo[playerid][Note17] = 0;
else if(note == 18) NoteInfo[playerid][Note18] = 0;
else if(note == 19) NoteInfo[playerid][Note19] = 0;
else if(note == 20) NoteInfo[playerid][Note20] = 0;
format(msg,124,"Note %d deleted.",note);
InfoMessage(playerid,msg);
return 1;
}
CMD:dropwep(playerid)
{
if(HasWeapon[playerid] == 0) return ErrorMessage(playerid,"You aren't holding a weapon!");
if(PlayerInfo[playerid][pDuty] == 1) return 1;
new msg[164],gunname[60];
for(new i = 1; i < MAX_WEAPONS; i++)
{
	if(WeaponInfo[i][WeaponID] == 0)
	{
	    GetPlayerPos(playerid,WeaponInfo[i][WeaponX],WeaponInfo[i][WeaponY],WeaponInfo[i][WeaponZ]);
	    WeaponInfo[i][WeaponZ] = WeaponInfo[i][WeaponZ] - 1;
	    WeaponInfo[i][WeaponVW] = GetPlayerVirtualWorld(playerid);
	    WeaponInfo[i][WeaponInt] = GetPlayerInterior(playerid);
	    WeaponInfo[i][WeaponTime] = 180;
	    GetPlayerWeaponData(playerid, GetWeaponSlot(GetPlayerWeapon(playerid)), WeaponInfo[i][WeaponID], WeaponInfo[i][WeaponAmmo]);
	    WeaponInfo[i][WeaponObject] = CreateDynamicObject(GetWeaponObject(WeaponInfo[i][WeaponID]),WeaponInfo[i][WeaponX],WeaponInfo[i][WeaponY],WeaponInfo[i][WeaponZ],90,0,0,WeaponInfo[i][WeaponVW],WeaponInfo[i][WeaponInt],-1,200,0);
        GetWeaponName(WeaponInfo[i][WeaponID],gunname,60);
	 	format(msg, sizeof(msg), "* %s drops a %s on the floor.", RPN(playerid,1),gunname);
		SetPlayerChatBubble(playerid, msg, COLME, 15.0, 2000);
		format(msg, sizeof(msg), ">> %s drops a %s on the floor.", RPN(playerid,1),gunname);
		SendClientMessage(playerid, COLME, msg);
		HasWeapon[playerid] = 0;
		ResetPlayerWeapons(playerid);
	    return 1;
	}
}
return 1;
}
CMD:nearwep(playerid)
{
new msg[164],gunname[20];
for(new i = 1; i < MAX_WEAPONS; i++)
{
	if(WeaponInfo[i][WeaponX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,6,WeaponInfo[i][WeaponX],WeaponInfo[i][WeaponY],WeaponInfo[i][WeaponZ]) && GetPlayerInterior(playerid) == WeaponInfo[i][WeaponInt] && GetPlayerVirtualWorld(playerid) == WeaponInfo[i][WeaponVW])
	    {
	        GetWeaponName(WeaponInfo[i][WeaponID],gunname,20);
	        format(msg,sizeof(msg),"{989898}ID %d | %s | %d Ammo (Expires in %d minutes)",i,gunname,WeaponInfo[i][WeaponAmmo],WeaponInfo[i][WeaponTime]);
	        SendClientMessage(playerid,-1,msg);
	    }
	}
}
return 1;
}

CMD:pickupwep(playerid,params[])
{
if(HasWeapon[playerid] == 1) return ErrorMessage(playerid,"You can't hold more than one weapon in your hand!");
new weaponid;
if(sscanf(params,"i",weaponid)) return UsageMessage(playerid, "/pickupwep (weaponid)");
new msg[164],gunname[20];
if(IsPlayerInRangeOfPoint(playerid,3,WeaponInfo[weaponid][WeaponX],WeaponInfo[weaponid][WeaponY],WeaponInfo[weaponid][WeaponZ]) && GetPlayerInterior(playerid) == WeaponInfo[weaponid][WeaponInt] && GetPlayerVirtualWorld(playerid) == WeaponInfo[weaponid][WeaponVW])
{
	GetWeaponName(WeaponInfo[weaponid][WeaponID],gunname,20);
 	format(msg, sizeof(msg), "* %s picks up a %s from the floor.", RPN(playerid,1),gunname);
	SetPlayerChatBubble(playerid, msg, COLME, 15.0, 2000);
	format(msg, sizeof(msg), ">> %s picks up a %s from the floor.", RPN(playerid,1),gunname);
	SendClientMessage(playerid, COLME, msg);
	GivePlayerWeapon(playerid,WeaponInfo[weaponid][WeaponID],WeaponInfo[weaponid][WeaponAmmo]);
	HasWeapon[playerid] = 1;
	DestroyDynamicObject(WeaponInfo[weaponid][WeaponObject]);
	WeaponInfo[weaponid][WeaponID] = 0;
	WeaponInfo[weaponid][WeaponAmmo] = 0;
	WeaponInfo[weaponid][WeaponTime] = 0;
	WeaponInfo[weaponid][WeaponX] = 0;
	WeaponInfo[weaponid][WeaponY] = 0;
	WeaponInfo[weaponid][WeaponZ] = 0;
 	WeaponInfo[weaponid][WeaponVW] = 0;
 	WeaponInfo[weaponid][WeaponInt] = 0;
 	return 1;
}
return 1;
}
CMD:buybusiness(playerid)
{
new bizs;
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOwner] == PlayerInfo[playerid][pID])
	{
	    bizs = bizs++;
	}
}
if(bizs >= 2) return ErrorMessage(playerid,"You already own the maximum amount of businesses!");
new bizid,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,3,BizInfo[i][bOX],BizInfo[i][bOY],BizInfo[i][bOZ]))
	    {
	        bizid = i;
	        break;
	    }
	}
}
if(bizid == 0) return 1;
if(BizInfo[bizid][bOwner] != 0 && BizInfo[bizid][bOwner] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid, "This business is already owned by someone!");
if(GetPlayerMoney(playerid) < BizInfo[bizid][bPrice]) return ErrorMessage(playerid, "You can't afford this business!");
GivePMoney(playerid,-BizInfo[bizid][bPrice]);
BizInfo[bizid][bOwner] = PlayerInfo[playerid][pID];
new string[124];
format(string,sizeof(string),"You have successfully bought this business! (ID: %d)",bizid);
InfoMessage(playerid,string);
Delete3DTextLabel(BizInfo[bizid][bLabel]);
new type[60];
format(type,sizeof(type),"");
if(BizInfo[bizid][bType] == 1) format(type,sizeof(type),"24/7");
else if(BizInfo[bizid][bType] == 2) format(type,sizeof(type),"Clothes Store");
else if(BizInfo[bizid][bType] == 3) format(type,sizeof(type),"Bar");
else if(BizInfo[bizid][bType] == 4) format(type,sizeof(type),"Restourant");
else if(BizInfo[bizid][bType] == 5) format(type,sizeof(type),"Club");
else if(BizInfo[bizid][bType] == 6) format(type,sizeof(type),"Fast Food");
else if(BizInfo[bizid][bType] == 7) format(type,sizeof(type),"Weapon Store");
format(string,sizeof(string),"%s\n/enter",BizInfo[bizid][bName],type);
if(BizInfo[bizid][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n/enter",BizInfo[bizid][bName],type);
if(BizInfo[bizid][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n/enter",type,BizInfo[bizid][bPrice]);
BizInfo[bizid][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[bizid][bOX], BizInfo[bizid][bOY], BizInfo[bizid][bOZ], 10.0, 0, 1);
return 1;
}
CMD:sellbusiness(playerid)
{
new bizid,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,3,BizInfo[i][bOX],BizInfo[i][bOY],BizInfo[i][bOZ]))
	    {
	        bizid = i;
	        break;
	    }
	}
}
if(bizid == 0) return 1;
if(BizInfo[bizid][bOwner] != PlayerInfo[playerid][pID] || BizInfo[bizid][bOwner] == 0) return ErrorMessage(playerid, "This is not your business!");
GivePMoney(playerid,BizInfo[bizid][bPrice]/2);
BizInfo[bizid][bOwner] = 0;
new string[124];
format(string,sizeof(string),"You have successfully sold this house and gained $%d!",BizInfo[bizid][bPrice]/2);
InfoMessage(playerid,string);
Delete3DTextLabel(BizInfo[bizid][bLabel]);
new type[60];
format(type,sizeof(type),"");
if(BizInfo[bizid][bType] == 1) format(type,sizeof(type),"24/7");
else if(BizInfo[bizid][bType] == 2) format(type,sizeof(type),"Clothes Store");
else if(BizInfo[bizid][bType] == 3) format(type,sizeof(type),"Bar");
else if(BizInfo[bizid][bType] == 4) format(type,sizeof(type),"Restourant");
else if(BizInfo[bizid][bType] == 5) format(type,sizeof(type),"Club");
else if(BizInfo[bizid][bType] == 6) format(type,sizeof(type),"Fast Food");
else if(BizInfo[bizid][bType] == 7) format(type,sizeof(type),"Weapon Store");
format(string,sizeof(string),"%s\n/enter",BizInfo[bizid][bName],type);
if(BizInfo[bizid][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n/enter",BizInfo[bizid][bName],type);
if(BizInfo[bizid][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n/enter",type,BizInfo[bizid][bPrice]);
BizInfo[bizid][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[bizid][bOX], BizInfo[bizid][bOY], BizInfo[bizid][bOZ], 10.0, 0, 1);
return 1;
}
CMD:checkmybiz(playerid)
{
new bizid,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,40,BizInfo[i][bIX],BizInfo[i][bIY],BizInfo[i][bIZ]) && BizInfo[i][bIVW] == GetPlayerVirtualWorld(playerid) && BizInfo[i][bIInt] == GetPlayerInterior(playerid))
	    {
	        bizid = i;
	        break;
	    }
	}
}
if(bizid == 0) return 1;
if(BizInfo[bizid][bOwner] != PlayerInfo[playerid][pID] || BizInfo[bizid][bOwner] == 0) return ErrorMessage(playerid, "This is not your business!");
new string[264],locked[10];
format(locked,sizeof(locked),"No");
if(BizInfo[bizid][bLocked] == 1) format(locked,sizeof(locked),"Yes");
format(string,sizeof(string)," Name: %s~n~ Type: %s~n~ Earnings: %d~n~ Locked: %s",BizInfo[bizid][bName],GetBusinessType(BizInfo[bizid][bType]),BizInfo[bizid][bMoney],locked);
CreatePlayerStatBox(playerid,"Your Business",string,1);
return 1;	
}
CMD:bizwithdraw(playerid,params[])
{
new amount;
if(sscanf(params,"i",amount)) return UsageMessage(playerid, "/bizwithdraw (amount)");
new bizid,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,40,BizInfo[i][bIX],BizInfo[i][bIY],BizInfo[i][bIZ]) && BizInfo[i][bIVW] == GetPlayerVirtualWorld(playerid) && BizInfo[i][bIInt] == GetPlayerInterior(playerid))
	    {
	        bizid = i;
	        break;
	    }
	}
}
if(bizid == 0) return 1;
if(BizInfo[bizid][bOwner] != PlayerInfo[playerid][pID] || BizInfo[bizid][bOwner] == 0) return ErrorMessage(playerid, "This is not your business!");
if(BizInfo[bizid][bMoney] < amount) return ErrorMessage(playerid,"Your business doesn't have that amount of money.");
BizInfo[bizid][bMoney] -= amount;
GivePMoney(playerid,amount);
new string[264];
format(string,sizeof(string),"You have taken $%d from your business.",amount);
InfoMessage(playerid,string);
return 1;	
}
CMD:lockbiz(playerid)
{
new bizid,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,40,BizInfo[i][bIX],BizInfo[i][bIY],BizInfo[i][bIZ]) || IsPlayerInRangeOfPoint(playerid,3,BizInfo[i][bOX],BizInfo[i][bOY],BizInfo[i][bOZ]))
	    {
	    	if(BizInfo[i][bIVW] == GetPlayerVirtualWorld(playerid) || BizInfo[i][bOVW] == GetPlayerVirtualWorld(playerid))
	    	{
	    		if(BizInfo[i][bIInt] == GetPlayerInterior(playerid) || BizInfo[i][bOInt] == GetPlayerInterior(playerid))
	    		{
			        bizid = i;
			        break;
			    }
	    	}
	    }
	}
}
if(bizid == 0) return 1;
if(BizInfo[bizid][bOwner] != PlayerInfo[playerid][pID] || BizInfo[bizid][bOwner] == 0) return ErrorMessage(playerid, "This is not your business!");
if(BizInfo[bizid][bLocked] != 1)
{
	BizInfo[bizid][bLocked] = 1;
	InfoMessage(playerid,"You have locked the business.");
}
else
{
	BizInfo[bizid][bLocked] = 0;
	InfoMessage(playerid,"You have unlocked the business.");
}
return 1;
}
CMD:myhouses(playerid)
{
new msg[60];
SendClientMessage(playerid,-1,"-----------------------------------------------------");
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOwner] == PlayerInfo[playerid][pID])
	{
	    format(msg,sizeof(msg),"ID%d",i);
	    SendClientMessage(playerid,-1,msg);
	}
}
SendClientMessage(playerid,-1,"-----------------------------------------------------");
return 1;
}
CMD:hlock(playerid)
{
new house,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.5,HouseInfo[i][hOX],HouseInfo[i][hOY],HouseInfo[i][hOZ]))
	    {
	        house = i;
	        i = MAX_HOUSES;
	    }
	}
}
if(house == 0){
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.5,HouseInfo[i][hIX],HouseInfo[i][hIY],HouseInfo[i][hIZ]))
	    {
	        house = i;
	        i = MAX_HOUSES;
	    }
	}
}}
if(house == 0 || HouseInfo[house][hOwner] != PlayerInfo[playerid][pID]) return 1;
if(HouseInfo[house][hLocked] == 1) {HouseInfo[house][hLocked] = 0;}
else if(HouseInfo[house][hLocked] == 0) {HouseInfo[house][hLocked] = 1;}
return 1;
}
CMD:buyhouse(playerid)
{
new houses;
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOwner] == PlayerInfo[playerid][pID])
	{
	    houses = houses + 1;
	}
}
if(houses >= 2) return ErrorMessage(playerid,"You already own the maximum amount of houses!");
new house,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,3,HouseInfo[i][hOX],HouseInfo[i][hOY],HouseInfo[i][hOZ]))
	    {
	        house = i;
	        i = MAX_HOUSES;
	    }
	}
}
if(house == 0) return 1;
if(HouseInfo[house][hOwner] != 0 && HouseInfo[house][hOwner] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid, "This house is already owned by someone!");
if(GetPlayerMoney(playerid) < HouseInfo[house][hPrice]) return ErrorMessage(playerid, "You can't afford this house!");
GivePMoney(playerid,-HouseInfo[house][hPrice]);
HouseInfo[house][hOwner] = PlayerInfo[playerid][pID];
GetPlayerName(playerid,HouseInfo[house][hOwnerName],65);
new msg[60];
format(msg,60,"You have successfully bought this house! (ID: %d)",house);
InfoMessage(playerid,msg);
Delete3DTextLabel(HouseInfo[house][hLabel]);
new string[60];
format(string,sizeof(string),"[House %d]",house);
HouseInfo[house][hLabel] = Create3DTextLabel(string, 0x00D700FF, HouseInfo[house][hOX], HouseInfo[house][hOY], HouseInfo[house][hOZ], 10.0, 0, 1);
return 1;
}
CMD:sellhouse(playerid)
{
new house,Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] != 0)
	{
 		if(IsPlayerInRangeOfPoint(playerid,1.5,HouseInfo[i][hOX],HouseInfo[i][hOY],HouseInfo[i][hOZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hOVW] && GetPlayerInterior(playerid) == HouseInfo[i][hOInt])
	    {
	        house = i;
	        i = MAX_HOUSES;
	    }
	}
}
if(house == 0) return 1;
if(HouseInfo[house][hOwner] != PlayerInfo[playerid][pID] || HouseInfo[house][hOwner] == 0) return ErrorMessage(playerid, "This is not your house!");
GivePMoney(playerid,HouseInfo[house][hPrice]/2);
HouseInfo[house][hOwner] = 0;
format(HouseInfo[house][hOwnerName],65,"None");
new msg[60];
format(msg,60,"You have successfully sold this house and gained $%d!",HouseInfo[house][hPrice]/2);
InfoMessage(playerid,msg);
Delete3DTextLabel(HouseInfo[house][hLabel]);
new string[60];
format(string,sizeof(string),"[House %d]\nPrice: $%d",house,HouseInfo[house][hPrice]);
HouseInfo[house][hLabel] = Create3DTextLabel(string, 0x00D700FF, HouseInfo[house][hOX], HouseInfo[house][hOY], HouseInfo[house][hOZ], 10.0, 0, 1);
return 1;
}
CMD:tabbed(playerid,params[])
{
SendClientMessage(playerid,-1,"Tabbed Players:");
new msg[60];
for(new i = 0; i < MAX_PLAYERS; i++)
{
    if(IsPlayerConnected(i))
	{
		if(Tabbed[i] > 0)
		{
		    format(msg,sizeof(msg),"{989898}%s | %d seconds",RPN(i,0),Tabbed[i]);
		    SendClientMessage(playerid,-1,msg);
		}
	}
}
return 1;
}
CMD:charity(playerid,params[])
{
new money,msg[164];
if(sscanf(params,"i",money)) return UsageMessage(playerid, "/charity (amount)");
if(GetPlayerMoney(playerid) < money) return ErrorMessage(playerid,"You don't have that much money!");
GivePMoney(playerid,-money);
new time[6],timestr[60];
gettime(time[0], time[1], time[2]);
getdate(time[3], time[4], time[5]);
format(timestr,60,"[%02d.%02d|%02d:%02d]",time[5],time[4], time[0], time[1]);
format(msg, sizeof(msg),"{7AA86C}%s %s has given %d into charity.",timestr,RPN(playerid,0),money);
SendClientMessage(playerid,-1,msg);
SendAdminMessage(-1,msg);
CharityLog(msg);
return 1;
}
CMD:bankcharity(playerid,params[])
{
new money,msg[164];
if(sscanf(params,"i",money)) return UsageMessage(playerid, "/bankcharity (amount)");
if(PlayerInfo[playerid][pBMoney] < money) return ErrorMessage(playerid,"You don't have that much money in the bank!");
PlayerInfo[playerid][pBMoney] = PlayerInfo[playerid][pBMoney] - money;
new time[6],timestr[60];
gettime(time[0], time[1], time[2]);
getdate(time[3], time[4], time[5]);
format(timestr,60,"[%02d.%02d|%02d:%02d]",time[5],time[4], time[0], time[1]);
format(msg, sizeof(msg),"{7AA86C}%s %s has given %d into charity.",timestr,RPN(playerid,0),money);
SendClientMessage(playerid,-1,msg);
SendAdminMessage(-1,msg);
CharityLog(msg);
return 1;
}
CMD:checkbelt(playerid,params[])
{
new playerb,msg[164];
if(sscanf(params,"i",playerb)) return UsageMessage(playerid, "/checkbelt (ID/name)");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(Seatbelt[playerb] == 1) format(msg,sizeof(msg),"%s's belt is on.",RPN(playerb,1));
else if(Seatbelt[playerb] == 0) format(msg,sizeof(msg),"%s's belt is off.",RPN(playerb,1));
SendClientMessage(playerid,-1,msg);
return 1;
}
CMD:admins(playerid)
{
SendClientMessage(playerid,-1,"Administrators:");
new string[128],ltext[60];
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] < 4)
{
	if(IsLogged[i] == 1)
	{
	    if(AdminHideCmds[playerid] == 0)
	    {
	 		if(PlayerInfo[i][pAdmin] == 1) {ltext = "Junior Admin";}
			if(PlayerInfo[i][pAdmin] == 2) {ltext = "Standard Admin";}
			if(PlayerInfo[i][pAdmin] == 3) {ltext = "Senior Admin";}
			if(PlayerInfo[i][pAdmin] == 4) {ltext = "Management";}
			format(string, sizeof(string), "%s {FFFFFF}[%d] %s", ltext, i, RPN(i,0));
			SendClientMessage(playerid, COLOR_ADUTY, string);
		}
	}
}
}
SendClientMessage(playerid,-1,"Moderators:");
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(PlayerInfo[i][pMod] >= 1)
{
	if(IsLogged[i] == 1)
	{
 		if(PlayerInfo[i][pMod] == 1) {ltext = "Junior";}
		if(PlayerInfo[i][pMod] == 2) {ltext = "Standard";}
		if(PlayerInfo[i][pMod] == 3) {ltext = "Senior";}
		format(string, sizeof(string), "{00CED1}%s Mod {FFFFFF}[%d] %s", ltext, i, RPN(i,0));
		SendClientMessage(playerid, -1, string);
	}
}
}
return 1;
}
CMD:windows(playerid)
{
new string[164];
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You are not in a vehicle!");
if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) == 2) return 1;
if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0)
{
	format(string, sizeof(string), "* %s rolls down the windows of the vehicle.", RPN(playerid,1));
	SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
	format(string, sizeof(string), ">> %s rolls down the windows of the vehicle.", RPN(playerid,1));
	SendClientMessage(playerid, COLME, string);
	DVehicles[GetPlayerVehicleID(playerid)][vWindows] = 0;
}
else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0)
{
    format(string, sizeof(string), "* %s rolls up the windows of the vehicle.", RPN(playerid,1));
	SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
	format(string, sizeof(string), ">> %s rolls up the windows of the vehicle.", RPN(playerid,1));
	SendClientMessage(playerid, COLME, string);
	DVehicles[GetPlayerVehicleID(playerid)][vWindows] = 1;
}
return 1;
}
CMD:startdelivery(playerid)
{
if(DVehicles[GetPlayerVehicleID(playerid)][vJob] != 1) return ErrorMessage(playerid,"You have to be in the correct vehicle to start the job!");
if(PlayerInfo[playerid][pJob] != 1) return ErrorMessage(playerid,"You aren't in the Delivery job!");
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMessage(playerid,"You must be the driver of the vehicle to start the job.");
DeliveryJob[playerid] = 1;
SetPlayerCheckpoint(playerid,-1530.7511,2627.7483,55.9297,5);
InfoMessage(playerid, "Follow the red markers to deliver.");
return 1;
}
CMD:seatbelt(playerid) return cmd_sb(playerid);
CMD:sb(playerid)
{
new string[164];
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You are not in a vehicle!");
if(Seatbelt[playerid] != 0)
{
	format(string, sizeof(string), "* %s takes their seatbelt off.", RPN(playerid,1));
	SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
	format(string, sizeof(string), ">> %s takes their seatbelt off.", RPN(playerid,1));
	SendClientMessage(playerid, COLME, string);
	Seatbelt[playerid] = 0;
}
else if(Seatbelt[playerid] == 0)
{
    format(string, sizeof(string), "* %s puts their seatbelt on.", RPN(playerid,1));
	SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
	format(string, sizeof(string), ">> %s puts their seatbelt on.", RPN(playerid,1));
	SendClientMessage(playerid, COLME, string);
	Seatbelt[playerid] = 1;
}
return 1;
}
forward GetPlayerIDFromMask(maskid);
public GetPlayerIDFromMask(maskid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(maskid == i) return i;
		if(PlayerInfo[i][pMaskID] == maskid && maskon[i] == 1) return i;
	}
	return 999;
}
CMD:pay(playerid, params[])
{
new playerb, amount,string[164];
if(sscanf(params,"ii",playerb,amount)) return UsageMessage(playerid, "/pay (playerid) (amount)");
if(GetPlayerMoney(playerid) < amount) return ErrorMessage(playerid, "You don't have that much!");
playerb = GetPlayerIDFromMask(playerb);
if(playerb == 999) ErrorMessage(playerid,"That player is not connected.");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
GivePMoney(playerid, -amount);
GivePMoney(playerb, amount);
format(string,sizeof(string),"takes out some money and gives it to %s.", RPN(playerb,1));
MeMessage(playerid, string);
format(string,sizeof(string),"       %s has given you $%d.", RPN(playerid,1),amount);
SendClientMessage(playerb,-1,string);
return 1;
}
CMD:transfer(playerid, params[])
{
if (!IsPlayerInRangeOfPoint(playerid, 3.0, 2308.8992, -13.4960, 26.7422)) return ErrorMessage(playerid, "You are not near the cashier!");
new playerb, amount,string[164];
if(sscanf(params,"ui",playerb,amount)) return UsageMessage(playerid, "/transfer (playerid) (amount)");
if(PlayerInfo[playerid][pBMoney] < amount) return ErrorMessage(playerid, "You don't have that much on your bank account!");
if(IsLogged[playerb] != 1) return ErrorMessage(playerid, "That player is not connected!");
PlayerInfo[playerid][pBMoney] = PlayerInfo[playerid][pBMoney] - amount;
PlayerInfo[playerb][pBMoney] = PlayerInfo[playerb][pBMoney] + amount;
format(string,sizeof(string),"You have transferred $%d to %s's bank account",amount, RPN(playerb,0));
InfoMessage(playerid, string);
format(string,sizeof(string),"You have received $%d on your bank account from %s.", amount,RPN(playerid,0));
InfoMessage(playerb,string);
return 1;
}
CMD:hangup(playerid)
{
if(InCall[playerid] == -1) return ErrorMessage(playerid, "You are not in a call!");
new string[264];
format(string, sizeof(string), "[Cellphone] %s hangs up their cell phone.",RPN(playerid,1));
ProxDetector(35.0, playerid, string, COLME, COLME, COLME, COLME, COLME);
SendClientMessage(InCall[playerid],-1,"{989898}The other side hung up.");
SendClientMessage(playerid,-1,"{989898}You have hung up.");
InCall[InCall[playerid]] = -1;
InCall[playerid] = -1;
return 1;
}

CMD:pickup(playerid)
{
if(BeingCalled[playerid] == 0) return ErrorMessage(playerid, "You are not being called by anyone!");
if(InCall[playerid] != -1) return ErrorMessage(playerid, "You are already in a call!");
new caller = GetIDFromNumber(BeingCalled[playerid]);
SendClientMessage(caller,-1,"{989898}The other side picked up.");
new string[264];
format(string, sizeof(string), "[Cellphone] %s answers their cell phone.",RPN(playerid,1));
ProxDetector(35.0, playerid, string, COLME, COLME, COLME, COLME, COLME);
SendClientMessage(playerid,-1,"{989898}You have picked up.");
BeingCalled[playerid] = 0;
InCall[playerid] = caller;
InCall[caller] = playerid;
return 1;
}

CMD:call(playerid,params[])
{
if(PlayerInfo[playerid][pPhone] == 0) return ErrorMessage(playerid, "You don't have a phone!");
if(PhonePower[playerid] == 0) return ErrorMessage(playerid, "Your phone is turned off!");
if(InCall[playerid] != -1) return ErrorMessage(playerid, "You are already in a call!");
new tonum,string[264];
if(sscanf(params, "i", tonum)) return UsageMessage(playerid, "/call (number)");
format(string, sizeof(string), "[Cellphone] %s takes out their cellphone.",RPN(playerid,1));
ProxDetector(15.0, playerid, string, COLME, COLME, COLME, COLME, COLME);
if(tonum == 911){
SendClientMessage(playerid,-1,"{989898}The other side picked up.");
SendClientMessage(playerid,-1,"{4DB3C5}OP:{989898} 911, state your emergency.");
InCall[playerid] = 911;
return 1;}
new playerb = GetIDFromNumber(tonum);
if(playerb == -1 || tonum == 0 || PhonePower[playerb] == 0) return ErrorMessage(playerid, "This number is not recognized.");
if(PhoneVib[playerb] == 0){
format(string, sizeof(string), "[Cellphone] %s's cell phone begins to ring.",RPN(playerb,1));
ProxDetector(15.0, playerb, string, COLME, COLME, COLME, COLME, COLME);}
if(PhoneWitheld[playerid] == 1) format(string,sizeof(string),"{989898}Your phone is being called. (Caller: WITHELD)");
else if(PhoneWitheld[playerid] == 0) format(string,sizeof(string),"{989898}Your phone is being called. (Caller: %d)",PlayerInfo[playerid][pPhone]);
SendClientMessage(playerb,-1,string);
InCall[playerid] = playerb;
BeingCalled[playerb] = PlayerInfo[playerid][pPhone];
format(string,sizeof(string),"[Phone %d]{989898}Your phone is being called. (Caller: %d)",PlayerInfo[playerid][pPhone]);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] != 0)
	{
		if(TappingPhone[i][playerid] == 1)
		{
		    format(string,sizeof(string),"[Phone %d] {989898}is calling phone number %d.",PlayerInfo[playerid][pPhone],PlayerInfo[playerb][pPhone]);
	 		InfoMessage(i,string);
		}
		else if(TappingPhone[i][playerb] == 1)
		{
		    format(string,sizeof(string),"[Phone %d] {989898}is being called by %d.",PlayerInfo[playerb][pPhone],PlayerInfo[playerid][pPhone]);
	 		InfoMessage(i,string);
		}
	}
}
return 1;
}

CMD:sms(playerid,params[])
{
if(PlayerInfo[playerid][pPhone] == 0) return ErrorMessage(playerid, "You don't have a phone!");
if(PhonePower[playerid] == 0) return ErrorMessage(playerid, "Your phone is turned off!");
new tonum,msg[164],string[264],frommsg[264];
if(sscanf(params, "is[164]", tonum,msg)) return UsageMessage(playerid, "/sms (number) (message)");
new playerb = GetIDFromNumber(tonum);
if(playerb == -1 || tonum == 0 || PhonePower[playerb] == 0) return ErrorMessage(playerid, "This number is not recognized.");
format(string, sizeof(string), "[Cellphone] %s taps an SMS into their cellphone.",RPN(playerid,1));
ProxDetector(15.0, playerid, string, COLME, COLME, COLME, COLME, COLME);
format(string,sizeof(string),"((SMS)) %s, To: %d",msg,tonum);
SendClientMessage(playerid,0xFFFF00FF,string);
if(PhoneWitheld[playerid] == 1) format(frommsg,sizeof(frommsg),"((SMS)) %s, From: WITHELD",msg);
else if(PhoneWitheld[playerid] == 0) format(frommsg,sizeof(frommsg),"((SMS)) %s, From: %d",msg,PlayerInfo[playerid][pPhone]);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] != 0)
	{
		if(TappingPhone[i][playerid] == 1)
		{
		    format(string,sizeof(string),"{989898}[Phone %d] %s, To: %d",PlayerInfo[playerid][pPhone],msg,tonum);
	 		SendClientMessage(i,-1,string);
		}
		else if(TappingPhone[i][playerb] == 1)
		{
	 		InfoMessage(i,frommsg);
		}
	}
}
SendClientMessage(playerb,0xFFFF00FF,frommsg);
if(PhoneVib[playerb] == 0){
format(string, sizeof(string), "*** %s's phone beeps.",RPN(playerb,1));
ProxDetector(15.0, playerb, string, COLME, COLME, COLME, COLME, COLME);}
return 1;
}
CMD:stoptoolkit(playerid)
{
if(Tooling[playerid] == 0) return ErrorMessage(playerid, "You aren't toolkitting a vehicle!");
InfoMessage(playerid, "You have stopped toolkitting the vehicle.");
Tooling[playerid] = 0;
PlayerTextDrawHide(playerid,PickingText[playerid]);
PlayerTextDrawHide(playerid,PickText[playerid]);
TogglePlayerControllable(playerid, 1);
return 1;
}
CMD:toolkit(playerid)
{
	if(GetClosestVehicle(playerid, 3) <= 0) return ErrorMessage(playerid, "You are not near a vehicle!");
	if(PlayerInfo[playerid][pToolkit] == 0) return ErrorMessage(playerid, "You don't have a toolkit!");
    new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
   	vehicleid = GetClosestVehicle(playerid, 3);
   	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    if(IsPlayerInAnyVehicle(playerid)) vehicleid = GetPlayerVehicleID(playerid);
    if(DVehicles[vehicleid][vRenter] == 1111 && DVehicles[vehicleid][vRental] == 1) return ErrorMessage(playerid, "You cannot toolkit a unrented rental!");
    if(PlayerInfo[playerid][pID] == DVehicles[vehicleid][vOwner]) return ErrorMessage(playerid, "This is your vehicle!");
	if(doors == 1)
	{
	    TogglePlayerControllable(playerid, 0);
	    PlayerTextDrawShow(playerid, PickText[playerid]);
	    PlayerTextDrawShow(playerid, PickingText[playerid]);
	    Tooling[playerid] = 120;
		MeMessage(playerid, "starts picking the vehicle's lock.");
		return 1;
	}
	ErrorMessage(playerid, "This vehicle is already unlocked!");
    return 1;
}
CMD:requesthelp(playerid, params[])
{
new text[60], string[160];
if(sscanf(params, "s[260]", text)) return UsageMessage(playerid, "/requesthelp (text)");
SendClientMessage(playerid, -1, "{50DAF2}[Request] Your request has been sent to the Staff Team.");
format(string,sizeof(string),"{50DAF2}[Request] '%s' From: %s", text, RPN(playerid,0));
SendAdminMessage(COLOR_ADUTY, string);
SendModMessage(-1,string);
return 1;
}
CMD:report(playerid, params[])
{
new text[60], string[160];
if(sscanf(params, "s[260]", text)) return UsageMessage(playerid, "/report (text)");
format(string,sizeof(string),"[Report] '%s' sent to the administration team.", text);
SendClientMessage(playerid, COLOR_YELLOW, string);
SendClientMessage(playerid, COLOR_YELLOW, "[Report] Please do NOT spam reports. Wait 10 minutes until reporting the same thing again.");
format(string,sizeof(string),"[Report] '%s' From: %s (ID: %d)", text, RPN(playerid,0), playerid);
SendAdminMessage(COLOR_ADUTY, string);
return 1;
}
CMD:balance(playerid)
{
if (!IsPlayerInRangeOfPoint(playerid, 3.0, 2308.8992, -13.4960, 26.7422)) return ErrorMessage(playerid, "You are not near the cashier!");
new string[480];
format(string,sizeof(string), "Your bank balance is $%d.", PlayerInfo[playerid][pBMoney]);
InfoMessage(playerid, string);
return 1;
}
CMD:withdraw(playerid, params[])
{
if (!IsPlayerInRangeOfPoint(playerid, 3.0, 2308.8992, -13.4960, 26.7422)) return ErrorMessage(playerid, "You are not near the cashier!");
new amount;
if(sscanf(params, "i", amount)) return UsageMessage(playerid, "/withdraw (amount)");
if (PlayerInfo[playerid][pBMoney] < amount) return ErrorMessage(playerid, "You don't have that much on your bank account!");
PlayerInfo[playerid][pBMoney] = PlayerInfo[playerid][pBMoney] - amount;
GivePMoney(playerid, amount);
new string[480];
format(string,sizeof(string), "You withdrew $%d. Your bank balance is $%d now.", amount, PlayerInfo[playerid][pBMoney]);
InfoMessage(playerid, string);
return 1;
}
CMD:deposit(playerid, params[])
{
if (!IsPlayerInRangeOfPoint(playerid, 3.0, 2308.8992, -13.4960, 26.7422)) return ErrorMessage(playerid, "You are not near the cashier!");
new amount;
if(sscanf(params, "i", amount)) return UsageMessage(playerid, "/deposit (amount)");
if (GetPlayerMoney(playerid) < amount) return ErrorMessage(playerid, "You don't have enough money!");
new string[480];
GivePMoney(playerid,-amount);
PlayerInfo[playerid][pBMoney] = PlayerInfo[playerid][pBMoney] + amount;
format(string,sizeof(string), "You deposited $%d. Your bank balance is $%d now.", amount, PlayerInfo[playerid][pBMoney]);
InfoMessage(playerid, string);
return 1;
}
CMD:takejob(playerid)
{
if (IsPlayerInRangeOfPoint(playerid, 3.0, -1536.0004,2564.1389,55.8359))
{
	if (PlayerInfo[playerid][pJob] != 0) return ErrorMessage(playerid, "You already have a job!");
	PlayerInfo[playerid][pJob] = 1;
	InfoMessage(playerid, "You are now a Delivery Guy.");
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, -1507.5129,2560.5530,55.8359))
{
	if (PlayerInfo[playerid][pJob] != 0) return ErrorMessage(playerid, "You already have a job!");
	PlayerInfo[playerid][pJob] = 2;
	InfoMessage(playerid, "You are now a Mechanic.");
}
return 1;
}
CMD:quitjob(playerid)
{
if (PlayerInfo[playerid][pJob] == 0) return ErrorMessage(playerid, "You don't have a job!");
PlayerInfo[playerid][pJob] = 0;
InfoMessage(playerid, "You have left your current job.");
return 1;
}
CMD:buy(playerid)
{
new biz;
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
		if(IsPlayerInRangeOfPoint(playerid,1.5,BizInfo[i][bBX],BizInfo[i][bBY],BizInfo[i][bBZ])  && GetPlayerVirtualWorld(playerid) == BizInfo[i][bIVW] && GetPlayerInterior(playerid) == BizInfo[i][bIInt])
		{
		    biz = i;
		    break;
		}
	}
}
if(biz == 0) return 1;
{
	switch (BizInfo[biz][bType])
	{
		case 1: ShowPlayerDialog(playerid, DIALOG_SHOP, DIALOG_STYLE_LIST, "24/7 Item List", "[$100] Mask\n[$85] Toolkit\n[$60] Camera\n[$125] Cell Phone\n[$85] Portable Radio\n[$75] Medikit\n[$25] Lottery Ticket\n[$50] Screwdriver\n[$65] Gas Can\n[$200] Boombox", "Select", "Cancel");
		case 2: 
		{
			if(PlayerInfo[playerid][pDuty] == 1) return ErrorMessage(playerid,"You cannot change clothes while on police duty.");
			ShowPlayerDialog(playerid,DIALOG_CLOTHES, DIALOG_STYLE_INPUT, "Clothes Shop", "Price: $20\nEnter the Skin ID you want", "Enter", "Cancel");
		}
		case 3,4,5: ShowPlayerDialog(playerid,DIALOG_DRINKS, DIALOG_STYLE_LIST, "Drinks Menu", "[$3] Soda\n[$5] Beer\n[$20] Wine", "Select", "Cancel");
		case 6,7: ErrorMessage(playerid,"To be made.");
	}
}
return 1;
}
CMD:setchannel(playerid,params[])
{
if(PlayerInfo[playerid][pRadio] == 0) return ErrorMessage(playerid, "You don't have a portable radio!");
new radio, channel;
if(sscanf(params, "dd",radio,channel)) return UsageMessage(playerid, "/setchannel (slot) (channel)");
if(radio == 1) {PlayerInfo[playerid][pRadio1] = channel;}
else if(radio == 2) {PlayerInfo[playerid][pRadio2] = channel;}
InfoMessage(playerid,"Radio channel changed.");
return 1;
}
CMD:pr1(playerid,params[])
{
if(PlayerInfo[playerid][pRadio] == 0) return ErrorMessage(playerid, "You don't have a portable radio!");
new message[124],string[124];
if(sscanf(params, "s[124]",message)) return UsageMessage(playerid, "/pr1 (message)");
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(PlayerInfo[i][pRadio1] == PlayerInfo[playerid][pRadio1] || PlayerInfo[i][pRadio2] == PlayerInfo[playerid][pRadio1])
	{
	    if(IsLogged[i] == 1)
	    {
	        new slot;
	        if(PlayerInfo[i][pRadio1] == PlayerInfo[playerid][pRadio1]) {slot = 1;}
	        else if(PlayerInfo[i][pRadio2] == PlayerInfo[playerid][pRadio1]) {slot = 2;}
	        format(string,sizeof(string),"* (Slot %d) (Channel %d) %s: %s *",slot,PlayerInfo[playerid][pRadio1],RPN(playerid,1),message);
			SendClientMessage(i, 0x5E944EFF, string);
		}
	}
}
if(IsPlayerInAnyVehicle(playerid)){
if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
format(string, sizeof(string), "(Windows Up) (Radio) %s says: %s", RPN(playerid,1), message);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
	{
		SendClientMessage(i, -1, string);
	}
}
return 1;}
else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
format(string, sizeof(string), "(Windows Down) (Radio) %s says: %s", RPN(playerid,1), message);
ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
return 1;}}
}
format(string, sizeof(string), "* (Radio) %s says: %s *", RPN(playerid,1), message);
ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
return 1;
}
CMD:pr2(playerid,params[])
{
if(PlayerInfo[playerid][pRadio] == 0) return ErrorMessage(playerid, "You don't have a portable radio!");
new message[124],string[124];
if(sscanf(params, "s[124]",message)) return UsageMessage(playerid, "/pr2 (message)");
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(PlayerInfo[i][pRadio1] == PlayerInfo[playerid][pRadio2] || PlayerInfo[i][pRadio2] == PlayerInfo[playerid][pRadio2])
	{
	    if(IsLogged[i] == 1)
	    {
	        new slot;
	        if(PlayerInfo[i][pRadio1] == PlayerInfo[playerid][pRadio2]) {slot = 1;}
	        else if(PlayerInfo[i][pRadio2] == PlayerInfo[playerid][pRadio2]) {slot = 2;}
	        format(string,sizeof(string),"* (Slot %d) (Channel %d) %s: %s *",slot,PlayerInfo[playerid][pRadio2],RPN(playerid,1),message);
			SendClientMessage(i, 0x5E944EFF, string);
		}
	}
}
if(IsPlayerInAnyVehicle(playerid)){
if(VehicleWindow(GetVehicleModel(GetPlayerVehicleID(playerid))) != 2){
if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] != 0){
format(string, sizeof(string), "(Windows Up) (Radio) %s says: %s", RPN(playerid,1), message);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(i))
	{
		SendClientMessage(i, -1, string);
	}
}
return 1;}
else if(DVehicles[GetPlayerVehicleID(playerid)][vWindows] == 0){
format(string, sizeof(string), "(Windows Down) (Radio) %s says: %s", RPN(playerid,1), message);
ProxDetector(6.0, playerid,string, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
return 1;}}
}
format(message, sizeof(message), "* (Radio) %s says: %s *", RPN(playerid,1), message);
ProxDetector(6.0, playerid,message, -1, -1, -1, 0x8D8D8DFF, 0x8D8D8DFF);
return 1;
}
CMD:channels(playerid)
{
if(PlayerInfo[playerid][pRadio] == 0) return ErrorMessage(playerid, "You don't have a portable radio!");
new string[146];
SendClientMessage(playerid,-1,"--------Channels--------");
format(string,sizeof(string), "Slot 1: %d",PlayerInfo[playerid][pRadio1]);
SendClientMessage(playerid,-1,string);
format(string,sizeof(string), "Slot 2: %d",PlayerInfo[playerid][pRadio2]);
SendClientMessage(playerid,-1,string);
SendClientMessage(playerid,-1,"----------------------------");
return 1;
}
CMD:withold(playerid)
{
if(PlayerInfo[playerid][pPhone] == 0) return ErrorMessage(playerid, "You don't have a phone!");
if(PhoneWitheld[playerid] == 1)
{
	PhoneWitheld[playerid] = 0;
	MeMessage(playerid,"stops witholding their phone number.");
}
else
{
    PhoneWitheld[playerid] = 1;
	MeMessage(playerid,"witholds their phone number.");
}
return 1;
}
CMD:togphone(playerid)
{
if(PlayerInfo[playerid][pPhone] == 0) return ErrorMessage(playerid, "You don't have a phone!");
if(PhonePower[playerid] == 1)
{
	PhonePower[playerid] = 0;
	MeMessage(playerid,"turns their phone off.");
}
else
{
    PhonePower[playerid] = 1;
	MeMessage(playerid,"turns their phone on.");
}
return 1;
}
CMD:togvibrate(playerid)
{
if(PlayerInfo[playerid][pPhone] == 0) return ErrorMessage(playerid, "You don't have a phone!");
if(PhoneVib[playerid] == 1)
{
	PhoneVib[playerid] = 0;
	InfoMessage(playerid, "You have put your phone off vibrate.");
}
else
{
    PhoneVib[playerid] = 1;
	InfoMessage(playerid, "You have put your phone on vibrate.");
}
return 1;
}
CMD:licenses(playerid, params[])
{
new targetid,playerb;
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/licenses (playerid)");
if(IsLogged[playerb] != 1)
{
	targetid = GetPlayerIDFromMask(playerb);
	if(targetid == -1) ErrorMessage(targetid,"That player is not connected.");
}
else targetid = playerb;
if(!IsPlayerNearPlayer(playerid,targetid,3)) return ErrorMessage(playerid, "You are not near that player!");
new string[128], atext[60],btext[60],gender[60];
if (PlayerInfo[playerid][pDLicense] == 0){ atext = "No"; }
if (PlayerInfo[playerid][pDLicense] == 1){ atext = "Yes"; }
if (PlayerInfo[playerid][pFLicense] == 0){ btext = "No"; }
if (PlayerInfo[playerid][pFLicense] == 1){ btext = "Yes"; }
if (PlayerInfo[playerid][pGender] == 1){ gender = "Male"; }
if (PlayerInfo[playerid][pGender] == 2){ gender = "Female"; }
format(string, sizeof(string), "shows their licenses to %s.", RPN(targetid,1));
MeMessage(playerid, string);
SendClientMessage(targetid, -1, "{4DB3C5}|___________________SAN ANDREAS LICENSES___________________|");
format(string, sizeof(string), "Full Name: %s | Date of Birth: %s | Gender: %s", RPN(playerid,0),PlayerInfo[playerid][pDOB],gender);
SendClientMessage(targetid, -1, string);
format(string, sizeof(string), "Driving License: %s | Flying License: %s", atext,btext);
SendClientMessage(targetid, -1, string);
return 1;
}
CMD:mask(playerid)
{
if(PlayerInfo[playerid][pMask] == 0) return ErrorMessage(playerid, "You don't have a mask");
if(maskon[playerid] == 0)
    {
        maskon[playerid] = 1;
        MeMessage(playerid,"puts their mask on.");
        Delete3DTextLabel(label[playerid]);
        label[playerid] = Create3DTextLabel(RPN(playerid,1), -1, 30.0, 40.0, 50.0, 4.0, 0);
    	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
		return 1;
    }
else if(maskon[playerid] == 1)
    {
        MeMessage(playerid,"takes their mask off.");
        maskon[playerid] = 0;
        Delete3DTextLabel(label[playerid]);
        label[playerid] = Create3DTextLabel(RPN(playerid,0), -1, 30.0, 40.0, 50.0, 4.0, 0);
    	Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.15);
		return 1;
    }
return 1;
}
forward HotwireVeh(playerid);
public HotwireVeh(playerid)
{
	new randomm = randomEx(1,100);
    if(randomm < 81 && randomm > 0){
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(GetPlayerVehicleID(playerid), 1, lights, alarm, doors, bonnet, boot, objective);
	TextDrawSetString(enginestate[playerid], "On");
	TogglePlayerControllable(playerid, 1);
	MeMessage(playerid,"successfully hotwires the ignition of the vehicle.");}
	else if(randomm > 80 && randomm < 101)
	{
		MeMessage(playerid,"fails to hotwire the ignition of the vehicle.");
		TogglePlayerControllable(playerid, 1);
	}
	Hotwire[playerid] = -1;
}
CMD:stophotwire(playerid)
{
if(Hotwire[playerid] == 0) return ErrorMessage(playerid, "You aren't hotwiring a vehicle!");
TogglePlayerControllable(playerid, 1);
KillTimer(Hotwire[playerid]);
InfoMessage(playerid, "You have stopped hotwiring the vehicle.");
return 1;
}
CMD:carradio(playerid,params[])
{
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You must be in a vehicle to use this command.");
new vehicleid,string[164];
if(IsPlayerInAnyVehicle(playerid))
{
    vehicleid = GetPlayerVehicleID(playerid);
	if(DVehicles[vehicleid][vRadioOn] == 1)
	{
	    format(string, sizeof(string), "* %s turns off the car radio.", RPN(playerid,1));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s turns off the car radio.", RPN(playerid,1));
		SendClientMessage(playerid, COLME, string);
	    DVehicles[vehicleid][vRadioOn] = 0;
	    for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsLogged[i] == 1)
			{
			    if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid)
			    {
			        StopAudioStreamForPlayer(i);
				}
			}
		}
		return 1;
	}
}
new url[124];
if(sscanf(params, "s[124]", url)) return UsageMessage(playerid, "/carradio (url)");
vehicleid = GetPlayerVehicleID(playerid);
format(string, sizeof(string), "* %s changes the car radio station.", RPN(playerid,1));
SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
format(string, sizeof(string), ">> %s changes the car radio station.", RPN(playerid,1));
SendClientMessage(playerid, COLME, string);
DVehicles[vehicleid][vRadioOn] = 1;
format(DVehicles[vehicleid][vRadio],124,url);
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsLogged[i] == 1)
	{
	    if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid)
	    {
	        PlayAudioStreamForPlayer(i, url);
		}
	}
}
return 1;
}
CMD:engine(playerid)
{
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You need to be the driver!");
    new vehicleid = GetPlayerVehicleID(playerid);
    if(VehicleHasEngine(vehicleid) == 1) return 1;
    new hotwire,string[164];
    if(DVehicles[vehicleid][vJob] != 0 && PlayerInfo[playerid][pJob] != DVehicles[vehicleid][vJob]) return ErrorMessage(playerid, "You don't have the keys for this vehicle!");
	if(DVehicles[vehicleid][vDMV] == 1 && PlayerInfo[playerid][pTakingTest] == 0) return ErrorMessage(playerid, "You must be taking a DMV test to start this vehicle!");
	if(DVehicles[vehicleid][vRental] == 1 && IsRenting[playerid] != vehicleid) return ErrorMessage(playerid, "You don't have the keys for this vehicle!");
	if(DVehicles[vehicleid][vFuel] <= 0) return ErrorMessage(playerid,"The vehicle has no fuel in it!");
	new Float:health;
	GetVehicleHealth(vehicleid, health);
	if(health <= 270) return ErrorMessage(playerid,"The engine of this vehicle is broken down!");
	if(DVehicles[vehicleid][vOwner] != PlayerInfo[playerid][pID] && DVehicles[vehicleid][vFaction] == 0 && PlayerInfo[playerid][pJob] != DVehicles[vehicleid][vJob] && DVehicles[vehicleid][vFaction] != 0 && DVehicles[vehicleid][vFaction] != PlayerInfo[playerid][pFac]) hotwire = 1;
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
    if(engine == 1)
	{
		SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
		format(string, sizeof(string), "* %s twists their key in the ignition, turning the engine of the %s off.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s twists their key in the ignition, turning the engine of the %s off.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
		TextDrawSetString(enginestate[playerid], "Off");
	}
    else
    {
        if(hotwire == 1){
        if(PlayerInfo[playerid][pToolkit] == 0) return ErrorMessage(playerid, "You don't have a toolkit!");
        Hotwire[playerid] = 15;
		MeMessage(playerid,"starts hotwiring the vehicle's ignition.");
		TogglePlayerControllable(playerid, 0);
		return 1;}
    	SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		format(string, sizeof(string), "* %s twists their key in the ignition, turning the engine of the %s on.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s twists their key in the ignition, turning the engine of the %s on.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
		TextDrawSetString(enginestate[playerid], "On");
	}
    return 1;
}
CMD:lights(playerid)
{
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You need to be the driver!");
    new engine, lights, alarm, doors, bonnet, boot, objective,string[164];
    new vehicleid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    if(lights == 1)
    {
    	SetVehicleParamsEx(vehicleid, engine, 0, alarm, doors, bonnet, boot, objective);
    	format(string, sizeof(string), "* %s turns the lights of the %s off.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s turns the lights of the %s off.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
	}
    else
	{
		SetVehicleParamsEx(vehicleid, engine, 1, alarm, doors, bonnet, boot, objective);
		format(string, sizeof(string), "* %s turns the lights of the %s on.", RPN(playerid,1), GetVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, string, COLME, 15.0, 2000);
		format(string, sizeof(string), ">> %s turns the lights of the %s on.", RPN(playerid,1), GetVehicleName(vehicleid));
		SendClientMessage(playerid, COLME, string);
	}
    return 1;
}
CMD:trunk(playerid)
{
    if(GetClosestVehicle(playerid, 4) <= 0 && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMessage(playerid, "You are not near or driving a vehicle!");
    new engine, lights, alarm, doors, bonnet, boot, objective,string[164];
    new vehicleid = GetClosestVehicle(playerid, 3);
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    if(doors != 0) return ErrorMessage(playerid,"This vehicle is locked!");
    if(boot == 1)
    {
    	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
    	format(string, sizeof(string), "closes the trunk of the %s.",GetVehicleName(vehicleid));
    	AmeMessage(playerid,string);
	}
    else
	{
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
		format(string, sizeof(string), "opens the trunk of the %s.", GetVehicleName(vehicleid));
		AmeMessage(playerid,string);
	}
    return 1;
}
CMD:removecp(playerid)
{
DisablePlayerCheckpoint(playerid);
return 1;
}
CMD:p(playerid, params[]) return cmd_pm(playerid, params);
CMD:pm(playerid, params[])
{
new playerb, text[128], string[128];
if(sscanf(params, "us[128]", playerb, text)) return UsageMessage(playerid, "/p(m) (nick/id) (message)");
if(!IsPlayerConnected(playerb)) return ErrorMessage(playerid, "Player is not connected.");
format(string, sizeof(string), "(( PM to %s {%d}: %s ))", RPN(playerb,0),playerb, text);
SendSplitMessage(playerid, COLOR_YELLOW, string);
format(string, sizeof(string), "(( PM from %s {%d}: %s ))", RPN(playerid,0),playerid, text);
SendSplitMessage(playerb, COLOR_YELLOW, string);
format(string, sizeof(string), "(( PM from %s to %s: %s ))", RPN(playerid,0),RPN(playerb,0), text);
ChatLog(string);
return 1;
}
CMD:ooc(playerid, params[]) return cmd_o(playerid, params);
CMD:o(playerid, params[])
{
new string[128];
if(sscanf(params, "s[128]", string)) return UsageMessage(playerid,"/o(oc) (message)");
if (oocstatus == 1) return ErrorMessage(playerid, "OOC Chat is currently disabled.");
format(string,sizeof(string),"{609ABD}(( {Global OOC} %s: %s ))", RPN(playerid,0), params);
SendClientMessageToAll(-1,string);
ChatLog(string);
return 1;
}
CMD:ping(playerid, params[]) return SendClientMessage(playerid, -1,"Pong!");
CMD:mypos(playerid)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
new string[150];
format(string, sizeof(string), "{00FF00}[POS] {5C5C5C}X = %f , Y = %f , Z = %f", x,y,z);
SendClientMessage(playerid, -1, string);
return 1;
}
CMD:checkveh(playerid, params[])
{
new vehid,string[164];
if(sscanf(params, "i", vehid)) return UsageMessage(playerid, "/checkveh (vehicle)");
if(GetClosestVehicle(playerid, 3) != vehid) return ErrorMessage(playerid, "You are not near that vehicle!");
new engine, lights, alarm, doors, bonnet, boot, objective;
GetVehicleParamsEx(vehid, engine, lights, alarm, doors, bonnet, boot, objective);
format(string, sizeof(string), "Vehicle ID %d's status:", vehid);
SendClientMessage(playerid, -1, string);
format(string, sizeof(string), "Plate number: %s", DVehicles[vehid][vPlate]);
SendClientMessage(playerid, -1, string);
if(DVehicles[vehid][vWindows] == 1) SendClientMessage(playerid, -1, "Windows - Up");
else if(DVehicles[vehid][vWindows] == 0) SendClientMessage(playerid, -1, "Windows - Down");
if(doors == 1) SendClientMessage(playerid, -1, "Doors - Locked");
else if(doors == 0) SendClientMessage(playerid, -1, "Doors - Unlocked");
return 1;
}
CMD:clearchat(playerid, params[])
{
	for(new i = 0; i < 50; i++)
	SendClientMessage(playerid, -1," ");
	InfoMessage(playerid, "You have cleared the chat!");
   	return 1;
}
CMD:me(playerid, params[])
{
	new text[128];
	if(sscanf(params, "s[127]", text)) return UsageMessage(playerid, "/me (action)");
	MeMessage(playerid, text);
	return 1;
}
CMD:ame(playerid, params[])
{
	new text[128];
	if(sscanf(params, "s[127]", text)) return UsageMessage(playerid, "/ame (action)");
	AmeMessage(playerid, text);
	return 1;
}
CMD:b(playerid, params[])
{
	new text[128], string[128];
	if(sscanf(params, "s[127]", text)) return UsageMessage(playerid, "/b (text)");
	format(string, sizeof(string), "(( {Local OOC} %s {%d}: %s ))", RPN(playerid,0), playerid, text);
	ProxDetector(15.0, playerid, string, 0x8D8D8DFF, 0x8D8D8DFF, 0x7D7D7DFF, 0x6B6B6BFF, 0x5C5C5CFF);
	ChatLog(string);
	return 1;
}
CMD:do(playerid, params[])
{
	new text[128];
	if(sscanf(params, "s[127]", text)) return UsageMessage(playerid, "/do (action)");
	DoMessage(playerid, text);
	return 1;
}
CMD:s(playerid, params[]) return cmd_shout(playerid, params);
CMD:shout(playerid, params[])
{
	new text[128], string[128];
	if(sscanf(params, "s[127]", text)) return UsageMessage(playerid, "/s(hout) (text)");
	format(string, sizeof(string), "%s shouts: %s", RPN(playerid,1), text);
	ProxDetector(17.0, playerid, string, -1,-1,-1,-1,-1);
	ChatLog(string);
	return 1;
}
CMD:l(playerid, params[]) return cmd_low(playerid, params);
CMD:low(playerid, params[])
{
	new text[128], string[128];
	if(sscanf(params, "s[127]", text)) return UsageMessage(playerid, "/l(ow) (text)");
	format(string, sizeof(string), "(Low) %s says: %s", RPN(playerid,1), text);
	ProxDetector(3.0,playerid, string, 0x6B6B6BFF, 0x6B6B6BFF, 0x6B6B6BFF, 0x6B6B6BFF, 0x6B6B6BFF);
	ChatLog(string);
	return 1;
}
CMD:taketest(playerid)
{
if (!IsPlayerInRangeOfPoint(playerid, 3.0, 1490.5454,1305.7091,1093.2964)) return ErrorMessage(playerid, "You are not near the licensing desk!");
if (PlayerInfo[playerid][pTakingTest] == 1) return ErrorMessage(playerid, "You are already taking a DMV test!");
if(GetPlayerMoney(playerid) < TYPA_PRICE) return ErrorMessage(playerid,"You cannot afford that!");
PlayerInfo[playerid][pTakingTest] = 1;
InfoMessage(playerid, "You started taking a DMV test. Go outside and enter a DMV vehicle to start.");
return 1;
}
CMD:starttest(playerid)
{
if(PlayerInfo[playerid][pTakingTest] != 1) return ErrorMessage(playerid, "You must be taking a test to continue!");
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMessage(playerid, "You need to be the driver of a DMV vehicle!");
new vehid = GetPlayerVehicleID(playerid);
if(DVehicles[vehid][vDMV] != 1) return ErrorMessage(playerid, "You need to be in a DMV vehicle!");
new engine, lights, alarm, doors, bonnet, boot, objective;
GetVehicleParamsEx(vehid, engine, lights, alarm, doors, bonnet, boot, objective);
if(engine == 0)
{
	SetVehicleParamsEx(vehid, 1, lights, alarm, doors, bonnet, boot, objective);
	AmeMessage(playerid,"starts the vehicle's engine.");
}
InfoMessage(playerid, "You started the driving test, follow the checkpoints to finish it.");
DMVTest[playerid] = 1;
SetPlayerCheckpoint(playerid,-1493.1528,2571.2371,55.5589,5);
return 1;
}
CMD:rentveh(playerid)
{
new vehid = GetPlayerVehicleID(playerid);
if(DVehicles[vehid][vRental] != 1) return ErrorMessage(playerid, "You are not in a rental vehicle!");
if(DVehicles[vehid][vRenter] != playerid && DVehicles[vehid][vRenter] != 1111) return ErrorMessage(playerid, "This vehicle is already rented by someone!");
if(IsRenting[playerid] != 1111) return ErrorMessage(playerid, "You cannot rent more than one vehicle!");
if(GetPlayerMoney(playerid) < VEH_RENT_PRICE) return ErrorMessage(playerid, "You cannot afford to rent this vehicle!");
DVehicles[vehid][vRenter] = playerid;
GivePMoney(playerid, -VEH_RENT_PRICE);
new string[160];
format(string,sizeof(string),"You have rented this vehicle for $%d.", VEH_RENT_PRICE);
IsRenting[playerid] = vehid;
InfoMessage(playerid,string);
return 1;
}
CMD:passgun(playerid, params[])
{
new playerb;
if(sscanf(params, "u", playerb)) return UsageMessage(playerid, "/passgun (ID/name)");
if(PlayerInfo[playerid][pDuty] == 1) return 1;
if(HasWeapon[playerid] == 0) return ErrorMessage(playerid, "You don't have a weapon in hand!");
if(!IsPlayerNearPlayer(playerid,playerb,3)) return ErrorMessage(playerid, "You are not near that player!");
if(HasWeapon[playerb] != 0) return ErrorMessage(playerid, "That player has a weapon in hand!");
new string[160], gunname[60], gunid, ammo;
GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),gunid,ammo);
GivePlayerWeapon(playerb,gunid,ammo);
GetWeaponName(GetPlayerWeapon(playerid), gunname, sizeof(gunname));
format(string, sizeof(string), "passes their %s to %s.", gunname, RPN(playerb,1));
AmeMessage(playerid,string);
ResetPlayerWeapons(playerid);
HasWeapon[playerb] = 1;
HasWeapon[playerid] = 0;
return 1;
}

CMD:ps(playerid, params[])
{
new slot, taken, gunid,pocket[60];
if(sscanf(params, "i", slot)) return UsageMessage(playerid, "/ps (slot)");
if(slot < 1 || slot > 4) return ErrorMessage(playerid, "Invalid weapon slot.");
if(slot == 4 && PlayerInfo[playerid][pDuty] != 1) return ErrorMessage(playerid, "Invalid weapon slot.");
if(GetPlayerWeapon(playerid) == 0) return ErrorMessage(playerid, "You don't have a weapon in hand!");
if(slot != 4){
if(IsGunStorable(GetPlayerWeapon(playerid)) == 0 || HasTazer[playerid] == 1) return ErrorMessage(playerid, "You can't store this kind of a weapon in your slots!");}
if(slot == 1){if(PlayerInfo[playerid][pGun1] != 0) taken = 1; format(pocket,60,"trousers pocket");}
else if(slot == 2){if(PlayerInfo[playerid][pGun2] != 0) taken = 1; format(pocket,60,"jacket pocket");}
else if(slot == 3){if(PlayerInfo[playerid][pGun3] != 0) taken = 1; format(pocket,60,"back pocket");}
else if(slot == 4){if(PlayerInfo[playerid][pGun4] != 0) taken = 1; format(pocket,60,"back strap");}
if(PlayerInfo[playerid][pDuty] == 1) format(pocket,60,"duty belt");
if(taken != 0) return ErrorMessage(playerid, "This slot is already taken!");
if(slot == 1){GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGun1],PlayerInfo[playerid][pGunAmmo1]); gunid = PlayerInfo[playerid][pGun1];}
else if(slot == 2){GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGun2],PlayerInfo[playerid][pGunAmmo2]); gunid = PlayerInfo[playerid][pGun2];}
else if(slot == 3){GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGun3],PlayerInfo[playerid][pGunAmmo3]); gunid = PlayerInfo[playerid][pGun3];}
else if(slot == 4){GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGun4],PlayerInfo[playerid][pGunAmmo4]); gunid = PlayerInfo[playerid][pGun4];}
new string[160], gunname[60];
GetWeaponName(gunid, gunname, sizeof(gunname));
format(string, sizeof(string), "holsters their %s into their %s.",gunname,pocket);
AmeMessage(playerid,string);
PlayerInfo[playerid][pGunHold] = 0;
PlayerInfo[playerid][pGunHoldAmmo] = 0;
ResetPlayerWeapons(playerid);
HasWeapon[playerid] = 0;
return 1;
}

CMD:pt(playerid, params[])
{
new slot, gunname[60],pocket[60];
if(sscanf(params, "i", slot)) return UsageMessage(playerid, "/pt (slot)");
if(slot < 1 || slot > 4) return ErrorMessage(playerid, "Invalid weapon slot.");
if(slot == 4 && PlayerInfo[playerid][pDuty] != 1) return ErrorMessage(playerid, "Invalid weapon slot.");
if(GetPlayerWeapon(playerid) != 0) return ErrorMessage(playerid, "You can hold only one weapon in your hand!");
if(slot == 1){slot = PlayerInfo[playerid][pGun1]; format(pocket,60,"trousers pocket"); GetWeaponName(PlayerInfo[playerid][pGun1], gunname, sizeof(gunname)); GivePlayerWeapon(playerid,PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pGunAmmo1]); PlayerInfo[playerid][pGun1] = 0; PlayerInfo[playerid][pGunHoldAmmo] = PlayerInfo[playerid][pGunAmmo1]; PlayerInfo[playerid][pGunAmmo1] = 0;}
else if(slot == 2){slot = PlayerInfo[playerid][pGun2]; format(pocket,60,"jacket pocket"); GetWeaponName(PlayerInfo[playerid][pGun2], gunname, sizeof(gunname)); GivePlayerWeapon(playerid,PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pGunAmmo2]); PlayerInfo[playerid][pGun2] = 0; PlayerInfo[playerid][pGunHoldAmmo] = PlayerInfo[playerid][pGunAmmo2]; PlayerInfo[playerid][pGunAmmo2] = 0;}
else if(slot == 3){slot = PlayerInfo[playerid][pGun3]; format(pocket,60,"back pocket"); GetWeaponName(PlayerInfo[playerid][pGun3], gunname, sizeof(gunname)); GivePlayerWeapon(playerid,PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pGunAmmo3]); PlayerInfo[playerid][pGun3] = 0; PlayerInfo[playerid][pGunHoldAmmo] = PlayerInfo[playerid][pGunAmmo3]; PlayerInfo[playerid][pGunAmmo3] = 0;}
else if(slot == 3){slot = PlayerInfo[playerid][pGun4]; format(pocket,60,"back strap"); GetWeaponName(PlayerInfo[playerid][pGun4], gunname, sizeof(gunname)); GivePlayerWeapon(playerid,PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pGunAmmo4]); PlayerInfo[playerid][pGun4] = 0; PlayerInfo[playerid][pGunHoldAmmo] = PlayerInfo[playerid][pGunAmmo4]; PlayerInfo[playerid][pGunAmmo4] = 0;}
if(PlayerInfo[playerid][pDuty] == 1 && slot != 4) format(pocket,60,"duty belt");
new string[160];
GetWeaponName(slot, gunname, sizeof(gunname));
PlayerInfo[playerid][pGunHold] = GetPlayerWeapon(playerid);
format(string, sizeof(string), "unholsters their %s from their %s.",gunname,pocket);
AmeMessage(playerid,string);
HasWeapon[playerid] = 1;
return 1;
}

CMD:myweps(playerid)
{
new string[160], gunname[60];
GetWeaponName(PlayerInfo[playerid][pGun1],gunname,sizeof(gunname));
format(string, sizeof(string), "Slot 1: %s (%d ammo)", gunname, PlayerInfo[playerid][pGunAmmo1]);
SendClientMessage(playerid, -1, string);
GetWeaponName(PlayerInfo[playerid][pGun2],gunname,sizeof(gunname));
format(string, sizeof(string), "Slot 2: %s (%d ammo)", gunname, PlayerInfo[playerid][pGunAmmo2]);
SendClientMessage(playerid, -1, string);
GetWeaponName(PlayerInfo[playerid][pGun3],gunname,sizeof(gunname));
format(string, sizeof(string), "Slot 3: %s (%d ammo)", gunname, PlayerInfo[playerid][pGunAmmo3]);
SendClientMessage(playerid, -1, string);
return 1;
}
CMD:accent(playerid, params[])
{
new accent[20], string[128];
if(sscanf(params,"s[20]",accent)) return UsageMessage(playerid, "/accent (accent) | None = No accent");
if(!strcmp(params, "none", true, 4)) {PlayerInfo[playerid][pAccent] = 0; InfoMessage(playerid, "You have removed your accent"); return 1;}
format(PlayerInfo[playerid][pAccent], 20,accent);
format(string, sizeof(string),"You have set your accent to %s", accent);
InfoMessage(playerid, string);
return 1;
}
CMD:frisk(playerid, params[])
{
new playerb, string[160];
new Float:x, Float:y, Float:z;
GetPlayerPos(playerb, x, y, z);
if(!IsPlayerInRangeOfPoint(playerid, 10,x, y, z)) return ErrorMessage(playerid, "You are not in range of that player.");
if(sscanf(params,"u",playerb)) return UsageMessage(playerid, "/frisk (ID/name)");
format(string, sizeof(string),"You have requested to frisk %s. Wait for them to accept the request.", RPN(playerb,1));
InfoMessage(playerid, string);
format(string, sizeof(string),"%s has requested to frisk you. Type /acceptfrisk to accept the request.", RPN(playerid,1));
InfoMessage(playerb, string);
OfferFrisk[playerb] = 1;
OfferFrisker[playerb] = playerid;
return 1;
}
CMD:acceptfrisk(playerid)
{
if(OfferFrisk[playerid] != 1) return ErrorMessage(playerid, "Nobody requested to frisk you!");
new gunname[60],string[160];
format(string, sizeof(string), "-------%s-------", RPN(playerid,1));
SendClientMessage(OfferFrisker[playerid], -1, string);
SendClientMessage(OfferFrisker[playerid], -1, "[ID] Yes");
GetWeaponName(PlayerInfo[playerid][pGun1],gunname,sizeof(gunname));
format(string, sizeof(string), "[Trousers Pocket] %s", gunname);
SendClientMessage(OfferFrisker[playerid], -1, string);
GetWeaponName(PlayerInfo[playerid][pGun2],gunname,sizeof(gunname));
format(string, sizeof(string), "[Jacket Pocket] %s", gunname);
SendClientMessage(OfferFrisker[playerid], -1, string);
GetWeaponName(PlayerInfo[playerid][pGun3],gunname,sizeof(gunname));
format(string, sizeof(string), "[Back Pocket] %s", gunname);
SendClientMessage(OfferFrisker[playerid], -1, string);
OfferFrisk[playerid] = 0;
OfferFrisker[playerid] = 0;
return 1;
}
CMD:renting(playerid)
{
if(IsRenting[playerid] == 1111) return ErrorMessage(playerid, "You aren't renting any vehicle!");
new string[160];
format(string,sizeof(string), "Renting: [VehID: %d] [Name: %s]", IsRenting[playerid], RPN(playerid,0));
SendClientMessage(playerid,-1,string);
return 1;
}

CMD:unrent(playerid) 
{
if(IsRenting[playerid] == 1111) return ErrorMessage(playerid, "You aren't renting any vehicle!");
SetVehicleToRespawn(IsRenting[playerid]);
DVehicles[IsRenting[playerid]][vRenter] = 1111;
IsRenting[playerid] = 1111;
InfoMessage(playerid, "You have successfully unrented your vehicle!");
return 1;
}
CMD:vs(playerid,params[])
{
new vehicleid = GetClosestVehicle(playerid, 3);
if(GetClosestVehicle(playerid, 4) <= 0 && GetPlayerVehicleID(playerid) != vehicleid) return ErrorMessage(playerid, "You are not near or in a vehicle!");
new engine, lights, alarm, doors, bonnet, boot, objective;
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
if(boot != 1 && GetPlayerVehicleID(playerid) != vehicleid) return ErrorMessage(playerid,"You can't do this while the vehicle's trunk is closed!");
if(HasWeapon[playerid] != 1) return ErrorMessage(playerid, "You don't have a weapon in hand!");
if(DVehicles[vehicleid][vFaction] == 1 && PlayerInfo[playerid][pFac] != 1) return 1;
new query[128];
format(query,sizeof(query),"SELECT * FROM `weapons_stored` WHERE `vehicle` = '%d'",DVehicles[vehicleid][vUID]);
mysql_tquery(connection,query,"StoreWeapInTrunk","ii",playerid,vehicleid);
return 1;
}

forward StoreWeapInTrunk(playerid,vehid);
public StoreWeapInTrunk(playerid,vehid)
{
	new rows,count,string[160];
	cache_get_row_count(rows);
	if(rows)
	{
		for (new i = 0; i < rows; i++)
		{
			new weaponid;
		    cache_get_value_name_int(i,"weaponid",weaponid);
		    count += GetWeaponSlotNum(weaponid);
		}
	}
	new gunid = GetPlayerWeapon(playerid);
	count += GetWeaponSlotNum(gunid);
	if(DVehicles[vehid][vSlots] < count) return ErrorMessage(playerid,"Not enough space to store this weapon.");
	new gunname[60],ammo,query[140];
	GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),gunid,ammo);
	format(query,sizeof(query),"INSERT INTO `weapons_stored` (weaponid,ammo,vehicle) VALUES ('%d','%d','%d')",gunid,ammo,DVehicles[vehid][vUID]);
	mysql_query(connection,query);
	GetWeaponName(gunid, gunname, sizeof(gunname));
	format(string, sizeof(string), "stores a %s into the vehicle's trunk.", gunname);
	AmeMessage(playerid,string);
	ResetPlayerWeapons(playerid);
	HasWeapon[playerid] = 0;
	return 1;
}

CMD:vt(playerid, params[])
{
if(HasWeapon[playerid] != 0) return ErrorMessage(playerid, "You can hold only one weapon in your hand!");
new vehicleid = GetClosestVehicle(playerid, 3);
if(GetClosestVehicle(playerid, 4) <= 0 && GetPlayerVehicleID(playerid) != vehicleid) return ErrorMessage(playerid, "You are not near or in a vehicle!");
new engine, lights, alarm, doors, bonnet, boot, objective,theid;
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
if(boot != 1 && GetPlayerVehicleID(playerid) != vehicleid) return ErrorMessage(playerid,"You can't do this while the vehicle's trunk is closed!");
if(DVehicles[vehicleid][vFaction] == 1 && PlayerInfo[playerid][pFac] != 1) return 1;
if(sscanf(params, "d", theid)) return UsageMessage(playerid, "/vt (id)");
new query[128];
format(query,sizeof(query),"SELECT * FROM `weapons_stored` WHERE `vehicle` = '%d' AND `ID` = '%d'",DVehicles[vehicleid][vUID],theid);
mysql_tquery(connection,query,"TakeWeapFromTrunk","i",playerid);
return 1;
}

forward TakeWeapFromTrunk(playerid);
public TakeWeapFromTrunk(playerid)
{
	new globalid,weaponid,weaponammo,gunname[60],string[124],query[128];
	cache_get_value_name_int(0,"ID",globalid);
	cache_get_value_name_int(0,"weaponid",weaponid);
	cache_get_value_name_int(0,"ammo",weaponammo);
	GetWeaponName(weaponid,gunname,sizeof(gunname));
	format(string, sizeof(string), "takes a %s from the vehicle's trunk.", gunname);
	AmeMessage(playerid,string);
	HasWeapon[playerid] = 1;
	GivePlayerWeapon(playerid,weaponid,weaponammo);
	format(query,sizeof(query),"DELETE FROM `weapons_stored` WHERE `ID` = '%d'",globalid);
	mysql_query(connection,query);
	return 1;
}

CMD:vw(playerid)
{
new vehicleid = GetClosestVehicle(playerid, 3);
if(GetClosestVehicle(playerid, 4) <= 0 && GetPlayerVehicleID(playerid) != vehicleid) return ErrorMessage(playerid, "You are not near or in a vehicle!");
new engine, lights, alarm, doors, bonnet, boot, objective,query[160];
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
if(boot != 1 && GetPlayerVehicleID(playerid) != vehicleid) return ErrorMessage(playerid,"You can't do this while the vehicle's trunk is closed!");
if(DVehicles[vehicleid][vFaction] != 0 && PlayerInfo[playerid][pFac] != DVehicles[vehicleid][vFaction]) return ErrorMessage(playerid, "You cannot do that on this vehicle!");
format(query,sizeof(query),"SELECT * FROM `weapons_stored` WHERE `vehicle` = '%d'",DVehicles[vehicleid][vUID]);
mysql_tquery(connection,query,"CheckVehTrunk","ii",playerid,vehicleid);
return 1;
}

forward CheckVehTrunk(playerid,vehid);
public CheckVehTrunk(playerid,vehid)
{
	new rows,count,string[160];
	cache_get_row_count(rows);
	if(rows)
	{
		for (new i = 0; i < rows; i++)
		{
			new weaponid;
			cache_get_value_name_int(i,"weaponid",weaponid);
			count += GetWeaponSlotNum(weaponid);
		}
	}
	format(string,sizeof(string),"---------Vehicle Storage (Slots %d/%d)---------",count,DVehicles[vehid][vSlots]);
	SendClientMessage(playerid, -1, string);
	if(rows)
	{
		for (new i = 0; i < rows; i++)
		{
			new globalid,weaponid,weaponammo,gunname[16];
			cache_get_value_name_int(i,"ID",globalid);
			cache_get_value_name_int(i,"weaponid",weaponid);
			cache_get_value_name_int(i,"ammo",weaponammo);
		    GetWeaponName(weaponid,gunname,sizeof(gunname));
			format(string,sizeof(string),"{989898}ID %d | %s | %d Ammo | Taking %d slots",globalid,gunname,weaponammo,GetWeaponSlotNum(weaponid));
			SendClientMessage(playerid,-1,string);
		}
	}
	return 1;
}

CMD:dealership(playerid)
{
if(!IsPlayerInRangeOfPoint(playerid, 3.0, -1438.9114,2591.2102,55.8359)) return ErrorMessage(playerid, "You are not near the vehicle dealership!");
ShowPlayerDialog(playerid, DIALOG_DEALERSHIP, DIALOG_STYLE_LIST, "Vehicle Dealership", "[$85] BMX\n[$100] Mountain Bike\n[$300] Faggio\n[$500] Sanchez\n[$525] PCJ-600\n[$610] Walton\n[$750] Clover\n[$775] Perenniel\n[$825] Landstalker", "Buy", "Exit");
return 1;
}

CMD:myvehicles(playerid)
{
    new string[80], vehicles;

    for (new i = 1; i < sizeof DVehicles; i++)
    {
        if (DVehicles[i][vOwner] != 0 && DVehicles[i][vOwner] == PlayerInfo[playerid][pID])
        {
            vehicles = vehicles + 1;
        }
    }

    format(string, sizeof(string), "{989898}----------Vehicles (%d/3)----------", vehicles);
    SendClientMessage(playerid, -1, string);

    for (new i = 1; i < sizeof DVehicles; i++)
    {
        if (DVehicles[i][vOwner] != 0 && DVehicles[i][vOwner] == PlayerInfo[playerid][pID])
        {
	        format(string, sizeof(string), "{989898}ID %d | %s", DVehicles[i][dID], GetVehicleName(DVehicles[i][dID]));
	        SendClientMessage(playerid, -1, string);
        }
    }
    return 1;
}
CMD:park(playerid)
{
if(!IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You need to be in a vehicle to do this!");
new fileid = GetPlayerVehicleID(playerid);
if (DVehicles[fileid][vOwner] != PlayerInfo[playerid][pID]) return ErrorMessage(playerid, "You must be the owner of the vehicle to park it!");
new vehz = GetPlayerVehicleID(playerid);
new Float:X,Float:Y,Float:Z,Float:A;
GetVehicleZAngle(vehz, A);
GetPlayerPos(playerid, X,Y,Z);
DVehicles[vehz][dX] = X;
DVehicles[vehz][dY] = Y;
DVehicles[vehz][dZ] = Z;
DVehicles[vehz][dA] = A;
DestroyVehicle(vehz);
DVehicles[vehz][dID] = CreateVehicle(411, 0,0,0,0, 0, 0, -1);
DestroyVehicle(DVehicles[vehz][dID]);
SaveVehicle(vehz);
new Query[80];
format(Query,sizeof(Query),"SELECT * FROM `vehicles` WHERE `vID` = '%d'",DVehicles[vehz][dID]);
mysql_tquery(connection,Query,"LoadVehicle","i",DVehicles[vehz][dID]);
RemovePlayerFromVehicle(playerid);
InfoMessage(playerid, "Vehicle successfully parked.");
return 1;
}
//***********************************************************MECHANIC SYSTEM*******************************************************
CMD:getmats(playerid)
{
if (PlayerInfo[playerid][pJob] != 2) return ErrorMessage(playerid, "You are not a Mechanic!");
if (PlayerInfo[playerid][pMats] >= 52) return ErrorMessage(playerid, "You have reached the maximum capacity of materials!");
if (IsPlayerInRangeOfPoint(playerid, 3.0, -1519.286499, 2560.106445, 55.840278))
{
	if (GetPlayerMoney(playerid) < 200) return ErrorMessage(playerid, "You don't have enough money to buy materials!");
	InfoMessage(playerid, "You bought 2 materials.");
	MeMessage(playerid, "takes some materials from the storage.");
	GivePMoney(playerid, -200);
	PlayerInfo[playerid][pMats] = PlayerInfo[playerid][pMats] + 2;
	return 1;
	}
else
{
	ErrorMessage(playerid, "You are not in range of the materials pickup!");
	SetPlayerCheckpoint(playerid,-1519.286499, 2560.106445, 55.840278,10);
 	MechCheck[playerid] = 1;
  	return 1;
}
}
CMD:mechhelp(playerid)
{
    if (PlayerInfo[playerid][pJob] != 2) return ErrorMessage(playerid, "You are not a Mechanic!");
    SendClientMessage(playerid, -1, "{00FFEE}-------------------------------------------------------------------------------------------------------------------");
	SendClientMessage(playerid,-1, "{009C0B}[COMMANDS]{C3C3C3}: /getmats /mymats /repairveh /paintveh");
    SendClientMessage(playerid, -1, "{00FFEE}-------------------------------------------------------------------------------------------------------------------");
	return 1;
}
CMD:mymats(playerid)
{
if (PlayerInfo[playerid][pJob] != 2) return ErrorMessage(playerid, "You are not a Mechanic!");
new string[150];
new mats = PlayerInfo[playerid][pMats];
format(string, sizeof(string), "{00FF00}[Info] {5C5C5C}You currently have %i materials.", mats);
SendClientMessage(playerid, COLGREEN, string);
return 1;
}
CMD:repairveh(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(PlayerInfo[playerid][pMats] < 2) return ErrorMessage(playerid, "You don't have enough materials!");
		PlayerInfo[playerid][pMats] = PlayerInfo[playerid][pMats] - 2;
		new vehicleid = GetPlayerVehicleID(playerid);
		SetVehicleHealth(vehicleid, 1000);
		InfoMessage(playerid, "The vehicle's engine has been fully repaired.");
		MeMessage(playerid, "has repaired the engine of the vehicle.");
		return 1;
	}
	else
	{
	ErrorMessage(playerid, "You are not in a vehicle!");
	return 1;
	}
}
CMD:paintveh(playerid, params[])
{
    if (PlayerInfo[playerid][pJob] != 2) return ErrorMessage(playerid, "You are not a Mechanic!");
	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(PlayerInfo[playerid][pMats] >= 1)
	    {
			new color[2];
			if(sscanf(params,"dD",color[0],color[1]))
			{
	    	return UsageMessage(playerid, "/paintveh [color1] [color2]");
			}
			PlayerInfo[playerid][pMats] = PlayerInfo[playerid][pMats] - 1;
            InfoMessage(playerid, "You have successfully painted the vehicle.");
 			ChangeVehicleColor(GetPlayerVehicleID(playerid),color[0],color[1]);
 			DVehicles[GetPlayerVehicleID(playerid)][dColor1] = color[0];
 			DVehicles[GetPlayerVehicleID(playerid)][dColor2] = color[1];
 			return 1;
	    }
	    else
	    {
	    	ErrorMessage(playerid, "You don't have enough materials!");
			return 1;
	    }
	}
	else
	{
		ErrorMessage(playerid, "You are not in a vehicle!");
		return 1;
	}
}
CMD:elevator(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if (IsPlayerInRangeOfPoint(playerid, 3.0, 1948.9642,-2236.6240,14.6328) && GetPlayerInterior(playerid) == 1 && GetPlayerVirtualWorld(playerid) == 3) return ShowPlayerDialog(playerid, DIALOG_SASMD_ELEVATOR, DIALOG_STYLE_LIST, "Elevator Menu", "Staff Floor\nLobby", "Goto", "Exit");
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1378.5524,395.9639,3383.7585) && GetPlayerInterior(playerid) == 1 && GetPlayerVirtualWorld(playerid) == 0) return ShowPlayerDialog(playerid, DIALOG_SASMD_ELEVATOR, DIALOG_STYLE_LIST, "Elevator Menu", "Staff Floor\nLobby", "Goto", "Exit");
return 1;
}
CMD:enter(playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 3.0, -1514.747431, 2518.928095, 56.035937)) // Hospital
	{
    	SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, -2825.9585, -1528.9202, -45.8510);
		FreezePlayer(playerid,1000);
		return 1;

	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0, -2485.5010,2272.7756,4.9844)) // Bank
	{
    	SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2305.2461,-16.1431,26.7422);
		FreezePlayer(playerid,1000);
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0, -1508.9448,2610.7012,55.8359)) // Ammunation
	{
    	SetPlayerInterior(playerid, 6);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 296.9212,-111.6275,1001.5156);
		FreezePlayer(playerid,1000);
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0, -1471.5673,2592.1096,55.8359)) // DMV
	{
    	SetPlayerInterior(playerid, 3);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1494.4193,1304.2587,1093.2891);
		FreezePlayer(playerid,1000);
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0,-1462.7360,2682.4851,55.8418)) // Burger Shot
	{
    	SetPlayerInterior(playerid, 10);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 363.2133,-74.8129,1001.5078);
		FreezePlayer(playerid,500);
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0,-1206.8391,1825.7917,41.7188)) // Prison
	{
    	SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 2);
		SetPlayerPos(playerid, 1930.9042,-2262.9624,13.5928);
		FreezePlayer(playerid,500);
		PlayerInfo[playerid][InPrison] = 1;
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0,-2454.5938,2254.0781,4.9801)) // SAST Lobby
	{
    	SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 3);
		SetPlayerPos(playerid, 1944.667602, -2251.452392, 14.632812);
		FreezePlayer(playerid,500);
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0,-1465.578002,2611.536376,56.179687)) // EQ Hotel
	{
    	SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid, 1405.654663, -1172.366699, -89.446807);
		FreezePlayer(playerid,500);
		return 1;
	}
	else if (IsPlayerInRangeOfPoint(playerid, 3.0,-2492.3667,2363.2014,10.2772)) // Gym
	{
    	SetPlayerInterior(playerid, 7);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid, 773.8607, -78.3802, 1000.6621);
		FreezePlayer(playerid,500);
		return 1;
	}
	new Float:x, Float:y, id;
	for(new i; i<MAX_DOORS; i++)
	{
	    if(DoorCreated[i] != 0)
	    {
	        id = i;
	        if(IsPlayerInRangeOfPoint(playerid, 2.0, DoorInfo[id][dox], DoorInfo[id][doy], DoorInfo[id][doz]) && DoorInfo[id][dlocked] == 0 && GetPlayerInterior(playerid) == DoorInfo[id][doi] && GetPlayerVirtualWorld(playerid) == DoorInfo[id][dow])
	        {
	            x = DoorInfo[id][dix] + floatsin(-DoorInfo[id][dia], degrees) * 2.3;
				y = DoorInfo[id][diy] + floatsin(-DoorInfo[id][dia], degrees) * 2.3;
				SetPlayerVirtualWorld(playerid, DoorInfo[id][diw]);
				SetPlayerInterior(playerid, DoorInfo[id][dii]);
				SetPlayerPos(playerid, x, y, DoorInfo[id][diz]);
				SetPlayerFacingAngle(playerid, DoorInfo[id][dia]);
				SetCameraBehindPlayer(playerid);
	        }
	    }
	}
	new biz;
	for(new i = 1; i < MAX_BIZ; i++)
	{
		if(BizInfo[i][bOX] != 0)
		{
		    if(IsPlayerInRangeOfPoint(playerid,1.5,BizInfo[i][bOX],BizInfo[i][bOY],BizInfo[i][bOZ])  && GetPlayerVirtualWorld(playerid) == BizInfo[i][bOVW] && GetPlayerInterior(playerid) == BizInfo[i][bOInt])
		    {
		        biz = i;
		        break;
		    }
		}
	}
	if(biz != 0)
	{
		if(BizInfo[biz][bLocked] == 1) return ErrorMessage(playerid,"The business is locked.");
		SetPlayerPos(playerid,BizInfo[biz][bIX],BizInfo[biz][bIY],BizInfo[biz][bIZ]);
		SetPlayerVirtualWorld(playerid,BizInfo[biz][bIVW]);
		SetPlayerInterior(playerid,BizInfo[biz][bIInt]);
		return 1;
	}
	new house;
	for(new i = 1; i < MAX_HOUSES; i++)
	{
		if(HouseInfo[i][hOX] != 0)
		{
		    if(IsPlayerInRangeOfPoint(playerid,1.5,HouseInfo[i][hOX],HouseInfo[i][hOY],HouseInfo[i][hOZ])  && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hOVW] && GetPlayerInterior(playerid) == HouseInfo[i][hOInt])
		    {
		        house = i;
		        i = MAX_HOUSES;
		    }
		}
	}
	if(house == 0) return 1;
	if(HouseInfo[house][hLocked] == 1) {ErrorMessage(playerid,"This house is locked."); return 1;}
	if(HouseInfo[house][hIX] == 0) return ErrorMessage(playerid, "House has no interior yet!");
	if(HouseInfo[house][hLights] == 1) SetPlayerTime(playerid, 0, 0);
	else if(HouseInfo[house][hLights] == 0) SetPlayerTime(playerid, 12, 0);
	SetPlayerPos(playerid,HouseInfo[house][hIX],HouseInfo[house][hIY],HouseInfo[house][hIZ]);
	SetPlayerVirtualWorld(playerid,HouseInfo[house][hIVW]);
	SetPlayerInterior(playerid,HouseInfo[house][hIInt]);
	return 1;
}
CMD:exit(playerid)
{
if (IsPlayerInRangeOfPoint(playerid, 3.0, -2825.9585, -1528.9202, -45.8510)) // Hospital
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -1514.747431, 2518.928095, 56.035937);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 2305.2461,-16.1431,26.7422)) // Bank
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -2485.5010,2272.7756,4.9844);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 296.9212,-111.6275,1001.5156)) // Ammunation
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -1508.9448,2610.7012,55.8359);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1494.4193,1304.2587,1093.2891)) // DMV
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -1471.5673,2592.1096,55.8359);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 363.2133,-74.8129,1001.5078)) // Burger Shot
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -1462.7360,2682.4851,55.8418);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1930.9042,-2262.9624,13.5928)) // Prison
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -1206.8391,1825.7917,41.7188);
	PlayerInfo[playerid][InPrison] = 0;
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1944.667602, -2251.452392, 14.632812)) // SAST Lobby
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -2454.5938,2254.0781,4.9801);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1405.654663, -1172.366699, -89.446807)) // EQ Hotel
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -1465.578002,2611.536376,56.179687);
	return 1;
}
else if (IsPlayerInRangeOfPoint(playerid, 3.0, 773.8607, -78.3802, 1000.6621)) // Gym
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, -2492.3667,2363.2014,10.2772);
	return 1;
}
new Float:x, Float:y, id;
for(new i; i<MAX_DOORS; i++)
{
	if(DoorCreated[i] != 0)
	{
	    id = i;
	    if(IsPlayerInRangeOfPoint(playerid, 2.0, DoorInfo[id][dix], DoorInfo[id][diy], DoorInfo[id][diz]) && DoorInfo[id][dlocked] == 0 && GetPlayerInterior(playerid) == DoorInfo[id][dii] && GetPlayerVirtualWorld(playerid) == DoorInfo[id][diw])
	    {
	        x = DoorInfo[id][dox] + floatsin(-DoorInfo[id][doa], degrees) * 2.3;
			y = DoorInfo[id][doy] + floatsin(-DoorInfo[id][doa], degrees) * 2.3;
			SetPlayerVirtualWorld(playerid, DoorInfo[id][dow]);
			SetPlayerInterior(playerid, DoorInfo[id][doi]);
			SetPlayerPos(playerid, x, y, DoorInfo[id][doz]);
			SetPlayerFacingAngle(playerid, DoorInfo[id][doa]);
			SetCameraBehindPlayer(playerid);
	    }
	}
}
new biz;
for(new i = 1; i < MAX_BIZ; i++)
{
	if(BizInfo[i][bOX] != 0)
	{
		if(IsPlayerInRangeOfPoint(playerid,1.5,BizInfo[i][bIX],BizInfo[i][bIY],BizInfo[i][bIZ])  && GetPlayerVirtualWorld(playerid) == BizInfo[i][bIVW] && GetPlayerInterior(playerid) == BizInfo[i][bIInt])
		{
		    biz = i;
		    break;
		}
	}
}
if(biz != 0)
{
	if(BizInfo[biz][bLocked] == 1) return ErrorMessage(playerid,"The business is locked.");
	SetPlayerPos(playerid,BizInfo[biz][bOX],BizInfo[biz][bOY],BizInfo[biz][bOZ]);
	SetPlayerVirtualWorld(playerid,BizInfo[biz][bOVW]);
	SetPlayerInterior(playerid,BizInfo[biz][bOInt]);
	return 1;
}
new house;
for(new i = 1; i < MAX_HOUSES; i++)
{
	if(HouseInfo[i][hOX] != 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.5,HouseInfo[i][hIX],HouseInfo[i][hIY],HouseInfo[i][hIZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hIVW] && GetPlayerInterior(playerid) == HouseInfo[i][hIInt])
	    {
	        house = i;
	        i = MAX_HOUSES;
	    }
	}
}
if(house == 0) return 1;
if(HouseInfo[house][hLocked] == 1) {ErrorMessage(playerid,"This house is locked."); return 1;}
SetPlayerPos(playerid,HouseInfo[house][hOX],HouseInfo[house][hOY],HouseInfo[house][hOZ]);
SetPlayerVirtualWorld(playerid,HouseInfo[house][hOVW]);
SetPlayerInterior(playerid,HouseInfo[house][hOInt]);
SetPlayerTime(playerid, 12, 0);
return 1;
}
/*CMD:enter(playerid)
{
new doorid = GetClosestEntrance(playerid);
if(doorid != -1){
SetPlayerVirtualWorld(playerid,DoorInfo[doorid][DDoorInVW]);
SetPlayerInterior(playerid,DoorInfo[doorid][DDoorInInt]);
SetPlayerPos(playerid,DoorInfo[doorid][DDoorInX],DoorInfo[doorid][DDoorInY],DoorInfo[doorid][DDoorInZ]);
return 1;}
return 1;
}
CMD:exit(playerid)
{
new doorid = GetClosestExit(playerid);
if(doorid != -1){
SetPlayerVirtualWorld(playerid,DoorInfo[doorid][DDoorOutVW]);
SetPlayerInterior(playerid,DoorInfo[doorid][DDoorOutInt]);
SetPlayerPos(playerid,DoorInfo[doorid][DDoorOutX],DoorInfo[doorid][DDoorOutY],DoorInfo[doorid][DDoorOutZ]);
return 1;}
return 1;
}*/
//***********************************************************STUFF*******************************************************
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
        if(IsPlayerConnected(playerid))
		{
	        new Float:posx, Float:posy, Float:posz;
	        new Float:oldposx, Float:oldposy, Float:oldposz;
	        new Float:tempposx, Float:tempposy, Float:tempposz;
	        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	        for(new i = 0; i < MAX_PLAYERS; i++)
			{
	        	if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
				{
			        GetPlayerPos(i, posx, posy, posz);
			        tempposx = (oldposx -posx);
			        tempposy = (oldposy -posy);
			        tempposz = (oldposz -posz);
	        		if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
	    				SendSplitMessage(i, col1, string);
					}
	    			else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
					    SendSplitMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
	    			{
					    SendSplitMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
					    SendSplitMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
					    SendSplitMessage(i, col5, string);
					}
				}
			}
		}
		return 1;
}
///--------GetPlayerNameEx----------///
forward DisplayPlayerFlags(playerid);
public DisplayPlayerFlags(playerid)
{
new rows,flagid,date[20],creator[20],string[4096];
format(string,sizeof(string),"");
cache_get_row_count(rows);
if(rows)
{
	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(i,"ID",flagid);
		cache_get_value_name(i,"date",date);
		cache_get_value_name(i,"creator",creator);
		format(string,sizeof(string),"%sID %d\tDate: %s\tCreator: %s\n",string,flagid,date,creator);
	}
	ShowPlayerDialog(playerid, DIALOG_FLAGS_LIST, DIALOG_STYLE_TABLIST, "Player Flags", string, "Select", "Back");
}
else return ErrorMessage(playerid,"That player has no flags on their account.");
return 1;
}

forward DisplayFlag(playerid,flagid);
public DisplayFlag(playerid,flagid)
{
new rows,string[200],date[20],creator[20],text[120],playerbid,playerb,playerbname[MAX_PLAYER_NAME];
cache_get_row_count(rows);
if(rows)
{
	cache_get_value_name_int(0,"playerID",playerbid);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[playerid][pID] == playerbid)
		{
			playerb = i;
			GetPlayerName(playerb,playerbname,MAX_PLAYER_NAME);
			break;
		}
	}
	cache_get_value_name(0,"date",date);
	cache_get_value_name(0,"text",text);
	cache_get_value_name(0,"creator",creator);
	format(string,sizeof(string)," ID: %d~n~ Player: %s (ID %d)~n~ Creator: %s~n~ Date: %s~n~ Flag Text: %s",flagid,playerbname,playerb,creator,date,text);
	CreatePlayerStatBox(playerid,"Flag Information",string,1);
}
return 1;
}

forward DeleteFlag(playerid,flagid);
public DeleteFlag(playerid,flagid)
{
new rows,string[200];
cache_get_row_count(rows);
if(rows)
{
	format(string,sizeof(string),"DELETE FROM `playerflags` WHERE `ID` = '%d'",flagid);
	mysql_query(connection,string);
	format(string, sizeof(string), "%s deleted flag ID %d.", RPN(playerid,0),flagid);
    if(AdminHideCmds[playerid] == 0) SendAdminWarnMessage(string);
}
else return ErrorMessage(playerid,"That flag ID does not exist.");
return 1;
}

forward DisplayBOLOs(playerid,type);
public DisplayBOLOs(playerid,type)
{
new rows,temp,boloid,string[4096];
format(string,sizeof(string),"");
cache_get_row_count(rows);
if(rows)
{
	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(i,"ID",temp);
		for(new b = 0; b < MAX_BOLOS; b++)
		{
			if(BOLOAdd[b][BOLOID] == temp)
			{
				boloid = b;
				break;
			}
		}
		format(string,sizeof(string),"%sID %d\tModel: %s\n",string,temp,BOLOAdd[boloid][BOLOmodel]);
	}
	switch(type)
	{
		case 1: ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_LIST1, DIALOG_STYLE_TABLIST, "Open BOLOs", string, "Select", "Back");
		case 2: ShowPlayerDialog(playerid, DIALOG_MDC_BOLO_LIST1, DIALOG_STYLE_TABLIST, "Closed BOLOs", string, "Select", "Back");
	}
}
return 1;
}

forward DisplayBOLO(playerid,boloid);
public DisplayBOLO(playerid,boloid)
{
new string[1000],status[10];
format(status,10,"Open");
if(BOLOAdd[boloid][BOLOstatus] == 2) format(status,10,"Closed");
switch(BOLOAdd[boloid][BOLOtype])
{
	case 1:
	{
		format(string,sizeof(string),"ID: %d~n~ Date: %s~n~ Person: %s~n~ Last Seen: %s~n~ Status: %s",
			BOLOAdd[boloid][BOLOID],BOLOAdd[boloid][BOLOdate],BOLOAdd[boloid][BOLOperson],
			BOLOAdd[boloid][BOLOlastseen],status);
	}
	case 2:
	{
		format(string,sizeof(string)," ID: %d~n~ Date: %s~n~ Model: %s~n~ Primary Color: %s~n~ Secondary Color: %s~n~ Plate: %s~n~ Last Seen: %s~n~ Status: %s",
			BOLOAdd[boloid][BOLOID],BOLOAdd[boloid][BOLOdate],BOLOAdd[boloid][BOLOmodel],BOLOAdd[boloid][BOLOcolor1],BOLOAdd[boloid][BOLOcolor2],
			BOLOAdd[boloid][BOLOplate],BOLOAdd[boloid][BOLOlastseen],status);
	}
}
CreatePlayerStatBox(playerid,"BOLO Information",string,1);
return 1;
}

forward LoadBOLO(boloid);
public LoadBOLO(boloid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
	cache_get_value_name_int(0,"ID",BOLOAdd[boloid][BOLOID]);
    cache_get_value_name(0,"creator",BOLOAdd[boloid][BOLOcreator],30);
    cache_get_value_name_int(0,"type",BOLOAdd[boloid][BOLOtype]);
    cache_get_value_name(0,"date",BOLOAdd[boloid][BOLOdate],20);
    cache_get_value_name(0,"model",BOLOAdd[boloid][BOLOmodel],40);
    cache_get_value_name(0,"color1",BOLOAdd[boloid][BOLOcolor1],20);
    cache_get_value_name(0,"color2",BOLOAdd[boloid][BOLOcolor2],20);
    cache_get_value_name(0,"plate",BOLOAdd[boloid][BOLOplate],10);
    cache_get_value_name(0,"person",BOLOAdd[boloid][BOLOperson],30);
    cache_get_value_name(0,"lastseen",BOLOAdd[boloid][BOLOlastseen],30);
    cache_get_value_name_int(0,"status",BOLOAdd[boloid][BOLOstatus]);
}
return 1;
}

forward PlateSearchResult(playerid,vehid);
public PlateSearchResult(playerid,vehid)
{
new rows,name[25];
cache_get_row_count(rows);
if(rows)
{
    cache_get_value_name(0,"username",name);
}
new string[126],str2[20];
format(str2,sizeof(str2),"Plate %s",DVehicles[vehid][vPlate]);
format(string,sizeof(string)," Model: %s~n~ Owner: %s~n~ Tickets: 0",GetVehicleName(vehid),NameWithoutUnderline(name));
CreatePlayerStatBox(playerid,str2,string,1);
return 1;
}

forward PersonSearchResult(playerid);
public PersonSearchResult(playerid)
{
new rows,name[25],string[224],gender,ggender[20],prison,pprison[20],age,dob[10],nat[20],height,weight;
cache_get_row_count(rows);
if(rows)
{
    cache_get_value_name(0,"username",name);
	cache_get_value_name_int(0,"Age",age);
    cache_get_value_name_int(0,"Gender",gender);
    cache_get_value_name_int(0,"PrisonTime",prison);
    cache_get_value_name(0,"DOB",dob);
    cache_get_value_name(0,"Nationality",nat);
    cache_get_value_name_int(0,"Height",height);
    cache_get_value_name_int(0,"Weight",weight);
    format(ggender,20,"Male");
	if(gender == 2) format(ggender,20,"Female");
	format(pprison,20,"No");
	if(prison != -1) format(pprison,20,"Yes");
	else if(prison == -1) prison = 0;
	format(string,sizeof(string)," Age: %d~n~ Gender: %s~n~ Date of birth: %s~n~ Nationality: %s~n~ Height: %d cm~n~ Weight: %d kg~n~ In Prison: %s (%d)",
								age,ggender,dob,nat,height,weight,pprison,prison);
	CreatePlayerStatBox(playerid,NameWithoutUnderline(name),string,1);
	return 1;
}
ErrorMessage(playerid,"Name not found.");
return 1;
}

stock NameWithoutUnderline(name[25])
{
	for(new i = 0; i < 25; i++)
    {
        if(name[i] == '_') name[i] = ' ';
    }
    return name;
}

stock GetPlayerNameEx(playerid)
{
     new pName[25];
     GetPlayerName(playerid, pName, sizeof(pName));
     return pName;
}
stock split(const strsrc[], strdest[][], delimiter)
{ // Not mine :3
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
stock BadgeNumber(playerid)
{
	new badge[30];
	format(badge,sizeof(badge),"%d",PlayerInfo[playerid][pBadge]);
	if (PlayerInfo[playerid][pBadge] == 0) format(badge,sizeof(badge),"000");
	else if (PlayerInfo[playerid][pBadge] < 10) format(badge,sizeof(badge),"00%d",PlayerInfo[playerid][pBadge]);
	else if (PlayerInfo[playerid][pBadge] > 9 && 100 > PlayerInfo[playerid][pBadge]) format(badge,sizeof(badge),"0%d",PlayerInfo[playerid][pBadge]);
	else if (PlayerInfo[playerid][pBadge] > 99 && 1000 > PlayerInfo[playerid][pBadge]) format(badge,sizeof(badge),"%d",PlayerInfo[playerid][pBadge]);
	return badge;
}

//Stocks
stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);
        if(IsPlayerInRangeOfPoint(playerid, radius ,x, y, z))
        {
            return 1;
        }
        return 0;
}

stock RPN(playerid,mask)
{
    new name[MAX_PLAYER_NAME],gender[60];
    GetPlayerName(playerid,name,sizeof(name));
    if(mask == 1 && maskon[playerid]){
    if(PlayerInfo[playerid][pGender] == 1) {format(gender,sizeof(gender),"Male");}
    else if(PlayerInfo[playerid][pGender] == 2) {format(gender,sizeof(gender),"Female");}
    format(name,sizeof(name), "%s_%d",gender, PlayerInfo[playerid][pMaskID]);}
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if(name[i] == '_') name[i] = ' ';
    }
    return name;
}

stock ErrorMessage(playerid, text[])
{
    CreatePlayerInfoBox(playerid,2,text);
    return 1;
}

stock MeMessage(playerid, text[])
{
    new string[150];
    format(string, sizeof(string), "* %s %s",RPN(playerid,1), text);
    ChatLog(string);
    ProxDetector(15.0, playerid, string, COLME, COLME, COLME, COLME, COLME);
    return 1;
}

stock AmeMessage(playerid, text[])
{
	new msg[150];
    format(msg, sizeof(msg), "* %s %s", RPN(playerid,1),text);
	SetPlayerChatBubble(playerid, msg, COLME, 15.0, 7000);
	format(msg, sizeof(msg), ">> %s %s", RPN(playerid,1),text);
	ChatLog(msg);
	SendClientMessage(playerid, COLME, msg);
	return 1;
}

stock DoMessage(playerid, text[])
{
    new string[150];
    format(string, sizeof(string), "** %s ((%s))",text, RPN(playerid,1));
    ChatLog(string);
    ProxDetector(15.0, playerid, string, COLME, COLME, COLME, COLME, COLME);
    return 1;
}

stock InfoMessage(playerid, text[])
{
    CreatePlayerInfoBox(playerid,1,text);
    return 1;
}

stock AntiCheatMessage(text[])
{
    new string[150];
    format(string, sizeof(string), "[ANTI-CHEAT] %s", text);
    SendAdminMessage(0x5700AEFF, string);
    return 1;
}

stock UsageMessage(playerid, text[])
{
    new string[128];
    format(string, sizeof(string), "USAGE: {989898}%s", text);
    SendClientMessage(playerid, 0xFF8C00AA, string);
    return 1;
}

forward UnFreezeP(playerid);
public UnFreezeP(playerid)
{
    TogglePlayerControllable(playerid, 1);
}

stock FreezePlayer(playerid,time)
{
	SetTimerEx("UnFreezeP",time,false,"i",playerid);
	TogglePlayerControllable(playerid, 0);
}

stock SendBetaTesterMessage(playerid,col,text[])
{
	new string[128];
	format(string,sizeof(string),"(( {Tester Chat} %s: %s ))", RPN(playerid,0), text);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsLogged[i] == 1)
	    {
			if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pMod] >= 1) SendSplitMessage(i, col, string);
			else if(PlayerInfo[i][pAdmin] == 0 && PlayerInfo[i][pMod] == 0 && PlayerInfo[i][pBetaTester] == 1) SendSplitMessage(i, col, string);
		}
	}
	return 1;
}

stock SendAdminInfoMessage(text[])
{
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pAdmin] >= 1)
		{
		    if(IsLogged[i] == 1)
		    {
				format(string, sizeof(string), "[INFO] %s", text);
				SendSplitMessage(i, COL_LIGHTBLUE, string);
			}
		}
	}

	return 1;
}
stock SendFactionMessage(facid,col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pFac] == facid)
		{
		    if(IsLogged[i] == 1)
		    {
				SendSplitMessage(i, col, string);
			}
		}
	}
    FacLog(facid,string);
	return 1;
}
stock SendDepartmentMessage(string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(FactionInfo[PlayerInfo[i][pFac]][Type] == 1)
		{
		    if(IsLogged[i] == 1)
		    {
				SendSplitMessage(i, 0xC90A4DFF, string);
			}
		}
	}

	return 1;
}
stock SendFactionInfoMessage(facid, text[])
{
    new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pFac] == facid)
		{
		    if(IsLogged[i] == 1)
		    {
				format(string, sizeof(string), "[FAC] %s", text);
				SendSplitMessage(i, FAC_INF_MSG, string);
			}
		}
	}
    FacLog(facid,string);
	return 1;
}

stock SendTierFacMessage(facid, text[])
{
    new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pFac] == facid)
		{
		    if(IsLogged[i] == 1)
		    {
		        if(PlayerInfo[i][pTier] > 1)
		        {
					format(string, sizeof(string), "[FAC] %s", text);
					SendSplitMessage(i, FAC_INF_MSG, string);
				}
			}
		}
	}
    FacLog(facid,string);
	return 1;
}

stock GetClosestVehicle(playerid, Float:Range = 100.0)
{
	new ClosestVehicle;
	new Float:ClosestDist = 100000.0;
	new Float:DistX;
	new Float:DistY;
	new Float:DistZ;
	new Float:px;
	new Float:py;
	new Float:pz;
	new Float:CheckDist;

	// Get the players position
	GetPlayerPos(playerid, px, py, pz);

	// Loop through vehicles to find cloest vehicle
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		// Vehicle doesn't exist
	    if(!GetVehicleModel(i)) continue;

		// Get vehicle position
		GetVehiclePos(i, DistX, DistY, DistZ);

		// Get the distance
		CheckDist = floatsqroot(
                    floatpower(floatsub(DistX, px), 2.0) +
                    floatpower(floatsub(DistY, py), 2.0) +
                    floatpower(floatsub(DistZ, pz), 2.0));

		// Distance less than range?
		if(CheckDist <= Range)
		{
			// Distance less than cloest distance, new cloest distance!
			if(CheckDist < ClosestDist)
			{
				ClosestDist = CheckDist;
				ClosestVehicle = i;
			}
		}
	}
	// Cloest less than or equal to the range return the closest vehicle ID
	if(ClosestDist <= Range) return ClosestVehicle;
	// no vehichle? return INVALID_VEHICLE_ID
	return ClosestVehicle = -1;
}

stock SendAdminWarnMessage(text[])
{
    new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pAdmin] >= 1)
		{
		    if(IsLogged[i] == 1)
		    {
				format(string, sizeof(string), "AdmWarn: %s", text);
				SendSplitMessage(i, COLOR_LIGHTRED, string);
			}
		}        //goes through all the players checking who is and isint in faction 1
	}

	return 1;
}
stock SendAdminMessage(col, text[])
{
    new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pAdmin] >= 1)
		{
		    if(IsLogged[i] == 1)
		    {
				format(string, sizeof(string), "%s", text);
				SendSplitMessage(i, col, string);
			}
		}        //goes through all the players checking who is and isint in faction 1
	}

	return 1;
}

stock SendModMessage(col, text[])
{
    new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pMod] >= 1)
		{
		    if(IsLogged[i] == 1)
		    {
				format(string, sizeof(string), "%s", text);
				SendSplitMessage(i, col, string);
			}
		}        //goes through all the players checking who is and isint in faction 1
	}

	return 1;
}

stock randomEx(min, max)
{
    //Credits to y_less
    new rand = random(max-min)+min;
    return rand;
}

stock LOCKER_DUTY(playerid,skin)
{
    if(PlayerInfo[playerid][pDuty] == 0)
	{
	    PlayerInfo[playerid][pOffSkin] = PlayerInfo[playerid][pSkin];
	}
    new string[184];
    SetPSkin(playerid, skin);
	PlayerInfo[playerid][pDuty] = 1;
	MeMessage(playerid, "takes their uniform and badge from the lockers.");
	format(string, sizeof(string), "%s is now on duty with skin id %d.", RPN(playerid,0),skin);
	SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);
}

stock EQSD_CASE0(playerid)
{
	if(FactionInfo[PlayerInfo[playerid][pFac]][Type] > 2) return 1;
	if(PlayerInfo[playerid][pDuty] == 0)
	{
	    new string[60];
    	format(string,sizeof(string),"%s Lockers",FactionInfo[PlayerInfo[playerid][pFac]][Name]);
    	ShowPlayerDialog(playerid, DIALOG_LOCKERS_DUTY, DIALOG_STYLE_LIST, string, "282\n283\n284\n285\n288\n306\n309", "Select", "Back");
	}
	else
	{
	    new string[184];
	    PlayerInfo[playerid][pDuty] = 0;
	    SetPSkin(playerid, PlayerInfo[playerid][pOffSkin]);
	    PlayerInfo[playerid][pGun1] = 0;
	    PlayerInfo[playerid][pGunAmmo1] = 0;
	    PlayerInfo[playerid][pGun2] = 0;
	    PlayerInfo[playerid][pGunAmmo2] = 0;
	    PlayerInfo[playerid][pGun3] = 0;
	    PlayerInfo[playerid][pGunAmmo3] = 0;
	    HasWeapon[playerid] = 0;
	    ResetPlayerWeapons(playerid);
	    SetPArmour(playerid,0);
	    format(string, sizeof(string), "%s has gone off duty.", RPN(playerid,0));
		SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);
	}
	return 1;
}

forward SaveUser(playerid);
public SaveUser(playerid)
{
if(PlayerInfo[playerid][pPrisonTime] == -1){
GetPlayerPos(playerid,PlayerInfo[playerid][pLastX],PlayerInfo[playerid][pLastY],PlayerInfo[playerid][pLastZ]);
GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pLastA]);}
new query[2300];
GetPlayerWeaponData(playerid,GetWeaponSlot(GetPlayerWeapon(playerid)),PlayerInfo[playerid][pGunHold],PlayerInfo[playerid][pGunHoldAmmo]);
format(query,sizeof(query),"UPDATE `users` SET `username` = '%s', `password` = '%d', `level` = '%d', `money` = '%d', `X` = '%f', `Y` = '%f', `Z` = '%f', `A` = '%f', `VW` = '%d',",
							GetPlayerNameEx(playerid),PlayerInfo[playerid][pPass],GetPlayerScore(playerid),PlayerInfo[playerid][pMoney],PlayerInfo[playerid][pLastX],PlayerInfo[playerid][pLastY],
							PlayerInfo[playerid][pLastZ],PlayerInfo[playerid][pLastA],GetPlayerVirtualWorld(playerid));
format(query,sizeof(query),"%s `Interior` = '%d', `Admin` = '%d', `Moderator` = '%d', `Donator` = '%d', `Health` = '%f', `Armor` = '%f', `Skin` = '%d', `Minutes` = '%d', `Gender` = '%d',",
							query,GetPlayerInterior(playerid),PlayerInfo[playerid][pAdmin],PlayerInfo[playerid][pMod],PlayerInfo[playerid][pDonator],PlayerInfo[playerid][pHealth],
							PlayerInfo[playerid][pArmor],PlayerInfo[playerid][pSkin],PlayerInfo[playerid][pMinutes],PlayerInfo[playerid][pGender]);
format(query,sizeof(query),"%s `Bank` = '%d', `Faction` = '%d', `FacRank` = '%s', `Tier` = '%d', `Duty` = '%d', `OffSkin` = '%d', `Badge` = '%d', `Mask` = '%d', `MaskID` = '%d',",
							query,PlayerInfo[playerid][pBMoney],PlayerInfo[playerid][pFac],PlayerInfo[playerid][pFacRank],PlayerInfo[playerid][pTier],PlayerInfo[playerid][pDuty],
							PlayerInfo[playerid][pOffSkin],PlayerInfo[playerid][pBadge],PlayerInfo[playerid][pMask],PlayerInfo[playerid][pMaskID]);
format(query,sizeof(query),"%s `Phone` = '%d', `Job` = '%d', `DeathTime` = '%d', `Radio` = '%d', `Channel1` = '%d', `Channel2` = '%d', `Toolkits` = '%d', `Medikits` = '%d',",
							query,PlayerInfo[playerid][pPhone],PlayerInfo[playerid][pJob],PlayerInfo[playerid][pDeathTime],PlayerInfo[playerid][pRadio],PlayerInfo[playerid][pRadio1],
							PlayerInfo[playerid][pRadio2],PlayerInfo[playerid][pToolkit],PlayerInfo[playerid][pMedikit]);
format(query,sizeof(query),"%s `Screwdrivers` = '%d', `GasCans` = '%d', `Mats` = '%d', `DLicense` = '%d', `FLicense` = '%d', `BetaTester` = '%d', `LotteryTicket` = '%d', `Detective` = '%d',",
							query,PlayerInfo[playerid][pScrewdriver],PlayerInfo[playerid][pGasCan],PlayerInfo[playerid][pMats],1,0,PlayerInfo[playerid][pBetaTester],
							PlayerInfo[playerid][pLotteryTicket], PlayerInfo[playerid][pDetective]);
format(query,sizeof(query),"%s `DMVTest` = '%d', `Gun1` = '%d', `GunAmmo1` = '%d', `Gun2` = '%d', `GunAmmo2` = '%d', `Gun3` = '%d', `GunAmmo3` = '%d', `Gun` = '%d', `GunAmmo` = '%d',",
							query,PlayerInfo[playerid][pTakingTest],PlayerInfo[playerid][pGun1],PlayerInfo[playerid][pGunAmmo1],PlayerInfo[playerid][pGun2],PlayerInfo[playerid][pGunAmmo2],
							PlayerInfo[playerid][pGun3],PlayerInfo[playerid][pGunAmmo3],PlayerInfo[playerid][pGunHold],PlayerInfo[playerid][pGunHoldAmmo]);
format(query,sizeof(query),"%s `PrisonTime` = '%d', `AJail` = '%d', `Banned` = '%d', `Reason` = '%s', `Banner` = '%s', `FightStyle` = '%d', `Boombox` = '%d', `Cocaine` = '%d',",
							query,PlayerInfo[playerid][pPrisonTime],PlayerInfo[playerid][pAJail],PlayerInfo[playerid][pBanned],PlayerInfo[playerid][pBReason],PlayerInfo[playerid][pBanner],
							PlayerInfo[playerid][pFightStyle],PlayerInfo[playerid][pBoombox],PlayerInfo[playerid][pCocaine]);
format(query,sizeof(query),"%s `Crack` = '%d', `Weed` = '%d', `Seeds` = '%d', `DOB` = '%s', `Nationality` = '%s', `Height` = '%d', `Weight` = '%d', `HairColor` = '%s', `EyeColor` = '%s'",
							query,PlayerInfo[playerid][pCrack],PlayerInfo[playerid][pWeed],PlayerInfo[playerid][pSeeds],PlayerInfo[playerid][pDOB],PlayerInfo[playerid][pNationality],
							PlayerInfo[playerid][pHeight],PlayerInfo[playerid][pWeight],PlayerInfo[playerid][pHairColor],PlayerInfo[playerid][pEyeColor]);
format(query,sizeof(query),"%s WHERE `ID` = '%d'",query,PlayerInfo[playerid][pID]);
mysql_query(connection,query);
return 1;
}

forward SaveDoor(bizid);
public SaveDoor(bizid)
{
new query[900];
format(query,sizeof(query),"UPDATE `doors` SET `ox` = '%f', `oy` = '%f', `oz` = '%f', `oa` = '%f', `oi` = '%d', `ow` = '%d', `ix` = '%d', `iy` = '%f', `iz` = '%f', `ia` = '%f',",
							DoorInfo[bizid][dox],DoorInfo[bizid][doy],DoorInfo[bizid][doz],DoorInfo[bizid][doa],DoorInfo[bizid][doi],DoorInfo[bizid][dow],DoorInfo[bizid][dix],
							DoorInfo[bizid][diy],DoorInfo[bizid][diz],DoorInfo[bizid][dia]);
format(query,sizeof(query),"%s `ii` = '%d', `iw` = '%d', `locked` = '%d', `label` = '%s', `texton` = '%d' WHERE `ID` = '%d'",
							query,DoorInfo[bizid][dii],DoorInfo[bizid][diw],DoorInfo[bizid][dlocked],DoorInfo[bizid][dlabel],DoorInfo[bizid][dtexton],bizid);
mysql_query(connection,query);
return 1;
}

forward LoadDoor(bizid);
public LoadDoor(bizid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
	{
		cache_get_value_name_float(0,"ox",DoorInfo[bizid][dox]);
		cache_get_value_name_float(0,"oy",DoorInfo[bizid][doy]);
		cache_get_value_name_float(0,"oz",DoorInfo[bizid][doz]);
		cache_get_value_name_float(0,"oa",DoorInfo[bizid][doa]);
		cache_get_value_name_float(0,"ix",DoorInfo[bizid][dix]);
		cache_get_value_name_float(0,"iy",DoorInfo[bizid][diy]);
		cache_get_value_name_float(0,"iz",DoorInfo[bizid][diz]);
		cache_get_value_name_float(0,"ia",DoorInfo[bizid][dia]);
		cache_get_value_name_int(0,"oi",DoorInfo[bizid][doi]);
		cache_get_value_name_int(0,"ow",DoorInfo[bizid][dow]);
		cache_get_value_name_int(0,"ii",DoorInfo[bizid][dii]);
		cache_get_value_name_int(0,"iw",DoorInfo[bizid][diw]);
		cache_get_value_name_int(0,"locked",DoorInfo[bizid][dlocked]);
		cache_get_value_name(0,"label",DoorInfo[bizid][dlabel],256);
		cache_get_value_name_int(0,"texton",DoorInfo[bizid][dtexton]);
		new str[256];
		if(DoorInfo[bizid][dtexton] == 1) format(str, sizeof(str), "%s\n{FFFFFF}/enter", DoorInfo[bizid][dlabel]);
		else format(str, sizeof(str), "");
		DoorInfo[bizid][dtext] = Create3DTextLabel(str, -1, DoorInfo[bizid][dox], DoorInfo[bizid][doy], DoorInfo[bizid][doz], 10.0, 0, 1);
	}
	return 1;
}

forward SaveBiz(bizid);
public SaveBiz(bizid)
{
new query[900];
format(query,sizeof(query),"UPDATE `bizs` SET `name` = '%s', `ownerid` = '%d', `locked` = '%d', `price` = '%d', `type` = '%d', `typeshow` = '%d', `money` = '%d', `ox` = '%f', `oy` = '%f',",
							BizInfo[bizid][bName],BizInfo[bizid][bOwner],BizInfo[bizid][bLocked],BizInfo[bizid][bPrice],BizInfo[bizid][bType],BizInfo[bizid][bTypeShow],BizInfo[bizid][bMoney],
							BizInfo[bizid][bOX],BizInfo[bizid][bOY]);
format(query,sizeof(query),"%s `oz` = '%f', `ix` = '%f', `iy` = '%f', `iz` = '%f', `bx` = '%f', `bby` = '%f', `bz` = '%f', `oint` = '%d', `ovw` = '%d', `iint` = '%d', `ivw` = '%d' WHERE `ID` = '%d'",
							query,BizInfo[bizid][bOZ],BizInfo[bizid][bIX],BizInfo[bizid][bIY],BizInfo[bizid][bIZ],BizInfo[bizid][bBX],BizInfo[bizid][bBY],BizInfo[bizid][bBZ],BizInfo[bizid][bOInt],
							BizInfo[bizid][bOVW],BizInfo[bizid][bIInt],BizInfo[bizid][bIVW],bizid);
mysql_query(connection,query);
return 1;
}

forward LoadBiz(bizid);
public LoadBiz(bizid)
{
	new string[60],rows;
	cache_get_row_count(rows);
	if(rows)
	{
		cache_get_value_name(0,"name",BizInfo[bizid][bName],30);
		cache_get_value_name_int(0,"ownerid",BizInfo[bizid][bOwner]);
		cache_get_value_name_int(0,"locked",BizInfo[bizid][bLocked]);
		cache_get_value_name_int(0,"price",BizInfo[bizid][bPrice]);
		cache_get_value_name_int(0,"type",BizInfo[bizid][bType]);
		cache_get_value_name_int(0,"typeshow",BizInfo[bizid][bTypeShow]);
		cache_get_value_name_int(0,"money",BizInfo[bizid][bMoney]);
		cache_get_value_name_float(0,"ox",BizInfo[bizid][bOX]);
		cache_get_value_name_float(0,"oy",BizInfo[bizid][bOY]);
		cache_get_value_name_float(0,"oz",BizInfo[bizid][bOZ]);
		cache_get_value_name_float(0,"ix",BizInfo[bizid][bIX]);
		cache_get_value_name_float(0,"iy",BizInfo[bizid][bIY]);
		cache_get_value_name_float(0,"iz",BizInfo[bizid][bIZ]);
		cache_get_value_name_float(0,"bx",BizInfo[bizid][bBX]);
		cache_get_value_name_float(0,"bby",BizInfo[bizid][bBY]);
		cache_get_value_name_float(0,"bz",BizInfo[bizid][bBZ]);
		cache_get_value_name_int(0,"oint",BizInfo[bizid][bOInt]);
		cache_get_value_name_int(0,"ovw",BizInfo[bizid][bOVW]);
		cache_get_value_name_int(0,"iint",BizInfo[bizid][bIInt]);
		cache_get_value_name_int(0,"ivw",BizInfo[bizid][bIVW]);
		format(string,sizeof(string),"%s\n{FFFFFF}/enter",BizInfo[bizid][bName],GetBusinessType(BizInfo[bizid][bType]));
		if(BizInfo[bizid][bTypeShow] != 0) format(string,sizeof(string),"%s\n%s\n{FFFFFF}Commands: /enter /buy",BizInfo[bizid][bName],GetBusinessType(BizInfo[bizid][bType]));
		if(BizInfo[bizid][bOwner] == -1) format(string,sizeof(string),"%s\nPrice: $%d\n{FFFFFF}Commands: /enter /buy",GetBusinessType(BizInfo[bizid][bType]),BizInfo[bizid][bPrice]);
		BizInfo[bizid][bLabel] = Create3DTextLabel(string, 0x00D700FF, BizInfo[bizid][bOX], BizInfo[bizid][bOY], BizInfo[bizid][bOZ], 10.0, 0, 1);
		BizInfo[bizid][bBLabel] = Create3DTextLabel("Commands:\n{FFFFFF}/buy", 0x00D700FF, BizInfo[bizid][bBX], BizInfo[bizid][bBY], BizInfo[bizid][bBZ], 10.0, 0, 1);
	}
	return 1;
}

forward SaveOpTable(table);
public SaveOpTable(table)
{
new query[321];
format(query,sizeof(query),"UPDATE `optables` SET `X` = '%f', `Y` = '%f', `Z` = '%f', `VW` = '%d' WHERE `ID` = '%d'",
							OTableInfo[table][OTX],OTableInfo[table][OTY],OTableInfo[table][OTZ],OTableInfo[table][OpVW],table);
mysql_query(connection,query);
return 1;
}

forward LoadOpTable(table);
public LoadOpTable(table)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
    cache_get_value_name_float(0,"X",OTableInfo[table][OTX]);
    cache_get_value_name_float(0,"Y",OTableInfo[table][OTY]);
    cache_get_value_name_float(0,"Z",OTableInfo[table][OTZ]);
    cache_get_value_name_int(0,"VW",OTableInfo[table][OpVW]);
}
return 1;
}

forward SaveGasStation(gasid);
public SaveGasStation(gasid)
{
new query[321];
format(query,sizeof(query),"UPDATE `gasstations` SET `OwnerID` = '%d', `X` = '%f', `Y` = '%f', `Z` = '%f', `VW` = '%d', `Interior` = '%d', `Price` = '%d' WHERE `ID` = '%d'",
							GasStationInfo[gasid][gsOwner],GasStationInfo[gasid][gsX],GasStationInfo[gasid][gsY],GasStationInfo[gasid][gsZ],GasStationInfo[gasid][gsVW],GasStationInfo[gasid][gsInt],
							GasStationInfo[gasid][gsPrice],gasid);
mysql_query(connection,query);
return 1;
}

forward LoadGasStation(gasid);
public LoadGasStation(gasid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
    cache_get_value_name_int(0,"OwnerID",GasStationInfo[gasid][gsOwner]);
    cache_get_value_name_float(0,"X",GasStationInfo[gasid][gsX]);
    cache_get_value_name_float(0,"Y",GasStationInfo[gasid][gsY]);
    cache_get_value_name_float(0,"Z",GasStationInfo[gasid][gsZ]);
    cache_get_value_name_int(0,"VW",GasStationInfo[gasid][gsVW]);
    cache_get_value_name_int(0,"Interior",GasStationInfo[gasid][gsInt]);
    cache_get_value_name_int(0,"Price",GasStationInfo[gasid][gsPrice]);
}
return 1;
}

forward SaveFaction(facid);
public SaveFaction(facid)
{
new query[900];
format(query,sizeof(query),"UPDATE `factions` SET `Name` = '%s', `Type` = '%d', `Money` = '%d', `Badges` = '%d', `Weapon_Colt` = '%d', `Weapon_Deagle` = '%d',",
							FactionInfo[facid][Name],FactionInfo[facid][Type],FactionInfo[facid][Money],FactionInfo[facid][Badges],FactionInfo[facid][Weapon_Colt],
							FactionInfo[facid][Weapon_Deagle]);
format(query,sizeof(query),"%s `Weapon_UZI` = '%d', `Weapon_Tec` = '%d', `Weapon_Shotgun` = '%d', `Weapon_M4` = '%d', `Weapon_AK` = '%d', `Weapon_Sniper` = '%d', `Weapon_Kevlar` = '%d',",
							query,FactionInfo[facid][Weapon_UZI],FactionInfo[facid][Weapon_Tec],FactionInfo[facid][Weapon_Shotgun],FactionInfo[facid][Weapon_M4],
							FactionInfo[facid][Weapon_AK],FactionInfo[facid][Weapon_Sniper],FactionInfo[facid][Weapon_Kevlar]);
format(query,sizeof(query),"%s `Dealer1` = '%d', `Dealer2` = '%d', `Dealer3` = '%d', `LockerName` = '%s', `LockerX` = '%f', `LockerY` = '%f', `LockerZ` = '%f', `LockerVW` = '%d' WHERE `ID` = '%d'",
							query,FactionInfo[facid][FacDealer1],FactionInfo[facid][FacDealer2],FactionInfo[facid][FacDealer3],FactionInfo[facid][LockerName],FactionInfo[facid][LockerX],
							FactionInfo[facid][LockerY],FactionInfo[facid][LockerZ],FactionInfo[facid][LockerVW],facid);
mysql_query(connection,query);
return 1;
}

forward LoadFaction(facid);
public LoadFaction(facid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
	new name[120];
    cache_get_value_name(0,"Name",name);
    format(FactionInfo[facid][Name],120,name);
    cache_get_value_name_int(0,"Type",FactionInfo[facid][Type]);
    cache_get_value_name_int(0,"Money",FactionInfo[facid][Money]);
    cache_get_value_name_int(0,"Badges",FactionInfo[facid][Badges]);
    cache_get_value_name_int(0,"Weapon_Colt",FactionInfo[facid][Weapon_Colt]);
    cache_get_value_name_int(0,"Weapon_Deagle",FactionInfo[facid][Weapon_Deagle]);
    cache_get_value_name_int(0,"Weapon_UZI",FactionInfo[facid][Weapon_UZI]);
    cache_get_value_name_int(0,"Weapon_Tec",FactionInfo[facid][Weapon_Tec]);
    cache_get_value_name_int(0,"Weapon_Shotgun",FactionInfo[facid][Weapon_Shotgun]);
    cache_get_value_name_int(0,"Weapon_M4",FactionInfo[facid][Weapon_M4]);
    cache_get_value_name_int(0,"Weapon_AK",FactionInfo[facid][Weapon_AK]);
    cache_get_value_name_int(0,"Weapon_Sniper",FactionInfo[facid][Weapon_Sniper]);
    cache_get_value_name_int(0,"Weapon_Kevlar",FactionInfo[facid][Weapon_Kevlar]);
    cache_get_value_name_int(0,"Dealer1",FactionInfo[facid][FacDealer1]);
    cache_get_value_name_int(0,"Dealer2",FactionInfo[facid][FacDealer2]);
    cache_get_value_name_int(0,"Dealer3",FactionInfo[facid][FacDealer3]);
    cache_get_value_name(0,"LockerName",name);
    format(FactionInfo[facid][LockerName],120,name);
    cache_get_value_name_float(0,"LockerX",FactionInfo[facid][LockerX]);
    cache_get_value_name_float(0,"LockerY",FactionInfo[facid][LockerY]);
    cache_get_value_name_float(0,"LockerZ",FactionInfo[facid][LockerZ]);
    cache_get_value_name_int(0,"LockerVW",FactionInfo[facid][LockerVW]);
    new string[80];
	format(string,sizeof(string),"%s\n{FFFFFF}/lockers",FactionInfo[facid][LockerName]);
	FactionInfo[facid][Lockers] = Create3DTextLabel(string, 0x008080FF, FactionInfo[facid][LockerX], FactionInfo[facid][LockerY], FactionInfo[facid][LockerZ], 10.0, 0, 1);
	FactionInfo[facid][Chat] = 1;
}
return 1;
}

forward SaveVehicle(vehid);
public SaveVehicle(vehid)
{
new query[640];
format(query,sizeof(query),"UPDATE `vehicles` SET `vID` = '%d', `OwnerID` = '%d', `Model` = '%d', `X` = '%f', `Y` = '%f', `Z` = '%f', `A` = '%f',",
							DVehicles[vehid][dID],DVehicles[vehid][vOwner],DVehicles[vehid][dModel],DVehicles[vehid][dX],DVehicles[vehid][dY],DVehicles[vehid][dZ],
							DVehicles[vehid][dA]);
format(query,sizeof(query),"%s `Color1` = '%d', `Color2` = '%d', `Health` = '%f', `Plate` = '%s', `Bulletproof` = '%d', `Locked` = '%d', `Faction` = '%d',",
							query,DVehicles[vehid][dColor1],DVehicles[vehid][dColor2],DVehicles[vehid][vHealth],DVehicles[vehid][vPlate],DVehicles[vehid][vBulletproof],
							DVehicles[vehid][vLocked],DVehicles[vehid][vFaction]);
format(query,sizeof(query),"%s `Rental` = '%d', `Job` = '%d', `DMV` = '%d', `Slots` = '%d', `Fuel` = '%d' WHERE `ID` = '%d'",
							query,DVehicles[vehid][vRental],DVehicles[vehid][vJob],DVehicles[vehid][vDMV],DVehicles[vehid][vSlots],DVehicles[vehid][vFuel],DVehicles[vehid][vUID]);
mysql_query(connection,query);
return 1;
}

forward LoadVehicle(vehid);
public LoadVehicle(vehid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
	cache_get_value_name_int(0,"ID",DVehicles[vehid][vUID]);
    cache_get_value_name_int(0,"OwnerID",DVehicles[vehid][vOwner]);
    cache_get_value_name_int(0,"Model",DVehicles[vehid][dModel]);
    cache_get_value_name_float(0,"X",DVehicles[vehid][dX]);
    cache_get_value_name_float(0,"Y",DVehicles[vehid][dY]);
    cache_get_value_name_float(0,"Z",DVehicles[vehid][dZ]);
    cache_get_value_name_float(0,"A",DVehicles[vehid][dA]);
    cache_get_value_name_int(0,"Color1",DVehicles[vehid][dColor1]);
    cache_get_value_name_int(0,"Color2",DVehicles[vehid][dColor2]);
    cache_get_value_name_float(0,"Health",DVehicles[vehid][vHealth]);
    new plate[6];
    cache_get_value_name(0,"Plate",plate);
    format(DVehicles[vehid][vPlate],6,plate);
    cache_get_value_name_int(0,"Bulletproof",DVehicles[vehid][vBulletproof]);
    cache_get_value_name_int(0,"Locked",DVehicles[vehid][vLocked]);
    cache_get_value_name_int(0,"Faction",DVehicles[vehid][vFaction]);
    cache_get_value_name_int(0,"Rental",DVehicles[vehid][vRental]);
    cache_get_value_name_int(0,"Job",DVehicles[vehid][vJob]);
    cache_get_value_name_int(0,"DMV",DVehicles[vehid][vDMV]);
    cache_get_value_name_int(0,"Slots",DVehicles[vehid][vSlots]);
    cache_get_value_name_int(0,"Fuel",DVehicles[vehid][vFuel]);
    DVehicles[vehid][dID] = CreateVehicle(DVehicles[vehid][dModel], DVehicles[vehid][dX],DVehicles[vehid][dY],DVehicles[vehid][dZ],DVehicles[vehid][dA], DVehicles[vehid][dColor1], DVehicles[vehid][dColor2],-1);
    SaveVehicle(vehid);
 	if(DVehicles[vehid][vLocked] != 0) SetVehicleParamsEx(DVehicles[vehid][dID], 0, 0, 0, 1, 0, 0, 0);
 	else SetVehicleParamsEx(DVehicles[vehid][dID], 0, 0, 0, 0, 0, 0, 0);
    SetVehicleHealth(DVehicles[vehid][dID],DVehicles[vehid][vHealth]);
    SetVehicleNumberPlate(DVehicles[vehid][dID],DVehicles[vehid][vPlate]);
    DVehicles[vehid][vRenter] = 1111;
}
return 1;
}

forward SaveHouse(houseid);
public SaveHouse(houseid)
{
new query[640];
format(query,sizeof(query),"UPDATE `houses` SET `OwnerID` = '%d', `OutsideX` = '%f', `OutsideY` = '%f', `OutsideZ` = '%f', `OutsideInt` = '%d', `OutsideVW` = '%d',",
							HouseInfo[houseid][hOwner],HouseInfo[houseid][hOX],HouseInfo[houseid][hOY],HouseInfo[houseid][hOZ],HouseInfo[houseid][hOInt],HouseInfo[houseid][hOVW]);
format(query,sizeof(query),"%s `InsideX` = '%f', `InsideY` = '%f', `InsideZ` = '%f', `InsideInt` = '%d', `InsideVW` = '%d', `Price` = '%d', `Locked` = '%d' WHERE `ID` = '%d'",
							query,HouseInfo[houseid][hIX],HouseInfo[houseid][hIY],HouseInfo[houseid][hIZ],HouseInfo[houseid][hIInt],HouseInfo[houseid][hIVW],HouseInfo[houseid][hPrice],
							HouseInfo[houseid][hLocked],houseid);
mysql_query(connection,query);
return 1;
}

forward LoadHouse(houseid);
public LoadHouse(houseid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
    cache_get_value_name_int(0,"OwnerID",HouseInfo[houseid][hOwner]);
    cache_get_value_name_float(0,"OutsideX",HouseInfo[houseid][hOX]);
    cache_get_value_name_float(0,"OutsideY",HouseInfo[houseid][hOY]);
    cache_get_value_name_float(0,"OutsideZ",HouseInfo[houseid][hOZ]);
    cache_get_value_name_int(0,"OutsideInt",HouseInfo[houseid][hOInt]);
    cache_get_value_name_int(0,"OutsideVW",HouseInfo[houseid][hOVW]);
    cache_get_value_name_float(0,"InsideX",HouseInfo[houseid][hIX]);
    cache_get_value_name_float(0,"InsideY",HouseInfo[houseid][hIY]);
    cache_get_value_name_float(0,"InsideZ",HouseInfo[houseid][hIZ]);
    cache_get_value_name_int(0,"InsideInt",HouseInfo[houseid][hIInt]);
    cache_get_value_name_int(0,"InsideVW",HouseInfo[houseid][hIVW]);
    cache_get_value_name_int(0,"Price",HouseInfo[houseid][hPrice]);
    cache_get_value_name_int(0,"Locked",HouseInfo[houseid][hLocked]);
    new string[60];
	format(string,sizeof(string),"[House %d]",houseid);
	if(HouseInfo[houseid][hOwner] == 0) format(string,sizeof(string),"[House %d]\nPrice: $%d",houseid,HouseInfo[houseid][hPrice]);
	HouseInfo[houseid][hLabel] = Create3DTextLabel(string, 0x00D700FF, HouseInfo[houseid][hOX], HouseInfo[houseid][hOY], HouseInfo[houseid][hOZ], 10.0, 0, 1);
}
return 1;
}

stock GetWeaponSlotNum(weaponid)
{
new slot;
switch(weaponid)
{
case 0 .. 5,10 .. 18,41,43: slot = 1;
case 6 .. 9,22 .. 24: slot = 2;
case 26,28,29,32,42,46: slot = 3;
case 25,27,30,31,33,34: slot = 4;
}
return slot;
}

stock GetWeaponSlot(weaponid)
{
new slot;
switch(weaponid)
{
case 0,1: slot = 0;
case 2,3,4,5,6,7,8,9: slot = 1;
case 10,11,12,13,14,15: slot = 10;
case 16,17,18,39: slot = 8;
case 22,23,24: slot =2;
case 25,26,27: slot = 3;
case 28,29,32: slot = 4;
case 30,31: slot = 5;
case 33,34: slot = 6;
case 35,36,37,38: slot = 7;
case 40: slot = 12;
case 41,42,43: slot = 9;
case 44,45,46: slot = 11;
}
return slot;
}

stock VehicleHasEngine(vehid)
{
new slot;
new model = GetVehicleModel(vehid);
switch(model)
{
case 435,450,481,509,510,569,570,584,590,591,606,607,608,610,611: slot = 1;
}
return slot;
}

stock VehicleWindow(vehid)
{
new slot;
switch(vehid)
{
case 400 .. 434, 436 .. 445,447,449,451,455,456,458 .. 460,466,467,469,470,474 .. 480,482,483,487 .. 492,494 .. 508,511 .. 520,524 .. 529, 532 .. 538,540 ..  567,573 .. 580,582,583,585,587,588,589,592,593,596 .. 605,609: slot = 1;
case 435,446,448,450,452 .. 454,457,461 .. 465,468,471 .. 473,481,484 .. 486,493,509,510,521,522,523,530,531,539,568 .. 572,581,584,586,590,591,594,595,606,607,608,610,611: slot = 2;
}
return slot;
}

stock IsGunStorable(weaponid)
{
new slot;
switch(weaponid)
{
case 1,4,11,12,13,16,17,22,23,24,28,32,39,40,41,43: slot = 1;
case 2,3,5,6,7,8,9,10,14,15,18,25,26,27,29,30,31,33,34,35,36,37,38,42,46: slot = 0;
}
return slot;
}

stock SkinGender(skinid)
{
new slot;
switch(skinid)
{
case 1 .. 8,14 .. 30,32 .. 37,42 .. 52,57 .. 62,66 .. 68,70,72,73,78 .. 84,86,94 .. 128,132 .. 137,142 .. 144,146,147,149,153 .. 156,158 .. 168,170,171,173 .. 177,179 .. 189,200,202 .. 204,206,208 .. 210,212,213,217,220 .. 223,227 .. 230,234 .. 236,239 .. 242,247 .. 250,252 .. 255,258 .. 262,264,268 .. 273,289 .. 299,303 .. 305: slot = 1;
case 9 .. 13,31,38 .. 41,53 .. 56,63 .. 65,69,75 .. 77,85,87 .. 93,129 .. 131,138 .. 141,145,148,150 .. 152,157,169,172,178,190 .. 199,201,205,207,214 .. 216,218,219,224 .. 226,231 .. 233,237,238,243 .. 246,251,256,257,263: slot = 2;
case 0,71,74,211,265 .. 267,274 .. 288,300 .. 302,306 .. 311: slot = 3;
}
return slot;
}

forward GetAvailablePlate(type,vehid,plate,playerid,virvehid);
public GetAvailablePlate(type,vehid,plate,playerid,virvehid)
{
new rows;
cache_get_row_count(rows);
if(rows)
{
    new platei = randomEx(100000,999999),Query[80];
	format(Query,sizeof(Query),"SELECT `Phone` FROM `users` WHERE `Phone` = '%d'",platei);
	mysql_tquery(connection,Query,"GetAvailablePlate","ii",DVehicles[vehid][dID],platei);
	return 1;
}
new string[240];
if (type == 1)
{
	valstr(DVehicles[virvehid][vPlate],plate);
	SetVehicleNumberPlate(vehid, DVehicles[virvehid][vPlate]);
	PutPlayerInVehicle(playerid, vehid, 0);
    SetVehicleParamsEx(vehid, 1, 0, 0, 0, 0, 0, 0);
    InfoMessage(playerid, "Vehicle created. Type /apark to re-park it.");
    format(string, sizeof(string), "%s has created vehicle ID %d.", RPN(playerid,0), virvehid);
    if(AdminHideCmds[playerid] == 0)SendAdminWarnMessage(string);
    AdminLog(string);
    format(string, sizeof(string), "SELECT * FROM `vehicles` WHERE `vID` = '%d'",virvehid);
    mysql_tquery(connection,string,"GetVehicleUniversalID","i",virvehid);
}
else if (type == 2)
{
    valstr(DVehicles[virvehid][vPlate],plate);
	SetVehicleNumberPlate(vehid, DVehicles[virvehid][vPlate]);
	format(string,sizeof(string),"You have bought a vehicle! Be sure to /park it away from the dealership or it will be removed! (ID: %d)",DVehicles[vehid][dID]);
	InfoMessage(playerid,string);
	format(string, sizeof(string), "SELECT * FROM `vehicles` WHERE `vID` = '%d'",virvehid);
    mysql_tquery(connection,string,"GetVehicleUniversalID","i",virvehid);
}
return 1;
}

forward GetVehicleUniversalID(vehid);
public GetVehicleUniversalID(vehid)
{
	cache_get_value_name_int(0,"ID",DVehicles[vehid][vUID]);
	SaveVehicle(vehid);
	return 1;
}

forward GetAvailableTicket(playerid,ticket);
public GetAvailableTicket(playerid,ticket)
{
new rows,string[146];
cache_get_row_count(rows);
if(rows) return ErrorMessage(playerid,"That lottery ticket number is already taken.");
format(string,sizeof(string),"You have bought a lottery ticket! (%d)",ticket);
InfoMessage(playerid, string);
PlayerInfo[playerid][pLotteryTicket] = ticket;
GivePMoney(playerid, -25);
return 1;
}

forward GetAvailablePhoneNum(playerid,number);
public GetAvailablePhoneNum(playerid,number)
{
new rows,string[146];
cache_get_row_count(rows);
if(rows)
{
    new platei = randomEx(111111,999999),Query[80];
	format(Query,sizeof(Query),"SELECT `Phone` FROM `users` WHERE `Phone` = '%d'",platei);
	mysql_tquery(connection,Query,"GetAvailablePhoneNum","ii",playerid,platei);
	return 1;
}
PlayerInfo[playerid][pPhone] = number;
format(string,sizeof(string),"You have bought a phone! (%d)",number);
InfoMessage(playerid, string);
GivePMoney(playerid, -125);
return 1;
}

stock SetPHealth(playerid,Float:amount)
{
	PlayerInfo[playerid][pHealth] = amount;
	new hp[4];
    format(hp, sizeof(hp), "%d", floatround(amount));
	PlayerTextDrawSetString(playerid, playerHP[playerid], hp);
    return 1;
}

stock SetPArmour(playerid,Float:amount)
{
    PlayerInfo[playerid][pArmor] = amount;
    new ap[4];
    format(ap, sizeof(ap), "%d", floatround(amount));
	PlayerTextDrawSetString(playerid, playerAP[playerid], ap);
    return 1;
}

stock FAC_FIRSTAID(playerid)
{
    SetPHealth(playerid, 100);
    return 1;
}

stock FAC_KEVLAR(playerid)
{
	new string[184];
    SetPArmour(playerid, 100);
	MeMessage(playerid, "takes a Kevlar from the lockers.");
	format(string, sizeof(string), "%s took a Kevlar from the lockers.", RPN(playerid,0));
	SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);
	return 1;
}

stock FAC_WEAPON(playerid,gunid,ammo)
{
    if(GetPlayerWeapon(playerid) != 0) return ErrorMessage(playerid, "You can't hold more than one weapon in hand!");
    new string[184],gunname[32];
    GetWeaponName(gunid,gunname,32);
    GivePlayerWeapon(playerid, gunid, ammo);
    format(string, sizeof(string), "takes a %s from the lockers.",gunname);
	MeMessage(playerid, string);
	format(string, sizeof(string), "%s took a %s with %d ammo from the lockers.", RPN(playerid,0),gunname,ammo);
	if(gunid == WEAPON_SPRAYCAN) format(string, sizeof(string), "%s took a Pepper Spray from the lockers.", RPN(playerid,0));
	SendFactionInfoMessage(PlayerInfo[playerid][pFac], string);
	HasWeapon[playerid] = 1;
	return 1;
}
stock SHOP_LOTTERYTICKET(playerid)
{
	if(PlayerInfo[playerid][pLotteryTicket] != 0) return ErrorMessage(playerid, "You already have a lottery ticket.");
	if(GetPlayerMoney(playerid) < 25) return ErrorMessage(playerid, "You cannot afford that!");
	ShowPlayerDialog(playerid, DIALOG_LOTTERY_TICKET, DIALOG_STYLE_INPUT,"Buy Lottery Ticket","Enter the number of the lottery ticket you want to buy.","Confirm","Exit");
	return 1;
}
stock SHOP_BUYMASK(playerid)
{
	if(PlayerInfo[playerid][pMask] == 1) return ErrorMessage(playerid, "You already have a mask.");
	if(GetPlayerMoney(playerid) < 100) return ErrorMessage(playerid, "You cannot afford that!");
	InfoMessage(playerid, "You have received a mask.");
	GetPlayerName(playerid, PlayerInfo[playerid][pRealName], MAX_PLAYER_NAME);
	PlayerInfo[playerid][pMaskID] = randomEx(111111,999999);
	PlayerInfo[playerid][pMask] = 1;
	GivePMoney(playerid, -100);
	return 1;
}
stock SHOP_GASCAN(playerid)
{
	if(PlayerInfo[playerid][pGasCan] >= 1) return ErrorMessage(playerid, "You can't carry more gas cans!");
	if(GetPlayerMoney(playerid) < 65) return ErrorMessage(playerid, "You cannot afford that!");
	InfoMessage(playerid, "You have received a gas can.");
	PlayerInfo[playerid][pGasCan] = PlayerInfo[playerid][pGasCan] + 1;
	GivePMoney(playerid, -65);
	return 1;
}
stock SHOP_SCREWDRIVER(playerid)
{
	if(PlayerInfo[playerid][pScrewdriver] >= 2) return ErrorMessage(playerid, "You can't carry more screwdrivers!");
	if(GetPlayerMoney(playerid) < 50) return ErrorMessage(playerid, "You cannot afford that!");
	InfoMessage(playerid, "You have received a screwdriver.");
	PlayerInfo[playerid][pScrewdriver] = PlayerInfo[playerid][pScrewdriver] + 1;
	GivePMoney(playerid, -50);
	return 1;
}
stock SHOP_MEDIKIT(playerid)
{
	if(PlayerInfo[playerid][pMedikit] == 2) return ErrorMessage(playerid, "You can't carry more medikits!");
	if(GetPlayerMoney(playerid) < 75) return ErrorMessage(playerid, "You cannot afford that!");
	InfoMessage(playerid, "You have received a medikit.");
	PlayerInfo[playerid][pMedikit] = PlayerInfo[playerid][pMedikit] + 1;
	GivePMoney(playerid, -75);
	return 1;
}
stock SHOP_TOOLKIT(playerid)
{
	if(PlayerInfo[playerid][pToolkit] == 2) return ErrorMessage(playerid, "You can't carry more toolkits!");
	if(GetPlayerMoney(playerid) < 85) return ErrorMessage(playerid, "You cannot afford that!");
	InfoMessage(playerid, "You have received a toolkit.");
	PlayerInfo[playerid][pToolkit] = PlayerInfo[playerid][pToolkit] + 1;
	GivePMoney(playerid, -85);
	return 1;
}
stock SHOP_CAMERA(playerid)
{
	if(GetPlayerWeapon(playerid) != 0) return ErrorMessage(playerid, "You can't hold more than one weapon in hand!");
	if(GetPlayerMoney(playerid) < 60) return ErrorMessage(playerid, "You cannot afford that!");
	InfoMessage(playerid, "You have received a camera.");
	GivePlayerWeapon(playerid, WEAPON_CAMERA, 20);
	GivePMoney(playerid, -60);
	HasWeapon[playerid] = 1;
	return 1;
}
stock SHOP_PHONE(playerid)
{
	if(PlayerInfo[playerid][pPhone] != 0) return ErrorMessage(playerid, "You already have a phone!");
	if(GetPlayerMoney(playerid) < 125) return ErrorMessage(playerid, "You cannot afford that!");
	new platei = randomEx(111111,999999),Query[80];
	format(Query,sizeof(Query),"SELECT `Phone` FROM `users` WHERE `Phone` = '%d'",platei);
	mysql_tquery(connection,Query,"GetAvailablePhoneNum","ii",playerid,platei);
	return 1;
}
stock SHOP_RADIO(playerid)
{
	if(PlayerInfo[playerid][pRadio] != 0) return ErrorMessage(playerid, "You already have a portable radio!");
	if(GetPlayerMoney(playerid) < 85) return ErrorMessage(playerid, "You cannot afford that!");
	PlayerInfo[playerid][pRadio] = 1;
	InfoMessage(playerid, "You have bought a portable radio!");
	GivePMoney(playerid, -85);
	return 1;
}
stock SHOP_BOOMBOX(playerid)
{
	if(PlayerInfo[playerid][pBoombox] != 0) return ErrorMessage(playerid, "You already have a boombox!");
	if(GetPlayerMoney(playerid) < 95) return ErrorMessage(playerid, "You cannot afford that!");
	PlayerInfo[playerid][pBoombox] = 1;
	InfoMessage(playerid, "You have bought a boombox!");
	GivePMoney(playerid, -200);
	return 1;
}

stock GetIDFromNumber(number)
{
	new playerid = -1;
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pPhone] != 0)
		{
		    if(IsLogged[i] == 1)
		    {
				if(PlayerInfo[i][pPhone] == number)
				{
					playerid = i;
				}
			}
		}
	}
	return playerid;
}

stock BuyDealerVeh(playerid,price,model)
{
	new thing;
    for(new b = 0; b < sizeof(DVehicles); b++)
    {
        if(DVehicles[b][dModel] != 0)
        {
            if(DVehicles[b][vOwner] == PlayerInfo[playerid][pID]) thing = thing + 1;
        }
    }
	if(thing >= 3) return ErrorMessage(playerid, "You have reached the maximum of vehicles you can own.");
	if(PlayerInfo[playerid][pDLicense] != 1) return ErrorMessage(playerid, "You need to have a license to buy a car!");
	if(GetPlayerMoney(playerid) < price) return ErrorMessage(playerid, "You can't afford this vehicle!");
	GivePMoney(playerid, price);
	new fileid,name[MAX_PLAYER_NAME];
    fileid = CreateVehicle(411,0,0,0,0,0,0,0,0);
    DestroyVehicle(fileid);
    DVehicles[fileid][dModel] = model;
    DVehicles[fileid][dX] = -1450.6105;
    DVehicles[fileid][dY] = 2574.5925;
    DVehicles[fileid][dZ] = 55.5267;
    DVehicles[fileid][dA] = 180;
    DVehicles[fileid][dColor1] = randomEx(0,100);
    DVehicles[fileid][dColor2] = randomEx(0,100);
    DVehicles[fileid][vFaction] = 0;
    DVehicles[fileid][vLocked] = 1;
    DVehicles[fileid][vRental] = 0;
    DVehicles[fileid][vBulletproof] = 0;
    DVehicles[fileid][vHealth] = 1000;
    DVehicles[fileid][vJob] = 0;
    DVehicles[fileid][vFuel] = 100;
    DVehicles[fileid][vOwner] = PlayerInfo[playerid][pID];
    DVehicles[fileid][dID] = CreateVehicle(DVehicles[fileid][dModel], DVehicles[fileid][dX],DVehicles[fileid][dY],DVehicles[fileid][dZ],DVehicles[fileid][dA], DVehicles[fileid][dColor1], DVehicles[fileid][dColor2], -1);
    new Query[240];
    format(Query,sizeof(Query),"INSERT INTO `vehicles` (vID,Model,X,Y,Z,Color1,Color2) VALUES ('%d','%d','%f','%f','%f','%d','%d')",fileid,model,-1450.6105,2574.592,55.5267,DVehicles[fileid][dColor1],DVehicles[fileid][dColor2]);
    mysql_query(connection,Query);
    GetPlayerName(playerid,name,sizeof(name));
    new plate = randomEx(100000,999999);
	format(Query,sizeof(Query),"SELECT `Phone` FROM `users` WHERE `Phone` = '%d'",plate);
	mysql_tquery(connection,Query,"GetAvailablePlate","iiiii",2,DVehicles[fileid][dID],plate,playerid,fileid);
	return 1;
}

stock GetAvailableVehicle()
{
for(new vehid = 1; vehid < sizeof(DVehicles); vehid++)
{
	if(DVehicles[vehid][dID] == 0)
 	{
  		return vehid;
    }
}
return 0;
}

stock GetVehicleName(vehicleid)
{
    new String[160];
    if(!GetVehicleModel(vehicleid)) return String;
    format(String,sizeof(String),"%s",VehicleNames[GetVehicleModel(vehicleid) - 400]);
	return String;
}

/*

Lonelymoo's RP Name Checker
(c), 2012, January 6.

*/

stock NameValidator(playerid)
{
    new pname[MAX_PLAYER_NAME],underline=0;
    GetPlayerName(playerid, pname, sizeof(pname));
    if(strfind(pname,"[",true) != (-1)) return 0;
    else if(strfind(pname,"]",true) != (-1)) return 0;
    else if(strfind(pname,"$",true) != (-1)) return 0;
    else if(strfind(pname,"(",true) != (-1)) return 0;
    else if(strfind(pname,")",true) != (-1)) return 0;
    else if(strfind(pname,"=",true) != (-1)) return 0;
    else if(strfind(pname,"@",true) != (-1)) return 0;
    else if(strfind(pname,"1",true) != (-1)) return 0;
    else if(strfind(pname,"2",true) != (-1)) return 0;
    else if(strfind(pname,"3",true) != (-1)) return 0;
    else if(strfind(pname,"4",true) != (-1)) return 0;
    else if(strfind(pname,"5",true) != (-1)) return 0;
    else if(strfind(pname,"6",true) != (-1)) return 0;
    else if(strfind(pname,"7",true) != (-1)) return 0;
    else if(strfind(pname,"8",true) != (-1)) return 0;
    else if(strfind(pname,"9",true) != (-1)) return 0;
    new maxname = strlen(pname);
    for(new i=0; i<maxname; i++)
    {
       if(pname[i] == '_') underline ++;
    }
    if(underline != 1) return 0;
    pname[0] = toupper(pname[0]);
    for(new x=1; x<maxname; x++)
    {
        if(pname[x] == '_') pname[x+1] = toupper(pname[x+1]);
        else if(pname[x] != '_' && pname[x-1] != '_') pname[x] = tolower(pname[x]);
    }
    SetPlayerName(playerid, "New_Name");
    SetPlayerName(playerid, pname);
    return 1;
}

stock GetWeaponObject(weaponid)
{
new slot;
switch(weaponid)
{
case 1: slot = 331;
case 2: slot = 333;
case 3: slot = 334;
case 4: slot = 335;
case 5: slot = 336;
case 6: slot = 337;
case 7: slot = 338;
case 8: slot = 339;
case 9: slot = 341;
case 10: slot = 321;
case 11: slot = 323;
case 12: slot = 322;
case 13: slot = 324;
case 14: slot = 325;
case 15: slot = 326;
case 16: slot = 342;
case 17: slot = 343;
case 18: slot = 344;
case 22: slot = 346;
case 23: slot = 347;
case 24: slot = 348;
case 25: slot = 349;
case 26: slot = 350;
case 27: slot = 351;
case 28: slot = 352;
case 29: slot = 353;
case 30: slot = 355;
case 31: slot = 356;
case 32: slot = 372;
case 33: slot = 357;
case 34: slot = 358;
case 35: slot = 359;
case 36: slot = 360;
case 37: slot = 361;
case 38: slot = 362;
case 39: slot = 363;
case 40: slot = 364;
case 41: slot = 365;
case 42: slot = 366;
case 43: slot = 367;
case 44: slot = 368;
case 45: slot = 369;
case 46: slot = 371;
}
return slot;
}

stock SendSplitMessage(playerid, color,final[]) //Credits to whoever made this
{
    new buffer[EX_SPLITLENGTH+10];
    new len = strlen(final);
    if(len>EX_SPLITLENGTH)
    {
        new times = (len/EX_SPLITLENGTH);
        for(new i = 0; i < times+1; i++)
        {
            strdel(buffer, 0, EX_SPLITLENGTH+5);
            if(len-(i*EX_SPLITLENGTH)>EX_SPLITLENGTH)
            {
                strmid(buffer, final, EX_SPLITLENGTH*i, EX_SPLITLENGTH*(i+1));
                if(!i)
                	format(buffer, sizeof(buffer), "%s ...", buffer);
				else
				    format(buffer, sizeof(buffer), "... %s ...", buffer);
            }
            else
            {
                strmid(buffer, final, EX_SPLITLENGTH*i, len);
				format(buffer, sizeof(buffer), "... %s", buffer);
            }
            SendClientMessage(playerid, color, buffer);
        }
    }
    else
    {
        SendClientMessage(playerid, color, final);
    }
}

stock OPTABLE_PATH(doorid)
{
    new string[128];
    format(string,sizeof(string),OPTABLES_PATH,doorid);
    return string;
}
stock BIZ_PATH(bizid)
{
    new string[128];
    format(string,sizeof(string),BIZS_PATH,bizid);
    return string;
}

stock explode(const sSource[], aExplode[][], const sDelimiter[] = " ", iVertices = sizeof aExplode, iLength = sizeof aExplode[]) // Created by Westie
{
	new
		iNode,
		iPointer,
		iPrevious = -1,
		iDelimiter = strlen(sDelimiter);

	while(iNode < iVertices)
	{
		iPointer = strfind(sSource, sDelimiter, false, iPointer);

		if(iPointer == -1)
		{
			strmid(aExplode[iNode], sSource, iPrevious, strlen(sSource), iLength);
			break;
		}
		else
		{
			strmid(aExplode[iNode], sSource, iPrevious, iPointer, iLength);
		}

		iPrevious = (iPointer += iDelimiter);
		++iNode;
	}
	return iPrevious;
}

forward CreatePlayerInfoBox(playerid,type,text[]);
public CreatePlayerInfoBox(playerid,type,text[])
{
    new string[124];
    format(string,sizeof(string)," %s", text);
    HidePlayerInfoBox(playerid);

    if(type == 1)
    {
        PlayerTextDrawSetString(playerid, InfoBoxHead[playerid], "Info");
        PlayerTextDrawColor(playerid, InfoBoxHead[playerid], COLGREEN);
    }

    else
    {
        PlayerTextDrawSetString(playerid, InfoBoxHead[playerid], "Error");
        PlayerTextDrawColor(playerid, InfoBoxHead[playerid], COLRED);
    }

    PlayerTextDrawShow(playerid, InfoBoxHead[playerid]);

    PlayerTextDrawSetString(playerid, InfoBoxText[playerid], string);
    PlayerTextDrawShow(playerid, InfoBoxText[playerid]);

    InfoBoxTimer[playerid] = SetTimerEx("HidePlayerInfoBox",5000,false,"i",playerid);
    return 1;
}

forward HidePlayerInfoBox(playerid);
public HidePlayerInfoBox(playerid)
{
    PlayerTextDrawHide(playerid, InfoBoxHead[playerid]);
    PlayerTextDrawHide(playerid, InfoBoxText[playerid]);
    KillTimer(InfoBoxTimer[playerid]);
    return 1;
}

forward CreatePlayerStatBox(playerid,headtext[],text[],align);
public CreatePlayerStatBox(playerid,headtext[],text[],align)
{
    new string[346];
    format(string,sizeof(string),"%s", text);
    HidePlayerStatBox(playerid);
    PlayerTextDrawSetString(playerid, StatBoxHead[playerid], headtext);
    PlayerTextDrawShow(playerid, StatBoxHead[playerid]);
    switch(align)
    {
    	case 1: 
    	{
    		PlayerTextDrawSetString(playerid,StatBoxLeftText[playerid], string);
    		PlayerTextDrawShow(playerid, StatBoxLeftText[playerid]);
    	}
    	case 2:
    	{
    		PlayerTextDrawSetString(playerid,StatBoxCenterText[playerid], string);
    		PlayerTextDrawShow(playerid, StatBoxCenterText[playerid]);
    	}
    }
    StatBoxTimer[playerid] = SetTimerEx("HidePlayerStatBox",15000,false,"i",playerid);
    return 1;
}

forward HidePlayerStatBox(playerid);
public HidePlayerStatBox(playerid)
{
    PlayerTextDrawHide(playerid, StatBoxHead[playerid]);
    PlayerTextDrawHide(playerid, StatBoxLeftText[playerid]);
    PlayerTextDrawHide(playerid, StatBoxCenterText[playerid]);
    KillTimer(StatBoxTimer[playerid]);
    return 1;
}

stock DRUGS_INV(playerid,drug)
{
DrugInvSelect[playerid] = drug;
new string[164],sstring[164];
if(DrugInvSelect[playerid] == 1) {format(string,sizeof(string),"Cocaine Menu"); format(sstring,sizeof(sstring),"Use\nGive\nDrop");}
else if(DrugInvSelect[playerid] == 2) {format(string,sizeof(string),"Weed Menu"); format(sstring,sizeof(sstring),"Use\nGive\nDrop");}
else if(DrugInvSelect[playerid] == 3) {format(string,sizeof(string),"Seeds Menu"); format(sstring,sizeof(sstring),"Give\nPlant\nDrop");}
ShowPlayerDialog(playerid, DIALOG_DRUGINV_MENU, DIALOG_STYLE_LIST, string, sstring, "Select", "Back");
return 1;
}

stock DRUGS_INV_MENU(playerid,drug,choice)
{
new list;
if(drug == 1 || drug == 2) {list = 1;}
else if(drug == 3) {list = 2;}
if(list == 1)
{
	if(choice == 1) {ShowPlayerDialog(playerid, DIALOG_DRUGINV_USE, DIALOG_STYLE_INPUT, "Use", "How much do you want to use?", "Confirm", "Back");}
	else if(choice == 2) {ShowPlayerDialog(playerid, DIALOG_DRUGINV_GIVE1, DIALOG_STYLE_INPUT, "Give", "How many do you want to give?", "Next", "Back");}
	else if(choice == 3) {ShowPlayerDialog(playerid, DIALOG_DRUGINV_DROP, DIALOG_STYLE_INPUT, "Drop", "How many do you want to drop?", "Confirm", "Back");}
}
else if(list == 2)
{
	if(choice == 2) {ShowPlayerDialog(playerid, DIALOG_DRUGINV_GIVE1, DIALOG_STYLE_INPUT, "Give", "How many do you want to give?", "Next", "Back");}
	else if(choice == 3) {InfoMessage(playerid,"Not made yet");}
	else if(choice == 4) {ShowPlayerDialog(playerid, DIALOG_DRUGINV_DROP, DIALOG_STYLE_INPUT, "Drop", "How many do you want to drop?", "Confirm", "Back");}
}
return 1;
}

forward DrugUse(playerid,drug,amount);
public DrugUse(playerid,drug,amount)
{
new string[164];
if(amount < 1) return ErrorMessage(playerid,"Invalid amount.");
if(drug == 1){
if(UsingCocaine[playerid] == 1) return ErrorMessage(playerid,"You are already using Cocaine.");
UsingCocaine[playerid] = 1;
}
else if(drug == 2){
if(UsingWeed[playerid] == 1) return ErrorMessage(playerid,"You are already using Weed.");
PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed] - amount;
SetPlayerSpecialAction(playerid,21);
if(amount == 1) format(string,sizeof(string),"You light up a joint with %d gram.",amount);
else if(amount > 1) format(string,sizeof(string),"You light up a joint with %d grams.",amount);
InfoMessage(playerid,string);
UsingWeed[playerid] = 1;
amount = amount * 20000;
SetTimerEx("FinishedWeed", amount, false, "i", playerid);}
return 1;
}

forward FinishedWeed(playerid);
public FinishedWeed(playerid)
{
InfoMessage(playerid, "You finished your joint.");
SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + 4000);
SetPlayerSpecialAction(playerid,0);
UsingWeed[playerid] = 0;
return 1;
}

forward NotDrunk(playerid);
public NotDrunk(playerid)
{
SetPlayerDrunkLevel(playerid, 0);
return 1;
}

stock GATE_1(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if(Gate1 != 1){MoveDynamicObject(EQSDGate1,-1415.08,2638.8,55.5+0.0001,0.0005,0,0,90); Gate1 = 1; MeMessage(playerid, "opens the gate with their remote.");}
else if(Gate1 == 1){MoveDynamicObject(EQSDGate1,-1415.08,2638.8,55.5-0.0001,0.0005,0,90,90); Gate1 = 0; MeMessage(playerid, "closes the gate with their remote.");}
return 1;
}

stock GATE_2(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if(Gate2 == 1){MoveDynamicObject(EQSDGate2,1370.40295,389.31790,3383.99878+0.0001,1,0,0,90); Gate2 = 0; }
else if(Gate2 != 1){MoveDynamicObject(EQSDGate2,1370.40295,387.6,3383.99878-0.0001,1,0,0,90); Gate2 = 1; }
return 1;
}

stock GATE_3(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if(Gate3 == 1){MoveDynamicObject(EQSDGate3,1935.625122,-2262.674072,13.822796,1,0.000000,0.000000,270.000000); Gate3 = 0;}
else if(Gate3 != 1){MoveDynamicObject(EQSDGate3,1935.625122,-2264.305664,13.822796,1,0.000000,0.000000,270.000000); Gate3 = 1;}
return 1;
}

stock GATE_4(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if(Gate4 == 1){MoveDynamicObject(EQSDGate4,1939.767944,-2262.684814,13.822796,1,0.000000,0.000000,270.000000); Gate4 = 0;}
else if(Gate4 != 1){MoveDynamicObject(EQSDGate4,1939.767944,-2264.326416,13.822796,1,0.000000,0.000000,270.000000); Gate4 = 1;}
return 1;
}

stock GATE_5(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if(Gate5 != 1){MoveDynamicObject(EQSDGate5,-1200.883789,1842.507568,41.559131,0.7,0,0,-44.799980); Gate5 = 1; MeMessage(playerid, "opens the gate with their remote.");}
else if(Gate5 == 1){MoveDynamicObject(EQSDGate5,-1196.739257,1838.392700,41.559131,0.7,0,0,-44.799980); Gate5 = 0; MeMessage(playerid, "closes the gate with their remote.");}
return 1;
}
stock GATE_6(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return ErrorMessage(playerid, "You are not a member of SASMD!");
if(Gate6 != 1){MoveDynamicObject(EQSDGate6,1940.728881,-2241.208007,14.872814,1,0,0,0); Gate6 = 1;}
else if(Gate6 == 1){MoveDynamicObject(EQSDGate6,1942.059204,-2241.208007,14.872814,1,0,0,0); Gate6 = 0;}
return 1;
}
stock GATE_7(playerid)
{
if(PlayerInfo[playerid][pFac] != 1) return 1;
if(Gate7 != 1){MoveDynamicObject(EQSDGate7,1958.880737,-2274.750244,13.822794,1,0,0,0); Gate7 = 1;}
else if(Gate7 == 1){MoveDynamicObject(EQSDGate7,1957.269409,-2274.750244,13.822794,1,0,0,0); Gate7 = 0;}
return 1;
}

stock GetAgeFromDOB(dob[])
{
    new dobb[4],value,time[6];
    getdate(time[0], time[1], time[2]);
    sscanf(dob, "p</>ddd", dobb[0], dobb[1], dobb[2]);
    value = (time[0]-(dobb[2]+1)) * 365;
    new preyear;
    if(dobb[2] < 2000) preyear = 1;
    value += (time[1]-1) * daysInMonth[dobb[1]] + (12 - dobb[1]) * daysInMonth[dobb[1]];
    value += time[2] + (daysInMonth[dobb[1]] - dobb[0]) - preyear;
    return value/365;
}

stock CheckBoomBox(playerid){
    for(new i; i<MAX_PLAYERS; i++){
        if(GetPVarInt(i, "PlayerBBArea")){
	        if(IsPlayerInDynamicArea(playerid, GetPVarInt(i, "PlayerBBArea"))){
		        if(strcmp(PlayerBBPUrl[playerid], PlayerBBUrl[i])){
		        	format(PlayerBBPUrl[playerid], 256, PlayerBBUrl[i]);
     				PlayAudio(playerid, PlayerBBUrl[i], GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ"), 30.0, 1);
					PlayerBBMOn[playerid] = 1;
		   		}
	  		}else if(PlayerBBMOn[playerid] != 0 && !IsPlayerInDynamicArea(playerid, GetPVarInt(i, "PlayerBBArea"))){
	  			StopAudio(playerid);
				PlayerBBPUrl[playerid] = "none";
				PlayerBBMOn[playerid] = 0;
			}
		}
	}
	return 1;
}
stock StopAudio(playerid){
	return StopAudioStreamForPlayer(playerid);
}
stock PlayAudio(playerid, url[], Float:posX = 0.0, Float:posY = 0.0, Float:posZ = 0.0, Float:distance = 50.0, usepos = 0)
{
    PlayAudioStreamForPlayer(playerid, url, posX, posY, posZ, distance, usepos);
}

stock DoorCount(){
	new nm;
	for(new i; i<MAX_DOORS; i++){
	    if(DoorCreated[i] != 0) nm++;
	}
	return nm;
}

stock EmptyDoor(){
	for(new i; i<MAX_DOORS; i++){
	    if(DoorCreated[i] == 0) return i;
	}
	return 1;
}

stock CheckDoors(playerid)
{
	new Float:x, Float:y, id;
	for(new i; i<MAX_DOORS; i++){
	    if(DoorCreated[i] != 0){
	        id = i;
	        if(IsPlayerInRangeOfPoint(playerid, 1.0, DoorInfo[id][dox], DoorInfo[id][doy], DoorInfo[id][doz]) && DoorInfo[id][dlocked] == 0){
	            x = DoorInfo[id][dix] + floatsin(-DoorInfo[id][dia], degrees) * 2.3;
				y = DoorInfo[id][diy] + floatsin(-DoorInfo[id][dia], degrees) * 2.3;
				SetPlayerVirtualWorld(playerid, DoorInfo[id][diw]);
				SetPlayerInterior(playerid, DoorInfo[id][dii]);
				SetPlayerPos(playerid, x, y, DoorInfo[id][diz]);
				SetPlayerFacingAngle(playerid, DoorInfo[id][dia]);
				SetCameraBehindPlayer(playerid);
	        }else if(IsPlayerInRangeOfPoint(playerid, 1.0, DoorInfo[id][dix], DoorInfo[id][diy], DoorInfo[id][diz]) && DoorInfo[id][dlocked] == 0){
	            x = DoorInfo[id][dox] + floatsin(-DoorInfo[id][doa], degrees) * 2.3;
				y = DoorInfo[id][doy] + floatsin(-DoorInfo[id][doa], degrees) * 2.3;
				SetPlayerVirtualWorld(playerid, DoorInfo[id][dow]);
				SetPlayerInterior(playerid, DoorInfo[id][doi]);
				SetPlayerPos(playerid, x, y, DoorInfo[id][doz]);
				SetPlayerFacingAngle(playerid, DoorInfo[id][doa]);
				SetCameraBehindPlayer(playerid);
	        }
	    }
	}
	return 1;
}


forward Float:GetDistance(Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2);
public Float:GetDistance(Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2)
{
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock ResetInjures(playerid)
{
    sInfo[playerid][Misc] = 0;
	sInfo[playerid][Head] = 0;
	sInfo[playerid][Chest] = 0;
	sInfo[playerid][Crotch] = 0;
	sInfo[playerid][LArm] = 0;
	sInfo[playerid][RArm] = 0;
	sInfo[playerid][LLeg] = 0;
	sInfo[playerid][RLeg] = 0;
	timenothit[playerid] = 0;
	return 1;
}

stock ShowInjures(playerid, toid)
{
	new holder[400], string[256], str[256];
	format(str, sizeof(str), "%s's Injures", GetName(playerid));
    if(sInfo[playerid][Misc] > 0) format(string, sizeof(string), "{FF0000}%d bruises on their body.\n", sInfo[playerid][Misc]);
	if(sInfo[playerid][Head] > 0) format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the head.\n", sInfo[playerid][Head]);
	if(sInfo[playerid][Chest] > 0) format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the chest.\n", sInfo[playerid][Chest]);
	if(sInfo[playerid][Crotch] > 0) format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the crotch.\n", sInfo[playerid][Crotch]);
	if(sInfo[playerid][LArm] > 0) format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the left arm.\n", sInfo[playerid][LArm]);
	if(sInfo[playerid][RArm] > 0) format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the right arm.\n", sInfo[playerid][RArm]);
	if(sInfo[playerid][LLeg] > 0) format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the left leg.\n", sInfo[playerid][LLeg]);
	if(sInfo[playerid][RLeg] > 0){
 		format(string, sizeof(string), "{FF0000}%d gun shot wound(s) in the right leg.\n", sInfo[playerid][RLeg]);
	}
	if(sInfo[playerid][Misc] == 0 && sInfo[playerid][Head] == 0 && sInfo[playerid][Chest] == 0 && sInfo[playerid][Crotch] == 0 && sInfo[playerid][LArm] == 0 && sInfo[playerid][RArm] == 0 && sInfo[playerid][LLeg] == 0 && sInfo[playerid][RLeg] == 0){
	    format(holder, sizeof(holder), "{FF0000}No Injures Were Found!");
	}
	strcat(holder, string, sizeof(holder));
	ShowPlayerDialog(toid, DIALOG_INJURES, DIALOG_STYLE_MSGBOX, str, holder, "Done", "");
	return 1;
}

stock SetUpPlayerText(playerid)
{
	speedo0[playerid] = CreatePlayerTextDraw(playerid, 637.000000, 355.648162, "usebox");
	PlayerTextDrawLetterSize(playerid, speedo0[playerid], 0.000000, 9.765639);
	PlayerTextDrawTextSize(playerid, speedo0[playerid], 532.166687, 0.000000);
	PlayerTextDrawAlignment(playerid, speedo0[playerid], 1);
	PlayerTextDrawColor(playerid, speedo0[playerid], 0);
	PlayerTextDrawUseBox(playerid, speedo0[playerid], true);
	PlayerTextDrawBoxColor(playerid, speedo0[playerid], 102);
	PlayerTextDrawSetShadow(playerid, speedo0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, speedo0[playerid], 0);
	PlayerTextDrawFont(playerid, speedo0[playerid], 0);

	speedo1[playerid] = CreatePlayerTextDraw(playerid, 534.166442, 359.851837, "Speed");
	PlayerTextDrawLetterSize(playerid, speedo1[playerid], 0.343750, 1.677778);
	PlayerTextDrawAlignment(playerid, speedo1[playerid], 1);
	PlayerTextDrawColor(playerid, speedo1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, speedo1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, speedo1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, speedo1[playerid], 51);
	PlayerTextDrawFont(playerid, speedo1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, speedo1[playerid], 1);

	speedo2[playerid] = CreatePlayerTextDraw(playerid, 533.750000, 380.074066, "Fuel");
	PlayerTextDrawLetterSize(playerid, speedo2[playerid], 0.343750, 1.677778);
	PlayerTextDrawAlignment(playerid, speedo2[playerid], 1);
	PlayerTextDrawColor(playerid, speedo2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, speedo2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, speedo2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, speedo2[playerid], 51);
	PlayerTextDrawFont(playerid, speedo2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, speedo2[playerid], 1);

	speedo3[playerid] = CreatePlayerTextDraw(playerid, 534.166625, 401.333312, "Doors");
	PlayerTextDrawLetterSize(playerid, speedo3[playerid], 0.343750, 1.677778);
	PlayerTextDrawAlignment(playerid, speedo3[playerid], 1);
	PlayerTextDrawColor(playerid, speedo3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, speedo3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, speedo3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, speedo3[playerid], 51);
	PlayerTextDrawFont(playerid, speedo3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, speedo3[playerid], 1);

	speedo4[playerid] = CreatePlayerTextDraw(playerid, 534.166687, 423.629638, "Windows");
	PlayerTextDrawLetterSize(playerid, speedo4[playerid], 0.343750, 1.677778);
	PlayerTextDrawAlignment(playerid, speedo4[playerid], 1);
	PlayerTextDrawColor(playerid, speedo4[playerid], -1);
	PlayerTextDrawSetShadow(playerid, speedo4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, speedo4[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, speedo4[playerid], 51);
	PlayerTextDrawFont(playerid, speedo4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, speedo4[playerid], 1);
}

stock ShowPlayerSpeedo(playerid, op)
{
	if(op == 1)
	{
		PlayerTextDrawShow(playerid, speedo0[playerid]);
		PlayerTextDrawShow(playerid, speedo1[playerid]);
		PlayerTextDrawShow(playerid, speedo2[playerid]);
		PlayerTextDrawShow(playerid, speedo3[playerid]);
		PlayerTextDrawShow(playerid, speedo4[playerid]);
	}
	if(op == 0)
	{
		PlayerTextDrawHide(playerid, speedo0[playerid]);
		PlayerTextDrawHide(playerid, speedo1[playerid]);
		PlayerTextDrawHide(playerid, speedo2[playerid]);
		PlayerTextDrawHide(playerid, speedo3[playerid]);
		PlayerTextDrawHide(playerid, speedo4[playerid]);
	}
}

stock UpdatePlayerSpeedo(playerid)
{
	new str[256];
	format(str, sizeof(str), "Speed: %d km/h", floatround(GetPlayerSpeed(playerid,true)));
	PlayerTextDrawSetString(playerid, speedo1[playerid], str);
	if(GetVehicleGas(GetPlayerVehicleID(playerid)) <= 10) {
		format(str, sizeof(str), "Fuel: ~r~%d %%", GetVehicleGas(GetPlayerVehicleID(playerid)));
	}
	else {
		format(str, sizeof(str), "Fuel: ~w~%d", GetVehicleGas(GetPlayerVehicleID(playerid)));
	}
	PlayerTextDrawSetString(playerid, speedo2[playerid], str);
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
	if(doors == 0){
 		format(str, sizeof(str), "Doors: ~r~Locked");
 	}else {
 	    format(str, sizeof(str), "Doors: ~g~Unlocked");
 	}
	PlayerTextDrawSetString(playerid, speedo3[playerid], str);
    if(GetVehicleWindows(GetPlayerVehicleID(playerid)) == 1) {
 		format(str, sizeof(str), "Windows: ~r~UP");
	}
	else {
	    format(str, sizeof(str), "Windows: ~g~Down");
	}
	PlayerTextDrawSetString(playerid, speedo4[playerid], str);
}

stock GetVehicleGas(vid) return DVehicles[vid][vFuel];

stock GetVehicleWindows(vid) return DVehicles[vid][vWindows];

stock GetPlayerSpeed(playerid,bool:kkmh)
{
    new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz);       else GetPlayerVelocity(playerid,Vx,Vy,Vz);
    rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
    return kkmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}