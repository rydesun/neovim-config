(local M {})

(fn has [ dir pattern]
  (-> dir
    (vim.fn.escape "?*[]")
    (vim.fn.globpath pattern 1)
    (length)
    (> 0))
)

(fn parent [path]
  (vim.fn.fnamemodify path ":h")
)

(fn match_dir [dir pattern]
  (var ok false)
  (var pdir dir)
  (var current "")

  (var loop? true)
  (while loop?
    (if (has pdir pattern)
      (do
        (set ok true)
        (set loop? false))
      (do
        (set current pdir)
        (set pdir (parent pdir))
        (when (= current pdir) (set loop? false)))
  ))
  (values ok pdir)
)

(fn match_all [dir patterns]
  (each [_ pattern (pairs patterns)]
    (let [(ok res) (match_dir dir pattern)]
      (when ok
        (lua "return res")))
  )
)

(set M.get (fn [patterns]
  (if (and (not= vim.b.rootpath nil) (not= vim.b.rootpath ""))
    vim.b.rootpath
    (let [
      dir (vim.fn.expand "%:p:h")
      res (match_all dir patterns)
    ] (if (and (not= res nil) (not= res ""))
      (do (set vim.b.rootpath res)
        vim.b.rootpath)
      (do (set vim.b.rootpath dir)
        vim.b.rootpath))
  ))
))

(set M.clear (fn []
  (set vim.b.rootpath nil)
))

M
