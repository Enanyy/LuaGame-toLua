require("Class")

PlayerInfo = Class()

function PlayerInfo:ctor(profession)

    self.guid = 0

	self.profession = profession

	self.position = Vector3.zero

	self.baseSpeed = 5 --//基础移速

	self.baseAttack = 1 --基础攻速

	self.attackSpeedAddition = 0.5 -- 攻速加成

	self.moveSpeedAddition = 0.0 --移速加成

	self.character = "Ahri"  --角色

	self.skin = "Ahri"		 --皮肤

end