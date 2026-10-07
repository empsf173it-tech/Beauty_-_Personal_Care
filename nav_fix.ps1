$path = 'f:\Smartfusion\October\Salon_Beauty_Parlour-main\Beauty_Personal_Care_Resource'
$files = Get-ChildItem -Path $path -Filter '*.html'

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8

    # 1. Desktop Menu Reordering
    # Replace the whole action buttons block
    $desktopSearch = '(?s)<div class="hidden min-\[1100px\]:flex items-center space-x-4 shrink-0">.*?<button id="theme-toggle".*?</button>.*?<a href="signup\.html".*?Sign.*?Up</a>.*?<a href="appointments\.html".*?Book.*?Now</a>.*?</div>'
    
    $desktopReplacement = '<div class="hidden min-[1100px]:flex items-center space-x-4 shrink-0">
                    <button id="theme-toggle"
                        class="p-2 rounded-full text-brand-textSec hover:text-brand-accent hover:bg-brand-bgSec transition-colors theme-icon"
                        aria-label="Toggle Theme">
                    </button>
                    
                    <a href="appointments.html"
                        class="px-5 py-2 rounded-full border border-brand-accent text-brand-accent hover:bg-brand-accent hover:text-white transition-all duration-300 text-sm font-bold shadow-neon hover:shadow-neon-strong whitespace-nowrap">Book
                        Now</a>
                    <a href="signup.html"
                        class="px-5 py-2 rounded-full border border-brand-accent text-brand-text hover:bg-brand-accent hover:text-white transition-all duration-300 text-sm font-bold shadow-neon hover:shadow-neon-strong whitespace-nowrap">Sign
                        Up</a>
                </div>'

    $content = [regex]::Replace($content, $desktopSearch, $desktopReplacement)

    # 2. Mobile Menu Reordering
    # The mobile menu has pt-4 border-t ... for buttons, and then mt-4 for theme toggle.
    $mobileSearch = '(?s)<div class="pt-4 border-t border-brand-border flex flex-col space-y-3">.*?<a href="signup\.html".*?Sign.*?Up</a>.*?<a href="appointments\.html".*?Book.*?Now</a>.*?</div>.*?<div class="flex justify-between items-center px-2 mt-4">.*?<button id="mobile-theme-toggle".*?</button>.*?</div>'
    
    $mobileReplacement = '<div class="pt-4 border-t border-brand-border flex flex-col space-y-3">
                    <div class="flex justify-between items-center px-2 mb-2">
                        <button id="mobile-theme-toggle"
                            class="p-2 rounded-full text-brand-textSec hover:text-brand-accent hover:bg-brand-bgSec transition-colors theme-icon flex items-center justify-center">
                            <!-- Icon will be inserted by JS -->
                        </button>
                    </div>
                    <a href="appointments.html"
                        class="px-5 py-2 rounded-full border border-brand-accent text-brand-accent hover:bg-brand-accent hover:text-white transition-all duration-300 text-sm font-bold shadow-neon hover:shadow-neon-strong text-center">Book
                        Now</a>
                    <a href="signup.html"
                        class="px-5 py-2 rounded-full border border-brand-accent text-brand-text hover:bg-brand-accent hover:text-white transition-all duration-300 text-sm font-bold shadow-neon hover:shadow-neon-strong text-center">Sign
                        Up</a>
                </div>'
    
    $content = [regex]::Replace($content, $mobileSearch, $mobileReplacement)
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
