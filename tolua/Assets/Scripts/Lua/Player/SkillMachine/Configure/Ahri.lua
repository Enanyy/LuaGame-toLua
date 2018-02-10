
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
                { name = "PlayerSkillMovePlugin", class = PlayerSkillMovePlugin,  beginAt= 0  endAt = 0 },
            }
        },
        ---------------------------移动结束--------------------------------        
    },

}