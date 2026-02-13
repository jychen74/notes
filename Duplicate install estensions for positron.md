## Export extension list

```
positron --lis-extensions > "$HOME\Desktop\extensions_list.txt"

```

- 會在桌面產生一個文字檔

## Install extensions from a list

- 可以把 extension list 放在桌面上

```
Get-Content "$HOME\Desktop\extensions_list.txt" | ForEach-Object { positron --install-extension $_ }

```
