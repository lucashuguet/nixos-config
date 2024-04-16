import os
import yaml
from yaml.loader import SafeLoader

config.load_autoconfig()
# c.colors.webpage.darkmode.enabled = False

c.fonts.default_family = "FantasqueSansM Nerd Font"
c.fonts.default_size = "12pt"

duck = "https://duckduckgo.com"

c.url.default_page = duck
c.url.start_pages = [duck]
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/&q={}"
}

c.downloads.location.prompt = False
c.downloads.position = "bottom"
c.downloads.remove_finished = 200

c.editor.command = ["emacsclient", "-c", "'{}'"]

# c.content.cookies.accept = "no-3rdparty"
c.completion.web_history.max_items = 0
c.content.autoplay = False

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; rv:114.0) Gecko/20100101 Firefox/114.0"

config.unbind("ZZ")
config.unbind("ZQ")

config.bind("<y><o>", "yank inline [[{url}][{title}]]")
config.bind("x", "hint links spawn mpv '{hint-url}'")
config.bind("X", "hint links spawn playbox -p '{hint-url}'")
config.bind("z", "hint links spawn addstr.sh '{hint-url}'")
config.bind("Z", "spawn --userscript savebox")
config.bind("e", "spawn --userscript playanim")

config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")

with open(os.path.expanduser("~/.config/colors/qutebrowser.yml")) as f:
    colors = yaml.load(f, Loader=SafeLoader)

    c.colors.statusbar.normal.bg = colors["colors"]["primary"]["background"]
    c.colors.statusbar.command.bg = colors["colors"]["primary"]["background"]
    c.colors.statusbar.normal.fg = colors["colors"]["primary"]["foreground"]
    c.colors.statusbar.command.fg = colors["colors"]["primary"]["foreground"]
    
    c.colors.tabs.even.bg = colors["colors"]["primary"]["background"]
    c.colors.tabs.odd.bg = colors["colors"]["primary"]["background"]
    c.colors.tabs.even.fg = colors["colors"]["primary"]["foreground"]
    c.colors.tabs.odd.fg = colors["colors"]["primary"]["foreground"]
    c.colors.tabs.selected.even.bg = colors["colors"]["bright"]["black"]
    c.colors.tabs.selected.odd.bg = colors["colors"]["bright"]["black"]
    c.colors.tabs.indicator.stop = colors["colors"]["normal"]["cyan"]
    
    c.colors.completion.even.bg = colors["colors"]["primary"]["background"]
    c.colors.completion.odd.bg = colors["colors"]["primary"]["background"]
    c.colors.completion.odd.bg = colors["colors"]["primary"]["background"]
    c.colors.completion.fg = colors["colors"]["primary"]["foreground"]
    c.colors.completion.category.bg = colors["colors"]["primary"]["background"]
    c.colors.completion.category.fg = colors["colors"]["primary"]["foreground"]
    c.colors.completion.item.selected.bg = colors["colors"]["primary"]["background"]
    c.colors.completion.item.selected.fg = colors["colors"]["primary"]["foreground"]
    
    c.colors.hints.bg = colors["colors"]["primary"]["background"]
    c.colors.hints.fg = colors["colors"]["primary"]["foreground"]

c.statusbar.show = "always"
c.hints.border = "1px solid #ffffff"
c.completion.height = "15%"
