decodeHtml = (html) ->
  txt = document.createElement("textarea")
  txt.innerHTML = html
  txt.value
