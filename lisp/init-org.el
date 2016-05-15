;;(require-package 'org) ;;貌似没有用
(require-package 'org-fstree)
(require-package 'orgit);;这个orgit 会导致latexpreview不起作用

;;---------------------------------------------------------------------------
;;pujie: use org-toc
;;---------------------------------------------------------------------------
(require-package 'toc-org)
(add-hook 'org-mode-hook 'toc-org-enable)



;;---------------------------------------------------------------------------
;;pujie: org mode 基本设置
;;---------------------------------------------------------------------------
;;解决中文不自动换行的问题
(add-hook 'org-mode-hook
      (lambda () (setq truncate-lines nil)))

; (setq org-agenda-files
;   (quote
;    ("~/Dropbox/Emacs/Papers/prject - test/pro test.org" "~/Dropbox/Projects/学习笔记/test.org" "~/Dropbox/Projects/学习笔记/org-mode学习笔记.org")))
(setq org-directory "~/Dropbox/Emacs/Notes/Org/")
(setq org-default-notes-file (concat org-directory "capture.org"))
(setq org-return-follows-link nil)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-c)" 'org-remove-file)
(define-key global-map "\C-c(" 'org-agenda-file-to-front)

(setq
 org-log-done t
 org-completion-use-ido t
 org-edit-timestamp-down-means-later t
 org-agenda-start-on-weekday nil
 org-agenda-span 14
 org-agenda-include-diary t
 org-agenda-window-setup 'current-window
 org-fast-tag-selection-single-key 'expert
 org-export-kill-product-buffer-when-displayed t
 org-tags-column 60
 org-startup-indented t
 )

; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                                (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))


;;增加md输出格式
;; enable markdown-exporting to the export menu
(eval-after-load "org"
  '(require 'ox-md nil t))







;;------------------------------------------------------------------------------
;;pujie: org clock 相关
;;------------------------------------------------------------------------------
;; Save the running clock and all clock history when exiting Emacs, load it on startup
;; (setq org-clock-persistence-insinuate t)
;; (setq org-clock-persist t)
;; (setq org-clock-in-resume t)

;; ;; Change task state to STARTED when clocking in
;; (setq org-clock-in-switch-to-state "STARTED")
;; ;; Save clock data and notes in the LOGBOOK drawer
;; (setq org-clock-into-drawer t)
;; ;; Removes clocked tasks with 0:00 duration
;; (setq org-clock-out-remove-zero-time-clocks t)

;; ;; Show the clocked-in task - if any - in the header line
;; (defun sanityinc/show-org-clock-in-header-line ()
;;   (setq-default header-line-format '((" " org-mode-line-string " "))))

;; (defun sanityinc/hide-org-clock-from-header-line ()
;;   (setq-default header-line-format nil))

;; (add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
;; (add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
;; (add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

;; (eval-after-load 'org-clock
;;   '(progn
;;      (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
;;      (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))


;;------------------------------------------------------------------------------
;;pujie: babel还不知道怎么用
;;------------------------------------------------------------------------------
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
;;pujie: org-mode 截图函数
;;---------------------------------------------------------------------------
;;另外一个http://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it
;; 生成子文件夹
(defun pujie/org-image-folder()
  "给出存放图片路径的目录"
  ;; 使用子目录
  ;;  (concat (file-name-nondirectory (buffer-file-name)) "image/")
  ;; 不使用子目录
  "_org-screenshot/"
  )

(defun pujie/org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat
           (pujie/org-image-folder)
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

(global-set-key "\C-cmc" 'pujie/org-screenshot)

(defun pujie/org-import-image()
  "拷贝剪贴板中的图片，放入本地文件夹，并在org文件中生成链接和显示图片"
    )





;;---------------------------------------------------------------------------
;;pujie: org2blog 设置(暂时不用)
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
;;pujie: 设置orgmode中Latex preview的处理程序(dvipng)
;;---------------------------------------------------------------------------
(setq org-latex-create-formula-image-program 'dvipng)
;;(setq org-latex-create-formula-image-program 'imagemagick)


;;---------------------------------------------------------------------------
;;pujie: org 内嵌公式实时预览调整大小（会出问题）
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
;; (setq
;;  bibtex-autokey-name-year-separator "-"
;;  bibtex-autokey-titleword-separator "-"
;;  bibtex-autokey-titlewords 2
;;  bibtex-autokey-titlewords-stretch 2
;;  bibtex-autokey-year-length 4
;;  bibtex-autokey-year-title-separator "-")




;;---------------------------------------------------------------------------
;;pujie: 设置默认寻找PDF的方式(zotero)
;;---------------------------------------------------------------------------
(defun pujie/org-ref-get-zotero-filename (key)
"pujie defined find pdf files"
  (car (helm-bibtex-find-pdf-in-field key))
)
(setq org-ref-get-pdf-filename-function (quote pujie/org-ref-get-zotero-filename))
;;---------------------------------------------------------------------------
;; 覆盖这个方法：org-ref-open-bibtex-notes(代码正确，但是没用了,advice-add例子)
;;---------------------------------------------------------------------------
;; 不用覆盖这个方法了，因为链接寻找方法已经自定义了
;; ;;** Open notes from bibtex entry
;; (defun pujie/org-ref-open-bibtex-notes (orig-fun &rest args)
;;   "pujie hack this function"
;;   (interactive)
;;   (bibtex-beginning-of-entry)
;;   (let* ((cb (current-buffer))
;;          (bibtex-expand-strings t)
;;          (entry (cl-loop for (key . value) in (bibtex-parse-entry t)
;;                          collect (cons (downcase key) value)))
;;          (key (reftex-get-bib-field "=key=" entry))
;;          )

;;     ;; save key to clipboard to make saving pdf later easier by pasting.
;;     (with-temp-buffer
;;       (insert key)
;;       (kill-ring-save (point-min) (point-max)))

;;     ;; now look for entry in the notes file
;;     (save-restriction
;;       (if  org-ref-bibliography-notes
;;           (find-file-other-window org-ref-bibliography-notes)
;;         (error "Org-ref-bib-bibliography-notes is not set to anything"))

;;       (widen)
;;       (goto-char (point-min))
;;       ;; put new entry in notes if we don't find it.
;;       (if (re-search-forward (format ":Custom_ID: %s$" key) nil 'end)
;;           (funcall org-ref-open-notes-function)
;;         ;; no entry found, so add one
;;         (insert (org-ref-reftex-format-citation
;;                  entry (concat "\n" org-ref-note-title-format)))
;;         (insert (format
;;                  "[[cite:%s]] [[file:%s][pdf]]\n\n"
;;                  ;;pujie.modified fix this link through helm
;;                  key
;;                  (car (helm-bibtex-find-pdf entry))
;;                  ))
;;         (save-buffer)))))

;; (advice-add 'org-ref-open-bibtex-notes :around #'pujie/org-ref-open-bibtex-notes)

;;------------------------------------------------------------------------------
;;pujie: 自定义orgmode下加粗字体和颜色
;;------------------------------------------------------------------------------
;;; custom org emhasis color
(require 'org)
(require 'cl)   ; for delete*
(setq org-emphasis-alist
      (cons '("+" '(:strike-through t :foreground "gray"))
            (delete* "+" org-emphasis-alist :key 'car :test 'equal)))

(setq org-emphasis-alist
      (cons '("*" '(:emphasis t :foreground "blue"))
            (delete* "*" org-emphasis-alist :key 'car :test 'equal)))



;;---------------------------------------------------------------------------
;;结束
;;---------------------------------------------------------------------------
(provide 'init-org)

