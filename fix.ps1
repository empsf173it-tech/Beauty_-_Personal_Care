$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'
foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    # Add instagram if not exists
    if ($content -notmatch 'data-lucide=\"instagram\"' -and $content -match 'data-lucide=\"linkedin\"') {
        $content = $content -replace '<a href=\"#\"><i data-lucide=\"linkedin\"(.*?)</i></a>', '<a href=\"#\"><i data-lucide=\"linkedin\"$1</i></a> <a href=\"#\"><i data-lucide=\"instagram\" class=\"h-5 w-5 text-brand-textSec cursor-pointer\"></i></a>'
    }
    
    # Remove hover from all social icons
    $content = $content -replace 'class=\"h-5 w-5 text-brand-textSec hover:text-brand-accent cursor-pointer transition-colors\"', 'class=\"h-5 w-5 text-brand-textSec cursor-pointer\"'
    
    # Remove hover from Quick links and Services links
    $content = $content -replace 'class=\"hover:text-brand-accent transition-colors\"', 'class=\"text-brand-textSec\"'
    
    # Remove underline highlight from footer titles
    $content = $content -replace 'class=\"text-brand-text font-bold mb-4 border-b border-brand-accent inline-block pb-1\"', 'class=\"text-brand-text font-bold mb-4 inline-block pb-1\"'
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
