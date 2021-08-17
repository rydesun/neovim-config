(local M {})

(local cmds {
  :i_et (.. "cnoreabb <expr> i%1"
    " (getcmdtype() == ':' && getcmdline() =~ '^i%1$')?"
    " 'setl sw=%1 ts=%1 et' : 'i%1'")
  :i_noet (.. "cnoreabb <expr> i%1t"
    " (getcmdtype() == ':' && getcmdline() =~ '^i%1t$')?"
    " 'setl sw=%1 ts=%1 noet' : 'i%1t'")
})

(tset M :setup (fn [self] (
  each [_ i (pairs [2 4 8])]
    (each [_ cmd (pairs cmds)]
      (->> cmd
        (string.gsub i "(%d)")
        (pick-values 1)
        (vim.api.nvim_command)))
)))

M
