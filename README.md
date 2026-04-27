# 규호 ❤ 태은 · 모바일 청첩장

2026년 4월 26일, 더청담 노블레스. 단일 HTML 파일 기반의 정적 모바일 청첩장입니다. 외부 의존성은 Google Fonts 하나뿐이라 빌드 과정 없이 어디든 올리면 그대로 동작합니다.

## 파일 구조

```
wedding-invitation/
├── index.html        ← 청첩장 본체 (전부 inline)
├── assets/           ← 갤러리 사진을 다운로드해서 이곳에 보관 (선택)
├── download_images.sh ← 갤러리 사진 일괄 다운로드 스크립트
├── .gitignore
└── README.md
```

## 로컬에서 미리보기

```bash
# Python이 깔려 있다면
python3 -m http.server 8000
# 또는 Node.js
npx serve .
```

브라우저에서 `http://localhost:8000` 열면 끝.

## 사진을 자체 호스팅으로 옮기기 (권장)

현재 `index.html`의 갤러리 이미지는 바른손카드 CDN을 그대로 참조합니다. 진짜 영구 보관을 원하시면 본인 도메인에 사진을 두는 게 안전합니다.

```bash
chmod +x download_images.sh
./download_images.sh
```

다운로드가 끝나면 `index.html`에서 갤러리 `<img src="...">` 9개와 `og:image` meta, 그리고 `cover-photo`의 `background-image: url(...)`를 모두 `assets/01.jpg` ~ `assets/09.jpg` 형태로 바꿔주세요. (`Find & Replace` 한 번이면 끝납니다.)

## GitHub에 올리기

```bash
cd wedding-invitation
git init
git add .
git commit -m "feat: initial wedding invitation"
git branch -M main

# GitHub에서 빈 저장소 만든 다음 (예: alliswell426)
git remote add origin https://github.com/<YOUR_ID>/alliswell426.git
git push -u origin main
```

## 배포 옵션 — 무료 + 영구

### A. GitHub Pages (가장 간단)

1. GitHub repo → **Settings → Pages**
2. **Source**: Deploy from branch
3. **Branch**: `main` / `(root)` → Save
4. 1~2분 뒤 `https://<ID>.github.io/<repo-name>/`에서 확인

### B. Vercel (커스텀 도메인 가장 편함)

1. [vercel.com](https://vercel.com) → New Project → GitHub repo 선택
2. Framework Preset: **Other** (그대로 둠)
3. Deploy
4. **Settings → Domains**에서 도메인 연결

### C. Cloudflare Pages (속도 가장 빠름, 한국에서 체감 빠름)

1. [Cloudflare Dashboard](https://dash.cloudflare.com) → Workers & Pages → Create
2. Connect to Git → repo 선택
3. Build command: 비워둠 / Output directory: `/`
4. Deploy → Custom domains에서 도메인 연결

## 도메인 연결

연결할 도메인이 준비되면 알려주세요. DNS 레코드(A/CNAME) 설정값과 SSL 인증 흐름까지 같이 정리해드릴 수 있습니다.

## 커스터마이징 가이드

### 인사말 / 텍스트 수정
`index.html` → `<!-- ===== GREETING ===== -->` 섹션 안의 `.greeting-text` 내용 변경

### 이미지 추가/삭제
갤러리: `<!-- ===== GALLERY ===== -->` 안의 `.gallery-item` 9개를 추가/삭제. 갯수가 바뀌면 카운터 표기도 같이 (`/ 09 — Swipe`).

### 색상
`<style>` 최상단의 `:root` 변수만 바꾸면 전체 톤이 바뀝니다.
```css
--bg: #F5EFE6;          /* 배경 크림 */
--accent: #B08968;      /* 포인트 골드 */
--rose: #C9A09A;        /* 더스티 로즈 */
--sage: #9CA886;        /* 세이지 */
```

### 글꼴
`<head>`의 Google Fonts URL을 교체하고 `:root` 아래 `.lat`, `.kor` 클래스가 가리키는 font-family를 수정.

### 카카오톡 공유 (선택)
현재는 Web Share API + 링크 복사 fallback으로 동작합니다. 카카오 인앱 브라우저에서 좀 더 예쁘게 떠야 한다면 [Kakao JS SDK](https://developers.kakao.com/docs/latest/ko/kakaotalk-sharing/js-link)를 적용하세요. 앱 키 받아오시면 도와드립니다.

### 방명록 (선택)
정적 사이트라 백엔드가 없습니다. 다음 중 택1해서 `<!-- ===== GUESTBOOK PLACEHOLDER ===== -->` 영역에 임베드:
- **Giscus** (GitHub Discussions 기반, 무료): https://giscus.app
- **Disqus**: https://disqus.com
- **Google Forms**: 가장 단순. 글 보기는 별도 페이지

## 검토 포인트

- [ ] 혼주 성함 표기 확인 (현재: 정태희 · 이명숙 / 김영국 · 이미숙)
- [ ] 식장 홀명 확인 (현재: 2F 노블레스홀 — 더청담 실제 홀명으로 수정 필요할 수 있음)
- [ ] 교통 정보 정확성 (지하철·버스 노선)
- [ ] 갤러리 사진 자체 호스팅으로 이전
- [ ] 카카오톡 공유 시 썸네일 (`og:image`) 점검
- [ ] 도메인 연결

문의 사항은 새 채팅 또는 이 채팅에서 이어서 물어보시면 됩니다.
