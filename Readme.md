# EnchantSearch
[![Version](https://img.shields.io/github/v/release/YourGitHubUsername/EnchantSearch?color=blue&label=version)](https://github.com/YourGitHubUsername/EnchantSearch/releases)
![WoW Version](https://img.shields.io/badge/WoW-1.12.1-ff69b4)
![License](https://img.shields.io/badge/license-MIT-green)
[![Latest ZIP](https://img.shields.io/badge/dynamic/json?color=success&label=Latest&query=$.assets[0].download_count&url=https://api.github.com/repos/YourGitHubUsername/EnchantSearch/releases/latest)](https://github.com/YourGitHubUsername/EnchantSearch/releases/latest) 

<a href="https://www.paypal.com/donate/?hosted_button_id=JCVW2JFJMBPKE" target="_blank">
    <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" 
         alt="Donate with PayPal" style="border: 0;">
</a>
<a href="https://www.paypal.com/donate/?hosted_button_id=JCVW2JFJMBPKE" class="paypal-button" target="_blank">
    💙 Buy me a coffee – support the addon
</a>

## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Compatibility](#compatibility)
- [License](#license)

## 📝 Overview

**EnchantSearch** enhances the default **CraftFrame** in WoW 1.12.1 by adding a real-time search box for enchantments.

<p align="center">
  <img src="EnchantSearch/screenshot.jpg" alt="Search Box" width="600">
</p>

It allows you to:
- Instantly filter enchant recipes by name
- Jump directly to the selected enchant
- Automatically expand collapsed headers
- Preview enchant stats via tooltip integration

This addon is written **exclusively for the WoW 1.12.1 API** and avoids modern functions to ensure full Vanilla compatibility.

## ✨ Features

- **Live Search Box**
  - Search enchantments by typing part of the name
  - Case-insensitive, instant filtering
  - Clears results automatically on escape

- **Smart Navigation**
  - Automatically expands required headers
  - Scrolls the Craft list to the correct position
  - Selects the recipe directly

- **Tooltip Stat Preview**
  - Hovering a result shows the enchant name
  - Displays enchant stats if available via `EnchantStatsDB`

- **Clean UI Integration**
  - Appears only when the Craft window is opened
  - Auto-adjusts positioning for pfUI

## 🛠️ Installation

1. **Download the Addon:**  
   👉👉👉[![⬇ DOWNLOAD](https://img.shields.io/github/downloads/YourGitHubUsername/EnchantSearch/total?style=for-the-badge&color=00b4d8&label=⬇+DOWNLOAD)](https://github.com/YourGitHubUsername/EnchantSearch/releases)👈👈👈

2. **Extract Files:**  
   - Extract the contents to your WoW addons directory:
     ```
     World of Warcraft/Interface/AddOns
     ```
   - Make sure the folder name is `EnchantSearch`.

3. **Enable the Addon:**  
   - Launch WoW and go to the AddOns menu from the character selection screen.  
   - Ensure that the addon is enabled in the list.

4. **IF YOU ARE HAVING TROUBLES**
   - 📘 [How to install addons](https://github.com/pumpan/howtoinstalladdons/wiki)


## 🚀 Usage

1. Open a profession that uses the **CraftFrame** (e.g. Enchanting)
2. The **Search box** will appear automatically
3. Start typing to filter enchantments
4. Click a result to:
   - Expand headers
   - Scroll to the recipe
   - Select it automatically
5. Press **Escape** to clear search and hide results


## 🔌 Compatibility

- ✅ WoW 1.12.1
- ✅ Enchanting profession
- ✅ Works with pfUI



## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

💙 Contributions and feedback are welcome!
