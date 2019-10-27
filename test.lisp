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

(defun read-file (path)
  (with-output-to-string (out)
    (with-open-file (in path)
      (loop with buffer = (make-array 8192 :element-type 'character)
            for n-characters = (read-sequence buffer in)
            while (< 0 n-characters)
            do (write-sequence buffer out :start 0 :end n-characters)))))

(defun test-parse-string ()
  (cl-apple-plist-decode:aplist-decode-string (read-file "./example.plist")))
