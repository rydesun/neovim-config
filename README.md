不喜欢打开 nvim 噼里啪啦一通安装后才能用，
想要 nvim 在新机器上立刻可以投入使用。

**最小干扰：在新机器上立刻可用！**

无需安装任何插件，无需任何额外步骤，
配置立刻处于可用的状态 (除了少数按键不可用)。
仅仅提供一条不干扰使用的报错信息，
表明缺少插件管理器 lazy.nvim。
没有 lazy.nvim 就不会安装插件。
安装任务交给了 [`bootstrap.lua`](bootstrap.lua) 这个
仅用于首次安装的文件，只有运行该文件才会安装 lazy.nvim。
正常流程 init.lua 不会有安装行为。

## 安装

这份配置不是开箱即用的，因为没有 lazy.nvim 的情况下
不会自动安装插件。

让 nvim 执行安装脚本 `bootstrap.lua`，
即可安装插件管理器 lazy.nvim 和所有插件

```bash
VIM_DEV=1 nvim --headless -u bootstrap.lua +qa
```

插件应该可以正常工作了。此外，没有任何语言是必须提供支持的，
所以再自行安装 tree-sitter 的 parser 以及从 mason 安装 LSP。

**按需安装插件：区分本地开发环境和服务器。**

环境变量 `VIM_DEV=1` 是可选的，代表 nvim 在开发代码的环境中，
将会额外安装 [`lua/plugins/dev.lua`](lua/plugins/dev.lua)
文件内包含的开发用插件。在服务器等环境可以去掉该环境变量，
nvim 还是熟悉的 nvim，除了不需要进行代码开发以外。

实际上，指定 `VIM_DEV=1` 时，`bootstrap.lua` 只是在插件目录
`~/.local/share/nvim/lazy/` 下生成一个文件 `.install_dev`，
这样在配置文件中通过判断该文件是否存在，
就可以知道是否需要安装开发用插件。

## 按键映射

推荐在系统上改键：**交换右 Ctrl 和右 Alt**

左手的小指和拇指很忙，右手的拇指竟在呼呼大睡
(如果习惯用左手拇指按空格的话)。
交换右 Ctrl 和右 Alt，激活右手的拇指来按 Ctrl。
不仅可以左右开弓，
甚至可以让手指几乎**不移出标准指位**的情况下按出
<kbd>Shfit</kbd> + <kbd>Ctrl</kbd> + <kbd>Alt</kbd>。
另外好处还有，对键盘的影响最小。别人用你的键盘时
不会轻易察觉到有改动，不像改动左侧按键那样让人不适应。
任何普通键盘都能这样改，HHKB 反而成了没用的键盘。

> 没有 HHKB 难道便无法按键吗？Ctrl 岂是如此不便之物。

终端内可以用 <kbd>Ctrl</kbd> + <kbd>[</kbd> 代替 <kbd>Escape</kbd>。
如果不习惯的话，交换 <kbd>CapsLock</kbd> 和
<kbd>Escape</kbd> 也行。

不必交换 <kbd>CapsLock</kbd> 和 <kbd>Ctrl</kbd>。
比如 <kbd>Ctrl</kbd> + <kbd>z</kbd> 没之前说的方法好按，
而且左手小指已经承担了太多的任务，
尽量不要再给左手小指增加负担了。

按键映射集中在单文件
[`plugin/keymaps.vim`](plugin/keymaps.vim)
里面 (虽然还是有极少数散落在外)。
忘记按什么键，直接查看该文件即可，
不用到各个文件里查看按键，不需要依靠插件来管理。
至于用 Vimscript 还是 Lua 编写，全凭个人喜好。
我偏好用 Vimscript 写按键映射，因为一目了然。

按键的报错信息是负反馈，不是该被驱逐的东西。
没有加载特定插件导致的按键映射无效，按键时能报错，则**必须报错**，
明确的负反馈可以提醒使用者缺少特定插件。
这就是为什么我反对在插件 attach 时才加载该插件的 key mappings。
否则，在按键没有任何反馈时，无法知道是因为插件没有加载；
还是该功能已经成功运行，只是没有任何输出。
更糟糕的是，如果按键搞乱了正在编辑的文本，
还要费脑子反推原因竟然是插件没有加载。
只有 dial.nvim 或者 nvim-hlslens 这类在原按键上增强功能的插件，
才适合在插件加载时加载 key mappings。

> 你按得很好，下次不许再按了。
>
> —— <cite>nvim</cite>

## Pager

把 nvim 当成 pager 来使用，
同时禁用一些插件来提升启动速度

```bash
ls / | nvim -R --cmd 'let paging=1'
```

可以处理 ANSI 转义码 (调用 nvim 的内置 term)，颜色可以显示

```bash
ls --color=always / | nvim -R --cmd 'let paging=1 | let ansi=1'
```

作为 kitty 的 scrollback pager 来使用，
在配置文件 `kitty.conf` 中添加一行

```bash
scrollback_pager nvim -R --cmd "let paging=1 | let ansi=1"
```

处理 ANSI 的代码实现在 [`lua/utils/term-cat.lua`](lua/utils/term-cat.lua) 中。
其实是先把当前 buffer 写入到一个临时文件，再打开一个内置终端，
调用 `cat` 命令输出该文件。

