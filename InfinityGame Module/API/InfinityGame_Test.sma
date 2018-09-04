#include <amxmodx>
#include <fakemeta>
#include <cstrike>
#include <hamsandwich>
#include <infinitygame>

#define PLUGIN "InfinityGame Module: Test Plugin"
#define VERSION "1.0"
#define AUTHOR "Josefu Rias de Dias"

#define MUZZLEFLASH "sprites/3dmflared.spr"

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	register_event("HLTV", "Event_NewRound", "a", "1=0", "2=0")
	register_logevent("Event_RoundStart", 2, "1=Round_Start")
	register_logevent("Event_RoundEnd", 2, "1=Round_End")

	// Class 1st
	IG_EndRound_Block(true, true)
	register_clcmd("say /endround", "endround") // Win CT, Effect, 3s
	register_clcmd("say /endround2", "endround2") // Win T, No Effect, 5s
	register_clcmd("say /endround3", "endround3") // Win Draw, Effect, 5s
	
	// Class 2nd
	register_clcmd("say /roundtime", "roundtime") // Set round time 120:30
	register_clcmd("say /mapname", "mapname") // Set map name 'Desert Storm'
	register_clcmd("say /emit", "emits") // play AK47 for self
	register_clcmd("say /emit2", "emits2") // play M4A1 for all around
	
	// Class 3rd
	register_clcmd("say /teamset", "teamset") // set team CT for self
	register_clcmd("say /teamset2", "teamset2") // set all to team CT
	register_clcmd("say /speedset", "speedset") // set speed 350, no block
	register_clcmd("say /speedset2", "speedset2") // set speed 350, block
	register_clcmd("say /speedreset", "speedreset") // reset speed
	register_clcmd("say /modelset", "modelset") // set self as 'VIP'
	register_clcmd("say /modelset2", "modelset2") // set all as 'VIP'
	register_clcmd("say /modelreset", "modelreset") // reset model for all
	
	// Class 4th
	register_clcmd("say /semiclip", "semiclip") // On, CT only, pass enemy
	register_clcmd("say /semiclip2", "semiclip2") // On, both, not pass enemy
	register_clcmd("say /semiclip3", "semiclip3") // Off
	register_clcmd("say /printcolor", "printcolor") // print color
	register_clcmd("say /fog", "fog") // set self red
	register_clcmd("say /fog2", "fog2") // set all green
	register_clcmd("say /fog3", "fog3") // reset all
	//register_clcmd("say /tutor", "tutor") // tutor show green
	//register_clcmd("say /tutor2", "tutor2") // close tutor
	register_clcmd("say /view", "view") // set 3rdview
	register_clcmd("say /view2", "view2") // reset 3rdview
	register_clcmd("say /dlight", "dlight") // set dlight green
	register_clcmd("say /dlight2", "dlight2") // reset dlight
	
	// Class 5th
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_m4a1", "Weapon_M4A1", 1)
	register_clcmd("say /attach", "attach")
	//register_clcmd("say /attach2", "attach2")
}


public Event_NewRound()
{
	IG_ClientPrintColor(0, "!gRound New!n")
}

public Event_RoundStart()
{
	IG_ClientPrintColor(0, "!gRound Start!n")
}

public Event_RoundEnd()
{
	IG_ClientPrintColor(0, "!gRound End!n")
}

public plugin_precache() 
{
	precache_generic("resource/UI/TutorTextWindow.res")
	precache_generic("gfx/career/icon_i.tga")
	precache_generic("gfx/career/icon_skulls.tga")
	
	precache_model(MUZZLEFLASH)
}
public client_putinserver(id) IG_Muzzleflash_Set(id, MUZZLEFLASH, 0.25)

// Class 1st
public endround() IG_TerminateRound(WIN_CT, 3.0, 1);
public endround2() IG_TerminateRound(WIN_TERRORIST, 5.0, 0);
public endround3() IG_TerminateRound(WIN_DRAW, 5.0, 1);

// Class 2nd
public roundtime(id) IG_RoundTime_Set(120, 30);
public mapname(id) 
{
	IG_MapName_Patch("Desert Storm 2");
	static Map[64];
	get_mapname(Map, 63);
	
	client_print(id, print_chat, "Map %s", Map)
}
public emits(id) 
{
	static Body, Target; get_user_aiming(id, Target, Body, 9999)
	
	if(is_user_alive(Target))
		IG_EmitSound(Target, 0, CHAN_WEAPON, "weapons/ak47-1.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM);
}
public emits2(id) IG_EmitSound(id, 0, CHAN_WEAPON, "weapons/m4a1-1.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM);

// Class 3rd
public teamset(id) IG_TeamSet(id, CS_TEAM_T);
public teamset2(id) 
{
	for(new i = 0; i < get_maxplayers(); i++)
	{
		if(!is_user_connected(i))
			continue
			
		if(cs_get_user_team(i) == CS_TEAM_CT) IG_TeamSet(i, CS_TEAM_T)
		else if(cs_get_user_team(i) == CS_TEAM_T) IG_TeamSet(i, CS_TEAM_CT)
	}
}
public speedset(id) IG_SpeedSet(id, 350.0, 0);
public speedset2(id) IG_SpeedSet(id, 350.0, 1);
public speedreset(id) IG_SpeedReset(id);
public modelset(id) IG_ModelSet(id, "vip", 1); 
public modelset2(id) 
{
	for(new i = 0; i < get_maxplayers(); i++)
	{
		if(!is_user_connected(i))
			continue
			
		IG_ModelSet(i, "vip", 1);
		client_print(id, print_chat, "Set %i", i)
	}
}
public modelreset(id)
{
	for(new i = 0; i < get_maxplayers(); i++)
	{
		if(!is_user_connected(i))
			continue
			
		IG_ModelReset(i);
	}
}

// Class 4th
public semiclip(id) IG_Semiclip(1, 2, 1);
public semiclip2(id) IG_Semiclip(1, 3, 0);
public semiclip3(id) IG_Semiclip(0, 0, 0);
public printcolor(id) IG_ClientPrintColor(0, "!gDias: !n Dkm, !tChung may!n lam an the a :v")
public fog(id) IG_Fog(id, 100, 0, 0, 4);
public fog2(id) IG_Fog(0, 0, 100, 0, 10);
public fog3(id) IG_Fog(0, 0, 0, 0, 0);
//public tutor(id) IG_TutorShow(0, "ZZZ", TUTOR_YELLOW);
//public tutor2(id) IG_TutorReset(0);
public view(id) IG_3rdView(id, 1);
public view2(id) IG_3rdView(id, 0);
public dlight(id) IG_DLight_Set(id, 1, 200, 200, 200, 10);
public dlight2(id) IG_DLight_Reset(id);

// Class 5th
public Weapon_M4A1(Ent)
{
	static ID; ID = pev(Ent, pev_owner)
	IG_Muzzleflash_Activate(ID);
}

public attach(id)
{
	IG_PlayerAttachment(id, MUZZLEFLASH, 10.0, 1.0, 0.0)
}


// Forward 
public IG_RunningTime() client_print(0, print_chat, "Running Time");
public IG_WeaponAnim(id, CSW, Anim) { setWeaponAnim(id, 0); return PLUGIN_HANDLED; }

stock setWeaponAnim(id, anim) 
{
	set_pev(id, pev_weaponanim, anim)

	message_begin(MSG_ONE, SVC_WEAPONANIM, {0, 0, 0}, id)
	write_byte(anim)
	write_byte(pev(id, pev_body))
	message_end()
} 
