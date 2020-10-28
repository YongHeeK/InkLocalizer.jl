module InkLocalizer

using JSON
using JSONPointer
using OrderedCollections  

# Any human readable words
const REG_WORD = r"[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]"

function parse_ink(file)
    s = read(file, String) 
    # Remove BOM(Byte Order Mars)
    JSON.parse(chop(s, head=1, tail=0); dicttype = OrderedDict)
end

function localize!(file)
    function _localize!(arr::AbstractArray, token)
        for (i, row) in enumerate(arr) 
            _localize!(row, vcat(token, i))
        end
    end
    function _localize!(dict::AbstractDict, token)
        for (k, v) in dict 
            _localize!(v, vcat(token, k))
        end
    end
    function _localize!(sentence::AbstractString, token)
        # All ink words starts with ^
        if startswith(sentence, "^")
            if occursin(REG_WORD, sentence)
                push!(lokalise_data, [token, sentence[2:end]])
            end
        end
    end
    function _localize!(x, key) 
        nothing
    end

    # localise
    lokalise_data = Any[]

    data = JSON.parse(file; dicttype = OrderedDict)
    _localize!(data["root"], [])

    # save it with localise key
    prefix = basename(file)

    for (i, row) in enumerate(lokalise_data)
        p = JSONPointer.Pointer("/root"* join(row[1], "/"))
        finalkey = ink_localkey(prefix, row[1], i)
        row[1] = finalkey

        # replace text with localize key
        data[p] = "^$finalkey"
    end

    return data, lokalise_data
end

function ink_localkey(prefix, tokens, suffix)
    tokens = filter(el -> isa(el, AbstractString), tokens)    
    tokens = filter(el -> occursin(REG_WORD, el), tokens)

    return join((prefix, join(tokens, "/"), suffix), ".")
end

end # module
