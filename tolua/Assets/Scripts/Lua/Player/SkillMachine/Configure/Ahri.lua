
--包含所有插件
require("Plugins")

----
----技能配置 阿狸
----

Role_Configure_Ahri = {

    name = "Ahri",
    
    StateList = {
        ---------------------------待机开始--------------------------------
        {
            name = "待机",
            enum = "Idle",
            skillTime = 2147483647,
            changeable = true,
            weight = 0,
            ChangeList = {
                {enum = "Run",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Attack_1",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Attack_2",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Attack_3",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_2",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_3",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_4",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
            },

            CancelList = {
               -- {enum = "Idle", before = 0.5, fadeLength = 0.2 },
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_idle1",loop = true },
            }
        },
        ---------------------------待机结束--------------------------------
        ---------------------------移动开始--------------------------------
        {
            name = "移动",
            enum = "Run",
            skillTime = 2147483647,
            changeable = true,
            weight = 3,
            ChangeList = {
                {enum = "Idle",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Attack_1",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Attack_2",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Attack_3",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_2",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_3",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                {enum = "Skill_4",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
            },

            CancelList = {

            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_run",loop = true },
                { name = "PlayerSkillMovePlugin", class = PlayerSkillMovePlugin,  beginAt= 0,  endAt = 2147483647 },
                { name = "PlayerSkillMoveSpeedPlugin", class = PlayerSkillMoveSpeedPlugin },
            }
        },
        ---------------------------移动结束--------------------------------     
        ---------------------------死亡开始--------------------------------
        {
            name = "死亡",
            enum = "Dead",
            skillTime = 7.5,
            changeable = true,
            weight = 4,
            ChangeList = {

                {enum = "Idle",endAt=0, beginAt= 0, speed = 1, fadeLength = 0.2 },
                
            },

            CancelList = {

            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_death",loop = false },
              
            }
        },
        ---------------------------死亡结束--------------------------------   
        ---------------------------普攻一段开始--------------------------------
        {
            name = "普攻一段",
            enum = "Attack_1",
            skillTime = 1.250,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 1.250, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=0.26, beginAt= 0, speed = 2, fadeLength = 0.2 },                
                {enum = "Attack_2",endAt=0.26, beginAt= 0.8, speed = 5, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=0.26, beginAt= 0.8, speed = 2, fadeLength = 0.2 },
                {enum = "Skill_2",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_3",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_4",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_Attack1",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin }, 
                { name = "PlayerSkillRotationPlugin", class = PlayerSkillRotationPlugin, duration = 0.2, immediately = false }, 
                { name = "PlayerSkillEffectPlugin", class = PlayerSkillEffectPlugin, beginAt = 0.25,
                    EffectPluginList = {
                        {name = "Ahri_PlayerEffectFollowPlugin", class = Ahri_PlayerEffectFollowPlugin, speed = 13, distance = 6  },
                    },
                },                  
            }
        },
        ---------------------------普攻一段结束--------------------------------     
        ---------------------------普攻二段开始--------------------------------
        {
            name = "普攻二段",
            enum = "Attack_2",
            skillTime = 1.250,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 1.250, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=0.26, beginAt= 0, speed = 2, fadeLength = 0.2 },                
                {enum = "Attack_3",endAt= 0.26, beginAt= 0.8, speed = 5, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=0.26, beginAt= 0.8, speed = 5, fadeLength = 0.2 },
                {enum = "Skill_2",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_3",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_4",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_Attack2",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin },
                { name = "PlayerSkillRotationPlugin", class = PlayerSkillRotationPlugin, duration = 0.2, immediately = false },                 
                { name = "PlayerSkillEffectPlugin", class = PlayerSkillEffectPlugin, beginAt = 0.25,
                    EffectPluginList = {
                        {name = "Ahri_PlayerEffectFollowPlugin", class = Ahri_PlayerEffectFollowPlugin, speed = 13, distance = 6  },
                    },
                },        
            }
        },
        ---------------------------普攻二段结束--------------------------------  
        ---------------------------普攻三段开始--------------------------------
        {
            name = "普攻三段",
            enum = "Attack_3",
            skillTime = 1.250,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 1.250, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=0.26, beginAt= 0, speed = 2, fadeLength = 0.2 },                
                {enum = "Skill_1",endAt=0.26, beginAt= 0.8, speed = 5, fadeLength = 0.2 },
                {enum = "Skill_2",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_3",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_4",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_Attack1",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin },
                { name = "PlayerSkillRotationPlugin", class = PlayerSkillRotationPlugin, duration = 0.2, immediately = false },                 
                { name = "PlayerSkillEffectPlugin", class = PlayerSkillEffectPlugin, beginAt = 0.25,
                    EffectPluginList = {
                        {name = "Ahri_PlayerEffectFollowPlugin", class = Ahri_PlayerEffectFollowPlugin, speed = 13, distance = 6 },
                    },
                },        
            }
        },
        ---------------------------普攻三段结束--------------------------------  
        ---------------------------技能一开始--------------------------------
        {
            name = "技能一",
            enum = "Skill_1",
            skillTime = 1.250,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 1.250, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=0.26, beginAt= 0, speed = 2, fadeLength = 0.2 },                
                {enum = "Attack_1",endAt= 0.3, beginAt= 0.6, speed = 5, fadeLength = 0.2 },
                {enum = "Attack_2",endAt= 0.3, beginAt= 0.6, speed = 5, fadeLength = 0.2 },
                {enum = "Attack_3",endAt= 0.3, beginAt= 0.6, speed = 5, fadeLength = 0.2 },
                {enum = "Skill_2",endAt=0.25, beginAt= 0, speed = 3, fadeLength = 0.2 },
                {enum = "Skill_3",endAt=0.25, beginAt= 0, speed = 3, fadeLength = 0.2 },
                {enum = "Skill_4",endAt=0.25, beginAt= 0, speed = 3, fadeLength = 0.2 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_spell1",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin },    
                { name = "PlayerSkillRotationPlugin", class = PlayerSkillRotationPlugin, duration = 0.2, immediately = false },                          
                { name = "PlayerSkillEffectPlugin", class = PlayerSkillEffectPlugin, beginAt = 0.2, 
                    EffectPluginList = {
                        {name = "Ahri_PlayerEffectMoveAndBackPlugin", class = Ahri_PlayerEffectMoveAndBackPlugin, speed = 12, distance = 6 },

                    },
                },             
            }
        },
        ---------------------------技能一结束--------------------------------  
        ---------------------------技能二开始--------------------------------
        {
            name = "技能二",
            enum = "Skill_2",
            skillTime = 1.250,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 1.250, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=1.250, beginAt= 0, speed = 1, fadeLength = 0.2 },                
                {enum = "Attack_1",endAt= 1, beginAt= 0.6, speed = 1.8, fadeLength = 0.2 },
                {enum = "Attack_2",endAt= 1, beginAt= 0.6, speed = 1.8, fadeLength = 0.2 },
                {enum = "Attack_3",endAt= 1, beginAt= 0.6, speed = 1.8, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_3",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_4",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_spell2",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin }, 
            }
        },
        ---------------------------技能二结束-------------------------------- 
        ---------------------------技能三开始--------------------------------
        {
            name = "技能三",
            enum = "Skill_3",
            skillTime = 1.250,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 1.250, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=0.21, beginAt= 0, speed = 2, fadeLength = 0.2 },                
                {enum = "Attack_1",endAt= 0.21, beginAt= 0.6, speed = 3, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=0.21, beginAt= 0.6, speed = 10, fadeLength = 0.1 },
                {enum = "Skill_2",endAt=0.25, beginAt= 0, speed = 3, fadeLength = 0.2 },
                {enum = "Skill_4",endAt=1, beginAt= 0, speed = 1, fadeLength = 0 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_spell3",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin },     
                { name = "PlayerSkillRotationPlugin", class = PlayerSkillRotationPlugin, duration = 0.2, immediately = false },                         
                { name = "PlayerSkillEffectPlugin", class = PlayerSkillEffectPlugin, beginAt = 0.2,
                    EffectPluginList = {
                        {name = "Ahri_PlayerEffectMovePlugin", class = Ahri_PlayerEffectMovePlugin, speed = 12, distance = 6 },
                    },
                },  
            }
        },
        ---------------------------技能三结束--------------------------------   
        ---------------------------技能四开始--------------------------------
        {
            name = "技能四",
            enum = "Skill_4",
            skillTime = 0.975,
            changeable = true,
            weight = 1,
            ChangeList = {
                {enum = "Idle",endAt= 0.975, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Run",endAt=0.975, beginAt= 0, speed = 1, fadeLength = 0.2 },                
                {enum = "Attack_1",endAt= 0.975, beginAt= 0.6, speed = 1.8, fadeLength = 0.2 },
                {enum = "Skill_1",endAt=0.975, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_2",endAt=0.975, beginAt= 0, speed = 1, fadeLength = 0 },
                {enum = "Skill_3",endAt=0.975, beginAt= 0, speed = 1, fadeLength = 0 },
            },

            CancelList = {
                {enum ="Idle", before = 0.5, fadeLength = 0.1}
            },

            PluginList = {
                { name = "PlayerSkillAnimationPlugin", class = PlayerSkillAnimationPlugin,  animationClip ="Ahri_spell4",loop = false },
                { name = "PlayerSkillAttackSpeedPlugin", class = PlayerSkillAttackSpeedPlugin }, 
                { name = "PlayerSkillRotationPlugin", class = PlayerSkillRotationPlugin, duration = 0.2, immediately = true },                         
                { name = "PlayerSkillFlashMovePlugin", class = PlayerSkillFlashMovePlugin, distance = 6, duration = 0.5 }, 
                { name = "PlayerSkillRotateMousePositionPlugin", class = PlayerSkillRotateMousePositionPlugin }, 
                
            }
        },
        ---------------------------技能四结束--------------------------------
    },
}