#!usr/bin/env perl
$latex = 'lualatex -synctex=1 -interaction=nonstopmode';
$bibtex = 'bibtex';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$out_dir = '.cache';
$pdf_mode = 4;
$pdf_view_file_via_temporary = 0;

if ($^O eq 'linux') {
    $pdf_previewer = 'zathura';
} elsif ($^O eq 'darwin') {
    $pdf_previewer = 'open';
} else {
    $pdf_previewer = 'start';
}
