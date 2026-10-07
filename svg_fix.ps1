$facebookSvg = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-5 w-5 text-brand-textSec cursor-pointer hover:text-brand-accent hover:-translate-y-1 transition-all duration-300"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg>'
$twitterSvg = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-5 w-5 text-brand-textSec cursor-pointer hover:text-brand-accent hover:-translate-y-1 transition-all duration-300"><path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"></path></svg>'
$linkedinSvg = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-5 w-5 text-brand-textSec cursor-pointer hover:text-brand-accent hover:-translate-y-1 transition-all duration-300"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg>'
$instagramSvg = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-5 w-5 text-brand-textSec cursor-pointer hover:text-brand-accent hover:-translate-y-1 transition-all duration-300"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>'

$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    # Skip index.html and about.html as they are already fixed
    if ($f.Name -eq 'index.html' -or $f.Name -eq 'about.html') {
        continue
    }
    
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    # Use (?s) for single-line mode so .* matches newlines
    $content = [regex]::Replace($content, '(?s)<i data-lucide="facebook".*?</i>', $facebookSvg)
    $content = [regex]::Replace($content, '(?s)<i data-lucide="twitter".*?</i>', $twitterSvg)
    $content = [regex]::Replace($content, '(?s)<i data-lucide="linkedin".*?</i>', $linkedinSvg)
    $content = [regex]::Replace($content, '(?s)<i data-lucide="instagram".*?</i>', $instagramSvg)
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
