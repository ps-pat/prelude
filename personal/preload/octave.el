(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(add-hook 'octave-mode-hook (lambda ()
                              (abbrev-mode 1)
                              (auto-fill-mode 1)
                              (font-lock-mode 1)
                              (define-key octave-mode-map
                                (kbd "C-c C-b") 'octave-send-buffer)
                              (define-key octave-mode-map
                                (kbd "C-c C-r") 'octave-send-region)))
