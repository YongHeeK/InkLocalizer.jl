using InkLocalizer
using Test
using JSON 


data = joinpath(@__DIR__, "data/TheIntercept.json")

a, b = InkLocalizer.localize(data)

output = joinpath(@__DIR__, "data/TheIntercept_localized.json")
localkeys = joinpath(@__DIR__, "data/TheIntercept_localkeys.json")
write(output, JSON.json(a))
write(localkeys, JSON.json(b, 2))
