
UnityLayer =
{
    Default         = 0,
    TransparentFX   = 1,
    IgnoreRaycast   = 2,
    Water           = 4,
    UI              = 5,
    Blur            = 8,
    Player          = 9,
    NPC             = 10,
    Monster         = 11,

}

function UnityLayer.MakeMask(...)
	local mask = 0
	local layers = {...}
	for i,v in ipairs(layers) do
		mask = mask + 2^v
	end
	return mask
end