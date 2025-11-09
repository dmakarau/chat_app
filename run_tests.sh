#!/bin/bash

# Flutter Chat App - Test Runner Script
# This script runs all tests and generates coverage reports

set -e  # Exit on any error

echo "🚀 Starting Flutter Chat App Test Suite"
echo "==============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}📋 $1${NC}"
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

# Step 1: Check Flutter installation
print_step "Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi
flutter --version
print_success "Flutter installation verified"

# Step 2: Get dependencies
print_step "Installing dependencies..."
flutter pub get
print_success "Dependencies installed"

# Step 3: Generate code (mocks, etc.)
print_step "Generating code (mocks, etc.)..."
if command -v dart &> /dev/null; then
    dart run build_runner build --delete-conflicting-outputs
    print_success "Code generation completed"
else
    print_warning "Skipping code generation (dart not found)"
fi

# Step 4: Run code analysis
print_step "Running code analysis..."
if flutter analyze; then
    print_success "Code analysis passed"
else
    print_error "Code analysis failed"
    exit 1
fi

# Step 5: Check formatting
print_step "Checking code formatting..."
if dart format --output=none --set-exit-if-changed .; then
    print_success "Code formatting is correct"
else
    print_warning "Code formatting issues found. Run 'dart format .' to fix"
fi

# Step 6: Run unit tests
print_step "Running unit tests..."
if flutter test test/unit/ --coverage; then
    print_success "Unit tests passed"
else
    print_error "Unit tests failed"
    exit 1
fi

# Step 7: Run widget tests
print_step "Running widget tests..."
if flutter test test/widget/; then
    print_success "Widget tests passed"
else
    print_error "Widget tests failed"
    exit 1
fi

# Step 8: Run all tests with coverage
print_step "Running all tests with coverage..."
if flutter test --coverage; then
    print_success "All tests passed with coverage"
    
    # Check if coverage file exists
    if [ -f "coverage/lcov.info" ]; then
        print_success "Coverage report generated at coverage/lcov.info"
        
        # Generate HTML coverage report if genhtml is available
        if command -v genhtml &> /dev/null; then
            print_step "Generating HTML coverage report..."
            genhtml coverage/lcov.info -o coverage/html
            print_success "HTML coverage report generated at coverage/html/"
            print_step "Open coverage/html/index.html in your browser to view the report"
        fi
    fi
else
    print_error "Tests failed"
    exit 1
fi

# Step 9: Check for outdated dependencies
print_step "Checking for outdated dependencies..."
flutter pub outdated || print_warning "Some dependencies might be outdated"

# Step 10: Build verification (optional)
if [ "$1" = "--build" ]; then
    print_step "Building Android APK (debug)..."
    if flutter build apk --debug; then
        print_success "Android debug build successful"
    else
        print_error "Android debug build failed"
        exit 1
    fi
fi

echo ""
echo "==============================================="
print_success "🎉 All tests completed successfully!"
echo ""
print_step "Summary:"
echo "  ✅ Code analysis passed"
echo "  ✅ Unit tests passed" 
echo "  ✅ Widget tests passed"
echo "  ✅ Coverage report generated"
echo ""
print_step "Next steps:"
echo "  📊 Review coverage report"
echo "  🔍 Check for any TODO items in code"
echo "  📱 Test on device/emulator"
echo "  🚀 Ready for deployment!"
echo ""