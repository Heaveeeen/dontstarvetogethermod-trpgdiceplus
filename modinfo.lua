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
configuration_options =
{
	{
		name = "TRPG_RULE",
		label = "规则",
		hover = "采用哪种TRPG规则？",
		options = 
		{
			{description = "COC7", data = "COC7", hover = "采用克苏鲁的呼唤7版规则"},
			{description = "无", data = "NONE", hover = "仅包含基础掷骰功能"},
		},
		default = "COC7",
	},
	{
		name = "ROOM_ROLE",
		label = "COC房规",
		hover = "设置COC大成功和大失败的取值范围，也叫setcoc",
		options =
		{
			{description = "默认", data = 0, hover = "符合COC7规则书，出1大成功，不满50出96-100大失败，满50出100大失败"},
			{description = "5点", data = 1, hover = "出1-5大成功，出96-100大失败"},
		},
		default = 0,
	},
	{
		name = "ANNOUNCE_STYLE",
		label = "提示语风格",
		hover = "你希望骰子用哪种风格说话？",
		options =
		{
			{description = "默认", data = "DEFAULT", hover = "掷骰时角色会以不加任何修辞的、朴实无华的方式说话。"},
			{description = "角色", data = "CHARACTER", hover = "每个角色都拥有自己独特的说话风格。"},
		},
		default = "DEFAULT",
	},
	{
		name = "DISPLAY_COMMAND",
		label = "显示掷骰指令",
		hover = "你想看到玩家输入的“/ra 侦查”这些指令吗？",
		options =
		{
			{description = "是", data = true, hover = "掷骰的提示语会附带显示玩家输入的掷骰指令。"},
			{description = "否", data = false, hover = "如果嫌烦可以关掉。"},
		},
		default = true,
	},
	{
		name = "LANGUAGE",
		label = "语言",
		hover = "目前仅有简中……欢迎提供翻译，有意者请与作者联系！",
		options =
		{
			{description = "中文", data = "zh", hover = "中文（zh）"},
		},
		default = "zh",
	},
}
