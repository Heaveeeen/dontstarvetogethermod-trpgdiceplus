--骰娘语言包在此！
--尽量使用半角标点，因为饥荒的自动换行功能不会识别全角标点。

COC_DICE_LANG =
{

    _ =
    {
        BONUS_DICE = "奖励骰: ",
        PENALTY_DICE = "惩罚骰: ",

        TI_NAME = { "失忆","假性残疾","暴力倾向","偏执","人际依赖","昏厥","逃避","歇斯底里","恐惧","躁狂", },
        TI_DES =
        {
            "{CHAR_NAME}发现自己只记得最后身处的安全地点, 却没有任何来到这里的记忆",
            "{CHAR_NAME}陷入了心理性的失明, 失聪以及躯体缺失感中",
            "{CHAR_NAME}陷入了六亲不认的暴力行为中, 对周围的敌人与友方进行着无差别的攻击",
            "{CHAR_NAME}陷入了严重的偏执妄想之中",
            "{CHAR_NAME}因为一些原因而将他人误认为了{CHAR_NAME}重要的人并且努力的会与那个人保持那种关系",
            "{CHAR_NAME}当场昏倒",
            "{CHAR_NAME}会用任何的手段试图逃离现在所处的位置",
            "{CHAR_NAME}表现出大笑, 哭泣, 嘶吼, 害怕等的极端情绪表现",
            "投1D100或者由守秘人选择, 来从恐惧症状表中选择一个恐惧源, 就算这一恐惧的事物是并不存在的",
            "投1D100或者由守秘人选择, 来从躁狂症状表中选择一个躁狂的诱因",
        },
        LI_NAME = { "失忆","被窃","遍体鳞伤","暴力倾向","极端信念","重要之人","被收容","逃避","恐惧","躁狂", },
        LI_DES =
        {
            "{CHAR_NAME}发现自己身处一个陌生的地方, 并忘记了自己是谁。记忆会随时间恢复",
            "{CHAR_NAME}发觉自己被盗, 身体毫发无损。如果{CHAR_NAME}携带着宝贵之物, {CHAR_NAME}应当做幸运检定来决定其是否被盗。所有有价值的东西无需检定自动消失",
            "{CHAR_NAME}恢复清醒后发现自己身上满是拳痕和瘀伤。生命值减少到疯狂前的一半, 但没有造成重伤",
            "{CHAR_NAME}陷入强烈的暴力与破坏欲之中。{CHAR_NAME}回过神来可能会理解自己做了什么也可能毫无印象",
            "{CHAR_NAME}采取了极端和疯狂的表现手段展示{CHAR_NAME}的思想信念之一",
            "{CHAR_NAME}不顾一切地尝试了接近重要之人, 并为{CHAR_NAME}和此人的关系做出行动",
            "{CHAR_NAME}在精神病院病房或警察局牢房中回过神来, {CHAR_NAME}可能会慢慢回想起导致自己被关在这里的事情",
            "{CHAR_NAME}发现自己在很远的地方, 也许迷失在荒郊野岭, 或是在驶向远方的列车或长途汽车上",
            "{CHAR_NAME}患上一个新的恐惧症。在恐惧症状表上骰1D100来决定症状, 或由守秘人选择一个",
            "{CHAR_NAME}患上一个新的躁狂症。在躁狂症状表上骰1D100来决定症状, 或由守秘人选择一个",
        },
    },



    DEFAULT =
    {
        --花括号 ( 例如{EXP} ) 是占位符, 我在注释中举了一些例子来解释这些花括号的含义
        R = "进行基础掷骰: {EXP}。",  --进行基础掷骰: 1D6+1D4=7。
        NR = "为{R_NAME}进行基础掷骰: {EXP}。",  --为伤害进行基础掷骰: 1D6+1D4=7。

        RH = "进行暗骰: {EXP}。",  --进行暗骰: 1D100。
        NRH = "为{R_NAME}进行暗骰: {EXP}。",  --为心理学进行暗骰: 1D100。

        RHR = "暗骰结果: {EXP}。",  --暗骰结果: 1D100=45。
        NRHR = "暗骰{R_NAME}的结果: {EXP}。",  --暗骰心理学的结果: 1D100=81

        ST = "已为此玩家设置{ST_AMOUNT}条属性。",  --已为此玩家设置28条属性。
        ST_SHOW = "此玩家的{ST_NAME}属性为{ST_VALUE}。",  --此玩家的理智为67。
        ST_CLEAR = "已初始化所有属性。",

        --进行侦查检定: 1D100=34/60, 成功。
        --进行斗殴检定: 1D100=79[奖励骰: 0]=9/50, 极难成功。
        RA = "进行检定: {EXP}, {RA_RES}",
        NRA = "进行{RA_NAME}检定: {EXP}, {RA_RES}",
        RA_RES = 
        {
            "大失败。",
            "失败。",
            "成功。",
            "困难成功。",
            "极难成功。",
            "大成功。",
        },

        SC = "进行理智检定 ( {SC_VALUE} ) : {EXP}, ",  --进行理智检定 ( 1/1D6 ) : 1D100=82/60, 失败, 扣除1D6=3点SAN。
        SC_SUCCESS = "成功, 扣除{EXP_2}点SAN。",
        SC_FAIL = "失败, 扣除{EXP_2}点SAN。",

        INS_CHAR_NAME = "调查员",
        --疯狂发作-即时症状: 1D10=3, 暴力, 调查员陷入了六亲不认的暴力行为中, 对周围的敌人与友方进行着无差别的攻击。持续1D10=8小时。
        TI = "疯狂发作-即时症状: {EXP}, {INS_NAME}, {INS_DES}。持续{EXP_2}小时。",
        --疯狂发作-总结症状: 1D10=5, 极端信念, 调查员采取了极端和疯狂的表现手段展示调查员的思想信念之一。持续了1D10=3小时。
        LI = "疯狂发作-总结症状: {EXP}, {INS_NAME}, {INS_DES}。持续{EXP_2}小时。",
    },



    --[[向文本传入的参数: 

        {R_NAME}		基础掷骰和暗骰指令的名称

        {EXP},{EXP_2}
            骰子的表达式及结果, 例如1D100=29、1D8+1D4=6等。暗骰不会给出结果
            若掷骰是一次检定, 则会附带一个斜杠和属性值显示为分数形式, 例如: 1D100=17/50
            若有奖励骰或惩罚骰, 则会像这样: 1D100=57 [奖励骰: 2,8] =27/40, 引用_.BONUS_DICE
            {EXP_2}代表另一个掷骰的表达式和结果, 用于需要一次性进行两次掷骰的指令 ( 如sc和ti ) 

        {ST_AMOUNT}		使用/st指令时设定属性的数量
        {ST_NAME}		属性 ( 或技能 ) 名称
        {ST_VALUE}		属性 ( 或技能 ) 的数值

        {RA_NAME}		检定名称, 通常是属性或技能的名称
        {RA_RES}		检定结果, 即检定的成功等级

        {SC_VALUE}		理智检定时应当扣除的理智, 例如: 1/1D6；1D3/1D20

        {INS_NAME}		疯狂发作症状的名称
        {INS_DES}		疯狂发作症状的描述

        向参数中传递的参数: 

        {CHAR_NAME}		{INS_DES}中角色的自称, 对应XXX.INS_CHAR_NAME
    --]]



    --[[角色名称: 

        WILSON 		威尔逊
        WILLOW		薇洛
        WOLFGANG		大力士
        WENDY		温蒂
        WX78		机器人
        WICKERBOTTOM		老奶奶
        WOODIE		伍迪
        WES		韦斯
        WAXWELL		老麦
        WIGFRID		女武神
        WEBBER		韦伯
        WINONA		女工
        WARLY		沃利
        WALTER		沃尔特
        WORTOX		恶魔
        WORMWOOD		植物人
        WURT		鱼妹
        WANDA		旺达
    --]]



    WILSON =
    {
        R = "为了科学, 我来掷骰子: {EXP}。",
        NR = "为了与{R_NAME}相关的科学, 我来掷骰子: {EXP}。",

        RH = "我进行了一次秘密实验: {EXP}。",
        NRH = "我为{R_NAME}进行了一次秘密实验: {EXP}。",

        RHR = "我为秘密实验写了份实验报告: {EXP}",
        NRHR = "我为这场隐秘的{R_NAME}实验写了份报告: {EXP}",

        ST = "这{ST_AMOUNT}个数据对我的实验是必不可少的, 我把它们记了下来。",
        ST_SHOW = "根据我的实验, 我的{ST_NAME}是{ST_VALUE}。",
        ST_CLEAR = "我的研究成果全部消失了！",

        RA = "我要研究一下这件事: {EXP}, {RA_RES}",
        NRA = "我认为{RA_NAME}很值得研究: {EXP}, {RA_RES}",
        RA_RES =
        {
            "大失败——哦不, 我的实验引发了爆炸！",
            "失败了——通往真理的道路总是曲折的。",
            "成功, 对一名绅士科学家来说不是什么难事。",
            "困难成功, 我离真理又近了一步！",
            "极难成功, 能获得这种成就, 我真是个天才！",
            "大成功！我要用我的思想征服这个世界！",
        },

        SC = "我还保持着科学的头脑吗 ( {SC_VALUE} ) ？{EXP}, ",
        SC_SUCCESS = "成功——我很清醒, 只扣除了{EXP_2}点SAN。",
        SC_FAIL = "失败——这还算科学吗？我损失了{EXP_2}点SAN！",

        INS_CHAR_NAME = "我",
        TI = "我疯了: 我开始{EXP}, {INS_NAME}了。在接下来的{EXP_2}小时内, {INS_DES}。",
        LI = "我怎么了？我好像在刚才的{EXP_2}小时内一直受困于{EXP}, {INS_NAME}的症状, 现在{INS_DES}。",
    },



    WILLOW =
    {
        R = "{EXP}, 哼, 掷骰子真无聊。",
        NR = "懒鬼, 你为什么要让我帮你{R_NAME}？{EXP}, 满意了吧！",

        RH = "我悄悄地点起一把火: {EXP}。",
        NRH = "为了{R_NAME}, 我悄悄地点起一把火: {EXP}。",

        RHR = "嘿！嘿！这场大火神不知鬼不觉地烧掉了{EXP}座房子！",
        NRHR = "别告诉别人, 我用{R_NAME}烧掉了{EXP}座房子！",

        ST = "这{ST_AMOUNT}个数字是什么？好吧, 我把它们记下来。",
        ST_SHOW = "我的{ST_NAME}差不多有{ST_VALUE}那么多。",
        ST_CLEAR = "我把所有东西都烧光了！",

        RA = "我要点把火试试: {EXP}, {RA_RES}",
        NRA = "我要试试点燃{RA_NAME}: {EXP}, {RA_RES}",
        RA_RES =
        {
            "大失败, 好冷！像冰火在燃烧！",
            "失败了, 我真想烧掉这颗愚蠢的骰子！",
            "成功, 呼！太棒了！",
            "困难成功！接招, 你们这些该死的家伙！",
            "极难成功！我要烧点东西庆祝一下！",
            "大成功！所有的一切终将沐浴在最美的火焰中。",
        },

        SC = "我的眼眶好像在燃烧 ( {SC_VALUE} ) , {EXP}！",
        SC_SUCCESS = "还好只是错觉, 扣除了{EXP_2}点SAN, 这些衣服都要烧掉！",
        SC_FAIL = "失败！帮帮我, 伯尼！那个影子袭击了我, 我损失了{EXP_2}点SAN！",

        INS_CHAR_NAME = "我",
        TI = "烧吧！我开始{EXP}, {INS_NAME}了, 接下来{EXP_2}个小时之内, {INS_DES}。",
        LI = "我怎么了？我浪费{EXP_2}个小时{EXP}, {INS_NAME}了, 现在{INS_DES}。你在哪, 伯尼？",
    },



    WOLFGANG =
    {
        R = "沃尔夫冈掷出小骰子: {EXP}！",
        NR = "沃尔夫冈为了{R_NAME}掷出小骰子: {EXP}。",

        RH = "沃尔夫冈悄悄掷出小骰子: {EXP}。",
        NRH = "沃尔夫冈会为了替{R_NAME}保守秘密而悄悄地掷出小骰子: {EXP}。",

        RHR = "小骰子告诉沃尔夫冈“{EXP}”。",
        NRHR = "小骰子告诉沃尔夫冈“{R_NAME}: {EXP}”",

        ST = "沃尔夫冈会记住这{ST_AMOUNT}个数字！",
        ST_SHOW = "沃尔夫冈有{ST_VALUE}那么多的{ST_NAME}。",
        ST_CLEAR = "沃尔夫冈把所有数字都忘光了！",

        RA = "沃尔夫冈努力锻炼肌肉: {EXP}, {RA_RES}",
        NRA = "沃尔夫冈用{RA_NAME}来锻炼肌肉: {EXP}, {RA_RES}",
        RA_RES =
        {
            "大失败。哦不, 沃尔夫冈搞砸了这场演出！",
            "失败, 沃尔夫冈的肌肉还不够强大。",
            "成功, 嗯, 肌肉感觉好多了, 但还可以更强壮些。",
            "困难成功, 沃尔夫冈的状态又回来了！",
            "极难成功, 沃尔夫冈强壮得能举起一节车厢！",
            "大成功, 我是最强壮的！没有人比我更强壮！",
        },

        SC = "沃尔夫冈神志不清了 ( {SC_VALUE} ) : {EXP}！",
        SC_SUCCESS = "成功——沃尔夫冈感觉好些了, 但还是失去了{EXP_2}点SAN。",
        SC_FAIL = "失败！我害怕！我扣除了{EXP_2}点SAN！",

        INS_CHAR_NAME = "沃尔夫冈",
        TI = "沃尔夫冈好害怕: {EXP}, 沃尔夫冈出现了{INS_NAME}, {INS_DES}, 沃尔夫冈会在{EXP_2}小时后恢复正常！",
        LI = "沃尔夫冈都干了什么？{EXP}, 沃尔夫冈{INS_NAME}！{INS_DES}, 已经过了{EXP_2}小时了？",
    },



    WENDY =
    {
        R = "来投骰子吧, 阿比盖尔！{EXP}。",
        NR = "我不擅长{R_NAME}, 让阿比盖尔来试试？{EXP}。",

        RH = "其他人永远看不到{EXP}的结果, 就像我的人生。",
        NRH = "只有阿比盖尔关心{EXP}的结果, 就像关心我的{R_NAME}一样。",

        RHR = "除了我, 没人在乎{EXP}。",
        NRHR = "阿比盖尔以前很擅长{R_NAME}, 就像{EXP}。",

        ST = "阿比盖尔, 帮我记一下这{ST_AMOUNT}个数字。",
        ST_SHOW = "我的{ST_NAME}有{ST_VALUE}——大人们总是喜欢数字。",
        ST_CLEAR = "我失去了我所拥有的一切。",

        RA = "生存还是毁灭, 这是个问题。{EXP}, {RA_RES}",
        NRA = "{RA_NAME}还是不{RA_NAME}, 这是个问题。{EXP}, {RA_RES}",
        RA_RES = 
        {
            "大失败, 不……不要再次丢下我！",
            "失败, 小心啊, 阿比盖尔！",
            "成功, 我能感觉到阿比盖尔的气息越来越强了。",
            "困难成功, 阿比盖尔就快到了！",
            "极难成功, 阿比盖尔准备好了, 但她需要一点空间。",
            "大成功, 阿比盖尔？回来！我还没和你玩够呢。",
        },

        SC = "我脚下的地面仿佛正在崩溃 ( {SC_VALUE} ) 。{EXP}, ",
        SC_SUCCESS = "成功。痛苦依旧, 但我早已麻木。只失去了{EXP}点SAN。",
        SC_FAIL = "失败。阿比盖尔, 你在哪？我失去了{EXP}点SAN……",

        INS_CHAR_NAME = "我",
        TI = "我的意识开始迷离: {EXP}, 我感到了{INS_NAME}。{INS_DES}。阿比盖尔, 请等我{EXP_2}小时。",
        LI = "我经历了最痛苦和恍惚的时间。{EXP}, 我经历了{INS_NAME}, {INS_DES}, 我无意义的人生又失去了{EXP_2}小时的时间。",
    },

}

local LangMetatable =
{
    __index = function(t, k)
        return t.DEFAULT
    end,
}

GLOBAL.setmetatable(COC_DICE_LANG, LangMetatable)


RULE_INFO = 
{
    COC7 =
    {
        _ = "- 规则: COC7 / 克苏鲁的呼唤第7版\n- 房规: {COC_SUB_RULE}\n- 语言: 中文",
        COC_SUB_RULE =
        {
            "0 ( 符合COC7规则书, 出1大成功, 不满50出96-100大失败, 满50出100大失败 )",
            "1",
            "2",
            "3 ( 出1-5大成功, 出96-100大失败 )",
            "4",
            "5",
        },
    },

    NONE =
    {
        _ = "- 规则: 无（仅包含基础掷骰和暗骰功能）\n- 语言: 中文"
    }
}
