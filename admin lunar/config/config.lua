InsConfig = {} -- Version 2.5

-- Configuration : Menu d'administration
InsConfig.Debug = true ---@return boolean Si les prints de debug doient apparaitre (Par defaut : true)
InsConfig.UltimeDebug = true ---@return boolean Si les prints de ultime debug doient apparaitre (Par defaut : true)
InsConfig.CallbackDebug = false ---@return boolean Afficher les debugs des callbacks

InsConfig.IgnoreOneSync = false ---@return boolean Masquer les prints pour le warning de onesync
InsConfig.UseJob1 = true ---@return boolean Activer ou désactiver le job2 (les métiers)
InsConfig.UseJob2 = false ---@return boolean Activer ou désactiver le job2 (les gangs)
InsConfig.showNoteToStaff = false ---@return boolean Montrer la note qu'il a reçu de la part d'un joueur ?
InsConfig.bypassRename = true ---@return boolean Pouvoir changer le nom du script
InsConfig.Authenticator = false ---@return boolean Activer la commande /auth pour se mettre les permissions sans faire de commande depuis la console ?
InsConfig.ReportRaison = true ---@return boolean Besoin d'une raison pour faire un report ?
InsConfig.NoclipType = 1 ---@return number Type de NoClip (1 : vMenu, 2 : vue première personne)
InsConfig.UseStaffGun = false ---@return boolean Give une arme lorsque le mode modération est activé ? Permet de faire des actions avec le joueur et les véhicules (Staffgun Dynasty)
InsConfig.StaffGunName = ' ' ---@return string Si l'option au dessus est actif, quel arme donner ?
InsConfig.UniqueIdFormat = 'cccccc' ---@return string 'l' = lettre 'c' = chiffre (format des UID)
InsConfig.staffActive = {
    setPed = false, ---@return boolean Mettre un ped lorsque le mode staff est activé ?
    ped = 'u_m_y_ushi', ---@return string Si l'option au dessus est actif, quel ped mettre ? (Hash) => https://docs.fivem.net/docs/game-references/ped-models/
    showInfos = false, ---@return boolean Afficher les informations en bas de l'ecran par défaut ? Joueurs connectés / Reports
    showBlips = false, ---@return boolean Afficher les blips lorsque l'on active le mode staff ?
    staffSkin = true, ---@return boolean Mettre un skin au staff lorsque l'on active le mode staff ?
    showGamertags = false, ---@return boolean Afficher les pseudos lorsque l'on active le mode staff ?
}
-- Tenue dans préférences
InsConfig.staffSkins = {
    [1] = {
        sex = 0,
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 178,
        torso_2 = 4,
        arms = 179,
        pants_1 = 77,
        pants_2 = 4,
        shoes_1 = 55,
        shoes_2 = 4,
        mask_1 = 169,
        mask_2 = 0,
        helmet_1 = 91,
        helmet_2 = 4,
        bags_1 = 44,
        bags_2 = 0,
    },
    [2] = {
        sex = 0,
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 178,
        torso_2 = 4,
        arms = 179,
        pants_1 = 77,
        pants_2 = 4,
        shoes_1 = 55,
        shoes_2 = 4,
        mask_1 = 169,
        mask_2 = 0,
        helmet_1 = 91,
        helmet_2 = 4,
        bags_1 = 44,
        bags_2 = 0,
        mask_1 = 169,
        mask_2 = 0,
    },
    [3] = {
        sex = 0,
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 178,
        torso_2 = 2,
        arms = 179,
        pants_1 = 77,
        pants_2 = 2,
        shoes_1 = 55,
        shoes_2 = 2,
        mask_1 = 169,
        mask_2 = 0,
        helmet_1 = 91,
        helmet_2 = 2,
        bags_1 = 44,
        bags_2 = 0,
        mask_1 = 169,
        mask_2 = 0,
    },
    [4] = {
        sex = 0,
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 178,
        torso_2 = 3,
        arms = 179,
        pants_1 = 77,
        pants_2 = 3,
        shoes_1 = 55,
        shoes_2 = 3,
        mask_1 = 169,
        mask_2 = 0,
        helmet_1 = 91,
        helmet_2 = 3,
        bags_1 = 44,
        bags_2 = 0,
        mask_1 = 169,
        mask_2 = 0,
    },
    [5] = {
        sex = 0,
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 178,
        torso_2 = 1,
        arms = 179,
        pants_1 = 77,
        pants_2 = 1,
        shoes_1 = 55,
        shoes_2 = 1,
        mask_1 = 169,
        mask_2 = 0,
        helmet_1 = 91,
        helmet_2 = 1,
        bags_1 = 44,
        bags_2 = 0,
        mask_1 = 169,
        mask_2 = 0,
    },
    [6] = {
        sex = 0,
        tshirt_1 = 15,
        tshirt_2 = 0,
        torso_1 = 178,
        torso_2 = 0,
        arms = 179,
        pants_1 = 77,
        pants_2 = 0,
        shoes_1 = 55,
        shoes_2 = 0,
        mask_1 = 169,
        mask_2 = 0,
        helmet_1 = 91,
        helmet_2 = 0,
        bags_1 = 44,
        bags_2 = 0,
        mask_1 = 169,
        mask_2 = 0,
    },
}

