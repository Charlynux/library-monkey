function addBookmark(urlAddress,pageName) {
    if (document.all) {
        window.external.AddFavorite(urlAddress,pageName);
    }
    else if (window.sidebar) {
        window.sidebar.addPanel(pageName, urlAddress, "");
    }
    else {
        alert("Vous pouvez ajouter cette page à vos favoris en cliquant simultanément sur les touches CTRL et D");
    }
}