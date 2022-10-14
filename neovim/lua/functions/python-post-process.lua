local M = {}

M.python_post_process = function()

	require('plenary.async').run(function()

		local Job = require('plenary.job')

		local current_file = vim.fn.expand('%')

		local on_stderr_fn = function(error, data)
			print('stderr output:')
			print(error)
			print(data)
		end

		local on_exit_fn = vim.schedule_wrap(function()
			vim.cmd('e %')
		end)

		local tidy_imports_job = Job:new({
			command = 'tidy-imports',
			args = {
				'--black',
				'--quiet',
				'--replace-star-imports',
				'--action', 'REPLACE',
				current_file
			},
			on_stderr = on_stderr_fn,
			on_exit = on_exit_fn
		})

		local flynt_job = Job:new({
			command = 'flynt',
			args = {
				'--aggressive',
				'--transform-concats',
				'--line-length',
				'120',
				current_file
			},
			on_stderr = on_stderr_fn,
			on_exit = on_exit_fn
		})

		local isort_job = Job:new({
			command = 'isort',
			args = { current_file },
			on_stderr = on_stderr_fn,
			on_exit = on_exit_fn
		})

		local pyquotes_job = Job:new({
			command = 'pyquotes',
			args = { current_file },
			on_stderr = on_stderr_fn,
			on_exit = vim.schedule_wrap(function()
				vim.cmd('e %')
			end)
		})

		tidy_imports_job:and_then(flynt_job)
		flynt_job:and_then(isort_job)
		isort_job:and_then(pyquotes_job)

		tidy_imports_job:start()
	end)
end

return M
