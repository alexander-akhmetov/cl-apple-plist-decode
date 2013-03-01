(require 'asdf)
(asdf:load-system :cl-apple-plist-decode)

(set-pprint-dispatch 'hash-table
 (lambda (str ht)
  (format str "{~{~{~S => ~S~}~^, ~}}"
   (loop for key being the hash-keys of ht
         for value being the hash-values of ht
         collect (list key value)))))

(defun test () 
  (cl-apple-plist-decode:aplist-decode-file "./example.plist"))
