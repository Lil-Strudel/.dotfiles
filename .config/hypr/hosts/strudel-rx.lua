local laptop  = "desc:BOE NE135A1M-NY1"
local samsung = "desc:Samsung Electric Company Odyssey G95C HNTL101141"

hl.monitor({
    output   = laptop,
    mode     = "2880x1920@120",
    position = "0x0",
    scale    = 2,
})

hl.monitor({
    output   = samsung,
    mode     = "5120x1440@240",
    position = "1440x0",
    scale    = 1,
})

hl.workspace_rule({ workspace = "1", monitor = samsung, default = true })
hl.workspace_rule({ workspace = "3", monitor = laptop,  default = true })
