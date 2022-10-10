local M = {}

function M.setup()
	require('code_runner').setup({
	mode = "toggleterm",
  filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
		sh = "cd $dir && dash $fileName",
		c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
	},
})
end

return M
