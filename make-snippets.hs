
import System.IO




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






languages = [
	makeSnippet "Ruby"    (bang "/usr/bin/ruby Ruby"),
	makeSnippet "Rscript" (bang "/usr/bin/env Rscript")]





main = putStrLn (languages !! 0)
