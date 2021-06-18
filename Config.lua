Config = {}

Config.notitype = 'mythic' --- 'esx' if you dont use mythic!

--- npc stuff
Config.Distancia = 10.0

Config.main = {

    {
        modelo = "cs_prolsec_02",
        coords = vector3(1869.29, 3686.78, 33.78),  ---- sheriff
        heading = 160.03,
        gender = "male"
    },
    {
        modelo = "s_f_y_scrubs_01",
        coords = vector3(294.65, -600.49, 43.3),  ---- ambulance
        heading = 157.14,
        gender = "male"
    },


}

--garage police!
Config.policejob = 'police' -- your policejob name drom db
Config.event = 'Night:policegarage' --- change it to 'Night:policegaragemoney' if you want the cars to take money!


--garage ambulance
Config.ambulancejob = 'ambulance'
Config.event2 = 'Night:ambulance'