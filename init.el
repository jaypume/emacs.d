;;------------------------------------------------------------------------------
;;pujie: 设定用户目录,加载所有普杰的设置
;;------------------------------------------------------------------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(if(eq system-type 'darwin)
    (setq user-emacs-directory "/Users/PUJIE/Dropbox/Libraries/dotFiles/emacs/pujie.d/")
  )
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-main)

;;------------------------------------------------------------------------------
;;pujie: 不知道这个有什么用，先注释着
;;------------------------------------------------------------------------------
;; (provide 'init)

