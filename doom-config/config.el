;;; ~/doom-config/config.el -*- lexical-binding: t; -*-
(setq doom-font (font-spec :family "Source Code Pro" :size 11))
;; (setq doom-font (font-spec :family "Iosevka" :size 12))
;; (setq doom-font (font-spec :family "Fira Code" :size 12))

;; Fix solidity-mode error when solium is absent
(setq solidity-flycheck-solium-checker-active nil)

;; Theme related config starts
(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-nord t)

;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)

;; Enable custom neotree theme
;; (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
;; Theme related config ends
;;

(add-hook 'org-mode-hook #'doom|enable-line-numbers)
(setq doom-line-numbers-style 'relative)

;; Enable company mode
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)
(global-company-mode t)

;; See https://github.com/ethereum/emacs-solidity#local-variables
(add-hook 'solidity-mode-hook
    (lambda ()
    (set (make-local-variable 'company-backends)
        (append '((company-solidity company-capf company-dabbrev-code))
            company-backends))))

;; Override where the Org-Agenda is shown - Following was suggested by Henrik on
;; The Discord
(set! :popup "^\\*Org Agenda"
  '((slot . -1) (vslot . -1) (side . right) (size . 35))
  '((transient . 0)))

;; Following came from spacemacs configuration

;; See http://batsov.com/articles/2011/11/25/emacs-tip-number-3-whitespace-cleanup/
(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'prog-mode-hook (lambda () (whitespace-mode)))

;; Org-mode specific configurations
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/inbox.org")
               "* TODO %?\n%T\n")
              ("n" "note" entry (file"~/org/inbox.org")
               "* %? :NOTE:\n%T\n")
              ("m" "Meeting" entry (file"~/org/meetings.org")
               "* MEETING with %? :MEETING:\n%T" :clock-in t :clock-resume t)
              ("i" "Interview" entry (file"~/org/interviews.org")
               "* Interview with %? \n%T" :clock-in t :clock-resume t)
              )))

(setq org-journal-dir "~/org/journal/")
(setq org-agenda-files (quote
                        ("~/org/work.org"
                         "~/org/gtd/inbox.org"
                         "~/org/gtd/tickler.org"
                         "~/org/Orgzly/mobile.org"
                         "~/org/personal-todo.org"
                         )
                        ))
;; Ref: http://endlessparentheses.com/changing-the-org-mode-ellipsis.html
;; and https://github.com/hlissner/doom-emacs/issues/546#issuecomment-385151302
(setq org-ellipsis " ⤵")
;; Ref : https://thraxys.wordpress.com/2016/01/14/pimp-up-your-org-agenda/
(add-hook! :append org-load
  (setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "䷢ STARTED(s)"
                                      "|" "✔ DONE(d)")
                            (sequence "⚑ WAITING(w)" "|")
                            (sequence "|" "✘ CANCELED(c)")))
)
;; (setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE" "CANCELED"))`
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))
                           ("~/org/notes.org" . (:maxlevel . 6))
                           ("~/org/gtd/someday.org" . (:maxlevel . 6))
                           ("~/org/meetings.org" . (:maxlevel . 6))
                           ))
;; Don't want line break when adding a new heading
;; See http://irreal.org/blog/?p=6297
(setq org-M-RET-may-split-line '((default . nil)))

;; Setup org export behavior
(setq org-export-with-section-numbers nil)
(setq org-export-with-toc nil)

;; Agenda and todos in a sing;e buffer
;; Refer : https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((agenda "")
          (alltodo "")))))
