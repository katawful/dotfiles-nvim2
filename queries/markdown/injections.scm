; extends

 (fenced_code_block
   (info_string
     (language) @injection.language)
   (code_fence_content)
     @injection.content)

((inline) @injection.content
  (#set! injection.language "markdown_inline")
  (#set! injection.include-children))


(
    [
     (inline)
    ] @injection.content
    (#match? @injection.content "\\{[^}]*}}")
    (#set! injection.language "gotmpl")
)

