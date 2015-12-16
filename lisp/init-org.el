(require-package 'org-fstree)
(require-package 'orgit)
(require-package 'toc-org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

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

(setq org-publish-project-alist
      '(
        ("blog" :components ("blog-notes" "blog-static"))
        ("blog-notes"
         :base-directory "~/Dropbox/Notes/"
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
         :base-directory "~/Dropbox/Notes/"
         :base-extension "css\\|js\\|pdf\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Dropbox/应用/Pancake.io/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;;
        ))



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


(defun org-html-export-to-html (org-html-export-to-html &rest (&optional async subtreep visible-only body-only ext-plist))
  " Pujie hacked this function to modified the default export directory!!
Return output file's name."
  (interactive)
  (let* ((extension (concat "." (or (plist-get ext-plist :html-extension)
				    org-html-extension
				    "html")))
         ;;pujie
         (file (org-export-output-file-name extension subtreep))
	 (file (concat "./exports/" (substring file 2 nil)))
	 (org-export-coding-system org-html-coding-system))
    (org-export-to-file 'html file
      async subtreep visible-only body-only ext-plist)
    (message "heizi, the file is %s" file)
    (message "heizi, the extension is %s" extension)
    )
  )

(advice-add 'html-heizi :around #'org-html-export-to-html)

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




;; use org-toc
(add-hook 'org-mode-hook 'toc-org-enable)

;;设置org的有关的默认位置
(add-hook 'org-mode-hook
          (lambda()
            (setq org-default-notes-file (concat org-directory "note.org"))
            (define-key global-map "\C-cc" 'org-capture)
            (define-key global-map "\C-cp" 'org-publish)
            ;; (define-key global-map "\C-," 'org-iswitchb)

            ))

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


;; enable markdown-exporting to the export menu
(eval-after-load "org"
  '(require 'ox-md nil t))

(provide 'init-org)
