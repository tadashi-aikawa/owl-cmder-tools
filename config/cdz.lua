local function init()
  os.execute("cd >> %home%/.cdz")
end 

-- Register this addon with Clink
clink.prompt.register_filter(init, 66)

os.execute("tac %home%/.cdz | awk '!a[$0]++' | tac | tail -1000 > .cdz.tmp")
os.execute("mv .cdz.tmp %home%/.cdz")