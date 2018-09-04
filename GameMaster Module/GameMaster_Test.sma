#include <amxmodx>
#include <cstrike>
#include <gamemaster>

#define PLUGIN "[GM] Test"
#define VERSION "1.0"
#define AUTHOR "Dias Pendragon"

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	GM_EndRound_Block(true)
	
	register_clcmd("say /ter", "TerminateRound")
	register_clcmd("say /model", "Set_Model")
	register_clcmd("say /remodel", "ReSet_Model")
	register_clcmd("say /team1", "Set_Team1")
	register_clcmd("say /team2", "Set_Team2")
	register_clcmd("say /speed", "Set_Speed")
	register_clcmd("say /respeed", "ReSet_Speed")
}

public plugin_cfg()
{
	server_cmd("sv_maxspeed 999")
}

public TerminateRound(id)
{
	GM_TerminateRound(3.0, WINSTATUS_CT)
}

public Set_Model(id)
{
	GM_Set_PlayerModel(id, "vip")
}

public ReSet_Model(id)
{
	GM_Reset_PlayerModel(id)
}

public Set_Team1(id)
{
	GM_Set_PlayerTeam(id, CS_TEAM_T)
}

public Set_Team2(id)
{
	GM_Set_PlayerTeam(id, CS_TEAM_CT)
}
	
public Set_Speed(id)
{
	GM_Set_PlayerSpeed(id, 350.0, 1)
}

public ReSet_Speed(id)
{
	GM_Reset_PlayerSpeed(id)
}
	
public GM_Time()
{
	client_print(0, print_chat, "Running Out of Time!")
}