# 创建目标目录
$targetDir = "assets/images/logos/youtube-tools"
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}

# 定义图标URL列表（使用更可靠的图标源）
$icons = @{
    "vidiq.png" = "https://cdn.vidiq.com/favicon-32x32.png"
    "tubebuddy.png" = "https://www.tubebuddy.com/wp-content/themes/tubebuddy/assets/images/favicon-32x32.png"
    "exploding.png" = "https://explodingtopics.com/static/img/favicon-32x32.png"
    "answerthepublic.png" = "https://answerthepublic.com/i/favicon-32x32.png"
    "canva.png" = "https://static.canva.com/static/images/favicon.ico"
    "davinci.png" = "https://www.blackmagicdesign.com/assets/images/favicon.ico"
    "socialblade.png" = "https://socialblade.com/favicon.ico"
    "morningfa.png" = "https://morningfa.com/favicon.ico"
    "kofi.png" = "https://storage.ko-fi.com/cdn/website/images/favicon.ico"
    "patreon.png" = "https://www.patreon.com/favicon.ico"
    "hootsuite.png" = "https://www.hootsuite.com/wp-content/themes/hootsuite/favicon.ico"
    "buffer.png" = "https://buffer.com/favicon.ico"
}

# 设置请求头
$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    "Accept" = "image/webp,image/apng,image/*,*/*;q=0.8"
    "Accept-Language" = "en-US,en;q=0.9"
}

# 下载每个图标
foreach ($icon in $icons.GetEnumerator()) {
    $outputPath = Join-Path $targetDir $icon.Key
    Write-Host "Downloading $($icon.Key)..."
    try {
        Invoke-WebRequest -Uri $icon.Value -OutFile $outputPath -Headers $headers
        Write-Host "Successfully downloaded $($icon.Key)"
    }
    catch {
        Write-Host "Failed to download $($icon.Key): $_"
        # 如果下载失败，创建一个默认图标
        Copy-Item "assets/images/default-icon.png" -Destination $outputPath -Force
        Write-Host "Created default icon for $($icon.Key)"
    }
}

Write-Host "All downloads completed!" 