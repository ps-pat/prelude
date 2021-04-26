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

;;; R.
(add-hook 'ess-r-mode-hook
          (lambda ()
            (setq flycheck-lintr-linters
                  "with_defaults(assignment_linter,
                                 closed_curly_linter,
                                 commas_linter = NULL,
                                 commented_code_linter,
                                 cyclocomp_linter,
                                 extraction_operator_linter,
                                 function_left_parentheses_linter,
                                 implicit_integer_linter,
                                 infix_spaces_linter,
                                 line_length_linter(80),
                                 nonportable_path_linter,
                                 no_tab_linter,
                                 object_name_linter = NULL,
                                 open_curly_linter,
                                 paren_brace_linter,
                                 pipe_continuation_linter,
                                 seq_linter,
                                 trailing_blank_lines_linter,
                                 trailing_whitespace_linter,
                                 T_and_F_symbol_linter,
                                 unneeded_concatenation_linter)")))

;;; Julia.
;; (flycheck-julia-setup)
;; (add-to-list 'flycheck-global-modes 'julia-mode)
;; (add-to-list 'flycheck-global-modes 'ess-julia-mode)
