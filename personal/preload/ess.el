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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Julia stuff.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.jl\\'" . ess-julia-mode))

(defmacro define-key-julia-all (key fun)
  "Define a new key mapping for both ess-r-mode and inferior-ess-r-mode."
  `(progn
     (add-hook
      'ess-julia-mode-hook
      (lambda () (define-key ess-julia-mode-map (kbd ,key) ,fun)))
     (add-hook
      'inferior-ess-julia-mode-hook
      (lambda () (define-key inferior-ess-julia-mode-map (kbd ,key) ,fun)))))

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
