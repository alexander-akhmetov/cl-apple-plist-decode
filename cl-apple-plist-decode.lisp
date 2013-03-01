(declaim (optimize (debug 3) (speed 0) (safety 3)))

(in-package :cl-apple-plist-decode)

(defun pair-list (lst)
  (if (null lst)
      nil
      (cons (cons (first lst) (second lst)) (pair-list (cddr lst)))))

(defun switch-to-cl-type (lst)
  (if (listp lst)
      (let ((type (car lst)))
        (cond ((eql type :|dict|)
               (let ((answer (make-hash-table)))             
                 (dolist (pair (pair-list (cdr lst)))
                   (setf (gethash (second (car pair)) answer)
                         (switch-to-cl-type (cdr pair))))
                 answer))
              ((eql type :|array|)
               (coerce (mapcar #'switch-to-cl-type (cdr lst)) 'vector))
              ((eql type :|integer|)
               (read-from-string (second lst)))
              ((eql type :|string|)
               (second lst))
              ((eql type :|real|)
               (read-from-string (second lst)))
              (t 
               (error "unsupproted type")
               nil)))
      (cond ((eql lst :|false|)
             nil)
            ((eql lst :|true|)
             t)
            ((eql lst :|string|)
             "")
            (t
             (error "unknown type")
             nil))))
  
(defun aplist-decode-file (path)
  (let ((xml (s-xml:parse-xml-file path)))
    (switch-to-cl-type (cadr xml))))

