
(defsystem "cl-apple-plist-decode"
   :description "decoder for apples plists"
   :version "0.1"
   :author "aclarke"
   :licence "BSD"
   :serial t
   :depends-on (s-xml)
   :components ((:file "package")
                (:file "cl-apple-plist-decode")))
