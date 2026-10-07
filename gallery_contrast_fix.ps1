$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource\gallery.html'
$content = Get-Content $path -Raw -Encoding UTF8

# Replace the gradient class
$content = [regex]::Replace($content, 'bg-gradient-to-t from-black/70 via-transparent', 'bg-gradient-to-t from-brand-bg via-brand-bg/50')

# Replace text-white with text-brand-text
$content = [regex]::Replace($content, '<h3 class="text-white', '<h3 class="text-brand-text')

Set-Content -Path $path -Value $content -Encoding UTF8
