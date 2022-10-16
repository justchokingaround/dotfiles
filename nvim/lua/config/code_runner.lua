local M = {}

function M.setup()
	require('code_runner').setup({
	mode = "toggleterm",
  filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		rust = "cd $dir && cargo run",
		sh = "cd $dir && dash $fileName",
		c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
		go = "cd $dir && go run $fileName",
	},
})
end

return M
