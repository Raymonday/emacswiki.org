;;; icicles.el --- Minibuffer input completion and cycling.
;;
;; Filename: icicles.el
;; Description: Minibuffer completion and cycling.
;; Author: Drew Adams
;; Maintainer: Drew Adams
;; Copyright (C) 1996-2011, Drew Adams, all rights reserved.
;; Created: Tue Aug  1 14:21:16 1995
;; Version: 22.0
;; Last-Updated: Sat Dec 24 10:58:41 2011 (-0800)
;;           By: dradams
;;     Update #: 23046
;; URL: http://www.emacswiki.org/cgi-bin/wiki/icicles.el
;; Keywords: extensions, help, abbrev, local, minibuffer,
;;           keys, apropos, completion, matching, regexp, command
;; Compatibility: GNU Emacs: 20.x, 21.x, 22.x, 23.x
;;
;; Features that might be required by this library:
;;
;;   `advice', `advice-preload', `apropos', `apropos+',
;;   `apropos-fn+var', `avoid', `backquote', `bookmark', `bookmark+',
;;   `bookmark+-1', `bookmark+-bmu', `bookmark+-key',
;;   `bookmark+-lit', `bookmark+-mac', `bytecomp', `cl', `cus-edit',
;;   `cus-face', `cus-load', `cus-start', `custom', `dired',
;;   `dired+', `dired-aux', `dired-x', `doremi', `easymenu',
;;   `ediff-diff', `ediff-help', `ediff-init', `ediff-merg',
;;   `ediff-mult', `ediff-util', `ediff-wind', `el-swank-fuzzy',
;;   `ffap', `ffap-', `fit-frame', `frame-cmds', `frame-fns',
;;   `fuzzy', `fuzzy-match', `help+20', `hexrgb', `icicles-cmd1',
;;   `icicles-cmd2', `icicles-face', `icicles-fn', `icicles-mcmd',
;;   `icicles-mode', `icicles-opt', `icicles-var', `image-dired',
;;   `info', `info+', `kmacro', `levenshtein', `menu-bar',
;;   `menu-bar+', `misc-cmds', `misc-fns', `mkhtml',
;;   `mkhtml-htmlize', `mouse3', `mwheel', `naked', `pp', `pp+',
;;   `regexp-opt', `ring', `ring+', `second-sel', `strings',
;;   `thingatpt', `thingatpt+', `unaccent', `w32-browser',
;;   `w32browser-dlgopen', `wid-edit', `wid-edit+', `widget'.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;  Minibuffer input completion and cycling of completion candidates.
;;
;;  Input completion takes as input a string and returns a name that
;;  contains the input string.  This library enables minibuffer
;;  cycling of completion candidates, and provides additional support
;;  for input completion.
;;
;;  Two kinds of completion are offered here, which are distinguished
;;  by how the input string is matched against the completed name:
;;
;;   - Prefix completion - The input string is a prefix of the
;;                         completed name.  This is the usual Emacs
;;                         completion.
;;
;;   - Apropos completion - The input string is a regular expression
;;                          that matches somewhere (anywhere) within
;;                          the completed name.  You can think of the
;;                          name as having been returned by `apropos'
;;                          (except it also works for file and buffer
;;                          names).
;;
;;  Files `icicles-doc1.el' and `icicles-doc2.el' contain the doc for
;;  Icicles, including how to install and use Icicles.  You can also
;;  read the Icicles doc, in formatted form, on the Emacs-Wiki Web
;;  site: http://www.emacswiki.org/cgi-bin/wiki/Icicles.  Emacs Wiki
;;  also has a few addtional pages about Icicles.  In particular, if
;;  you are new to Emacs, as well as Icicles, see this page:
;;  http://www.emacswiki.org/cgi-bin/wiki/EmacsNewbieWithIcicles.
;;
;;  See also: Library `lacarte.el', which lets you execute menu
;;  commands, cycling and completing them.  It is not part of Icicles,
;;  but it is greatly enhanced by Icicles.
 
;;(@> "Index")
;;
;;  Index
;;  -----
;;
;;  If you have library `linkd.el' and Emacs 22 or later, load
;;  `linkd.el' and turn on `linkd-mode' now.  It lets you easily
;;  navigate around the sections of this doc.  Linkd mode will
;;  highlight this Index, as well as the cross-references and section
;;  headings throughout this file.  You can get `linkd.el' here:
;;  http://dto.freeshell.org/notebook/Linkd.html.
;;
;;  (@> "Things Defined in Icicles")
;;  (@> "Miscellaneous")
 
;;(@* "Things Defined in Icicles")
;;
;;  Things Defined in Icicles
;;  -------------------------
;;
;;  Key bindings defined in Icicles: see (@> "Key Bindings"), below.
;;
;;  Macros defined in Icicles:
;;
;;    `icicle-buffer-bindings', `icicle-condition-case-no-debug',
;;    `icicle-define-add-to-alist-command',
;;    `icicle-define-bookmark-command',
;;    `icicle-define-bookmark-command-1',
;;    `icicle-define-bookmark-other-window-command',
;;    `icicle-define-command', `icicle-define-file-command',
;;    `icicle-define-search-bookmark-command',
;;    `icicle-define-sort-command', `icicle-file-bindings',
;;    `icicle-kbd', `icicle-maybe-byte-compile-after-load'
;;    `icicle-maybe-cached-action', `icicle-search-modes',
;;    `icicle-with-comments-hidden', `icicle-with-selected-window'.
;;
;;  Commands defined in Icicles -
;;
;;   Commands to be used mainly at top level:
;;
;;    `a', `any', `buffer', `clear-option',
;;    `cycle-icicle-image-file-thumbnail', `file',
;;    `icicle-add-buffer-candidate', `icicle-add-buffer-config',
;;    `icicle-add-entry-to-saved-completion-set',
;;    `icicle-add-file-to-fileset',
;;    `icicle-add/update-saved-completion-set', `icicle-anything',
;;    `icicle-apply' `icicle-apropos', `icicle-apropos-command',
;;    `icicle-apropos-function', `icicle-apropos-option',
;;    `icicle-apropos-variable', `icicle-apropos-zippy',
;;    `icicle-bbdb-complete-name', `icicle-bookmark',
;;    `icicle-bookmark-a-file', `icicle-bookmark-all-tags',
;;    `icicle-bookmark-all-tags-other-window',
;;    `icicle-bookmark-all-tags-regexp',
;;    `icicle-bookmark-all-tags-regexp-other-window',
;;    `icicle-bookmark-autofile',
;;    `icicle-bookmark-autofile-other-window',
;;    `icicle-bookmark-autonamed',
;;    `icicle-bookmark-autonamed-other-window',
;;    `icicle-bookmark-autonamed-this-buffer',
;;    `icicle-bookmark-autonamed-this-buffer-other-window',
;;    `icicle-bookmark-bookmark-file',
;;    `icicle-bookmark-bookmark-list', `icicle-bookmark-cmd',
;;    `icicle-bookmark-desktop', `icicle-bookmark-dired',
;;    `icicle-bookmark-dired-other-window',
;;    `icicle-bookmarked-buffer-list', `icicle-bookmarked-file-list',
;;    `icicle-bookmark-file', `icicle-bookmark-file-all-tags',
;;    `icicle-bookmark-file-all-tags-other-window',
;;    `icicle-bookmark-file-all-tags-regexp',
;;    `icicle-bookmark-file-all-tags-regexp-other-window',
;;    `icicle-bookmark-file-other-window',
;;    `icicle-bookmark-file-some-tags',
;;    `icicle-bookmark-file-some-tags-other-window',
;;    `icicle-bookmark-file-some-tags-regexp',
;;    `icicle-bookmark-file-some-tags-regexp-other-window',
;;    `icicle-bookmark-file-this-dir',
;;    `icicle-bookmark-file-this-dir-other-window',
;;    `icicle-bookmark-file-this-dir-all-tags',
;;    `icicle-bookmark-file-this-dir-all-tags-other-window',
;;    `icicle-bookmark-file-this-dir-all-tags-regexp',
;;    `icicle-bookmark-file-this-dir-all-tags-regexp-other-window',
;;    `icicle-bookmark-file-this-dir-some-tags',
;;    `icicle-bookmark-file-this-dir-some-tags-other-window',
;;    `icicle-bookmark-file-this-dir-some-tags-regexp',
;;    `icicle-bookmark-file-this-dir-some-tags-regexp-other-window',
;;    `icicle-bookmark-gnus', `icicle-bookmark-gnus-other-window',
;;    `icicle-bookmark-image', `icicle-bookmark-image-other-window',
;;    `icicle-bookmark-info', `icicle-bookmark-info-other-window',
;;    `icicle-bookmark-jump', `icicle-bookmark-jump-other-window',
;;    `icicle-bookmark-list', `icicle-bookmark-local-file',
;;    `icicle-bookmark-local-file-other-window',
;;    `icicle-bookmark-man', `icicle-bookmark-man-other-window',
;;    `icicle-bookmark-non-file',
;;    `icicle-bookmark-non-file-other-window',
;;    `icicle-bookmark-other-window', `icicle-bookmark-region',
;;    `icicle-bookmark-region-other-window',
;;    `icicle-bookmark-remote-file',
;;    `icicle-bookmark-remote-file-other-window',
;;    `icicle-bookmark-save-marked-files',
;;    `icicle-bookmark-save-marked-files-as-project',
;;    `icicle-bookmark-save-marked-files-more',
;;    `icicle-bookmark-save-marked-files-persistently',
;;    `icicle-bookmark-save-marked-files-to-variable',
;;    `icicle-bookmark-set', `icicle-bookmark-some-tags',
;;    `icicle-bookmark-some-tags-other-window',
;;    `icicle-bookmark-some-tags-regexp',
;;    `icicle-bookmark-some-tags-regexp-other-window',
;;    `icicle-bookmark-specific-buffers',
;;    `icicle-bookmark-specific-buffers-other-window',
;;    `icicle-bookmark-specific-files',
;;    `icicle-bookmark-specific-files-other-window',
;;    `icicle-bookmark-temporary',
;;    `icicle-bookmark-temporary-other-window',
;;    `icicle-bookmark-this-buffer',
;;    `icicle-bookmark-this-buffer-other-window',
;;    `icicle-bookmark-url', `icicle-bookmark-url-other-window'
;;    `icicle-bookmark-w3m-other-window', `icicle-buffer',
;;    `icicle-buffer-config', `icicle-buffer-list',
;;    `icicle-buffer-other-window',
;;    `icicle-change-alternative-sort-order',
;;    `icicle-change-history-variable', `icicle-choose-faces',
;;    `icicle-choose-invisible-faces', `icicle-choose-visible-faces',
;;    `icicle-clear-history', `icicle-clear-current-history',
;;    `icicle-color-theme', `icicle-comint-command',
;;    `icicle-comint-dynamic-complete',
;;    `icicle-comint-dynamic-complete-filename',
;;    `icicle-comint-replace-by-expanded-filename',
;;    `icicle-comint-search', `icicle-command-abbrev',
;;    `icicle-compilation-search', `icicle-complete-keys',
;;    `icicle-complete-thesaurus-entry', `icicle-completing-yank',
;;    `icicle-customize-apropos', `icicle-customize-apropos-faces',
;;    `icicle-customize-apropos-groups',
;;    `icicle-customize-apropos-options',
;;    `icicle-customize-apropos-options-of-type',
;;    `icicle-customize-face', `icicle-customize-icicles-group',
;;    `icicle-cycle-image-file-thumbnail',
;;    `icicle-dabbrev-completion', `icicle-delete-file',
;;    `icicle-delete-window', `icicle-delete-windows',
;;    `icicle-delete-windows-on', `icicle-describe-file',
;;    `icicle-describe-option-of-type', `icicle-describe-process',
;;    `icicle-directory-list', `icicle-dired',
;;    `icicle-dired-chosen-files',
;;    `icicle-dired-chosen-files-other-window',
;;    `icicle-dired-other-window', `icicle-dired-project',
;;    `icicle-dired-project-other-window',
;;    `icicle-dired-saved-file-candidates',
;;    `icicle-dired-saved-file-candidates-other-window',
;;    `icicle-dired-save-marked',
;;    `icicle-dired-save-marked-as-project',
;;    `icicle-dired-save-marked-more',
;;    `icicle-dired-save-marked-persistently',
;;    `icicle-dired-save-marked-to-variable', `icicle-doc',
;;    `icicle-doremi-candidate-width-factor+',
;;    `icicle-doremi-increment-max-candidates+',
;;    `icicle-doremi-increment-swank-prefix-length+',
;;    `icicle-doremi-increment-swank-timeout+',
;;    `icicle-doremi-increment-variable+',
;;    `icicle-doremi-inter-candidates-min-spaces+',
;;    `icicle-ess-complete-filename',
;;    `icicle-ess-complete-object-name',
;;    `icicle-ess-internal-complete-object-name',
;;    `icicle-ess-R-complete-object-name',
;;    `icicle-exchange-point-and-mark',
;;    `icicle-execute-extended-command',
;;    `icicle-execute-named-keyboard-macro', `icicle-face-list',
;;    `icicle-file', `icicle-file-list', `icicle-file-other-window',
;;    `icicle-find-file', `icicle-find-file-absolute',
;;    `icicle-find-file-absolute-other-window',
;;    `icicle-find-file-all-tags',
;;    `icicle-find-file-all-tags-other-window',
;;    `icicle-find-file-all-tags-regexp',
;;    `icicle-find-file-all-tags-regexp-other-window',
;;    `icicle-find-file-in-tags-table',
;;    `icicle-find-file-in-tags-table-other-window',
;;    `icicle-find-file-other-window', `icicle-find-file-read-only',
;;    `icicle-find-file-read-only-other-window',
;;    `icicle-find-file-some-tags',
;;    `icicle-find-file-some-tags-other-window',
;;    `icicle-find-file-some-tags-regexp',
;;    `icicle-find-file-some-tags-regexp-other-window',
;;    `icicle-find-file-tagged',
;;    `icicle-find-file-tagged-other-window', `icicle-find-first-tag',
;;    `icicle-find-first-tag-other-window', `icicle-find-tag',
;;    `icicle-font', `icicle-frame-bg', `icicle-frame-fg',
;;    `icicle-fundoc', `icicle-goto-global-marker',
;;    `icicle-goto-global-marker-or-pop-global-mark',
;;    `icicle-goto-marker', `icicle-goto-marker-or-set-mark-command',
;;    `icicle-grep-saved-file-candidates',
;;    `icicle-gud-gdb-complete-command', `icicle-handle-switch-frame',
;;    `icicle-hide-faces', `icicle-hide-only-faces',
;;    `icicle-hide/show-comments', `icicle-ido-like-mode',
;;    `icicle-imenu', `icicle-imenu-command',
;;    `icicle-imenu-command-full', `icicle-imenu-face-full',
;;    `icicle-imenu-face-full', `icicle-imenu-full',
;;    `icicle-imenu-key-explicit-map',
;;    `icicle-imenu-key-explicit-map-full',
;;    `icicle-imenu-key-implicit-map',
;;    `icicle-imenu-key-implicit-map-full', `icicle-imenu-macro',
;;    `icicle-imenu-macro-full',
;;    `icicle-imenu-non-interactive-function',
;;    `icicle-imenu-non-interactive-function-full',
;;    `icicle-imenu-user-option', `icicle-imenu-user-option-full',
;;    `icicle-imenu-variable', `icicle-imenu-variable-full',
;;    `icicle-increment-option', `icicle-increment-variable',
;;    `icicle-Info-goto-node', `icicle-Info-index',
;;    `icicle-Info-index-20', `icicle-Info-menu',
;;    `icicle-Info-virtual-book', `icicle-insert-buffer',
;;    `icicle-insert-thesaurus-entry', `icicle-keyword-list',
;;    `icicle-kill-buffer', `icicle-kmacro',
;;    `icicle-lisp-complete-symbol', `icicle-locate',
;;    `icicle-locate-file', `icicle-locate-file-no-symlinks',
;;    `icicle-locate-file-no-symlinks-other-window',
;;    `icicle-locate-file-other-window', `icicle-locate-other-window',
;;    `icicle-mode', `icy-mode', `icicle-next-visible-thing',
;;    `icicle-object-action', `icicle-occur',
;;    `icicle-other-window-or-frame', `icicle-pick-color-by-name',
;;    `icicle-plist', `icicle-pop-tag-mark',
;;    `icicle-pp-eval-expression', `icicle-previous-visible-thing',
;;    `icicle-read-color', `icicle-read-color-wysiwyg',
;;    `icicle-read-kbd-macro', `icicle-recent-file',
;;    `icicle-recent-file-other-window',
;;    `icicle-recompute-shell-command-candidates',
;;    `icicle-regexp-list', `icicle-remove-buffer-candidate',
;;    `icicle-remove-buffer-config',
;;    `icicle-remove-entry-from-saved-completion-set',
;;    `icicle-remove-file-from-recentf-list',
;;    `icicle-remove-saved-completion-set',
;;    `icicle-repeat-complex-command', `icicle-reset-option-to-nil',
;;    `icicle-resolve-file-name', `icicle-save-string-to-variable',
;;    `icicle-search', `icicle-search-all-tags-bookmark',
;;    `icicle-search-all-tags-regexp-bookmark',
;;    `icicle-search-autofile-bookmark',
;;    `icicle-search-autonamed-bookmark', `icicle-search-bookmark',
;;    `icicle-search-bookmark-list-bookmark',
;;    `icicle-search-bookmark-list-marked',
;;    `icicle-search-bookmarks-together', `icicle-search-buffer',
;;    `icicle-search-buff-menu-marked', `icicle-search-char-property',
;;    `icicle-search-defs', `icicle-search-defs-full',
;;    `icicle-search-desktop-bookmark',
;;    `icicle-search-dired-bookmark', `icicle-search-dired-marked',
;;    `icicle-search-file', `icicle-search-file-bookmark',
;;    `icicle-search-generic', `icicle-search-gnus-bookmark',
;;    `icicle-search-highlight-cleanup',
;;    `icicle-search-ibuffer-marked', `icicle-search-info-bookmark',
;;    `icicle-search-keywords', `icicle-search-lines',
;;    `icicle-search-local-file-bookmark',
;;    `icicle-search-man-bookmark', `icicle-search-non-file-bookmark',
;;    `icicle-search-overlay-property', `icicle-search-pages',
;;    `icicle-search-paragraphs', `icicle-search-region-bookmark',
;;    `icicle-search-remote-file-bookmark', `icicle-search-sentences',
;;    `icicle-search-some-tags-bookmark',
;;    `icicle-search-some-tags-regexp-bookmark',
;;    `icicle-search-specific-buffers-bookmark',
;;    `icicle-search-specific-files-bookmark',
;;    `icicle-search-temporary-bookmark',
;;    `icicle-search-text-property', `icicle-search-thing',
;;    `icicle-search-this-buffer-bookmark',
;;    `icicle-search-url-bookmark', `icicle-search-w3m-bookmark',
;;    `icicle-search-w-isearch-string', `icicle-search-word',
;;    `icicle-search-xml-element',
;;    `icicle-search-xml-element-text-node',
;;    `icicle-select-bookmarked-region', `icicle-select-frame',
;;    `icicle-select-frame-by-name', `icicle-select-window',
;;    `icicle-select-window-by-name', `icicle-send-bug-report',
;;    `icicle-send-signal-to-process', `icicle-set-option-to-t',
;;    `icicle-set-S-TAB-methods-for-command',
;;    `icicle-set-TAB-methods-for-command', `icicle-sexp-list',
;;    `icicle-shell-dynamic-complete-command',
;;    `icicle-shell-dynamic-complete-environment-variable',
;;    `icicle-shell-dynamic-complete-filename', `icicle-show-faces',
;;    `icicle-show-only-faces', `icicle-sit-for',
;;    `icicle-skip-this-command', `icicle-sort-alphabetical',
;;    `icicle-sort-by-abbrev-frequency',
;;    `icicle-sort-by-directories-first',
;;    `icicle-sort-by-directories-last', `icicle-sort-by-file-type.',
;;    `icicle-sort-by-last-file-modification-time',
;;    `icicle-sort-by-last-use-as-input',
;;    `icicle-sort-by-previous-use-alphabetically',
;;    `icicle-sort-by-2nd-parts-alphabetically',
;;    `icicle-sort-case-insensitive',
;;    `icicle-sort-extra-candidates-first',
;;    `icicle-sort-proxy-candidates-first',
;;    `icicle-sort-special-candidates-first',
;;    `icicle-sort-special-candidates-first',
;;    `icicle-sort-turned-OFF', `icicle-string-list',
;;    `icicle-synonyms', `icicle-tag-a-file', `icicle-tags-search',
;;    `icicle-toggle-~-for-home-dir',
;;    `icicle-toggle-alternative-sorting',
;;    `icicle-toggle-angle-brackets',
;;    `icicle-toggle-case-sensitivity', `icicle-toggle-C-for-actions',
;;    `icicle-toggle-hiding-common-match',
;;    `icicle-toggle-hiding-non-matching-lines',
;;    `icicle-toggle-highlight-all-current',
;;    `icicle-toggle-highlight-historical-candidates',
;;    `icicle-toggle-highlight-saved-candidates',
;;    `icicle-toggle-ignored-extensions',
;;    `icicle-toggle-ignored-space-prefix',
;;    `icicle-toggle-ignoring-comments',
;;    `icicle-toggle-incremental-completion',
;;    `icicle-toggle-literal-replacement', `icicle-toggle-option',
;;    `icicle-toggle-proxy-candidates', `icicle-toggle-regexp-quote',
;;    `icicle-toggle-remote-file-testing',
;;    `icicle-toggle-search-cleanup',
;;    `icicle-toggle-search-complementing-domain',
;;    `icicle-toggle-search-replace-whole',
;;    `icicle-toggle-search-whole-word', `icicle-toggle-sorting',
;;    `icicle-toggle-transforming',
;;    `icicle-toggle-WYSIWYG-Completions', `icicle-untag-a-file',
;;    `icicle-vardoc', `icicle-where-is',
;;    `icicle-yank-maybe-completing', `old-bbdb-complete-name',
;;    `old-comint-dynamic-complete',
;;    `old-comint-dynamic-complete-filename',
;;    `old-comint-replace-by-expanded-filename',
;;    `old-dired-read-shell-command', `old-ess-complete-object-name',
;;    `old-gud-gdb-complete-command', `old-read-shell-command',
;;    `orig-read-file-name', `toggle', `synonyms',
;;    `toggle-icicle-~-for-home-dir',
;;    `toggle-icicle-alternative-sorting',
;;    `toggle-icicle-angle-brackets',
;;    `toggle-icicle-case-sensitivity', `toggle-icicle-C-for-actions',
;;    `toggle-icicle-fuzzy-completion',
;;    `toggle-icicle-hiding-common-match',
;;    `toggle-icicle-hiding-non-matching-lines',
;;    `toggle-icicle-highlight-all-current',
;;    `toggle-icicle-highlight-historical-candidates',
;;    `toggle-icicle-highlight-saved-candidates',
;;    `toggle-icicle-ignored-extensions',
;;    `toggle-icicle-ignored-space-prefix',
;;    `toggle-icicle-incremental-completion',
;;    `toggle-icicle-literal-replacement',
;;    `toggle-icicle-proxy-candidates', `toggle-icicle-regexp-quote',
;;    `toggle-icicle-remote-file-testing',
;;    `toggle-icicle-search-cleanup',
;;    `toggle-icicle-search-complementing-domain',
;;    `toggle-icicle-search-replace-whole',
;;    `toggle-icicle-search-whole-word',
;;    `toggle-icicle-show-multi-completion', `toggle-icicle-sorting',
;;    `toggle-icicle-transforming',
;;    `toggle-icicle-WYSIWYG-Completions', `what-which-how'.
;;
;;   Commands to be used mainly in the minibuffer or `*Completions*':
;;
;;    `cycle-icicle-image-file-thumbnail',
;;    `icicle-abort-recursive-edit', `icicle-all-candidates-action',
;;    `icicle-all-candidates-alt-action',
;;    `icicle-all-candidates-list-action',
;;    `icicle-all-candidates-list-alt-action',
;;    `icicle-apropos-complete', `icicle-apropos-complete-and-exit',
;;    `icicle-apropos-complete-and-narrow',
;;    `icicle-apropos-complete-and-widen',
;;    `icicle-apropos-complete-no-display',
;;    `icicle-backward-char-dots',
;;    `icicle-backward-delete-char-untabify',
;;    `icicle-backward-kill-paragraph',
;;    `icicle-backward-kill-sentence', `icicle-backward-kill-sexp',
;;    `icicle-backward-kill-word', `icicle-beginning-of-line+',
;;    `icicle-bookmark-bookmark-file-narrow',
;;    `icicle-bookmark-bookmark-list-narrow',
;;    `icicle-bookmark-desktop-narrow',
;;    `icicle-bookmark-dired-narrow',`icicle-bookmark-file-narrow',
;;    `icicle-bookmark-gnus-narrow', `icicle-bookmark-info-narrow',
;;    `icicle-bookmark-local-file-narrow',
;;    `icicle-bookmark-man-narrow', `icicle-bookmark-non-file-narrow',
;;    `icicle-bookmark-region-narrow',
;;    `icicle-bookmark-remote-file-narrow',
;;    `icicle-bookmark-specific-buffers-narrow',
;;    `icicle-bookmark-specific-files-narrow',
;;    `icicle-bookmark-this-buffer-narrow',
;;    `icicle-bookmark-url-narrow', `icicle-bookmark-w3m-narrow',
;;    `icicle-candidate-action', `icicle-candidate-alt-action',
;;    `icicle-candidate-read-fn-invoke',
;;    `icicle-candidate-set-complement',
;;    `icicle-candidate-set-define',
;;    `icicle-candidate-set-difference',
;;    `icicle-candidate-set-intersection',
;;    `icicle-candidate-set-retrieve',
;;    `icicle-candidate-set-retrieve-from-variable',
;;    `icicle-candidate-set-retrieve-more',
;;    `icicle-candidate-set-retrieve-persistent',
;;    `icicle-candidate-set-save', `icicle-candidate-set-save-more',
;;    `icicle-candidate-set-save-more-selected',
;;    `icicle-candidate-set-save-persistently',
;;    `icicle-candidate-set-save-selected',
;;    `icicle-candidate-set-save-to-variable',
;;    `icicle-candidate-set-swap', `icicle-candidate-set-truncate',
;;    `icicle-candidate-set-union', `icicle-cd-for-abs-files',
;;    `icicle-cd-for-loc-files',
;;    `icicle-change-alternative-sort-order',
;;    `icicle-change-sort-order', `icicle-change-sort-order',
;;    `icicle-choose-completion', `icicle-clear-current-history',
;;    `icicle-completing-read+insert',
;;    `icicle-Completions-mouse-3-menu',
;;    `icicle-cycle-image-file-thumbnail',
;;    `icicle-search-define-replacement',
;;    `icicle-delete-backward-char', `icicle-delete-candidate-object',
;;    `icicle-delete-char', `icicle-digit-argument',
;;    `icicle-dispatch-C-^', `icicle-dispatch-C-.',
;;    `icicle-dispatch-C-x.', `icicle-dispatch-M-_',
;;    `icicle-dispatch-M-comma', `icicle-dispatch-M-q',
;;    `icicle-doremi-candidate-width-factor+',
;;    `icicle-doremi-increment-max-candidates+',
;;    `icicle-doremi-increment-swank-prefix-length+',
;;    `icicle-doremi-increment-swank-timeout+',
;;    `icicle-doremi-inter-candidates-min-spaces',
;;    `icicle-doremi-zoom-Completions+', `icicle-end-of-line+',
;;    `icicle-erase-minibuffer',
;;    `icicle-erase-minibuffer-or-history-element',
;;    `icicle-exit-minibuffer', `icicle-forward-char-dots',
;;    `icicle-goto/kill-failed-input', `icicle-help-on-candidate',
;;    `icicle-help-on-next-apropos-candidate',
;;    `icicle-help-on-next-prefix-candidate',
;;    `icicle-help-on-previous-apropos-candidate',
;;    `icicle-help-on-previous-prefix-candidate',
;;    `icicle-help-string-non-completion', `icicle-history',
;;    `icicle-bookmark-image-narrow', `icicle-insert-completion',
;;    `icicle-insert-dot-command', `icicle-insert-history-element',
;;    `icicle-insert-key-description',
;;    `icicle-insert-list-join-string',
;;    `icicle-insert-newline-in-minibuffer',
;;    `icicle-insert-string-at-point',
;;    `icicle-insert-string-from-variable', `icicle-isearch-complete',
;;    `icicle-keep-only-past-inputs', `icicle-kill-line',
;;    `icicle-kill-paragraph', `icicle-kill-region',
;;    `icicle-kill-region-wimpy', `icicle-kill-sentence',
;;    `icicle-kill-sexp', `icicle-kill-word', `icicle-make-directory',
;;    `icicle-minibuffer-complete-and-exit', `icicle-minibuffer-help',
;;    `icicle-mouse-candidate-action',
;;    `icicle-mouse-candidate-alt-action',
;;    `icicle-mouse-candidate-read-fn-invoke',
;;    `icicle-mouse-candidate-set-save',
;;    `icicle-mouse-candidate-set-save-more',
;;    `icicle-mouse-choose-completion',
;;    `icicle-mouse-help-on-candidate',
;;    `icicle-mouse-remove-candidate',
;;    `icicle-mouse-save/unsave-candidate',
;;    `icicle-mouse-save-then-kill', `icicle-mouse-yank-secondary',
;;    `icicle-move-to-next-completion',
;;    `icicle-move-to-previous-completion',
;;    `icicle-narrow-candidates',
;;    `icicle-narrow-candidates-with-predicate',
;;    `icicle-negative-argument', `icicle-next-apropos-candidate',
;;    `icicle-next-apropos-candidate-action',
;;    `icicle-next-apropos-candidate-alt-action',
;;    `icicle-next-candidate-per-mode',
;;    `icicle-next-candidate-per-mode-action',
;;    `icicle-next-candidate-per-mode-alt-action',
;;    `icicle-next-candidate-per-mode-help', `icicle-next-line',
;;    `icicle-next-prefix-candidate',
;;    `icicle-next-prefix-candidate-action',
;;    `icicle-next-prefix-candidate-alt-action',
;;    `icicle-next-S-TAB-completion-method', `icicle-other-history',
;;    `icicle-plus-saved-sort',
;;    `icicle-pp-eval-expression-in-minibuffer',
;;    `icicle-prefix-complete', `icicle-prefix-complete-no-display',
;;    `icicle-prefix-word-complete',
;;    `icicle-previous-apropos-candidate',
;;    `icicle-previous-apropos-candidate-action',
;;    `icicle-previous-apropos-candidate-alt-action',
;;    `icicle-previous-candidate-per-mode',
;;    `icicle-previous-candidate-per-mode-action',
;;    `icicle-previous-candidate-per-mode-alt-action',
;;    `icicle-previous-candidate-per-mode-help',
;;    `icicle-previous-line', `icicle-previous-prefix-candidate',
;;    `icicle-previous-prefix-candidate-action',
;;    `icicle-previous-prefix-candidate-alt-action',
;;    `icicle-read+insert-file-name', `icicle-regexp-quote-input',
;;    `icicle-remove-candidate', `icicle-remove-Completions-window',
;;    `icicle-resolve-file-name', `icicle-retrieve-last-input',
;;    `icicle-retrieve-next-input', `icicle-retrieve-previous-input',
;;    `icicle-reverse-sort-order',
;;    `icicle-save-predicate-to-variable',
;;    `icicle-save/unsave-candidate',
;;    `icicle-scroll-Completions-backward',
;;    `icicle-scroll-Completions-forward', `icicle-scroll-backward',
;;    `icicle-scroll-forward', `icicle-search-define-replacement',
;;    `icicle-self-insert', `icicle-sort-alphabetical',
;;    `icicle-sort-by-abbrev-frequency',
;;    `icicle-sort-by-directories-first',
;;    `icicle-sort-by-directories-last',
;;    `icicle-sort-by-last-file-modification-time',
;;    `icicle-sort-by-last-use-as-input',
;;    `icicle-sort-by-previous-use-alphabetically',
;;    `icicle-sort-case-insensitive',
;;    `icicle-sort-proxy-candidates-first', `icicle-sort-turned-OFF',
;;    `icicle-switch-to-Completions-buf',
;;    `icicle-switch-to-completions',
;;    `icicle-switch-to/from-minibuffer', `icicle-toggle-.',
;;    `icicle-toggle-~-for-home-dir', `icicle-toggle-C-for-actions',
;;    `icicle-toggle-alternative-sorting',
;;    `icicle-toggle-angle-brackets',
;;    `icicle-toggle-case-sensitivity', `icicle-toggle-dot',
;;    `icicle-toggle-expand-to-common-match',
;;    `icicle-toggle-hiding-common-match',
;;    `icicle-toggle-hiding-non-matching-lines',
;;    `icicle-toggle-highlight-all-current',
;;    `icicle-toggle-highlight-historical-candidates',
;;    `icicle-toggle-highlight-saved-candidates',
;;    `icicle-toggle-ignored-extensions',
;;    `icicle-toggle-ignored-space-prefix',
;;    `icicle-toggle-ignoring-comments',
;;    `icicle-toggle-incremental-completion',
;;    `icicle-toggle-literal-replacement',
;;    `icicle-toggle-proxy-candidates', `icicle-toggle-regexp-quote',
;;    `icicle-toggle-search-cleanup',
;;    `icicle-toggle-search-complementing-domain',
;;    `icicle-toggle-search-replace-common-match',
;;    `icicle-toggle-search-replace-whole',
;;    `icicle-toggle-search-whole-word',
;;    `icicle-toggle-show-multi-completion', `icicle-toggle-sorting',
;;    `icicle-toggle-transforming', `icicle-transpose-chars',
;;    `icicle-transpose-sexps', `icicle-transpose-words',
;;    `icicle-universal-argument', `icicle-universal-argument-minus',
;;    `icicle-universal-argument-more',
;;    `icicle-universal-argument-other-key', `icicle-up-directory',
;;    `icicle-use-interactive-command-history',
;;    `icicle-widen-candidates', `icicle-yank', `icicle-yank-pop',
;;    `icicle-yank-secondary', `old-choose-completion',
;;    `old-exit-minibuffer', `old-minibuffer-complete-and-exit',
;;    `old-sit-for', `old-switch-to-completions', `toggle-icicle-.',
;;    `toggle-icicle-~-for-home-dir', `toggle-icicle-C-for-actions',
;;    `toggle-icicle-alternative-sorting',
;;    `toggle-icicle-angle-brackets',
;;    `toggle-icicle-case-sensitivity', `toggle-icicle-dot',
;;    `toggle-icicle-expand-to-common-match',
;;    `toggle-icicle-fuzzy-completion',
;;    `toggle-icicle-hiding-common-match',
;;    `toggle-icicle-hiding-non-matching-lines',
;;    `toggle-icicle-highlight-all-current',
;;    `toggle-icicle-highlight-historical-candidates',
;;    `toggle-icicle-ignored-extensions',
;;    `toggle-icicle-ignored-space-prefix',
;;    `toggle-icicle-incremental-completion',
;;    `toggle-icicle-literal-replacement',
;;    `toggle-icicle-proxy-candidates', `toggle-icicle-regexp-quote',
;;    `toggle-icicle-search-cleanup',
;;    `toggle-icicle-search-complementing-domain',
;;    `toggle-icicle-search-replace-common-match',
;;    `toggle-icicle-search-replace-whole',
;;    `toggle-icicle-search-whole-word', `toggle-icicle-sorting',
;;    `toggle-icicle-transforming'.
;;
;;  Faces defined in Icicles (in Custom group `icicles'):
;;
;;    `icicle-candidate-part',
;;    `icicle-common-match-highlight-Completions',
;;    `icicle-complete-input', `icicle-completion',
;;    `icicle-Completions-instruction-1',
;;    `icicle-Completions-instruction-2',
;;    `icicle-current-candidate-highlight', `icicle-extra-candidate',
;;    `icicle-historical-candidate', `icicle-input-completion-fail',
;;    `icicle-input-completion-fail-lax',
;;    `icicle-match-highlight-Completions',
;;    `icicle-match-highlight-minibuffer', `icicle-mode-line-help',
;;    `icicle-msg-emphasis', `icicle-multi-command-completion',
;;    `icicle-mustmatch-completion', `icicle-proxy-candidate',
;;    `icicle-saved-candidate', `icicle-search-context-level-1',
;;    `icicle-search-context-level-2',
;;    `icicle-search-context-level-3',
;;    `icicle-search-context-level-4',
;;    `icicle-search-context-level-5',
;;    `icicle-search-context-level-6',
;;    `icicle-search-context-level-7',
;;    `icicle-search-context-level-8', `icicle-search-current-input',
;;    `icicle-search-main-regexp-current',
;;    `icicle-search-main-regexp-others', `icicle-special-candidate',
;;    `icicle-whitespace-highlight', `minibuffer-prompt'.
;;
;;  User options defined in Icicles:
;;
;;    `icicle-act-before-cycle-flag',
;;    `icicle-add-proxy-candidates-flag',
;;    `icicle-alternative-actions-alist',
;;    `icicle-alternative-sort-comparer',
;;    `icicle-anything-transform-candidates-flag',
;;    `icicle-apropos-complete-keys',
;;    `icicle-apropos-complete-no-display-keys',
;;    `icicle-apropos-cycle-next-keys',
;;    `icicle-apropos-cycle-next-action-keys',
;;    `icicle-apropos-cycle-next-alt-action-keys',
;;    `icicle-apropos-cycle-next-help-keys',
;;    `icicle-apropos-cycle-previous-keys',
;;    `icicle-apropos-cycle-previous-action-keys',
;;    `icicle-apropos-cycle-previous-alt-action-keys',
;;    `icicle-apropos-cycle-previous-help-keys',
;;    `icicle-bookmark-name-length-max',
;;    `icicle-bookmark-refresh-cache-flag', `icicle-buffer-configs',
;;    `icicle-buffer-extras',
;;    `icicle-buffer-ignore-space-prefix-flag',
;;    `icicle-buffer-match-regexp', `icicle-buffer-no-match-regexp',
;;    `icicle-buffer-predicate', `icicle-buffer-require-match-flag'
;;    `icicle-buffer-sort', `icicle-buffers-ido-like-flag',
;;    `icicle-byte-compile-eval-after-load-flag',
;;    `icicle-candidate-action-keys', `icicle-candidate-help-keys',
;;    `icicle-candidate-width-factor',
;;    `icicle-change-region-background-flag',
;;    `icicle-change-sort-order-completion-flag',
;;    `icicle-C-l-uses-completion-flag', `icicle-color-themes',
;;    `icicle-comint-dynamic-complete-replacements',
;;    `icicle-command-abbrev-alist',
;;    `icicle-command-abbrev-match-all-parts-flag',
;;    `icicle-command-abbrev-priority-flag',
;;    `icicle-complete-key-anyway-flag',
;;    `icicle-complete-keys-self-insert-ranges',
;;    `icicle-completing-read+insert-keys',
;;    `icicle-completion-history-max-length',
;;    `icicle-Completions-display-min-input-chars',
;;    `icicle-completions-format',
;;    `icicle-Completions-mouse-3-menu-entries',
;;    `icicle-Completions-max-columns',
;;    `icicle-Completions-text-scale-decrease',
;;    `icicle-Completions-window-max-height',
;;    `icicle-customize-save-flag',
;;    `icicle-customize-save-variable-function',
;;    `icicle-cycle-into-subdirs-flag', `icicle-default-cycling-mode',
;;    `icicle-default-thing-insertion', `icicle-default-value',
;;    `icicle-define-alias-commands-flag',
;;    `icicle-deletion-action-flag', `icicle-dot-show-regexp-flag',
;;    `icicle-dot-string', `icicle-expand-input-to-common-match-flag',
;;    `icicle-file-extras', `icicle-file-match-regexp',
;;    `icicle-file-no-match-regexp', `icicle-file-predicate',
;;    `icicle-file-require-match-flag', `icicle-file-sort',
;;    `icicle-files-ido-like-flag',
;;    `icicle-filesets-as-saved-completion-sets-flag',
;;    `icicle-functions-to-redefine', `icicle-guess-commands-in-path',
;;    `icicle-help-in-mode-line-delay',
;;    `icicle-hide-common-match-in-Completions-flag',
;;    `icicle-hide-non-matching-lines-flag',
;;    `icicle-highlight-historical-candidates-flag',
;;    `icicle-highlight-input-completion-failure',
;;    `icicle-highlight-input-completion-failure-delay',
;;    `icicle-highlight-input-completion-failure-threshold',
;;    `icicle-highlight-input-initial-whitespace-flag',
;;    `icicle-highlight-lighter-flag',
;;    `icicle-highlight-saved-candidates-flag',
;;    `icicle-ignore-comments-flag', `icicle-ignored-directories',
;;    `icicle-ignore-space-prefix-flag',
;;    `icicle-image-files-in-Completions',
;;    `icicle-incremental-completion-delay',
;;    `icicle-incremental-completion-flag',
;;    `icicle-incremental-completion-threshold',
;;    `icicle-inhibit-advice-functions', `icicle-inhibit-ding-flag',
;;    `icicle-input-string', `icicle-inter-candidates-min-spaces',
;;    `icicle-isearch-complete-keys', `icicle-key-complete-keys',
;;    `icicle-key-descriptions-use-<>-flag',
;;    `icicle-key-descriptions-use-angle-brackets-flag',
;;    `icicle-keymaps-for-key-completion', `icicle-kmacro-ring-max',
;;    `icicle-levenshtein-distance', `icicle-list-join-string',
;;    `icicle-list-nth-parts-join-string',
;;    `icicle-mark-position-in-candidate', `icicle-max-candidates',
;;    `icicle-menu-items-to-history-flag',
;;    `icicle-minibuffer-setup-hook', `icicle-modal-cycle-down-keys',
;;    `icicle-modal-cycle-down-action-keys',
;;    `icicle-modal-cycle-down-alt-action-keys',
;;    `icicle-modal-cycle-down-help-keys',
;;    `icicle-modal-cycle-up-keys',
;;    `icicle-modal-cycle-up-action-keys',
;;    `icicle-modal-cycle-up-alt-action-keys',
;;    `icicle-modal-cycle-up-help-keys', `icicle-mode',
;;    `icicle-mode-hook', `icicle-move-Completions-frame',
;;    `icicle-no-match-hook', `icicle-option-type-prefix-arg-list',
;;    `icicle-point-position-in-candidate',
;;    `icicle-populate-interactive-history-flag',
;;    `icicle-pp-eval-expression-print-length',
;;    `icicle-pp-eval-expression-print-level',
;;    `icicle-prefix-complete-keys',
;;    `icicle-prefix-complete-no-display-keys',
;;    `icicle-prefix-cycle-next-keys',
;;    `icicle-prefix-cycle-next-action-keys',
;;    `icicle-prefix-cycle-next-alt-action-keys',
;;    `icicle-prefix-cycle-next-help-keys',
;;    `icicle-prefix-cycle-previous-keys',
;;    `icicle-prefix-cycle-previous-action-keys',
;;    `icicle-prefix-cycle-previous-alt-action-keys',
;;    `icicle-prefix-cycle-previous-help-keys',
;;    `icicle-previous-candidate-keys',
;;    `icicle-quote-shell-file-name-flag',
;;    `icicle-read+insert-file-name-keys', `icicle-recenter',
;;    `icicle-regexp-quote-flag', `icicle-regexp-search-ring-max',
;;    `icicle-region-background', `icicle-require-match-flag',
;;    `icicle-saved-completion-sets', `icicle-search-cleanup-flag',
;;    `icicle-search-from-isearch-keys',
;;    `icicle-search-highlight-all-current-flag',
;;    `icicle-search-highlight-context-levels-flag',
;;    `icicle-search-highlight-threshold', `icicle-search-hook',
;;    `icicle-search-key-prefix',
;;    `icicle-search-replace-common-match-flag',
;;    `icicle-search-replace-literally-flag',
;;    `icicle-search-replace-whole-candidate-flag',
;;    `icicle-search-ring-max', `icicle-search-whole-word-flag',
;;    `icicle-shell-command-candidates-cache',
;;    `icicle-show-Completions-help-flag',
;;    `icicle-show-Completions-initially-flag',
;;    `icicle-show-multi-completion-flag', `icicle-sort-comparer',
;;    `icicle-sort-orders-alist', `icicle-special-candidate-regexp',
;;    `icicle-S-TAB-completion-methods-alist',
;;    `icicle-S-TAB-completion-methods-per-command',
;;    `icicle-swank-prefix-length', `icicle-swank-timeout',
;;    `icicle-TAB-completion-methods',
;;    `icicle-TAB-completion-methods-per-command',
;;    `icicle-TAB-shows-candidates-flag',
;;    `icicle-test-for-remote-files-flag',
;;    `icicle-thing-at-point-functions',
;;    `icicle-top-level-key-bindings',
;;    `icicle-top-level-when-sole-completion-delay',
;;    `icicle-top-level-when-sole-completion-flag',
;;    `icicle-touche-pas-aux-menus-flag', `icicle-transform-function',
;;    `icicle-type-actions-alist',
;;    `icicle-unpropertize-completion-result-flag',
;;    `icicle-update-input-hook', `icicle-use-~-for-home-dir-flag',
;;    `icicle-use-C-for-actions-flag',
;;    `icicle-use-anything-candidates-flag',
;;    `icicle-use-candidates-only-once-flag',
;;    `icicle-word-completion-keys',
;;    `icicle-WYSIWYG-Completions-flag', `icicle-yank-function'.
;;
;;  Non-interactive functions in Icicles:
;;
;;    `custom-variable-p', `icicle-2nd-part-string-less-p',
;;    `icicle-abbreviate-or-expand-file-name', `icicle-activate-mark',
;;    `icicle-add-key+cmd', `icicle-add-menu-item-to-cmd-history',
;;    `icicle-add/remove-tags-and-refresh',
;;    `icicle-all-candidates-action-1', `icicle-all-completions',
;;    `icicle-all-exif-data', `icicle-alpha-p',
;;    `icicle-alt-act-fn-for-type', `icicle-any-candidates-p',
;;    `icicle-anychar-regexp', `icicle-anything-candidate-value',
;;    `icicle-apply-action', `icicle-apply-list-action',
;;    `icicle-apply-to-saved-candidate',
;;    `icicle-apropos-any-candidates-p',
;;    `icicle-apropos-any-file-name-candidates-p',
;;    `icicle-apropos-candidates', `icicle-apropos-complete-1',
;;    `icicle-backward-delete-char-untabify-dots',
;;    `icicle-barf-if-outside-Completions',
;;    `icicle-barf-if-outside-Completions-and-minibuffer',
;;    `icicle-barf-if-outside-minibuffer', `icicle-binary-option-p',
;;    `icicle-bind-completion-keys',
;;    `icicle-bind-file-candidate-keys', `icicle-bind-isearch-keys',
;;    `icicle-bind-key-completion-keys-for-map-var',
;;    `icicle-bind-key-completion-keys-in-keymaps-from',
;;    `icicle-bind-other-keymap-keys',
;;    `icicle-bind-top-level-commands', `icicle-bookmark-cleanup',
;;    `icicle-bookmark-cleanup-on-quit',
;;    `icicle-bookmark-delete-action', `icicle-bookmark-help-string',
;;    `icicle-bookmark-jump-1',
;;    `icicle-buffer-file/process-name-less-p',
;;    `icicle-buffer-smaller-p', `icicle-buffer-sort-*...*-last',
;;    `icicle-call-then-update-Completions',
;;    `icicle-cancel-Help-redirection', `icicle-candidate-action-1',
;;    `icicle-candidate-set-1', `icicle-candidate-set-retrieve-1',
;;    `icicle-candidate-set-save-1',
;;    `icicle-candidate-set-save-selected-1',
;;    `icicle-candidate-short-help',
;;    `icicle-case-insensitive-string-less-p',
;;    `icicle-case-string-less-p', `icicle-cdr-lessp',
;;    `icicle-char-properties-in-buffer',
;;    `icicle-char-properties-in-buffers',
;;    `icicle-choose-anything-candidate',
;;    `icicle-choose-candidate-of-type',
;;    `icicle-choose-completion-string', `icicle-clear-history-1',
;;    `icicle-clear-history-entry', `icicle-clear-lighter',
;;    `icicle-clear-minibuffer', `icicle-cmd2-after-load-bookmark+',
;;    `icicle-cmd2-after-load-hexrgb',
;;    `icicle-cmd2-after-load-highlight',
;;    `icicle-cmd2-after-load-palette',
;;    `icicle-cmd2-after-load-synonyms', `icicle-color-blue-lessp',
;;    `icicle-color-completion-setup',
;;    `icicle-color-distance-hsv-lessp',
;;    `icicle-color-distance-rgb-lessp', `icicle-color-green-lessp',
;;    `icicle-color-help', `icicle-color-hsv-lessp',
;;    `icicle-color-hue-lessp', `icicle-color-name-w-bg',
;;    `icicle-color-red-lessp', `icicle-color-saturation-lessp',
;;    `icicle-color-value-lessp', `icicle-column-wise-cand-nb',
;;    `icicle-Completions-popup-choice',
;;    `icicle-Completions-popup-choice-1',
;;    `icicle-comint-dynamic-complete-as-filename',
;;    `icicle-comint-dynamic-simple-complete',
;;    `icicle-comint-hook-fn',
;;    `icicle-comint-replace-orig-completion-fns',
;;    `icicle-comint-search-get-final-choice',
;;    `icicle-comint-search-get-minibuffer-input',
;;    `icicle-comint-search-send-input',
;;    `icicle-command-abbrev-action', `icicle-command-abbrev-command',
;;    `icicle-command-abbrev-matching-commands',
;;    `icicle-command-abbrev-record', `icicle-command-abbrev-regexp',
;;    `icicle-command-abbrev-save',
;;    `icicle-command-abbrev-used-more-p',
;;    `icicle-command-names-alphabetic-p',
;;    `icicle-compilation-hook-fn',
;;    `icicle-compilation-search-in-context-fn',
;;    `icicle-complete-again-update', `icicle-complete-keys-1',
;;    `icicle-complete-keys-action', `icicle-completing-p',
;;    `icicle-completing-read', , `icicle-completing-read-multiple',
;;    `icicle-completing-read-history',
;;    `icicle-completion-all-completions',
;;    `icicle-completion-setup-function',
;;    `icicle-completion-try-completion',
;;    `icicle-compute-shell-command-candidates',
;;    `icicle-convert-dots',
;;    `icicle-current-completion-in-Completions',
;;    `icicle-current-sort-functions', `icicle-current-sort-order',
;;    `icicle-current-TAB-method', `icicle-customize-faces',
;;    `icicle-custom-type', `icicle-dabbrev--abbrev-at-point',
;;    `icicle-default-buffer-names',
;;    `icicle-define-crm-completion-map', ,
;;    `icicle-define-cycling-keys', `icicle-defined-thing-p',
;;    `icicle-define-icicle-maps', `icicle-define-minibuffer-maps',
;;    `icicle-delete-alist-dups', `icicle-delete-backward-char-dots',
;;    `icicle-delete-candidate-object-1', `icicle-delete-char-dots',
;;    `icicle-delete-count', `icicle-delete-current-candidate-object',
;;    `icicle-delete-dups', `icicle-delete-file-or-directory',
;;    `icicle-delete-whitespace-from-string',
;;    `icicle-describe-opt-action',
;;    `icicle-describe-opt-of-type-complete', `icicle-ding',
;;    `icicle-dired-read-shell-command',
;;    `icicle-dired-smart-shell-command',
;;    `icicle-dir-prefix-wo-wildcards', `icicle-dirs-first-p',
;;    `icicle-dirs-last-p', `icicle-displayable-cand-from-saved-set',
;;    `icicle-display-cand-from-full-cand',
;;    `icicle-display-completion-list', `icicle-display-Completions',
;;    `icicle-display-candidates-in-Completions', `icicle-doc-action',
;;    `icicle-edmacro-parse-keys',
;;    `icicle-ensure-overriding-map-is-bound',
;;    `icicle-execute-extended-command-1',
;;    `icicle-expanded-common-match',
;;    `icicle-expanded-common-match-1', `icicle-expand-file-name-20',
;;    `icicle-expand-file-or-dir-name',
;;    `icicle-explicit-saved-completion-candidates', `icicle-explore',
;;    `icicle-extra-candidates-first-p',
;;    `icicle-face-after-load-hexrgb',
;;    `icicle-face-valid-attribute-values', `icicle-file-directory-p',
;;    `icicle-file-name-apropos-candidates',
;;    `icicle-file-name-directory',
;;    `icicle-file-name-directory-w-default',
;;    `icicle-file-name-input-p', `icicle-file-name-nondirectory',
;;    `icicle-file-name-prefix-candidates', `icicle-file-readable-p',
;;    `icicle-file-remote-p', `icicle-file-type-less-p',
;;    `icicle-file-writable-p', `icicle-filesets-files-under',
;;    `icicle-files-within', `icicle-files-within-1',
;;    `icicle-filter-alist', `icicle-filter-wo-input',
;;    `icicle-find-first-tag-action',
;;    `icicle-find-first-tag-other-window-action',
;;    `icicle-find-tag-action', `icicle-find-tag-define-candidates',
;;    `icicle-find-tag-define-candidates-1',
;;    `icicle-find-tag-final-act', `icicle-find-tag-help',
;;    `icicle-find-tag-quit-or-error',
;;    `icicle-first-matching-candidate', `icicle-first-N',
;;    `icicle-fit-completions-window', `icicle-fix-default-directory',
;;    `icicle-flat-list', `icicle-fn-doc-minus-sig',
;;    `icicle-font-w-orig-size', `icicle-frame-name-history',
;;    `icicle-frames-on', `icicle-function-name-history',
;;    `icicle-fuzzy-candidates', `icicle-get-alist-candidate',
;;    `icicle-get-anything-actions-for-type',
;;    `icicle-get-anything-cached-candidates',
;;    `icicle-get-anything-candidates',
;;    `icicle-get-anything-candidates-of-type',
;;    `icicle-get-anything-default-actions-for-type',
;;    `icicle-get-anything-input-delay',
;;    `icicle-get-anything-req-pat-chars',
;;    `icicle-get-anything-types',
;;    `icicle-get-candidates-from-saved-set', `icicle-goto-marker-1',
;;    `icicle-goto-marker-1-action', `icicle-group-regexp',
;;    `icicle-dired-guess-shell-command',
;;    `icicle-help-on-candidate-symbol', `icicle-help-line-buffer',
;;    `icicle-help-line-file', `icicle-help-string-completion',
;;    `icicle-highlight-candidate-in-Completions',
;;    `icicle-highlight-complete-input',
;;    `icicle-highlight-initial-whitespace',
;;    `icicle-highlight-input-noncompletion',
;;    `icicle-highlight-input-noncompletion-rest',
;;    `icicle-highlight-lighter', `icicle-historical-alphabetic-p',
;;    `icicle-imenu-command-p', `icicle-imenu-in-buffer-p',
;;    `icicle-imenu-non-interactive-function-p',
;;    `icicle-increment-cand-nb+signal-end',
;;    `icicle-increment-color-hue', `icicle-increment-color-value',
;;    `icicle-Info-book-order-p',
;;    `icicle-Info-build-node-completions',
;;    `icicle-Info-build-node-completions-1',
;;    `icicle-Info-goto-node-1', `icicle-Info-goto-node-action',
;;    `icicle-Info-index-action', `icicle-Info-read-node-name',
;;    `icicle-input-from-minibuffer',
;;    `icicle-input-is-a-completion-p', `icicle-insert-candidates',
;;    `icicle-insert-cand-in-minibuffer',
;;    `icicle-insert-Completions-help-string', `icicle-insert-dot',
;;    `icicle-insert-for-yank', `icicle-insert-input',
;;    `icicle-insert-thesaurus-entry-cand-fn', `icicle-insert-thing',
;;    `icicle-invisible-face-p', `icicle-invisible-p',
;;    `icicle-isearch-complete-past-string', `icicle-join-nth-parts',
;;    `icicle-key-description', `icicle-keys+cmds-w-prefix',
;;    `icicle-kill-a-buffer',
;;    `icicle-kill-a-buffer-and-update-completions',
;;    `icicle-kmacro-action', `icicle-last-modified-first-p',
;;    `icicle-levenshtein-match', `icicle-levenshtein-one-match',
;;    `icicle-levenshtein-one-regexp',
;;    `icicle-levenshtein-strict-match',
;;    `icicle-lisp-completion-at-point',
;;    `icicle-lisp-vanilla-completing-read',
;;    `icicle-local-keys-first-p', `icicle-locate-file-1',
;;    `icicle-locate-file-action',
;;    `icicle-locate-file-other-window-action',
;;    `icicle-locate-file-use-locate-p',
;;    `icicle-looking-at-anychar-regexp-p',
;;    `icicle-looking-back-at-anychar-regexp-p',
;;    `icicle-major-mode-name-less-p', `icicle-make-color-candidate',
;;    `icicle-make-face-candidate', `icicle-make-frame-alist',
;;    `icicle-make-plain-predicate', `icicle-make-window-alist',
;;    `icicle-markers', `icicle-markers-to-readable',
;;    `icicle-marker+text',
;;    `icicle-maybe-multi-completion-completing-p',
;;    `icicle-maybe-sort-and-strip-candidates',
;;    `icicle-maybe-sort-maybe-truncate', `icicle-mctize-all',
;;    `icicle-mctized-display-candidate',
;;    `icicle-mctized-full-candidate',
;;    `icicle-merge-saved-order-less-p',
;;    `icicle-minibuffer-default-add-completions',
;;    `icicle-minibuf-input', `icicle-minibuf-input-sans-dir',
;;    `icicle-minibuffer-default-add-dired-shell-commands',
;;    `icicle-minibuffer-prompt-end', `icicle-minibuffer-setup',
;;    `icicle-mode-line-name-less-p', `icicle-most-recent-first-p',
;;    `icicle-mouse-candidate-action-1',
;;    `icicle-msg-maybe-in-minibuffer', `icicle-ms-windows-NET-USE',
;;    `icicle-multi-sort', `icicle-nb-Completions-cols',
;;    `icicle-nb-of-cand-at-Completions-pos',
;;    `icicle-nb-of-cand-in-Completions-horiz',
;;    `icicle-next-candidate',
;;    `icicle-next-single-char-property-change',
;;    `icicle-next-visible-thing-1', `icicle-next-visible-thing-2',
;;    `icicle-next-visible-thing-and-bounds',
;;    `icicle-non-whitespace-string-p',
;;    `icicle-not-basic-prefix-completion-p',
;;    `icicle-part-1-cdr-lessp', `icicle-part-1-lessp',
;;    `icicle-part-2-lessp', `icicle-part-3-lessp',
;;    `icicle-part-4-lessp', `icicle-part-N-lessp',
;;    `icicle-pick-color-by-name-action', `icicle-place-cursor',
;;    `icicle-place-overlay', `icicle-position',
;;    `icicle-prefix-any-candidates-p',
;;    `icicle-prefix-any-file-name-candidates-p',
;;    `icicle-prefix-candidates', `icicle-prefix-complete-1',
;;    `icicle-prefix-keys-first-p',
;;    `icicle-previous-single-char-property-change',
;;    `icicle-propertize', `icicle-proxy-candidate-first-p',
;;    `icicle-put-at-head', `icicle-put-whole-cand-prop',
;;    `icicle-quote-file-name-part-of-cmd',
;;    `icicle-raise-Completions-frame', `icicle-readable-to-markers',
;;    `icicle-read-args-for-set-completion-methods',
;;    `icicle-read-char-exclusive', `icicle-read-char-by-name',
;;    `icicle-read-face-name', `icicle-read-file-name',
;;    `icicle-read-from-minibuffer',
;;    `icicle-read-from-minibuf-nil-default', `icicle-read-number',
;;    `icicle-read-shell-command',
;;    `icicle-read-shell-command-completing', `icicle-read-string',
;;    `icicle-read-string-completing',
;;    `icicle-read-var-value-satisfying', `icicle-rebind-global',
;;    `icicle-recentf-make-menu-items', `icicle-recompute-candidates',
;;    `icicle-redefine-standard-functions',
;;    `icicle-redefine-standard-options',
;;    `icicle-redefine-std-completion-fns',
;;    `icicle-region-or-buffer-limits', `icicle-remap',
;;    `icicle-remove-buffer-candidate-action',
;;    `icicle-remove-buffer-config-action',
;;    `icicle-remove-cand-from-lists',
;;    `icicle-remove-candidate-display-others',
;;    `icicle-remove-color-duplicates', `icicle-remove-dots',
;;    `icicle-remove-duplicates', `icicle-remove-dups-if-extras',
;;    `icicle-remove-from-recentf-candidate-action',
;;    `icicle-remove-if', `icicle-remove-if-not',
;;    `icicle-remove-property', `icicle-replace-mct-cand-in-mct',
;;    `icicle-remove-saved-set-action',
;;    `icicle-replace-input-w-parent-dir', `icicle-require-match-p',
;;    `icicle-restore-completion-keys',
;;    `icicle-restore-other-keymap-keys',
;;    `icicle-restore-region-face',
;;    `icicle-restore-standard-commands',
;;    `icicle-restore-standard-options',
;;    `icicle-restore-std-completion-fns',
;;    `icicle-retrieve-candidates-from-set', `icicle-reversible-sort',
;;    `icicle-row-wise-cand-nb',
;;    `icicle-run-icicle-post-command-hook',
;;    `icicle-run-icicle-pre-command-hook', `icicle-saved-fileset-p',
;;    `icicle-save-or-restore-input', `icicle-save-raw-input',
;;    `icicle-scatter', `icicle-scatter-match',
;;    `icicle-scroll-or-update-Completions', `icicle-search-action',
;;    `icicle-search-action-1', `icicle-search-bookmark-action',
;;    `icicle-search-char-property-scan',
;;    `icicle-search-char-prop-matches-p',
;;    `icicle-search-choose-buffers', `icicle-search-cleanup',
;;    `icicle-search-define-candidates',
;;    `icicle-search-define-candidates-1', `icicle-search-final-act',
;;    `icicle-search-help',
;;    `icicle-search-highlight-all-input-matches',
;;    `icicle-search-highlight-and-maybe-replace',
;;    `icicle-search-highlight-input-matches-here',
;;    `icicle-search-in-context-default-fn',
;;    `icicle-search-property-args',
;;    `icicle-search-property-default-match-fn',
;;    `icicle-search-quit-or-error',
;;    `icicle-search-read-context-regexp', `icicle-search-read-word',
;;    `icicle-search-regexp-scan',
;;    `icicle-search-replace-all-search-hits',
;;    `icicle-search-replace-cand-in-alist',
;;    `icicle-search-replace-cand-in-mct',
;;    `icicle-search-replace-fixed-case-p',
;;    `icicle-search-replace-match', `icicle-search-thing-args',
;;    `icicle-search-thing-scan', `icicle-search-where-arg',
;;    `icicle-select-minibuffer-contents' `icicle-set-calling-cmd',
;;    `icicle-set-completion-methods-for-command',
;;    `icicle-set-difference', `icicle-set-intersection',
;;    `icicle-set-union', `icicle-shell-command',
;;    `icicle-shell-command-on-file',
;;    `icicle-shell-command-on-region',
;;    `icicle-shell-dynamic-complete-as-command',
;;    `icicle-shell-dynamic-complete-as-environment-variable',
;;    `icicle-show-help-in-mode-line', `icicle-show-in-mode-line',
;;    `icicle-signum', `icicle-S-iso-lefttab-to-S-TAB', `icicle-some',
;;    `icicle-special-candidates-first-p',
;;    `icicle-start-of-candidates-in-Completions',
;;    `icicle-strip-ignored-files-and-sort',
;;    `icicle-subst-envvar-in-file-name',
;;    `icicle-substring-no-properties', `icicle-substrings-of-length',
;;    `icicle-substitute-keymap-vars', `icicle-successive-action',
;;    `icicle-take', `icicle-things-alist',
;;    `icicle-this-command-keys-prefix',
;;    `icicle-toggle-icicle-mode-twice', `icicle-top-level-prep',
;;    `icicle-transform-candidates',
;;    `icicle-transform-multi-completion',
;;    `icicle-transform-sole-candidate',
;;    `icicle-transpose-chars-dots', `icicle-try-switch-buffer',
;;    `icicle-unbind-file-candidate-keys',
;;    `icicle-unbind-isearch-keys',
;;    `icicle-unbind-key-completion-keys-for-map-var',
;;    `icicle-unbind-key-completion-keys-in-keymaps-from',
;;    `icicle-undo-std-completion-faces',
;;    `icicle-unhighlight-lighter', `icicle-unmap',
;;    `icicle-unpropertize-completion',
;;    `icicle-unsorted-apropos-candidates',
;;    `icicle-unsorted-file-name-apropos-candidates',
;;    `icicle-unsorted-file-name-prefix-candidates',
;;    `icicle-unsorted-prefix-candidates', `icicle-upcase',
;;    `icicle-upcase-if-ignore-case', `icicle-update-and-next',
;;    `icicle-update-ignored-extensions-regexp',
;;    `icicle-value-satisfies-type-p', `icicle-var-inherits-type-p',
;;    `icicle-var-is-of-type-p', `icicle-var-matches-type-p',
;;    `icicle-var-val-satisfies-type-p',
;;    `old-choose-completion-string', `old-completing-read',
;;    `old-completing-read-multiple', `old-completion-setup-function',
;;    `old-dired-smart-shell-command', `old-display-completion-list',
;;    `old-face-valid-attribute-values',
;;    `old-minibuffer-default-add-completions',
;;    `old-read-char-by-name', `old-read-face-name',
;;    `old-read-from-minibuffer', `old-read-number',
;;    `old-read-string', `old-shell-command',
;;    `old-shell-command-on-region'.
;;
;;  Internal variables and constants defined in Icicles:
;;
;;    `icicle-abs-file-candidates', `icicle-acting-on-next/prev',
;;    `icicle-active-map', `icicle-advice-info-list',
;;    `icicle-all-candidates-action',
;;    `icicle-all-candidates-list-action-fn',
;;    `icicle-all-candidates-list-alt-action-fn',
;;    `icicle-anychar-regexp', `icicle-apply-nomsg',
;;    `icicle-apropos-complete-match-fn', `icicle-bookmark-history',
;;    `icicle-bookmark-list-names-only-p', `icicle-bookmark-menu-map',
;;    `icicle-bookmark-types', `icicle-buffer-config-history',
;;    `icicle-buffer-sort-first-time-p', `icicle-bufflist',
;;    `icicle-candidate-action-fn', `icicle-candidate-alt-action-fn',
;;    `icicle-candidate-entry-fn', `icicle-candidate-help-fn',
;;    `icicle-candidate-nb', `icicle-candidate-properties-alist',
;;    `icicle-candidates-alist', `icicle-char-property-value-history',
;;    `icicle-cmd-calling-for-completion', `icicle-cmd-reading-input',
;;    `icicle-color-history', `icicle-color-theme-history',
;;    `icicle-command-abbrev-history', `icicle-commands-for-abbrev',
;;    `icicle-common-match-string',
;;    `icicle-comp-base-is-default-dir-p',
;;    `icicle-complete-input-overlay', `icicle-complete-keys-alist',
;;    `icicle-completing-p',
;;    `icicle-completing-read+insert-candidates',
;;    `icicle-completion-candidates',
;;    `icicle-completion-prompt-overlay',
;;    `icicle-completion-set-history',
;;    `icicle-Completions-misc-submenu',
;;    `icicle-Completions-save/retrieve-submenu',
;;    `icicle-Completions-sets-submenu',
;;    `icicle-Completions-sorting-submenu',
;;    `icicle-Completions-this-candidate-submenu',
;;    `icicle-Completions-toggle-submenu'
;;    `icicle-confirm-exit-commands',
;;    `icicle-crm-local-completion-map',
;;    `icicle-crm-local-must-match-map',
;;    `icicle-current-completion-candidate-overlay',
;;    `icicle-current-completion-mode', `icicle-current-input',
;;    `icicle-current-raw-input', `icicle-current-TAB-method',
;;    `icicle-custom-menu-map', `icicle-cycling-p',
;;    `icicle-default-directory',
;;    `icicle-default-thing-insertion-flipped-p',
;;    `icicle-delete-candidate-object', `icicle-describe-menu-map',
;;    `icicle-dictionary-history', `icicle-dir-candidate-can-exit-p',
;;    `icicle-dirs-done', `icicle-doc-last-initial-cand-set',
;;    `icicle-dot-string-internal', `icicle-edit-menu-map',
;;    `icicle-edit-update-p', `icicle-explore-final-choice',
;;    `icicle-explore-final-choice-full', `icicle-extra-candidates',
;;    `icicle-extra-candidates-dir-insert-p',
;;    `icicle-face-name-history', `icicle-fancy-candidates-p',
;;    `icicle-fancy-cands-internal-p', `icicle-file-menu-map',
;;    `icicle-files', `icicle-file-sort-first-time-p',
;;    `icicle-filtered-default-value', `icicle-font-name-history',
;;    `icicle-frame-alist', `icicle-frame-name-history',
;;    `icicle-frames-menu-map', `icicle-full-cand-fn',
;;    `icicle-function-name-history',
;;    `icicle-fundoc-last-initial-cand-set',
;;    `icicle-general-help-string',
;;    `icicle-get-alist-candidate-function',
;;    `icicle-hist-cands-no-highlight', `icicle-hist-var',
;;    `icicle-ignored-extensions', `icicle-ignored-extensions-regexp',
;;    `icicle-incremental-completion-p', `icicle-info-buff',
;;    `icicle-info-menu-map', `icicle-Info-only-rest-of-book-p',
;;    `icicle-info-window', `icicle-inhibit-sort-p',
;;    `icicle-inhibit-try-switch-buffer', `icicle-initial-value',
;;    `icicle-input-completion-fail-overlay', `icicle-input-fail-pos',
;;    `icicle-insert-string-at-pt-end',
;;    `icicle-insert-string-at-pt-start',
;;    `icicle-interactive-history', `icicle-key-prefix',
;;    `icicle-key-prefix-2', `icicle-key-prefix-description',
;;    `icicle-kill-history', `icicle-kmacro-alist',
;;    `icicle-kmacro-history',
;;    `icicle-last-apropos-complete-match-fn',
;;    `icicle-last-completion-candidate',
;;    `icicle-last-completion-command', `icicle-last-input',
;;    `icicle-last-sort-comparer', `icicle-last-top-level-command',
;;    `icicle-last-transform-function', `icicle-last-thing-type',
;;    `icicle-locate-file-action-fn',
;;    `icicle-locate-file-no-symlinks-p', `icicle-lighter-truncation',
;;    `icicle-list-use-nth-parts', `icicle-menu-map',
;;    `icicle-minibuffer-message-ok-p', `icicle-minor-mode-map-entry',
;;    `icicle-mode-map', `icicle-ms-windows-drive-hash',
;;    `icicle-must-match-regexp', `icicle-must-not-match-regexp',
;;    `icicle-must-pass-after-match-predicate',
;;    `icicle-must-pass-predicate', `icicle-named-colors',
;;    `icicle-nb-candidates-before-truncation',
;;    `icicle-nb-of-other-cycle-candidates', `icicle-new-last-cmd',
;;    `icicle-next-apropos-complete-cycles-p',
;;    `icicle-next-prefix-complete-cycles-p',
;;    `icicle-old-read-file-name-fn', `icicle-options-menu-map',
;;    `icicle-orig-buff', `icicle-orig-extra-cands',
;;    `icicle-orig-font', `icicle-orig-frame', `icicle-orig-menu-bar',
;;    `icicle-orig-must-pass-after-match-pred',
;;    `icicle-orig-pixelsize', `icicle-orig-pointsize',
;;    `icicle-orig-pt-explore', `icicle-orig-show-initially-flag',
;;    `icicle-orig-sort-orders-alist', `icicle-orig-window',
;;    `icicle-other-window', `icicle-plist-last-initial-cand-set',
;;    `icicle-pre-minibuffer-buffer', `icicle-post-command-hook',
;;    `icicle-pre-command-hook', `icicle-predicate-types-alist',
;;    `icicle-previous-raw-file-name-inputs',
;;    `icicle-previous-raw-non-file-name-inputs',
;;    `icicle-progressive-completing-p', `icicle-prompt',
;;    `icicle-proxy-candidate-regexp', `icicle-proxy-candidates',
;;    `icicle-read-expression-map', `icicle-remove-icicles-props-p',
;;    `icicle-re-no-dot', `icicle-require-match-p',
;;    `icicle-reverse-multi-sort-p', `icicle-reverse-sort-p',
;;    `icicle-saved-candidate-overlays',
;;    `icicle-saved-candidates-variables-obarray',
;;    `icicle-saved-completion-candidate',
;;    `icicle-saved-completion-candidates',
;;    `icicle-saved-completion-candidates-internal',
;;    `icicle-saved-ignored-extensions',
;;    `icicle-saved-kmacro-ring-max', `icicle-saved-proxy-candidates',
;;    `icicle-saved-regexp-search-ring-max',
;;    `icicle-saved-region-background',
;;    `icicle-saved-search-ring-max',
;;    `icicle-scroll-Completions-reverse-p', `icicle-search-command',
;;    `icicle-search-complement-domain-p',
;;    `icicle-search-context-level', `icicle-search-context-regexp',
;;    `icicle-search-current-overlay', `icicle-search-final-choice',
;;    `icicle-search-history', `icicle-search-in-context-fn',
;;    `icicle-searching-p', `icicle-search-level-overlays',
;;    `icicle-search-map', `icicle-search-modes',
;;    `icicle-search-menu-map', `icicle-search-tags-menu-map',
;;    `icicle-search-overlays', `icicle-search-refined-overlays',
;;    `icicle-search-replacement',
;;    `icicle-search-replacement-history',
;;    `icicle-successive-grab-count',
;;    `icicle-text-property-value-history',
;;    `icicle-thing-at-pt-fns-pointer', `icicle-this-cmd-keys',
;;    `icicle-transform-before-sort-p',
;;    `icicle-universal-argument-map',
;;    `icicle-vardoc-last-initial-cand-set',
;;    `icicle-vardoc-last-initial-option-cand-set',
;;    `icicle-variable-name-history',
;;    `icicle-whole-candidate-as-text-prop-p',
;;    `lacarte-menu-items-alist', `old-crm-local-completion-map',
;;    `old-crm-local-must-match-map'.
;;
;;  Emacs functions defined in Icicles for older Emacs versions:
;;
;;    `select-frame-set-input-focus'.
;;
;;  Widgets (customization types) defined in Icicles:
;;
;;    `icicle-key-definition'.
;;
;;
;;  ***** NOTE: These EMACS PRIMITIVES have been REDEFINED in Icicles:
;;
;;  `completing-read'              - (See below and doc string.)
;;  `display-completion-list'      - (See below and doc string.)
;;  `exit-minibuffer'              - Remove *Completion* window.
;;  `minibuffer-complete-and-exit' - Remove *Completion* window.
;;  `read-file-name'               - (See below and doc string.)
;;  `read-from-minibuffer'         - (See below and doc string.)
;;  `read-string'                  - (See below and doc string.)
;;
;;
;;  ***** NOTE: The following functions defined in `dabbrev.el' have
;;              been REDEFINED in Icicles:
;;
;;  `dabbrev-completion' - Use Icicles completion when you repeat
;;                         (`C-M-/').
;;
;;
;;  ***** NOTE: The following functions defined in `lisp.el' have
;;              been REDEFINED in Icicles:
;;
;;  `lisp-complete-symbol' - Selects `*Completions*' window even if on
;;                           another frame.
;;
;;
;;  ***** NOTE: The following functions defined in `mouse.el' have
;;              been REDEFINED in Icicles:
;;
;;  `mouse-choose-completion' - Return the number of the completion.
;;
;;
;;  ***** NOTE: The following functions defined in `simple.el' have
;;              been REDEFINED in Icicles:
;;
;;  `choose-completion-string' -
;;     Don't exit minibuffer after `lisp-complete-symbol' completion.
;;  `completion-setup-function' - 1. Put faces on inserted string(s).
;;                                2. Help on help.
;;  `switch-to-completions' - Always selects `*Completions*' window.
;;
;;  `next-history-element' (advised only) -
;;     Depending on `icicle-default-value', select minibuffer
;;     contents.
;;
;;  `repeat-complex-command' - Use `completing-read' to read command.
;;
;;  For descriptions of changes to this file, see `icicles-chg.el'.
;;
;;  ******************
;;  NOTE: Whenever you update Icicles (i.e., download new versions of
;;  Icicles source files), I recommend that you do the following:
;;
;;      1. Delete all existing byte-compiled Icicles files
;;         (icicles*.elc).
;;      2. Load Icicles (`load-library' or `require').
;;      3. Byte-compile the source files.
;;
;;  In particular, always load `icicles-mac.el' (not
;;  `icicles-mac.elc') before you byte-compile new versions of the
;;  files, in case there have been any changes to Lisp macros (in
;;  `icicles-mac.el').
;;  ******************

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(eval-when-compile
 (when (< emacs-major-version 20) (require 'cl))) ;; when, unless

;;;;;;;;;;;;;


;;; Load other Icicles files (except documentation) ------------------

;; Put this first
;;;###autoload
(defcustom icicle-byte-compile-eval-after-load-flag t
  "*Non-nil means byte-compile definitions made within `eval-after-load'.
Some Icicles functions (commands, in particular) work only if a given
library is loaded.  Some such functions are defined inside an
`eval-after-load' form, which means they are defined only, and as soon
as, the required library is loaded.

If this option is non-nil then those function definitions are
byte-compiled.  This compilation adds a bit to the load time, in
effect, but it means that the functions run faster."
  :type 'boolean :group 'Icicles-Miscellaneous)

(eval-when-compile
 (or (condition-case nil
         ;; Use load-library to ensure latest .elc.
         (load-library "icicles-mac")
       (error nil))
     ;; Require, so can load separately if not on `load-path'.
     (require 'icicles-mac)))

(require 'icicles-face)
(require 'icicles-opt)  ;; Requires face
(require 'icicles-var)  ;; Requires opt
(require 'icicles-fn)   ;; Requires mac, opt, var
(require 'icicles-mcmd) ;; Requires opt, var, fn, mac
(require 'icicles-cmd1) ;; Requires mac, opt, var, fn, mcmd
(require 'icicles-cmd2) ;; Requires mac, opt, var, fn, mcmd, cmd1
(require 'icicles-mode) ;; Requires face, opt, cmd

 
;;(@* "Miscellaneous")

;;; Miscellaneous  -----------------------------------------

;; Make Emacs-Lisp mode fontify definitions of Icicles commands.
(font-lock-add-keywords
 'emacs-lisp-mode
 `((,(concat "(" (regexp-opt
                  '("icicle-define-add-to-alist-command" "icicle-define-command"
                    "icicle-define-file-command" "icicle-define-sort-command")
                             t)
             ;; $$ "\\s-+\\(\\sw\\(\\sw\\|\\s_\\)+\\)")
             "\\>[ \t'\(]*\\(\\sw+\\)?")
    (1 font-lock-keyword-face)
    ;; Index (2 or 3) depends on whether or not shy groups are supported.
    ,(list (if (string-match "\\(?:\\)" "") 2 3) 'font-lock-function-name-face nil t))
   ("(\\(icicle-condition-case-no-debug\\)\\>" 1 font-lock-keyword-face)))

;; Make Icicles macros indent better.
(put 'icicle-define-command              'common-lisp-indent-function '(4 &body))
(put 'icicle-define-file-command         'common-lisp-indent-function '(4 &body))
(put 'icicle-define-sort-command         'common-lisp-indent-function '(4 4 &body))
(put 'icicle-define-add-to-alist-command 'common-lisp-indent-function '(4 &body))
(put 'icicle-with-selected-window        'common-lisp-indent-function '(4 &body))
(put 'icicle-condition-case-no-debug     'common-lisp-indent-function '(4 4 &body))

;; You might also want to use the following or something similar.
;; (defun lisp-indentation-hack ()
;;   "Better Lisp indenting.  Use in Lisp mode hooks
;; such as `lisp-mode-hook', `emacs-lisp-mode-hook', and
;; `lisp-interaction-mode-hook'."
;;   (load "cl-indent" nil t)
;;   (set (make-local-variable 'lisp-indent-function) 'common-lisp-indent-function)
;;   (setq lisp-indent-maximum-backtracking  10)
;;   (put 'define-derived-mode 'common-lisp-indent-function '(4 4 4 2 &body))
;;   (put 'if                  'common-lisp-indent-function '(nil nil &body)))
;;
;; (add-hook 'emacs-lisp-mode-hook       'lisp-indentation-hack)
;; (add-hook 'lisp-mode-hook             'lisp-indentation-hack)
;; (add-hook 'lisp-interaction-mode-hook 'lisp-indentation-hack)

;;;;;;;;;;;;;;;;;;;;;;;

(provide 'icicles)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; icicles.el ends here
