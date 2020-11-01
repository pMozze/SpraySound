#include <sdktools>

ConVar g_cvSpraySound = null;
char g_szSound[PLATFORM_MAX_PATH];

public Plugin myinfo = {
    name = "SpraySound",
    author = "Mozze",
    description = "",
    version = "1.0",
    url = "t.me/pMozze"
};

public void OnPluginStart() {
    g_cvSpraySound = CreateConVar("sm_spraysound", "player/sprayer.wav", "Путь до звука без sound/");
    AutoExecConfig(true, "SpraySound");
    AddNormalSoundHook(soundHook);
}

public void OnConfigsExecuted() {
    char Buffer[PLATFORM_MAX_PATH];

    Format(Buffer, sizeof(Buffer), "sound/%s", g_szSound);
    AddFileToDownloadsTable(Buffer);

    g_cvSpraySound.GetString(g_szSound, sizeof(g_szSound));
    PrecacheSound(g_szSound);
}

public Action soundHook(Clients[64], &numClients, char Sample[PLATFORM_MAX_PATH], int &Entity, int &Channel, float &Volume, int &Level, int &Pitch, int &Flags) {
    if (StrEqual(Sample, "player/sprayer.wav")) {
        strcopy(Sample, PLATFORM_MAX_PATH, g_szSound);
        return Plugin_Changed;
    }

    return Plugin_Continue;
}