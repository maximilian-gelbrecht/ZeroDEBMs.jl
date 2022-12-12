using Exercise8
using Documenter

DocMeta.setdocmeta!(Exercise8, :DocTestSetup, :(using Exercise8); recursive=true)

makedocs(;
    modules=[Exercise8],
    authors="Maximilian Gelbrecht <maximilian.gelbrecht@posteo.de> and contributors",
    repo="https://github.com/maximilian-gelbrecht/Exercise8.jl/blob/{commit}{path}#{line}",
    sitename="Exercise8.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://maximilian-gelbrecht.github.io/Exercise8.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/maximilian-gelbrecht/Exercise8.jl",
    devbranch="main",
)
