# pnpm
$env.PNPM_HOME = "/Users/rohan/Library/pnpm"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME )
# pnpm end
