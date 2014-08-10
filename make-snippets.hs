
import System.IO
import Control.Monad


-- generate XML tags.

cdata :: String -> String
cdata content =
	"<![CDATA[" ++ content ++ "]]>"

tag :: String -> String -> String
tag name content =
	"<" ++ name ++ ">" ++ content ++ "</" ++ name ++ ">\n"






-- build up XML with the above functions,
-- given a language and shebang line.

makeSnippet :: String -> String -> String
makeSnippet lang command =
	tag "snippet" body
		where body =
			(tag "description" ("Shebang: " ++ lang)) ++
			(tag "content" (cdata command))  ++
			(tag "tabTrigger" "#!")





bangEnv :: String -> String
bangEnv lang =
	"#! /usr/bin/env " ++ lang ++ " ${1}"



-- generate snippets for tags of the form /usr/bin/env lang/

envSnippets = [
	["Bash",         "sh"        ],
	["CoffeeScript", "coffee"    ],

	["Erlang",       "escript"   ],
	["Haskell",      "runhaskell"],

	["Lua" ,         "lua"       ],
	["Node",         "node"      ],

	["Perl",         "perl"      ],
	["Python",       "python"    ],
	["Python3",      "python3"   ],

	["Ruby",         "ruby"      ],
	["Rscript",      "Rscript"   ],
	["R",            "Rscript"   ],

	["Scala",        "scala"     ] ]






envLangs  = map (!! 0) envSnippets
envPaths  = map (bangEnv . (!! 1)) envSnippets

filenames = map (++ ".sublime-snippet") envLangs
snippets  = zipWith makeSnippet envLangs envPaths






main = do
	zipWithM_ writeFile filenames snippets
