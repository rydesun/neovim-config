(var M {})
(var hlslens (require "hlslens"))
(var config (require "hlslens.config"))
(var lens_backup nil)

(fn override_lens [render plist nearest? idx r_idx]
  (var (lnum col) (unpack (. plist idx)))
  (var text nil)
  (var chunks nil)
  (if nearest?
    (set text (string.format "[%d/%d]" idx (length plist)))
    (set text (string.format "[%d]" idx))
  )
  (if nearest?
    (set chunks [[" " "Ignore"] [text "VM_Extend"]])
    (set chunks [[" " "Ignore"] [text "HlSearchLens"]])
  )
  (render.set_virt 0 (- lnum 1) (- col 1) chunks nearest?)
)


(set M.start (fn []
  (set lens_backup config.override_lens)
  (set config.override_lens override_lens)
  (hlslens.start)))
(set M.exit (fn []
  (set config.override_lens lens_backup)
  (hlslens.start)))

M
