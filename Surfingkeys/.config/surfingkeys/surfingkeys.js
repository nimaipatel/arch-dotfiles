// located at 🏠: https://raw.githubusercontent.com/nimaipatel/dotfiles/master/.config/surfingkeys/surfingkeys.js

const {
    aceVimMap,
    mapkey,
    unmap,
    imap,
    imapkey,
    getClickableElements,
    vmapkey,
    map,
    cmap,
    addSearchAlias,
    removeSearchAlias,
    tabOpenLink,
    readText,
    Clipboard,
    Front,
    Hints,
    Visual,
    RUNTIME
} = api

map('J', 'E')
map('K', 'R')

mapkey('T', 'Choose a tab with omnibar', function() {
    Front.openOmnibar({type: "Tabs"});
})

settings.smoothScroll = false

settings.defaultSearchEngine = 'd'

settings.blacklistPattern = /.*mail.google.com.*|.*inbox.google.com.*|.*teams.microsoft.com.*/i;

// set theme
settings.theme = `
.sk_theme {
    font-family: Liberation Mono, monospace;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 10pt;
}`;
