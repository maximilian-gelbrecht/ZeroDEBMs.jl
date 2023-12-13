using ZeroDEBMs
using Documenter

DocMeta.setdocmeta!(ZeroDEBMs, :DocTestSetup, :(using ZeroDEBMs); recursive=true)

makedocs(;
    modules=[ZeroDEBMs],
    authors="Maximilian Gelbrecht <maximilian.gelbrecht@posteo.de> and contributors",
    repo="https://github.com/maximilian-gelbrecht/ZeroDEBMs.jl/blob/{commit}{path}#{line}",
    sitename="ZeroDEBMs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://maximilian-gelbrecht.github.io/ZeroDEBMs.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/maximilian-gelbrecht/ZeroDEBMs.jl",
    devbranch="main",
)
