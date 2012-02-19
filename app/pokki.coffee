# pokki magic
# attach click event to minimize button
minimize = document.getElementById('minimize')
minimize.addEventListener('click', pokki.closePopup)

pokki.addEventListener('popup_hiding', NB.Director.pause)

$('a.twitter').click( ->
    pokki.openURLInDefaultBrowser('https://twitter.com/#!/james_gary')
)
