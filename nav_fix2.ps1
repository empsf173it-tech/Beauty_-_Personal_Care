$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8

    $mobileSearch = '(?s)<div class="pt-4 border-t border-brand-border flex flex-col space-y-3">.*?<div class="flex justify-between items-center px-2 mb-2">.*?<button id="mobile-theme-toggle".*?</button>.*?</div>.*?<a href="appointments\.html".*?Book.*?Now</a>.*?<a href="signup\.html".*?Sign.*?Up</a>.*?</div>'
    
    $mobileReplacement = '<div class="pt-4 border-t border-brand-border flex flex-col space-y-3">
                    <a href="appointments.html"
                        class="px-5 py-2 rounded-full border border-brand-accent text-brand-accent hover:bg-brand-accent hover:text-white transition-all duration-300 text-sm font-bold shadow-neon hover:shadow-neon-strong text-center">Book
                        Now</a>
                    <a href="signup.html"
                        class="px-5 py-2 rounded-full border border-brand-accent text-brand-text hover:bg-brand-accent hover:text-white transition-all duration-300 text-sm font-bold shadow-neon hover:shadow-neon-strong text-center">Sign
                        Up</a>
                    <div class="flex justify-center items-center pt-2">
                        <button id="mobile-theme-toggle"
                            class="p-2 rounded-full text-brand-textSec hover:text-brand-accent hover:bg-brand-bgSec transition-colors theme-icon flex items-center justify-center">
                            <!-- Icon will be inserted by JS -->
                        </button>
                    </div>
                </div>'
    
    $content = [regex]::Replace($content, $mobileSearch, $mobileReplacement)
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
