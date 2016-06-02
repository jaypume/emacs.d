;;------------------------------------------------------------------------------
;;pujie: 设定用户目录,加载所有普杰的设置
;;------------------------------------------------------------------------------
;;(if(eq system-type 'darwin)
;;    (setq user-emacs-directory "/Users/PUJIE/Dropbox/Libraries/dotFiles/emacs.pujie.d/")
;;  )
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-main)

;;------------------------------------------------------------------------------
;;pujie: 不知道这个有什么用，先注释着
;;------------------------------------------------------------------------------
;; (provide 'init)

