(require 'ox-publish)
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
         :html-link-home "index.html"
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

(provide 'my-publish-project)