-- Configuration : Menus et titres
InsConfig.MenuTitle = "Administration" ---@return string Retourne le texte affiché sur la bannière du menu RageUI
InsConfig.MenuSubTitle = "Administration" ---@return string Retourne le texte affiché sous la bannière du menu RageUI (Sur la ligne noir par defaut)
InsConfig.ServerTitle = "." ---@return string Retourne le titre du serveur (Affiché lors de la connexion, lors du ban ou d'une sanction)
InsConfig.ColorMenu = "~g~" ---@return string Retourne la couleur de certaines choses dans le menu
InsConfig.RightLabel = ">" ---@return string Retourne la couleur de certaines choses dans le menu

-- Configuration : Jail / Prison
InsConfig.PrisonPos = vec3(1642.0, 2570.0, 46.0) ---@return vector3 Retourne la position de la prison de votre serveur (Jail)
InsConfig.PrisonExit = vec3(1850.5, 2608.3, 45.5) ---@return vector3 Retourne la position de sorti (Jail)
InsConfig.Distance = 10.0 ---@return number Retourne la distance maximal a la quelle le joueur peut partir de la position indiqué au dessus (=> InsConfig.PrisonPos)
InsConfig.GiveVehicleOnExit = 'faggio' ---@return number Donner un véhicule lorsque la personne sort de jail ? nil = ne pas donner

-- Configuration : Ban
InsConfig.BanScreen = {
    bouton = '', ---@return string Texte qui apparait sur le bouton
    discord = '', ---@return string Lien qui revoit vers votre Discord pour contester les sanctions
    image = '', ---@return string Lien de l'image que vous souhaitez afficher sur l'ecran de ban
    image2 = '', ---@return string Lien de l'image que vous souhaitez afficher sur l'ecran d'échec de connexion lors d'un emoji dans un pseudo !
}

-- Configuration : Téléportations rapide
InsConfig.FastTravel = {
    {
        Name = "Parking Central", ---@return string Label sur le RageUI.List
        Position = vec3(216, -810, 30), ---@return vector3 Position lors de la téléportation
    },
    {
        Name = "Poste de police", ---@return string Label sur le RageUI.List
        Position = vec3(420, -1001, 29), ---@return vector3 Position lors de la téléportation
    },
}
InsConfig.Fastillegal = {
    {
        Name = "GoFast", ---@return string Label sur le RageUI.List
        Position = vec3(-1160.8839, -1532.0499, 4.3502), ---@return vector3 Position lors de la téléportation
    },
    {
        Name = "Labo de drogue", ---@return string Label sur le RageUI.List
        Position = vec3(-1161.5135, -1530.0522, 4.3064), ---@return vector3 Position lors de la téléportation
    },
}

