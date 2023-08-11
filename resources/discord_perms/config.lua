Config = {
	DiscordToken = "NTg4MDcwNzQ1OTIyMzM4ODE4.XP_xjw.il_qEpsimlWyO-cJbzaaujTSass",
	GuildId = "732689260863291463",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["TestRole"] = "Some Role ID" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}
