function Link(el)
  if el.target:match("%.md([#?].*)?$") then
    el.target = el.target:gsub("%.md([#?].*)?$", ".html%1")
  end
  return el
end
