;;; Common hook.
(add-hook 'c-mode-common-hook (lambda ()
                                (electric-indent-mode t)
                                (setq indent-tabs-mode nil)
                                (setq c-basic-offset 4)
                                (define-key c-mode-base-map
                                  (kbd "<return>") 'c-context-line-break)
                                (define-key c-mode-base-map
                                  (kbd "C-<tab>") 'clang-format-region)
                                (define-key c-mode-base-map
                                  (kbd "<backtab>") 'clang-format-buffer)
                                (setq c-default-style "linux")
                                (c-set-offset 'cpp-macro 0 nil)
                                (c-set-offset 'case-label 2 nil)
                                (flycheck-mode 1)
                                (ggtags-mode)))
