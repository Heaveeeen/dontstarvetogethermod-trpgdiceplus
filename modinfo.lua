name = "TRPG掷骰增强"
description = "加入多种掷骰指令以辅助在饥荒里玩跑团（TRPG）\n目前仅支持COC7一种规则"
author = "苍穹"
version = "1.0"

forumthread = ""
api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false

all_clients_require_mod = true

server_filter_tags = {
	"跑团",
	"TRPG",
}

--[[  取消注释，在这行前面加个-就行。可选的mod设置，在modmain里面用 GetModConfigData("test_name") 来获取值，data只能是boolean/string/number--]]
configuration_options = {
	{
		name = "trpg_rule",
		label = "规则",
		hover = "采用哪种TRPG规则？",
		options =
			{
				{description = "COC7", data = "coc7", hover = "采用克苏鲁的呼唤7版规则"},
				{description = "无", data = "none", hover = "仅包含基础掷骰功能"},
			},
		default = "coc7",
	},
	{
		name = "room_rule",
		label = "COC房规",
		hover = "相当于setcoc，设置COC大成功和大失败的取值范围",
		options =
			{
				{description = "默认", data = 0, hover = "符合COC7规则书，出1大成功，不满50出96-100大失败，满50出100大失败"},
				{description = "5点", data = 1, hover = "出1-5大成功，出96-100大失败"},
			},
		default = 0,
	},
	{
		name = "announce_style",
		label = "提示语风格",
		hover = "你希望骰子用哪种方式说话？",
		options =
			{
				{description = "默认", data = "default", hover = "骰子会以不加任何修辞的、朴实无华的方式说话"},
				{description = "威尔逊", data = "wilson", hover = "骰子会模仿威尔逊的语气，为了科学！"},
			},
		default = "default",
	},
}
