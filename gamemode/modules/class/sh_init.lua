JOB = JOB or {}

JOB = {
	[1] = {
		Name = "백수",
		Desc = "",
		Salary = 15,
		Default = true,
		Weapons = {
		
		},
		Model = {
			"models/kerry/player/citizen/female_01.mdl",
			"models/kerry/player/citizen/female_02.mdl",
			"models/kerry/player/citizen/female_03.mdl",
			"models/kerry/player/citizen/female_04.mdl",
			"models/kerry/player/citizen/female_05.mdl",
			"models/kerry/player/citizen/female_06.mdl",
			"models/kerry/player/citizen/male_01.mdl",
			"models/kerry/player/citizen/male_02.mdl",
			"models/kerry/player/citizen/male_03.mdl",
			"models/kerry/player/citizen/male_04.mdl",
			"models/kerry/player/citizen/male_05.mdl",
			"models/kerry/player/citizen/male_06.mdl",
			"models/kerry/player/citizen/male_07.mdl",
			"models/kerry/player/citizen/male_08.mdl",
			"models/kerry/player/citizen/male_09.mdl",
		},		
	},
	
	[2] = {
		Name = "정비공",
		Desc = "",
		Salary = 15,
		Max = 2,
		GiveWeapon = true,
		Weapons = {
			"vc_wrench",
			"tow_attach",
		},
		Model = {
			"models/player/mechanic.mdl",
		},		
	},
	
	[3] = {
		Name = "경찰",
		Desc = "",
		Level = {
			[1] = {
				Name = "순경",
				Default = true,
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
			[2] = {
				Name = "경위",
				Default = true,
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
			[3] = {
				Name = "경감",
				Default = true,
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
			[4] = {
				Name = "총감",
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
			[5] = {
				Name = "청장",
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
		},
		Model = {
			"models/kerry/player/police_chicago_01.mdl",
			"models/kerry/player/police_chicago_02.mdl",
			"models/kerry/player/police_chicago_03.mdl",
			"models/kerry/player/police_chicago_04.mdl",
			"models/kerry/player/police_chicago_05.mdl",
			"models/kerry/player/police_chicago_06.mdl",
			"models/kerry/player/police_chicago_07.mdl",
			"models/kerry/player/police_chicago_08.mdl",
			"models/kerry/player/police_chicago_09.mdl",
			"models/player/kerry/f_sheriff_03.mdl",
			"models/player/kerry/f_sheriff_04.mdl",
			"models/player/kerry/thalia_sheriff_02.mdl",
			"models/player/kerry/thalia_sheriff_02.mdl",
			"models/player/kerry/f_sheriff_03.mdl",
			"models/player/kerry/f_sheriff_04.mdl",			
		},
		Salary = 30,
		WhiteList = true,
	},
	
	[4] = {
		Name = "응급 의료원",
		Desc = "",
		Model = {
			"models/player/kerry/medic/medic_01.mdl",
			"models/player/kerry/medic/medic_01_f.mdl",
			"models/player/kerry/medic/medic_02.mdl",
			"models/player/kerry/medic/medic_02_f.mdl",
			"models/player/kerry/medic/medic_03.mdl",
			"models/player/kerry/medic/medic_03_f.mdl",
			"models/player/kerry/medic/medic_04.mdl",
			"models/player/kerry/medic/medic_04_f.mdl",
			"models/player/kerry/medic/medic_05.mdl",
			"models/player/kerry/medic/medic_05_f.mdl",
			"models/player/kerry/medic/medic_06.mdl",
			"models/player/kerry/medic/medic_06_f.mdl",
			"models/player/kerry/medic/medic_07.mdl",
		},
		Salary = 40,
		WhiteList = true,
		Weapons = {
			"weapon_gmedkit",
			"weapon_gdefib",
			"weapon_bandages",
		},
	},
	
	[5] = {
		Name = "배달 알바",
		Desc = "",
		Salary = 15,
		GiveWeapon = true,
		Weapons = {
			
		},
		Model = {
		
		},		
	},
	
	[6] = {
		Name = "FBI",
		Desc = "",
		Model = {
			"models/fbi_pack/fbi_01.mdl",
			"models/fbi_pack/fbi_02.mdl",
			"models/fbi_pack/fbi_03.mdl",
			"models/fbi_pack/fbi_04.mdl",
			"models/fbi_pack/fbi_05.mdl",
			"models/fbi_pack/fbi_06.mdl",
			"models/fbi_pack/fbi_07.mdl",
			"models/fbi_pack/fbi_08.mdl",
			"models/fbi_pack/fbi_09.mdl",		
		},
		Salary = 50,
		WhiteList = true,
		Level = {
			[1] = {
				Name = "현장 요원",
				Default = true,
				Weapons = {
					"vc_spikestrip_wep",
					"gtav_carbine_rifle",
					"gtav_stungun",
				},
			},
			[2] = {
				Name = "특수 부대",
				Default = true,
				Weapons = {
					"vc_spikestrip_wep",
					"gtav_carbine_rifle",
					"gtav_stungun",
				},
			},
			[3] = {
				Name = "현장 감독관",
				Weapons = {
					"vc_spikestrip_wep",
					"gtav_carbine_rifle",
					"gtav_stungun",
				},
			},
			[4] = {
				Name = "부 국장",
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
			[5] = {
				Name = "국장",
				Weapons = {
					"vc_spikestrip_wep",
					"pistol_mk2",
					"gtav_stungun",
				},
			},
		},
	},
	
	[7] = {
		Name = "마피아",
		Desc = "",
		Model = {
			"models/fearless/mafia02.mdl",
			"models/fearless/mafia04.mdl",
			"models/fearless/mafia06.mdl",
			"models/fearless/mafia07.mdl",
			"models/fearless/mafia09.mdl",
		},
		Salary = 30,
		WhiteList = true,
		Level = {
			[1] = {
				Name = "준 조직원",
				Default = true,
				Weapons = {

				},
			},
			[2] = {
				Name = "정식 조직원",
				Default = true,
				Weapons = {

				},
			},
			[3] = {
				Name = "부 행동 대장",
				Weapons = {

				},
			},
			[4] = {
				Name = "행동 대장",
				Weapons = {

				},
			},
			[5] = {
				Name = "리더",
				Weapons = {

				},
			},
		},
	},
	
	[8] = {
		Name = "종로파",
		Desc = "",
		Model = {
			"models/gang_ballas/gang_ballas_1.mdl",
			"models/gang_ballas/gang_ballas_2.mdl",		
		},
		Salary = 20,
		WhiteList = true,
		Level = {
			[1] = {
				Name = "이방인",
				Default = true,
				Weapons = {

				},
			},
			[2] = {
				Name = "조직원",
				Default = true,
				Weapons = {

				},
			},
			[3] = {
				Name = "부 행동 대장",
				Weapons = {

				},
			},
			[4] = {
				Name = "행동 대장",
				Weapons = {

				},
			},
			[5] = {
				Name = "리더",
				Weapons = {

				},
			},
		},
	},
	
	[9] = {
		Name = "세금 관리원",
		Desc = "",
		Salary = 40,
		WhiteList = true,
		Model = {
			"models/player/gman.mdl",	
		},		
	},
	
	[10] = {
		Name = "시장",
		Desc = "",
		Salary = 60,
		WhiteList = true,
		Model = {
			"models/player/gman.mdl",	
		},		
	},
	
	[11] = {
		Name = "소방관",
		Desc = "",
		Salary = 40,
		WhiteList = true,
		Weapons = {
			"weapon_extinguisher",
		},
		Model = {
			"models/player/gman.mdl",	
		},		
	},
	
	[12] = {
		Name = "피자집 알바",
		Desc = "",
		Salary = 15,
		Max = 2,
		GiveWeapon = true,
		Model = {
			"models/player/kleiner.mdl",
		},		
	},
	
	[13] = {
		Name = "수리공",
		Desc = "",
		Salary = 15,
		Max = 2,
		GiveWeapon = true,
		Weapons = {
			"cityworker_pliers",
			"cityworker_shovel",
			"cityworker_wrench",
		},
		Model = {
			"models/player/kleiner.mdl",
		},		
	},
}