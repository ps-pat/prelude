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

(defun get-line-up-to-point ()
  "Get the current line up to the current position."
  (buffer-substring-no-properties
   (line-beginning-position)
   (+ (line-beginning-position) (current-column))))

(defun get-last-characters (n)
  "Get the last n non whitespace characters."
  (let* ((line-up-to-point (get-line-up-to-point))
         (line-without-space (remove ? line-up-to-point))
         (nchar (min n (length line-without-space))))
    (subseq line-without-space (- nchar))))

(defun delete-last-characters (n)
  "Delete the last n non whitespace characters."
  (let* ((line (get-line-up-to-point))
         (nb-whitespaces (- (length line)
                            (length (string-trim-right line)))))
    (delete-char (- (+ nb-whitespaces n)))))

(defun in-quotes-p ()
  "Determines if cursor is inside quotes."
  (oddp (reduce #'+ (mapcar (lambda (char) (if (= char 34) 1 0))
                            (get-line-up-to-point)))))

(provide 'helper)
