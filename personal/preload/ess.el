(require 'helper)

(defcustom ess-operator-no-space-characters
  (list ? ?.)
  "Characters after which a space is not needed when inserting an operator."
  :type 'list
  :options '(?  ?.)
  :group 'ess)

(defmacro new-operator (fun-name operator-str)
  "Interactively insert an operator."
  `(defun ,fun-name ()
     (interactive)

     (unless (member (preceding-char) ess-operator-no-space-characters)
       (insert ? ))

     (insert ,operator-str)

     (if (char-equal (following-char) ? )
         (forward-char 1)
         (insert ? ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; R stuff.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro define-key-r-all (key fun)
  "Define a new key mapping for both ess-r-mode and inferior-ess-r-mode."
  `(progn
     (add-hook
      'ess-r-mode-hook
      (lambda () (define-key ess-r-mode-map (kbd ,key) ,fun)))
     (add-hook
      'inferior-ess-r-mode-hook
      (lambda () (define-key inferior-ess-r-mode-map (kbd ,key) ,fun)))))

(new-operator magrittr-pipe "%>%")
(new-operator magrittr-backpipe "%<>%")
(new-operator magrittr-with "%$%")

;; (with-eval-after-load "ess-r-mode"
;;   (require 'ess-smart-underscore))

;; ;; Smart underscore.
;; (define-key-r-all "_" 'ess-smarter-underscore)

;; Magrittr pipe operator.
(define-key-r-all "C-c x >" 'magrittr-pipe)

;; Magrittr backpipe operator.
(define-key-r-all "C-c x <" 'magrittr-backpipe)

;; Magrittr with operator.
(define-key-r-all "C-c x $" 'magrittr-with)

;; TODO: Not working... (binding shadowed by prelude-mode).
(add-hook
 'inferior-ess-r-mode-hook
 (lambda () (define-key inferior-ess-r-mode-map (kbd "C-a") 'comint-bol)))

;; My dumb smart underscore.
(new-operator left-arrow "<-")

(defun ess-dumb-underscore ()
  "Basic replacement for ess smart underscore."
  (interactive)
  (cond ((in-quotes-p) (insert "_"))
        ((bolp) (insert "_"))
        ((string= (get-last-characters 2) "<-")
         (progn
           (delete-last-characters 2)
           (unless (string= (string-trim (get-line-up-to-point)) "")
             (delete-last-characters 0))
           (insert "_")))
        ((string= (get-last-characters 1) "_")
         (progn
           (delete-last-characters 1)
           (if (bolp) (insert "__") (left-arrow))))
        (t (left-arrow))))

(define-key-r-all "_" 'ess-dumb-underscore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Julia stuff.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package julia-snail
  :ensure t
  :after vterm
  :hook (julia-mode . julia-snail-mode))

(add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))

(defmacro define-key-julia-all (key fun)
  "Define a new key mapping for both ess-r-mode and inferior-ess-r-mode."
  `(progn
     (add-hook
      'julia-snail-mode-hook
      (lambda () (define-key julia-snail-mode-map (kbd ,key) ,fun)))
     ;; Not working currently.
     (add-hook
      'julia-snail-repl-mode-hook
      (lambda () (define-key julia-snail-repl-mode-map (kbd ,key) ,fun)))))

(new-operator julia-pipe "|>")
(new-operator julia-compose "∘")
(new-operator julia-subtype "<:")
(new-operator julia-lambda-function "->")
(new-operator julia-integer-division "÷")
(new-operator julia-xor "⊻")
(new-operator julia-approx "≈")

(define-key-julia-all "C-c x >" 'julia-pipe)
(define-key-julia-all "C-c x é" 'julia-compose)
(define-key-julia-all "C-c x <" 'julia-subtype)
(define-key-julia-all "C-c x ." 'julia-lambda-function)
(define-key-julia-all "C-c x /" 'julia-integer-division)
(define-key-julia-all "C-c x x" 'julia-xor)
(define-key-julia-all "C-c x =" 'julia-approx)

;; Desactivate flycheck mode.
(add-hook 'ess-julia-mode-hook (lambda () (flycheck-mode -1)))
