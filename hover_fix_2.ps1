$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    # Update footer links (Services) which have newlines
    $content = [regex]::Replace($content, '<li>\s*<a href="([^"]+)"\s*class="text-brand-textSec">', '<li><a href="$1" class="text-brand-textSec hover:text-brand-accent hover:translate-x-1 inline-block transition-all duration-300">')
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
