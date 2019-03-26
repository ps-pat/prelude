(defmacro define-key-r-all (key fun)
  "Define a new key mapping for both ess-r-mode and inferior-ess-r-mode."
  `(progn
     (add-hook
      'ess-r-mode-hook
      (lambda () (define-key ess-r-mode-map (kbd ,key) ,fun)))
     (add-hook
      'inferior-ess-r-mode-hook
      (lambda () (define-key inferior-ess-r-mode-map (kbd ,key) ,fun)))))

(defmacro new-operator (fun-name operator-str)
  "Interactively insert an operator."
  `(defun ,fun-name ()
     (interactive)

     (unless (or (string-equal (string (preceding-char)) " ")
                 (bolp))
       (insert " "))
     (insert ,operator-str)
     (unless (string-equal (string (following-char)) " ")
       (insert " "))))

(new-operator magrittr-pipe "%>%")
(new-operator magrittr-backpipe "%<>%")
(new-operator magrittr-with "%$%")

(with-eval-after-load "ess-r-mode"
  (require 'ess-smart-underscore))

;; Smart underscore.
(define-key-r-all "_" 'ess-smarter-underscore)

;; Magrittr pipe operator.
(define-key-r-all "C->" 'magrittr-pipe)

;; Magrittr backpipe operator.
(define-key-r-all "C-<" 'magrittr-backpipe)

;; Magrittr with operator.
(define-key-r-all "C-$" 'magrittr-with)

;; TODO: Not working... (binding shadowed by prelude-mode).
(add-hook
 'inferior-ess-r-mode-hook
 (lambda () (define-key inferior-ess-r-mode-map (kbd "C-a") 'comint-bol)))
