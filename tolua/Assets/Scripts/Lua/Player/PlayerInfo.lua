require("Class")

PlayerInfo = Class()

function PlayerInfo:ctor(profession)

    self.guid = 0

	self.profession = profession

	self.baseSpeed = 5 --//基础移速

	self.baseAttack = 1 --基础攻速

	self.attackSpeedAddition = 0.5f -- 攻速加成

	self.moveSpeedAddition = 0.0f --移速加成

end