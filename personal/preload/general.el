;;; Load path.
(defvar home-built "~/Build"
  "Location of custom built packages.")

;; Undo-tree
(add-to-list 'load-path (expand-file-name "emacs-undo-tree" home-built))

;;; Default browser.
(setq-default browse-url-browser-function 'browse-url-xdg-open)

;;; Revert buffer without asking for confirmation. The cursor will stay
;;; at the same position.
(defun revert-buffer-no-confirm ()
  "Reverts the current buffer without asking for confirmation."
  (let ((old-line (line-number-at-pos))
        (old-column (current-column)))
    (revert-buffer t t)
    (line-move (- old-line (line-number-at-pos)))
    (move-to-column old-column)))

(global-set-key (kbd "C-x C-v") (lambda (&optional x) (interactive)
                                  (revert-buffer-no-confirm)))

;;; Transparency:
(set-frame-parameter (selected-frame) 'alpha '(97 . 90))
(add-to-list 'default-frame-alist '(alpha . (97 . 90)))

;;; Menu bar
(menu-bar-mode)

;;; Backup files:
(defvar *bkp-dir* "~/backup/")

(setq backup-directory-alist
      `((".*" . ,*bkp-dir*)))

(setq auto-save-file-name-transforms
      (list (list ".*" *bkp-dir* t)))

(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files *bkp-dir* t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

;;; Undo tree mode.
(setq undo-limit 78643200)
(setq undo-outer-limit 104857600)
(setq undo-strong-limit 157286400)
(setq undo-tree-mode-lighter " Undo-Tree")
(setq undo-tree-auto-save-history nil)
(setq undo-tree-enable-undo-in-region nil)
(setq undo-tree-visualizer-lazy-drawing 100)

(when (timerp undo-auto-current-boundary-timer)
  (cancel-timer undo-auto-current-boundary-timer))

(setq whitespace-style '(face tabs trailing))


(provide 'general)
