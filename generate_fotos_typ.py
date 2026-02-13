import argparse
import subprocess
from pathlib import Path

DEFAULT_PHOTOS_DIR = "fotos"
DEFAULT_OUTPUT = "fotos.typ"
DEFAULT_THUMBS_DIR = "thumbs"

SUPPORTED_EXTENSIONS = {
    ".jpg",
    ".jpeg",
    ".png",
    ".webp",
    ".gif",
    ".tif",
    ".tiff",
    ".bmp",
    ".heic",
    ".avif",
}


def is_photo(path: Path) -> bool:
    return path.is_file() and path.suffix.lower() in SUPPORTED_EXTENSIONS


def normalize_typst_path(path: Path) -> str:
    # Typst expects forward slashes
    return path.as_posix()


def generate_thumbnails(photos_dir: Path, thumbs_dir: Path) -> None:
    thumbs_dir.mkdir(parents=True, exist_ok=True)
    photos = sorted(
        (p for p in photos_dir.glob("*") if is_photo(p)),
        key=lambda p: p.as_posix().lower(),
    )

    for photo in photos:
        thumb_path = thumbs_dir / photo.name
        if thumb_path.exists():
            continue

        subprocess.run(
            ["sips", "-Z", "400", str(photo), "--out", str(thumb_path)],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=False,
        )


def build_typ_list(photos_dir: Path, relative_to: Path) -> str:
    photos = sorted(
        (p for p in photos_dir.rglob("*") if is_photo(p)),
        key=lambda p: p.as_posix().lower(),
    )

    items = []
    for photo in photos:
        items.append(f'  "{photo.name}"')

    return "#let fotos = (\n" + ",\n".join(items) + "\n)\n"


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Generate a Typst file listing all photos in the fotos directory."
    )
    parser.add_argument(
        "--photos-dir",
        default=DEFAULT_PHOTOS_DIR,
        help=f"Photos directory (default: {DEFAULT_PHOTOS_DIR})",
    )
    parser.add_argument(
        "--output",
        default=DEFAULT_OUTPUT,
        help=f"Output Typst file path (default: {DEFAULT_OUTPUT})",
    )

    args = parser.parse_args()
    cwd = Path.cwd()
    photos_dir = (cwd / args.photos_dir).resolve()
    output_path = (cwd / args.output).resolve()

    if not photos_dir.exists() or not photos_dir.is_dir():
        print(f"Photos directory not found: {photos_dir}")
        return 1

    thumbs_dir = (cwd / DEFAULT_THUMBS_DIR).resolve()
    generate_thumbnails(photos_dir, thumbs_dir)

    typ_content = build_typ_list(photos_dir, cwd)

    # Ensure output directory exists
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(typ_content, encoding="utf-8")

    print(f"Wrote {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
