(require 'helper)

;;; Compilation.
(defun asy-compile-only ()
  "Compile current file and does nothing else."
  (interactive)
  (message "Compiling...")
  (let* ((file (buffer-file-name))
         (other-args '("--verbose" "--verbose"))
         (args-strings (flatten (list other-args file)))
         (buffer-name "*Asymptote Compilation*"))
    (when (get-buffer buffer-name) (kill-buffer buffer-name))
    (let ((exit-code (apply 'call-process
                       "asy"
                       file
                       buffer-name
                       t
                       args-strings)))
      (message (if (zerop exit-code)
                   "Compiling... Success :)"
                 "Compiling... Failure :(")))))

;;; Mode map.

;; Remap C-c C-c to compile (no viewing).
(add-hook 'asy-mode-hook
          (lambda ()
            (define-key asy-mode-map (kbd "C-c C-c") 'asy-compile-only)))
