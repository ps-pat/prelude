(global-prettify-symbols-mode +1)

(defmacro prettify-function-factory (name symbols-alist)
  `(defun ,name ()
     (mapc (lambda (x) (push x prettify-symbols-alist)) ,symbols-alist)))

(prettify-function-factory prettify-arith '(("<=" . #x2264)
                                            (">=" . #x2265)
                                            ("!=" . #x2260)))

(prettify-function-factory prettify-r '(("%in%" . #x2208)))

;;; R
(defvar prettify-r-functions '(prettify-arith
                               prettify-r))

(mapc (lambda (x) (progn (add-hook 'ess-r-mode-hook x)
                    (add-hook 'inferior-ess-r-mode-hook x)))
      prettify-r-functions)

