#!/usr/bin/env bash
# 갤러리 사진을 assets/ 디렉토리로 다운로드합니다.
# 실행: chmod +x download_images.sh && ./download_images.sh
set -e

mkdir -p assets

BASE="https://mcard-resources.barunsoncard.com/upload/invitation/260225/1138414/gallery"

declare -a IMAGES=(
  "dec90ae7-4fbc-427c-870c-b7c895e6b629.jpg"
  "cc79f353-4962-4724-b8df-a59b53540f7f.jpg"
  "8912a2bb-3bbc-4e91-881f-b92f7b203255.jpg"
  "141bf289-e633-4e3a-943f-f8ef92e6c85f.jpg"
  "db476932-4298-4898-8fef-5cb26e27839e.jpg"
  "aeb154c8-f22d-44d4-8252-4548a23ed6f8.jpg"
  "5f1c1e4f-382a-44f9-b23f-87cdcc33e4ee.jpg"
  "9ffdc041-0518-4c30-9bab-ee2d6a1e68c7.jpg"
  "009fdde8-7e1d-4d6c-9fed-3a19c1ba2185.jpg"
)

i=1
for filename in "${IMAGES[@]}"; do
  out=$(printf "assets/%02d.jpg" "$i")
  echo "→ Downloading $out"
  curl -fsSL "$BASE/$filename" -o "$out"
  i=$((i+1))
done

echo ""
echo "✓ 9장 모두 받았습니다."
echo "  이제 index.html에서 갤러리 src를 assets/01.jpg ~ assets/09.jpg로 바꿔주세요."
