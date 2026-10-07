$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    # In Mobile menu:
    $content = [regex]::Replace($content, '(<a href="index\.html"[^>]*>Home</a>)\s+(<a href="about\.html")', "`$1`r`n                    `$2")
    
    # In Desktop menu (just in case there is a gap there too):
    $content = [regex]::Replace($content, '(Home<span[^>]*></span>\s*</a>)\s+(<a href="about\.html")', "`$1`r`n                        `$2")

    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
