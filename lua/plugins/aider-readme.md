In Neovim, as in Vim, you can yank text into a specific register by prefixing the yank command with `"` followed by the register name. Registers are named with single letters or certain symbols, and you can use either lowercase or uppercase letters to specify the register. Using a lowercase letter will overwrite the register, while using an uppercase letter will append to the register.
Here's how you can yank text into a specific register:

1. To yank a line into register `a`, you would use:
   ```
   "ayy
   ```
   This yanks the current line into register `a`.
2. To yank a selection (in visual mode) into register `b`, you would first select the text using visual mode (`v` for character-wise, `V` for line-wise, or `Ctrl-v` for block-wise), and then type:
   ```
   "by
   ```
   This yanks the selected text into register `b`.
3. To append yanked text to an existing register, use an uppercase letter. For example, to append a line to register `a`, you would use:
   ```
   "Ayy
   ```
   This appends the current line to the contents of register `a`.
   Remember that registers are very useful for storing different bits of text that you want to paste later. To paste from a register, you would use the paste command (`p` or `P`) with the register name. For example, to paste the contents of register `a`, you would type:

```
"ap
```

This pastes the contents of register `a` after the cursor position. Use `P` to paste before the cursor position.
You can view the contents of all registers by typing:

```
:registers
```

or just for a specific register (e.g., register `a`):

```
:registers a
```

This will display the contents of the specified register(s) in a list.
