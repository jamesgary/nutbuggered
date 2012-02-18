# pokki magic
# attach click event to minimize button
minimize = document.getElementById('minimize')
minimize.addEventListener('click', pokki.closePopup)

pokki.addEventListener('popup_hidden', NB.Director.pause);
