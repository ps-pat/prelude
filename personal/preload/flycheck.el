;; pylint
(add-hook 'python-mode-hook
          (lambda ()
            (setq flycheck-python-pylint-executable
                  "/home/pfournier/.local/bin/pylint")
            (setq flycheck-pylintrc
                  "/home/pfournier/.config/pylintrc")))

;; Deactivate some checkers.
(add-hook 'flycheck-mode-hook
          (lambda ()
            (add-to-list 'flycheck-disabled-checkers 'python-flake8)
            (add-to-list 'flycheck-disabled-checkers 'julia-linter)))

;;; C.
(add-hook 'flycheck-mode-hook
          (lambda ()
            (add-to-list 'flycheck-clang-include-path
                         "/usr/lib/llvm-7/include/openmp")))

;;; Julia.
;; (flycheck-julia-setup)
;; (add-to-list 'flycheck-global-modes 'julia-mode)
;; (add-to-list 'flycheck-global-modes 'ess-julia-mode)
