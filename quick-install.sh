#!/bin/bash

# Neovim Offline Package Quick Installer
# This script helps you quickly install the pre-built Neovim package

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════╗"
    echo "║     Neovim Offline Package Installer  ║"
    echo "║                                        ║"
    echo "║     🚀 Ready for offline deployment   ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

check_dependencies() {
    print_info "Checking dependencies..."
    
    # Check if tar is available
    if ! command -v tar &> /dev/null; then
        print_error "tar is required but not installed. Please install tar first."
        exit 1
    fi
    
    # Check if we're on a supported system
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        PLATFORM="Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="macOS"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        PLATFORM="Windows (Git Bash/WSL)"
    else
        PLATFORM="Unknown"
        print_warning "Unknown platform: $OSTYPE. Installation may not work as expected."
    fi
    
    print_success "Platform detected: $PLATFORM"
}

backup_existing() {
    local backup_time=$(date +%Y%m%d_%H%M%S)
    
    if [ -d ~/.config/nvim ]; then
        print_info "Backing up existing Neovim config..."
        mv ~/.config/nvim ~/.config/nvim.backup.$backup_time
        print_success "Config backed up to ~/.config/nvim.backup.$backup_time"
    fi
    
    if [ -d ~/.local/share/nvim ]; then
        print_info "Backing up existing Neovim data..."
        mv ~/.local/share/nvim ~/.local/share/nvim.backup.$backup_time
        print_success "Data backed up to ~/.local/share/nvim.backup.$backup_time"
    fi
}

create_directories() {
    print_info "Creating necessary directories..."
    mkdir -p ~/.config
    mkdir -p ~/.local/share
    mkdir -p ~/.local/state
    mkdir -p ~/.cache
    print_success "Directories created"
}

install_package() {
    local package_file="neovim-offline-package.tar.gz"
    
    if [ ! -f "$package_file" ]; then
        print_error "Package file '$package_file' not found!"
        echo ""
        print_info "Please make sure you have downloaded the package file and placed it in the same directory as this script."
        echo ""
        print_info "You can download it from:"
        print_info "https://github.com/LongQIByte/kickstart.nvim/releases/latest"
        exit 1
    fi
    
    print_info "Installing Neovim offline package..."
    print_info "Package size: $(du -h $package_file | cut -f1)"
    
    # Extract the package
    tar -xzf "$package_file" -C ~/
    
    # Make scripts executable
    if [ -f ~/.config/nvim/install-offline.sh ]; then
        chmod +x ~/.config/nvim/install-offline.sh
    fi
    
    print_success "Package installed successfully!"
}

verify_installation() {
    print_info "Verifying installation..."
    
    if [ -d ~/.config/nvim ]; then
        print_success "Neovim config directory exists"
    else
        print_error "Neovim config directory missing"
        return 1
    fi
    
    if [ -d ~/.local/share/nvim ]; then
        print_success "Neovim data directory exists"
    else
        print_error "Neovim data directory missing"
        return 1
    fi
    
    # Check for some key files
    if [ -f ~/.config/nvim/init.lua ]; then
        print_success "Configuration file found"
    else
        print_error "Configuration file missing"
        return 1
    fi
    
    if [ -d ~/.local/share/nvim/lazy ]; then
        print_success "Plugins directory found"
        local plugin_count=$(ls -1 ~/.local/share/nvim/lazy | wc -l)
        print_info "Found $plugin_count plugins"
    else
        print_warning "Plugins directory not found"
    fi
    
    if [ -d ~/.local/share/nvim/mason ]; then
        print_success "Mason tools directory found"
        if [ -d ~/.local/share/nvim/mason/bin ]; then
            local tool_count=$(ls -1 ~/.local/share/nvim/mason/bin 2>/dev/null | wc -l)
            print_info "Found $tool_count Mason tools"
        fi
    else
        print_warning "Mason tools directory not found"
    fi
}

show_completion_message() {
    echo ""
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║  🎉 Neovim Offline Package Installed Successfully!       ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    
    print_info "What's included:"
    echo "  • Complete LSP setup (Python, Go, JS/TS, HTML/CSS, Vue, Lua)"
    echo "  • AI-powered code completion (Codeium)"
    echo "  • 15+ essential development plugins"
    echo "  • Auto-formatting and syntax highlighting"
    echo "  • Git integration and diff viewer"
    echo "  • Floating terminal toggle"
    echo ""
    
    print_info "Quick start:"
    echo "  1. Start Neovim: ${YELLOW}nvim${NC}"
    echo "  2. First run may take 10-30 seconds to initialize"
    echo "  3. For AI completion, run: ${YELLOW}:Codeium Auth${NC} (requires internet - one time)"
    echo ""
    
    print_info "Key bindings:"
    echo "  • ${YELLOW}Ctrl+\\${NC}    - Toggle terminal"
    echo "  • ${YELLOW}<leader>dv${NC} - Open git diff view"  
    echo "  • ${YELLOW}Ctrl+G${NC}     - Accept AI suggestion"
    echo "  • ${YELLOW}<leader>sf${NC} - Find files"
    echo "  • ${YELLOW}<leader>f${NC}  - Format code"
    echo ""
    
    print_info "Documentation: ~/.config/nvim/OFFLINE_USAGE.md"
    echo ""
    
    print_success "Happy coding! 🚀"
}

main() {
    print_header
    
    # Parse command line arguments
    SKIP_BACKUP=false
    FORCE_INSTALL=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --skip-backup)
                SKIP_BACKUP=true
                shift
                ;;
            --force)
                FORCE_INSTALL=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --skip-backup    Skip backing up existing Neovim config"
                echo "  --force          Force installation even if Neovim is already configured"
                echo "  --help, -h       Show this help message"
                echo ""
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    # Check if Neovim is already configured and we're not forcing
    if [ -d ~/.config/nvim ] && [ "$FORCE_INSTALL" = false ]; then
        echo ""
        print_warning "Existing Neovim configuration detected."
        echo ""
        read -p "Do you want to continue? This will backup your existing config. (y/N): " -n 1 -r
        echo ""
        
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled by user."
            exit 0
        fi
    fi
    
    check_dependencies
    
    if [ "$SKIP_BACKUP" = false ]; then
        backup_existing
    fi
    
    create_directories
    install_package
    
    if verify_installation; then
        show_completion_message
    else
        print_error "Installation verification failed. Please check the logs above."
        exit 1
    fi
}

# Run main function with all arguments
main "$@"