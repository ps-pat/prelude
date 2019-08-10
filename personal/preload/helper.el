(defun flatten (lst)
  "Flatten a list."
  (cond ((null lst) nil)
        ((atom lst) (list lst))
        (t (append (flatten (car lst)) (flatten (cdr lst))))))

(defun concat-sep (sep &rest sequences)
  "Concatenate all sequences and separate them with sep."
  (unless (null sequences)
    (let ((tail (cdr sequences)))
      (concat (car sequences)
              (when tail sep)
              (apply 'concat-sep sep tail)))))
