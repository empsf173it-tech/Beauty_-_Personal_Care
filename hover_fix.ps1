$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    # 1. Update social media icons hover effect
    # Currently they are: class="h-5 w-5 text-brand-textSec cursor-pointer"
    $content = $content -replace 'class="h-5 w-5 text-brand-textSec cursor-pointer"', 'class="h-5 w-5 text-brand-textSec cursor-pointer hover:text-brand-accent hover:-translate-y-1 transition-all duration-300"'

    # 2. Update footer links (Quick links & Services)
    # They currently are <a href="..." class="text-brand-textSec">
    # Let's replace class="text-brand-textSec" inside the footer links with proper hover
    # To be safe, we'll target the Quick Links and Services blocks by replacing 'class="text-brand-textSec"' 
    # but wait, that class might be used elsewhere.
    # Let's target the exact list item structure: 'class="text-brand-textSec"' inside the footer.
    # Actually, we can just replace 'class="text-brand-textSec"' with 'class="text-brand-textSec hover:text-brand-accent hover:translate-x-1 inline-block transition-all duration-300"' 
    # But only inside the <ul> elements. A regex is better.
    $content = $content -replace '<li><a href="([^"]+)" class="text-brand-textSec">', '<li><a href="$1" class="text-brand-textSec hover:text-brand-accent hover:translate-x-1 inline-block transition-all duration-300">'
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
