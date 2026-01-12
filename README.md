# Reddit Style Comments

A highly customizable Flutter package for building recursive, Reddit-style threaded comment trees. It handles the complex logic of nesting, indentation, and thread lines automatically, allowing you to focus on your app's unique style and logic.

[![pub package](https://img.shields.io/pub/v/reddit_style_comments.svg)](https://pub.dev/packages/reddit_style_comments)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Ashar-Azeem/Reddit-Style-Comments/blob/main/LICENSE)

---

## ✨ Features

* **Recursive Nesting:** Supports infinite levels of nested replies with automatic indentation.
* **Smart Interaction:** Built-in callbacks for upvoting, downvoting, replying, and reporting.
* **Animated UI:** Smooth scaling animations for voting actions powered by `flutter_animate`.
* **Highly Customizable:** * Control background, text, and active/inactive vote colors.
    * Customizable vertical thread lines to visualize comment depth.
    * Support for both Network and Asset avatars.
* **Performance Optimized:** Uses a non-blocking `Column` based recursive approach to prevent layout crashes.

---

## 📸 Screenshot

| Threaded View | Nested Levels |
| :---: | :---: |
| <img src="https://raw.githubusercontent.com/Ashar-Azeem/Reddit-Style-Comments/main/reddit_style_comment(gif).gif" width="300"> | <img src="https://raw.githubusercontent.com/Ashar-Azeem/Reddit-Style-Comments/main/reddit_style_comment(image).jpg" width="300"> |


---

## 🚀 Getting Started

### Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  reddit_style_comments: ^0.0.1

