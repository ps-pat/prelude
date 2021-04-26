(use-package polymode
  :ensure t
  :custom
  (polymode-weave-output-file-format "%s")
  (polymode-exporter-output-file-format "%s")

  :init
  (require 'poly-R))
