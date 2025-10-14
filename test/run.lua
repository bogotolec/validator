--!strict

local ServerScriptService = game:GetService("ServerScriptService")

local TestEZ = require(ServerScriptService.DevPackages.TestEZ)

local results = TestEZ.TestBootstrap:run({ ServerScriptService })

if results.failureCount > 0 then
	error(`{results.failureCount} tests failed`)
end
