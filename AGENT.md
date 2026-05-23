# `wedding-invitation/` — Reference Asset (NOT an Agent)

> ⚠️ 이 폴더는 **에이전트 작업 폴더가 아닙니다.**
> 정규호·태은의 실제 결혼식 정적 모바일 청첩장 프로젝트이며, **AI 청첩장 서비스의 디자인·구조·UX 학습 소스(읽기 전용)** 입니다.
>
> Git: <https://github.com/GueHoJung88/wedding.git>

---

## 1. 위치 및 정체성

- **로컬 경로**: `/Users/hdh05945/Business/wedding-invitation`
- **성격**: 1회성 정적 웹 결과물 (HTML/CSS/JS)
- **역할**: AI Wedding Invitation Service Agent 의 **레퍼런스 자산(Reference Asset)**
- **소유권**: SQUATS Inc.

## 2. 에이전트가 이 폴더를 다루는 규칙

| 행동 | 허용 | 비고 |
|---|---|---|
| 읽기 (구조·스타일·콘텐츠 분석) | ✅ | 자유롭게 |
| 자산 추출 (이미지·BGM·HTML 패턴) | ✅ | 출처 메타데이터를 같이 추출 |
| 디자인 토큰 추출 (색상·폰트·간격) | ✅ | `tokens.json` 형태로 서비스 에이전트에 전달 |
| **수정·커밋·삭제** | ❌ | 본인 결혼식 자산. 무결성 보존 |
| 빌드·서비스 실행 | ❌ | 정적 HTML 직접 오픈으로 충분 |
| 포트 점유 | ❌ | 본 프로젝트는 포트를 사용하지 않음 |

## 3. 추출 가이드 — 서비스 에이전트가 가져갈 것

```
wedding-invitation/
├── (HTML 구조)        → 청첩장 섹션 분류(인사말·갤러리·약도·계좌·RSVP …)
├── (CSS/스타일)        → 디자인 토큰: --color-*, --font-*, --space-*
├── (이미지)            → 비율·구도·필터 톤 학습용
└── (BGM)              → 분위기 레퍼런스
```

추출 결과는 다음 위치에 적재합니다.

```
ai-wedding-invitation-service-agent/
└── reference/
    ├── tokens.json        # 디자인 토큰
    ├── sections.json      # 섹션 구조 스키마
    └── samples/           # 익명화/저작권 검토 후 샘플
```

## 4. 침해 방지 (필수사항)

- 본 폴더는 **포트를 점유하지 않음.** 다른 프로젝트와 충돌 없음.
- 다른 에이전트가 이 폴더에 쓰기 작업을 시도하면 **즉시 중단** 하고 `decisions.log` 에 차단 사유를 기록하라.

## 5. 변경 이력

이 폴더의 변경은 정규호 본인이 직접 git 커밋한 경우에만 유효합니다. 에이전트 자동 변경 금지.
