(define-module (sc-im)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages base)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages xml)
  #:use-module (guix git-download))

(define-public sc-im
  (package
    (name "sc-im")
    (version "0.7.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                     (url "https://github.com/andmarti1424/sc-im")
                     (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0xi0n9qzby012y2j7hg4fgcwyly698sfi4i9gkvy0q682jihprbk"))))
    (build-system gnu-build-system)
    (inputs
      `(("ncurses" ,ncurses)
        ("bison" ,bison)
        ("libxml2" ,libxml2)
        ("libxlsxwriter" ,libxlsxwriter)
        ("which" ,which)
        ("gnuplot" ,gnuplot)
        ("pkg-config" ,pkg-config)
        ("libzip" ,libzip)))
    (arguments
         '(#:phases (modify-phases %standard-phases (delete 'configure))
          #:tests? #f
          #:make-flags (list "CC=gcc" "--directory=src" (string-append "prefix=" %output))))
    (home-page "https://github.com/andmarti1424/sc-im/")
    (synopsis "Spreadsheet Calculator Improvised -- An ncurses spreadsheet program for terminal")
    (description "SC-IM is a spreadsheet program
that is based on SC (http://ibiblio.org/pub/Linux/apps/financial/spreadsheet/sc-7.16.tar.gz).
SC original authors are James Gosling and Mark Weiser,
and mods were later added by Chuck Martin.")
    (license license:bsd-4)))

(define-public libxlsxwriter
  (package
    (name "libxlsxwriter")
    (version "0.9.4")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                     (url "https://github.com/jmcnamara/libxlsxwriter")
                     (commit (string-append "RELEASE_" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "127vchhvkw4gp9kwqghgfkzgphwpd4z3lpfgv4mdy2kk1la76w3r"))))
    (build-system gnu-build-system)
    (inputs
      `(("zlib" ,zlib)))
    (arguments
         '(#:phases (modify-phases %standard-phases (delete 'configure))
          #:tests? #f
          #:make-flags (list "CC=gcc" (string-append "PREFIX=" %output))))
    (home-page "https://github.com/jmcnamara/libxlsxwriter/")
    (synopsis "C library for creating Excel XLSX files.")
    (description "Libxlsxwriter is a C library
that can be used to write text, numbers, formulas and hyperlinks
to multiple worksheets in an Excel 2007+ XLSX file.")
    (license license:bsd-2)))
