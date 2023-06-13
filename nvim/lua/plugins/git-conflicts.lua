-- >  A plugin to visualise and resolve merge conflicts in neovim
-- Bindings (default):
-- > This plugin offers default buffer local mappings inside conflicted files. This is primarily because applying these mappings only to relevant buffers is impossible through global mappings. A user can however disable these by setting default_mappings = false anyway and create global mappings as shown below. The default mappings are:
-- > - co — choose ours
-- > - ct — choose theirs
-- > - cb — choose both
-- > - c0 — choose none
-- > - ]x — move to previous conflict
-- > - [x — move to next conflict
return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
}
