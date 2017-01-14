;;; packages.el --- pujie-misc layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: 普杰 <PUJIE@HEIZI-EPIC.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `pujie-misc-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `pujie-misc/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `pujie-misc/pre-init-PACKAGE' and/or
;;   `pujie-misc/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst pujie-misc-packages
  '(
    youdao-dictionary
    sr-speedbar
    org-ref
    org-bullets
    )
  "The list of Lisp packages required by the pujie-misc layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun pujie-misc/init-youdao-dictionary()
  (use-package youdao-dictionary
    :config
    (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)
    )
  )

;;---------------------------------------------------------------------------
;;pujie: sr-speedbar 安装和设置
;;---------------------------------------------------------------------------
(defun pujie-misc/init-sr-speedbar()
  (use-package sr-speedbar
    :config
    (setq sr-speedbar-width 30)
    (setq sr-speedbar-auto-refresh t)
    (setq sr-speedbar-right-side nil)
    )
  )

;;------------------------------------------------------------------------------
;;pujie: org-ref 设置
;;------------------------------------------------------------------------------
(defun pujie-misc/init-org-ref()
  (use-package org-ref
    :config
    ;; see org-ref for use of these variables
    (setq org-ref-bibliography-notes "_notes.org"
          org-ref-default-bibliography '("_references.bib")
          org-ref-pdf-directory "_pdfs/")

   (setq helm-bibtex-bibliography "_references.bib")
   (setq helm-bibtex-library-path "_pdfs")
    ;; ;; open pdf with system pdf viewer (works on mac)
    (setq helm-bibtex-pdf-open-function
          (lambda (fpath)
            (start-process "open" "*open*" "open" fpath)))
    ;; 设置file字段
    (setq helm-bibtex-pdf-field "file")
    (global-set-key "\C-cf" 'org-ref-helm-insert-cite-link)
   )
  )

;;---------------------------------------------------------------------------
;;pujie: 设置默认寻找PDF的方式(zotero)
;;---------------------------------------------------------------------------
(defun pujie/org-ref-get-zotero-filename (key)
  "pujie defined find pdf files"
  ;;  (car (helm-bibtex-find-pdf-in-field key))
  ;; 似乎是helm-bibtex改了代码，导致上面的失效了，要改为下面的
  (car (bibtex-completion-find-pdf-in-field key))
  )
(setq org-ref-get-pdf-filename-function (quote pujie/org-ref-get-zotero-filename))


(defun pujie-misc/init-org-bullets()
  (use-package org-bullets
    :config
    (lambda () (org-bullets-mode 1))
    ;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )
)

;;; packages.el ends here
