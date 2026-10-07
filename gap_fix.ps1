$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    if ($f.Name -eq 'index.html' -or $f.Name -eq 'about.html') {
        continue
    }
    
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    $content = $content -replace 'class="flex space-x-4 pt-2"', 'class="flex gap-4 pt-2"'
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
