# InkLocalizer.jl

Localizer for Inkle ink script 

# Example
Istallation 
``` julia 
using Pkg 
Pkg.add("https://github.com/yongheekim-dev/InkLocalizer.jl")
```
run
``` julia
using InkLocalizer
data = joinpath(@__DIR__, "data/TheIntercept.json")

a, b = InkLocalizer.localize(data)

output = joinpath(@__DIR__, "data/TheIntercept_localized.json")
localkeys = joinpath(@__DIR__, "data/TheIntercept_localkeys.json")
write(output, JSON.json(a))
write(localkeys, JSON.json(b, 2))

```

# Output
It will produce 
``` json 
{
  "$TheIntercept.json.b.1": "IN DEBUG MODE!",
  "$TheIntercept.json.b.2": "Beginning...",
  "$TheIntercept.json.b.3": "Framing Hooper...",
  "$TheIntercept.json.b.4": "In with Hooper...",
  "$TheIntercept.json.start.5": "They are keeping me waiting.",
  ......
}

all the values within original json is replaced with `$TheIntercept.json ...`

```