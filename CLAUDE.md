# Sibisi Ramen 菜单网站

Valencia 的 Sibisi Ramen（食必思）三语（西 / 英 / 中）手机菜单。GitHub Pages 发布：https://hao1992.github.io/sibisi/

## 结构
- `index.html` — 线上页面，**由脚本生成，不要手改**
- `img/` — 菜品照片，按菜号命名（`2-5.jpg`），800×800 JPG
- `source/data.py` — 菜品、价格、过敏原、口味、加配菜、饮料、推荐搭配、界面文字
- `source/det.py` — 每道菜点开后的详细介绍（zh / es / en）
- `source/app.js.tpl`、`head2.part`、`illo.part` — 页面逻辑、样式、无照片时的示意插画
- `source/build.py` — 生成 `index.html`

## 改动流程
1. 改 `source/data.py` 或 `source/det.py`（价格是 `d("菜号", 中文名, 西语名, 英文名, 价格, ...)` 的第 5 个参数）
2. `python3 source/build.py`，输出里 `missing images` 应为 `none`
3. 用 grep 核对 `index.html` 里确实是新值，再 `git commit` + `git push`
4. Pages 部署需 1–3 分钟；查看时可加 `?v=数字` 绕过缓存

## 新照片
裁成正方形、去雾提亮、暖色、轻锐化，存成 `img/<菜号>.jpg`，然后在 `data.py` 对应菜加 `img="<菜号>"`。

## 规则
- 菜号是稳定的点单依据，不要改菜号
- 三种语言内容必须一致；改一种语言时同步另外两种
- 过敏原（G 麸质、H 鸡蛋、S 大豆、Sé 芝麻、P 鱼类、M 菌菇）每道菜都要准确；拿不准时宁可多标，并问店主
- 推荐搭配是**另收费**的加点，不能写得像套餐赠送
- 不要写店里没有的食材或做法；涉及做法的新描述先让店主确认
- 先改中文给 Hao 审核，确认方向后再同步西语 / 英语
