require("Class")
require("Configures")

PlayerInfo = Class()

function PlayerInfo:ctor(profession)

    self.guid = 0

	self.profession = profession

	self.position = Vector3.zero

	self.direction = Vector3.zero

	self.baseSpeed = 5 --//基础移速

	self.baseAttack = 1 --基础攻速

	self.attackSpeedAddition = 0.5 		-- 攻速加成

	self.attackTimeInterval	= 1.250 	--普攻时间间隔 实际= attackTimeInterval * （1 - attackSpeedAddition）

	self.moveSpeedAddition = 0.0 --移速加成

	self.character = "Ahri"  --角色

	self.skin = "Ahri"		 --皮肤

	self.configure = Role_Configure_Ahri --配置文件

	self.weapon = "Ahri" --武器

	self.weaponBone = "weapon/BUFFBONE_GLB_WEAPON_1" --武器绑定的骨骼

	self.height = 1.6	--高
	self.radius = 0.4	--半径

end