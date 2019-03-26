(add-hook 'LaTeX-mode-hook (lambda ()
                             (setq-default TeX-engine 'xetex)))

;; Add a latex command to compile with --shell-escape enabled.
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("LaTeX-shell-escape"
                           "%`%l --shell-escape %(mode)%' %t"
                           TeX-run-TeX
                           nil
                           (latex-mode doctex-mode)
                           :help "Run LaTeX"))))
