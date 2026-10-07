$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource\gallery.html'
$content = Get-Content $path -Raw -Encoding UTF8

# Replace the gradient to be strictly gold so black text is visible
$content = [regex]::Replace($content, 'bg-gradient-to-t from-brand-bg via-brand-bg/50', 'bg-gradient-to-t from-brand-accent via-brand-accent/80')

# Replace text-brand-text with strictly text-black
$content = [regex]::Replace($content, '<h3 class="text-brand-text', '<h3 class="text-black')

# Let's also ensure the tag ("Skin Care", "Hair Care", etc.) is black or white for contrast on gold
# Currently it is: <span class="text-brand-accent text-xs...
# Gold text on gold background is invisible! So we must change text-brand-accent to text-black there too!
$content = [regex]::Replace($content, '<span class="text-brand-accent text-xs font-bold uppercase tracking-wider drop-shadow-sm">', '<span class="text-black text-xs font-bold uppercase tracking-wider">')

Set-Content -Path $path -Value $content -Encoding UTF8
