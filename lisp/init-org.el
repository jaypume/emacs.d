(require-package 'org-fstree)
(require-package 'orgit)
(require-package 'toc-org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-c)" 'org-remove-file)
(define-key global-map "\C-c()" 'org-agenda-file-to-front)


;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80
      org-startup-indented t)


; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                                (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))

;; 出现以下错误
;; File mode specification error: (invalid-function org-babel-header-args-safe-fn)
;; (after-load 'org
;;   (org-babel-do-load-languages
;;    'org-babel-load-languages
;;    '((R . t)
;;      (emacs-lisp . t)
;;      (gnuplot . t)
;;      (haskell . nil)
;;      (latex . t)
;;      (octave . t)
;;      (python . t)
;;      (ruby . t)
;;      (sh . t))))

;;---------------------------------------------------------------------------
;;pujie: org mode 基本设置
;;---------------------------------------------------------------------------
; (setq org-agenda-files
;   (quote
;    ("~/Dropbox/Emacs/Papers/prject - test/pro test.org" "~/Dropbox/Projects/学习笔记/test.org" "~/Dropbox/Projects/学习笔记/org-mode学习笔记.org")))
 (setq org-directory "~/Dropbox/Emacs/Notes/")



;;---------------------------------------------------------------------------
;;pujie: 设置org project 发布到pancake.io
;;---------------------------------------------------------------------------
(setq org-publish-project-alist
      '(
        ("blog" :components ("blog-notes" "blog-static"))
        ("blog-notes"
         :base-directory "~/Dropbox/Documents/Org Notes/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/应用/Pancake.io/"
         :recursive t
         ;;         :publishing-function org-publish-org-to-html ;;org 7.X
         :publishing-function org-html-publish-to-html
         ;;         :link-home "index.html"
         ;;         :link-up "sitemap.html"
         :html-link-home "http://note.jaypu.com/sitemap.html"
         :html-link-up "sitemap.html"
         :headline-levels 5
         :section-numbers nil
         :auto-preamble t
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :author "普杰"
         :email "i@jaypu.com"
         ;;         :style    "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\"/>"
         :html-head  "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\"/>"
         :html-preamble "黑子的笔记-网页版"
         :html-postamble " 评论系统代码(disqus,多说等等)
     <p class=\"author\">Author: %a (%e)</p><p>Last Updated %d . Created by %c </p>"
         )
        ("blog-static"
         :base-directory "~/Dropbox/Documents/Org Notes/"
         :base-extension "css\\|js\\|pdf\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Dropbox/应用/Pancake.io/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;;
        ))


;;---------------------------------------------------------------------------
;;pujie: 覆盖export函数，修改生成的html默认位置
;;---------------------------------------------------------------------------
;;使用这种方式必须保证函数名跟原来的一样
;; (defadvice org-html-export-to-html (around org-html-export-to-html
;;   (&optional async subtreep visible-only body-only ext-plist))
;;   " Pujie hacked this function to modified the default export directory!!
;; Return output file's name."
;;   (interactive)
;;   (let* ((extension (concat "." (or (plist-get ext-plist :html-extension)
;; 				    org-html-extension
;; 				    "html")))
;;          ;;pujie
;;          (file (org-export-output-file-name extension subtreep))
;; 	 (file (concat "./exports/" (substring file 2 nil)))
;; 	 (org-export-coding-system org-html-coding-system))
;;     (org-export-to-file 'html file
;;       async subtreep visible-only body-only ext-plist)
;;     (message "heizi, the file is %s" file)
;;     (message "heizi, the extension is %s" extension)
;;     )
;;   )

;; TODO someday to deal this problem
;; (defun org-html-export-to-html (org-html-export-to-html &rest (&optional async subtreep visible-only body-only ext-plist))
;;   " Pujie hacked this function to modified the default export directory!!
;; Return output file's name."
;;   (interactive)
;;   (let* ((extension (concat "." (or (plist-get ext-plist :html-extension)
;; 				    org-html-extension
;; 				    "html")))
;;          ;;pujie
;;          (file (org-export-output-file-name extension subtreep))
;; 	 (file (concat "./exports/" (substring file 2 nil)))
;; 	 (org-export-coding-system org-html-coding-system))
;;     (org-export-to-file 'html file
;;       async subtreep visible-only body-only ext-plist)
;;     (message "heizi, the file is %s" file)
;;     (message "heizi, the extension is %s" extension)
;;     )
;;   )

