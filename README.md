# 규호 ❤ 태은 · 모바일 청첩장

2026년 4월 26일, 더청담 노블레스. 단일 HTML 페이지 + JSON 설정 파일 + GitHub API 기반 백오피스로 구성된 정적 청첩장입니다.

## 파일 구조

```
wedding-invitation/
├── index.html        ← 청첩장 본체 (config.json 자동 로드)
├── admin.html        ← 백오피스 (사진·음악·텍스트 편집)
├── config.json       ← 콘텐츠 설정 (admin이 자동 갱신)
├── assets/           ← 사진·음악 파일들
│   ├── 01.jpg ~ 09.jpg
│   └── bgm.mp3
├── download_images.sh
├── README.md
└── .gitignore
```

## 동작 방식

```
[브라우저] → index.html 로드 → config.json fetch → DOM에 반영
                                       ↑
[관리자] admin.html ← GitHub API → repo에 직접 commit
```

`index.html`은 페이지 로드 시 `config.json`을 읽어 커버 이미지, 갤러리, 배경음악, 이름, 인사말 등을 동적으로 채웁니다. 관리자는 `admin.html`에서 GitHub Personal Access Token으로 인증한 뒤, 브라우저 UI만으로 사진을 올리고 설정을 바꿀 수 있습니다. 저장하면 GitHub repo에 자동 commit되고, 1~2분 뒤 GitHub Pages에 반영됩니다.

## 백오피스 사용법 (admin.html)

배포 후 `https://<ID>.github.io/<repo>/admin.html` 로 접속.

### 1. GitHub Personal Access Token 발급 (최초 1회)

1. GitHub 로그인 후 [토큰 발급 페이지](https://github.com/settings/tokens/new?scopes=repo&description=Wedding+Admin) 접속 (자동으로 필요한 권한이 체크됨)
2. **Note**: `Wedding Admin`
3. **Expiration**: 결혼식 이후로 충분히 긴 기간 (90 days 이상)
4. **Scopes**: `repo` 하나만 체크 (이미 체크되어 있음)
5. **Generate token** → 표시된 `ghp_...` 문자열 복사

> ⚠ 토큰은 한 번만 보입니다. 즉시 admin 페이지에 입력하세요.

### 2. 로그인

admin 페이지에서:
- **GitHub Username**: `github.com/yourname/repo`의 `yourname` 부분
- **Repository Name**: repo 이름
- **Branch**: `main` (기본값)
- **Personal Access Token**: 위에서 복사한 값

토큰은 본인 브라우저의 `localStorage`에만 저장됩니다. 외부로 전송되지 않습니다.

### 3. 콘텐츠 편집

| 탭 | 할 수 있는 일 |
|---|---|
| **텍스트** | 신랑·신부 이름(한/영), 인사말, 페이지 타이틀 |
| **메인 이미지** | 갤러리 사진 중 커버로 쓸 사진 선택, 새 사진 업로드 |
| **갤러리** | 사진 추가, 순서 변경(←/→), 갤러리에서 제거 |
| **배경음악** | mp3 업로드, 현재 사용 중인 음악 미리듣기, 음악 변경 |

변경사항이 있으면 하단에 분홍색으로 "저장되지 않은 변경사항이 있습니다" 표시. **저장하기**를 누르면 GitHub repo에 commit되고 1~2분 뒤 사이트에 반영됩니다.

### 주의사항

- **파일 크기**: 사진은 10MB 이하 권장. 음악 파일은 압축해서 5MB 이하로 (GitHub은 100MB까지 허용하지만 로딩 속도 고려).
- **파일 이름**: 한글·공백·특수문자는 자동으로 영문화됩니다. 동일 이름이면 timestamp가 붙어 새 파일로 저장됩니다.
- **갤러리에서 제거 ≠ 파일 삭제**: 제거해도 repo의 `assets/` 폴더에 파일은 남습니다(휴지통 개념). 완전히 지우려면 GitHub repo에서 직접 삭제.
- **저작권**: 상업 음원(스트리밍 OST 등)은 사용 불가. YouTube 오디오 보관함, Pixabay Music 등 라이선스 명확한 음원만.

## 로컬에서 미리보기

```bash
python3 -m http.server 8000
# 또는
npx serve .
```

브라우저에서 `http://localhost:8000`. admin 페이지는 `http://localhost:8000/admin.html`.

## 사진 일괄 다운로드 (최초 셋업용)

```bash
chmod +x download_images.sh
./download_images.sh
git add assets/
git commit -m "feat: add gallery images"
git push
```

## 배포 — GitHub Pages

1. repo → **Settings → Pages**
2. **Source**: Deploy from a branch
3. **Branch**: `main` / `(root)` → **Save**
4. 1~2분 후 `https://<ID>.github.io/<repo>/`에서 확인
5. admin 페이지: `https://<ID>.github.io/<repo>/admin.html`

## 커스텀 도메인 (선택)

repo 루트에 `CNAME` 파일 추가 후 도메인 등록처에서 DNS 레코드 설정:

```
타입: A    호스트: @    값: 185.199.108.153
타입: A    호스트: @    값: 185.199.109.153
타입: A    호스트: @    값: 185.199.110.153
타입: A    호스트: @    값: 185.199.111.153
```

상세는 [GitHub Pages 커스텀 도메인 가이드](https://docs.github.com/ko/pages/configuring-a-custom-domain-for-your-github-pages-site) 참고.

## config.json 직접 수정하기 (admin 없이)

`config.json`을 텍스트 에디터로 열어서 수정 후 commit해도 동일하게 동작합니다. admin 페이지는 이 작업을 GUI로 대신해주는 도구일 뿐입니다.
