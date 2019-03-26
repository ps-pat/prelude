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
            (add-to-list 'flycheck-disabled-checkers 'python-flake8)))

;;; C.
(add-hook 'flycheck-mode-hook
          (lambda ()
            (add-to-list 'flycheck-clang-include-path
                         "/usr/lib/llvm-7/include/openmp")))