;; (advice-add 'html-heizi :around #'org-html-export-to-html)

;; (defun his-tracing-function (orig-fun &rest args)
;;   (message "display-buffer called with args %S" args)
;;   (let ((res (apply orig-fun args)))
;;     (message "display-buffer returned %S" res)
;;     res))

;; (advice-add 'display-buffer :around #'his-tracing-function)




;;(setq org-export-publishing-directory "./exports")
;; (setq org-publish-project-alist
;;       '(("html"
;;          :base-directory "~/Dropbox/Notes/"
;;          :base-extension "org"
;;          :publishing-directory "./exports"
;;          :recursive t
;;          :publishing-function org-html-export-to-html
;;          )
;;         ("pdf"
;;          :base-directory "~/Dropbox/Notes/"
;;          :base-extension "org"
;;          :publishing-directory "./exports"
;;          :recursive t
;;          :publishing-function org-publish-org-to-pdf
;;          )
;;         ("all" :components ("html" "pdf"))))


;; (defadvice org-export-output-file-name (around export-to-directories activate)
;;   "alters the org export process to create a subdirectory for each exported org file"
;;   (let* ((visited-file (buffer-file-name (buffer-base-buffer)))
;;          (dir-name (file-name-sans-extension (file-name-nondirectory visited-file))))
;;     (setf pub-dir
;;           (concat (file-name-as-directory (or pub-dir "."))
;;                   dir-name))
;;     ad-do-it
;;     (setf ad-return-value
;;           (replace-regexp-in-string (regexp-quote (concat dir-name "." extension))
;;                                     (concat "index." extension)
;;                                     ad-return-value))))



