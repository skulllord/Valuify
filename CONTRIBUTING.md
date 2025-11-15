# Contributing to Valuify

Thank you for considering contributing to Valuify! This document provides guidelines for contributing to the project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/Valuify.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test thoroughly
6. Commit: `git commit -m "Add: your feature description"`
7. Push: `git push origin feature/your-feature-name`
8. Create a Pull Request

## Development Setup

1. Install Flutter SDK (3.x or higher)
2. Run `flutter pub get`
3. Set up Firebase (see FIREBASE_SETUP.md)
4. Run `flutter run`

## Code Style

- Follow Dart style guide
- Use `flutter format` before committing
- Run `flutter analyze` to check for issues
- Write meaningful commit messages
- Add comments for complex logic

## Commit Message Format

```
Type: Brief description

Detailed description (if needed)

- Change 1
- Change 2
```

Types:
- `Add`: New feature
- `Fix`: Bug fix
- `Update`: Update existing feature
- `Refactor`: Code refactoring
- `Docs`: Documentation changes
- `Style`: Code style changes
- `Test`: Test additions/changes

## Pull Request Guidelines

- Provide clear description of changes
- Reference related issues
- Include screenshots for UI changes
- Ensure all tests pass
- Update documentation if needed

## Testing

- Test on both Android and iOS
- Test in light and dark modes
- Test with different screen sizes
- Verify Firebase integration
- Check for memory leaks

## Reporting Issues

When reporting issues, include:
- Device/OS version
- Flutter version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots/logs if applicable

## Feature Requests

- Check existing issues first
- Provide clear use case
- Explain expected behavior
- Consider implementation complexity

## Code Review Process

1. Maintainer reviews PR
2. Feedback provided if needed
3. Changes requested or approved
4. Merged into main branch

## Questions?

Open an issue or reach out to maintainers.

Thank you for contributing! 🎉
