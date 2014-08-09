
import System.IO
import Control.Monad




cdata :: String -> String
cdata content =
	"<![CDATA[" ++ content ++ "]]>"

tag :: String -> String -> String
tag name content =
	"<" ++ name ++ ">" ++ content ++ "</" ++ name ++ ">\n"






description = tag "description"
content     = tag "content"
tabTrigger  = tag "tabTrigger"
snippet     = tag "snippet"




-- build up XML with the above functions,
-- given a language and shebang line.

makeSnippet :: String -> String -> String
makeSnippet lang command =
	snippet body
		where body =
			(description ("Shebang: " ++ lang)) ++
			(content (cdata command))  ++
			(tabTrigger "#!")

bang :: String -> String
bang path =
	"#! " ++ path ++ " ${1}"

unspread2 :: (a -> a -> c) -> ([a] -> c)
unspread2 f xs = f (xs !! 0) (xs !! 1)




snippetData = [
	["Ruby",    (bang "/usr/bin/env Ruby")],
	["Rscript", (bang "/usr/bin/env Rscript")],
	["Node",    (bang "/usr/bin/env node")] ]

filenames   = map fn snippetData
	where fn x = (x !! 0) ++ ".sublime-snippet"

snippets    = map (unspread2 makeSnippet) snippetData






main = do
	zipWithM_ writeFile filenames snippets