;;---------------------------------------------------------------------------
;;pujie: org-mode 截图函数
;;---------------------------------------------------------------------------
;;另外一个http://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it
(defun pujie/org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-nondirectory (buffer-file-name))
                  "image/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename)))
  ; take screenshot
  (if (eq system-type 'darwin)
      (call-process "screencapture" nil nil nil "-i" filename))
  (if (eq system-type 'gnu/linux)
      (call-process "import" nil nil nil filename))
  ; insert into file if correctly taken
  (if (file-exists-p filename)
      (insert (concat "[[file:" filename "]]"))
    )
    (org-redisplay-inline-images)
  )



;;---------------------------------------------------------------------------
;;pujie: use org-toc
;;---------------------------------------------------------------------------
(add-hook 'org-mode-hook 'toc-org-enable)

;;---------------------------------------------------------------------------
;;pujie: org2blog 设置
;;---------------------------------------------------------------------------
;; 暂时用不到了
;; ;; org2blog  在orgmode 加载之后设置
;; (require-package 'org2blog)
;; (require 'org2blog-autoloads)
;; (require 'auth-source)
;; (let (credentials)
;;   (setq org2blog/wp-blog-alist
;;         `(("blog.jaypu.com"
;;            :url "http://blog.jaypu.com/xmlrpc.php"
;;            :username "jaypume"
;;            :password ,(cadr credentials)))))


;;---------------------------------------------------------------------------
;;pujie: 设置orgmode中Latex preview的处理程序，以及Mac的Latex相关路径
;;---------------------------------------------------------------------------
(setq org-latex-create-formula-image-program 'dvipng)
;;(setq org-latex-create-formula-image-program 'imagemagick)

;;设置orgmode中Latex的路径，针对Mac有效，添加变量后面加了冒号会出错
(setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin") exec-path))



;;---------------------------------------------------------------------------
;;pujie: org 内嵌公式实时预览
;;---------------------------------------------------------------------------
;;http://emacs.stackexchange.com/questions/3387/how-to-enlarge-latex-fragments-in-org-mode-at-the-same-time-as-the-buffer-text
;;TODO: 我觉得可以在这里添加一项功能，删除相关的图片
;; 这里会导致C-x 1 关闭其他窗口功能失效
;; (defun update-org-latex-fragments ()
;;   "ceshi 注释"
;;   (org-toggle-latex-fragment '(16))
;;   (plist-put org-format-latex-options :scale text-scale-mode-amount)
;;   (org-toggle-latex-fragment '(16)))
;; (add-hook 'text-scale-mode-hook 'update-org-latex-fragments)


;;---------------------------------------------------------------------------
;;pujie: minted 这个功能还没想好如何处理
;;---------------------------------------------------------------------------
;; minted 不知道怎么翻译这个
;; (setq org-latex-listings 'minted)
;; (require 'ox-latex)
;; (add-to-list 'org-latex-packages-alist '("" "minted"))

;;---------------------------------------------------------------------------
;;pujie: org 加载之后加载ox-mid
;;---------------------------------------------------------------------------
;; enable markdown-exporting to the export menu
(eval-after-load "org"
  '(require 'ox-md nil t))


;;---------------------------------------------------------------------------
;;pujie: zotelo
;;---------------------------------------------------------------------------
(require-package 'zotelo)
(require-package 'zotxt)


;;---------------------------------------------------------------------------
;;pujie: get-bibtex-from-doi
;;---------------------------------------------------------------------------
(defun get-bibtex-from-doi (doi)
 "Get a BibTeX entry from the DOI"
 (interactive "MDOI: ")
 (let ((url-mime-accept-string "text/bibliography;style=bibtex"))
   (with-current-buffer 
     (url-retrieve-synchronously 
       (format "http://dx.doi.org/%s" 
;;      (format "http://www.doi2bib.org/#/doi/%s" 
       	(replace-regexp-in-string "http://dx.doi.org/" "" doi)))
;;              (replace-regexp-in-string "http://www.doi2bib.org/#/doi/" "" doi)))
     (switch-to-buffer (current-buffer))
     (goto-char (point-max))
     (setq bibtex-entry 
     	  (buffer-substring 
          	(string-match "@" (buffer-string))
              (point)))
     (kill-buffer (current-buffer))))
 (insert (decode-coding-string bibtex-entry 'utf-8))
 (bibtex-fill-entry))


;;---------------------------------------------------------------------------
;;pujie: reftex相关设置
;;---------------------------------------------------------------------------
;; http://tex.stackexchange.com/questions/139824/disabling-the-select-reference-format-menu-in-reftex
;;(setq reftex-default-bibliography
;;      (quote
;;       ("default.bib" "~/Dropbox/reference/reference.bib")))
;; (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;; (setq reftex-ref-macro-prompt nil) ;; 取消额外的窗口




;;---------------------------------------------------------------------------
;;pujie: org-mode 自动加载reftex相关
;;---------------------------------------------------------------------------
;;https://tincman.wordpress.com/2011/01/04/research-paper-management-with-emacs-org-mode-and-reftex/
;; (defun org-mode-reftex-setup ()
;;   "hello org-mdoe -reftex setup"
;;   (interactive)
;;   (load-library "reftex")
;;   (and (buffer-file-name) (file-exists-p (buffer-file-name))
;;        (progn
;; 	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
;; 	 (global-auto-revert-mode t)
;; 	 (reftex-parse-all)
;; 	 ;add a custom reftex cite format to insert links
;; 	 (reftex-set-cite-format
;; 	  '((?b . "[[bib:%l][%l-bib]]")
;; 	    (?n . "[[notes:%l][%l-notes]]")
;; 	    (?p . "[[papers:%l][%l-paper]]")
;; 	    (?t . "%t")
;; 	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;;   (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)

;; (setq org-link-abbrev-alist
;;       '(("bib" . "~/Dropbox/bibliography/refs.bib::%s")
;; 	("notes" . "~/Dropbox/bibliography/notes.org::#%s")
;; 	("papers" . "~/Dropbox/bibliography/papers/%s.pdf")))

;; (defun org-mode-reftex-search ()
;;   ;;jump to the notes for the paper pointed to at from reftex search
;;   (interactive)
;;   (org-open-link-from-string (format "[[notes:%s]]" (first (reftex-citation t)))))





;;---------------------------------------------------------------------------
;;pujie: org-ref 设置
;;---------------------------------------------------------------------------
;;installation
(require-package 'org-ref)
;; setup
(require 'org-ref)
;; ;;https://github.com/jkitchin/org-ref
(setq reftex-default-bibliography '("_references.bib"))

;; ;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "_notes.org"
      org-ref-default-bibliography '("_references.bib")
      org-ref-pdf-directory "_pdfs/")


(setq helm-bibtex-bibliography "_references.bib")
(setq helm-bibtex-library-path "_pdfs")

;; open pdf with system pdf viewer (works on mac)
(setq helm-bibtex-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

;; 设置file字段
(setq helm-bibtex-pdf-field "file")
(global-set-key "\C-cf" 'org-ref-helm-insert-cite-link)

;; alternative
;; (setq helm-bibtex-pdf-open-function 'org-open-file)
;; (setq helm-bibtex-notes-path "~/Dropbox/bibliography/helm-bibtex-notes")

;; 设置自动doi的格式
(setq
 bibtex-autokey-name-year-separator "-"
 bibtex-autokey-titleword-separator "-"
 bibtex-autokey-titlewords 2
 bibtex-autokey-titlewords-stretch 2
 bibtex-autokey-year-length 4
 bibtex-autokey-year-title-separator "-")


;;---------------------------------------------------------------------------
;;pujie: 覆盖这个方法：org-ref-open-bibtex-notes
;;---------------------------------------------------------------------------

;;** Open notes from bibtex entry
(defun pujie/org-ref-open-bibtex-notes (orig-fun &rest args)
  "pujie hack this function"
  (interactive)
  (bibtex-beginning-of-entry)
  (let* ((cb (current-buffer))
         (bibtex-expand-strings t)
         (entry (cl-loop for (key . value) in (bibtex-parse-entry t)
                         collect (cons (downcase key) value)))
         (key (reftex-get-bib-field "=key=" entry))
         )

    ;; save key to clipboard to make saving pdf later easier by pasting.
    (with-temp-buffer
      (insert key)
      (kill-ring-save (point-min) (point-max)))

    ;; now look for entry in the notes file
    (save-restriction
      (if  org-ref-bibliography-notes
          (find-file-other-window org-ref-bibliography-notes)
        (error "Org-ref-bib-bibliography-notes is not set to anything"))

      (widen)
      (goto-char (point-min))
      ;; put new entry in notes if we don't find it.
      (if (re-search-forward (format ":Custom_ID: %s$" key) nil 'end)
          (funcall org-ref-open-notes-function)
        ;; no entry found, so add one
        (insert (org-ref-reftex-format-citation
                 entry (concat "\n" org-ref-note-title-format)))
        (insert (format
                 "[[cite:%s]] [[file:%s][pdf]]\n\n"
                 ;;pujie.modified fix this link through helm
                 key (car (helm-bibtex-find-pdf entry))
                 ))
        (save-buffer)))))

(advice-add 'org-ref-open-bibtex-notes :around #'pujie/org-ref-open-bibtex-notes)


;;---------------------------------------------------------------------------
;;pujie:代码测试
;;---------------------------------------------------------------------------





;;---------------------------------------------------------------------------
;;pujie: TODO:把这些绑定代码挪到对应的位置， 设置org的有关的默认位置
;;---------------------------------------------------------------------------
(add-hook 'org-mode-hook
          (lambda()
            (setq org-default-notes-file (concat org-directory "note.org"))
            (define-key global-map "\C-cc" 'org-capture)
            (define-key global-map "\C-cp" 'org-publish)
            ;; (define-key global-map "\C-," 'org-iswitchb)
            ))



;;---------------------------------------------------------------------------
;;结束
;;---------------------------------------------------------------------------
(provide 'init-org)

