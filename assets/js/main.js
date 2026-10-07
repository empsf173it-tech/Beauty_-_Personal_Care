// Shared logic for Glamour Salon

document.addEventListener('DOMContentLoaded', () => {
    // RTL State Persistence
    const savedDir = localStorage.getItem('dir') || 'ltr';
    document.documentElement.dir = savedDir;

    // Listen to clicks on any RTL button/toggle
    document.body.addEventListener('click', (e) => {
        const rtlToggle = e.target.closest('[onclick*="document.documentElement.dir"]') || 
                          (e.target.textContent && e.target.textContent.trim() === 'RTL');
        if (rtlToggle) {
            setTimeout(() => {
                localStorage.setItem('dir', document.documentElement.dir);
            }, 50);
        }
    });

    lucide.createIcons();

    // Theme Management
    const themeToggle = document.getElementById('theme-toggle');
    const mobileThemeToggle = document.getElementById('mobile-theme-toggle');
    const htmlElement = document.documentElement;

    const savedTheme = localStorage.getItem('theme') || 'light';
    htmlElement.setAttribute('data-theme', savedTheme);
    updateThemeIcons(savedTheme);

    function toggleTheme() {
        const currentTheme = htmlElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        htmlElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeIcons(newTheme);
    }

    function updateThemeIcons(theme) {
        const icons = document.querySelectorAll('.theme-icon');
        icons.forEach(icon => {
            if (theme === 'dark') {
                icon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-sun"><circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/><path d="m4.93 4.93 1.41 1.41"/><path d="m17.66 17.66 1.41 1.41"/><path d="M2 12h2"/><path d="M20 12h2"/><path d="m6.34 17.66-1.41 1.41"/><path d="m19.07 4.93-1.41 1.41"/></svg>`;
            } else {
                icon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-moon"><path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/></svg>`;
            }
        });
    }

    if (themeToggle) themeToggle.addEventListener('click', toggleTheme);
    if (mobileThemeToggle) mobileThemeToggle.addEventListener('click', toggleTheme);

    // Mobile Menu Management
    const menuToggle = document.getElementById('menu-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    const menuOpenIcon = document.getElementById('menu-open-icon');
    const menuCloseIcon = document.getElementById('menu-close-icon');

    if (menuToggle && mobileMenu) {
        menuToggle.addEventListener('click', () => {
            const isOpen = mobileMenu.classList.contains('hidden');
            if (isOpen) {
                mobileMenu.classList.remove('hidden');
                menuOpenIcon.classList.add('hidden');
                menuCloseIcon.classList.remove('hidden');
            } else {
                mobileMenu.classList.add('hidden');
                menuOpenIcon.classList.remove('hidden');
                menuCloseIcon.classList.add('hidden');
            }
        });
    }

    // Scroll to Top
    const scrollToTopBtn = document.getElementById('scroll-to-top');
    if (scrollToTopBtn) {
        scrollToTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // Scroll to Top
    const backToTopBtn = document.createElement('button');
    backToTopBtn.id = 'back-to-top';
    backToTopBtn.innerHTML = '<i data-lucide="chevron-up"></i>';
    backToTopBtn.className = 'fixed bottom-8 right-8 p-3 bg-brand-accent text-brand-bg rounded-full shadow-lg opacity-0 translate-y-10 transition-all duration-300 hover:scale-110 z-50 cursor-pointer';
    document.body.appendChild(backToTopBtn);
    lucide.createIcons();

    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            backToTopBtn.classList.remove('opacity-0', 'translate-y-10', 'pointer-events-none');
            backToTopBtn.classList.add('opacity-100', 'translate-y-0');
        } else {
            backToTopBtn.classList.add('opacity-0', 'translate-y-10', 'pointer-events-none');
            backToTopBtn.classList.remove('opacity-100', 'translate-y-0');
        }
    });

    backToTopBtn.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    // Active Menu Highlight
    const currentPath = window.location.pathname;
    let path = currentPath.substring(currentPath.lastIndexOf('/') + 1);
    if (path === '') path = 'index.html'; // Default to index.html for root

    const navLinks = document.querySelectorAll('nav a, #mobile-menu a');
    
    navLinks.forEach(link => {
        // Skip logo link (handles Lucide i-to-svg conversion and flex styling)
        if (link.querySelector('.lucide-scissors') || link.querySelector('[data-lucide="scissors"]') || link.classList.contains('flex')) {
            return;
        }

        const href = link.getAttribute('href');
        if (href === path) {
            // Update text color
            link.classList.add('text-brand-accent');
            link.classList.remove('text-brand-textSec', 'text-brand-text');
            
            // Handle desktop underline span
            const span = link.querySelector('span');
            if (span) {
                span.classList.remove('scale-x-0', 'group-hover:scale-x-100');
                span.classList.add('scale-x-100');
            }
        } else {
            // Reset highlight
            link.classList.remove('text-brand-accent');
            link.classList.add('text-brand-textSec');
            
            // Handle desktop underline span
            const span = link.querySelector('span');
            if (span) {
                span.classList.add('scale-x-0', 'group-hover:scale-x-100');
                span.classList.remove('scale-x-100');
            }
        }
    });
});
