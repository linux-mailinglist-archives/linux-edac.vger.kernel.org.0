Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE72A2E2A
	for <lists+linux-edac@lfdr.de>; Mon,  2 Nov 2020 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgKBPVZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Nov 2020 10:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgKBPUx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Nov 2020 10:20:53 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B14EC061A48
        for <linux-edac@vger.kernel.org>; Mon,  2 Nov 2020 07:20:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 13so9780557wmf.0
        for <linux-edac@vger.kernel.org>; Mon, 02 Nov 2020 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cAnhvx340aJ9UoLX1zbzAI7OYOIgRl1WRMoR3sh/3E=;
        b=1SSGYQiV02UgtOHtJSH9FJfR85Ha4HUObVTcAB4GRJTGZaZIhzSrXM0vHFpOEKMzpy
         9AVGovKSH1wVLrXkWnMIzOHSW4wOPIS5fZx3b8ig/WoV5AMjTLszIAqy59pnDVv14w/l
         IYbEa1NUeZDKQoqe1O1eFKcs7UR1ERcou6uj5vI9B+71gx66QuxqtHDKWi7rH8IfdwOh
         yw48kSM/sVpl+pp3eua+NGFFDAf41lVgMyri3bmmaOjyWJ1HxXj6Xh4yzVYGP94elkAY
         ex0gQu47xGOfITLoiNnuoXnMesEvAqtWgstdC5/DubydCuhho06kgzvLJIxv7Zdk+/Mc
         9hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cAnhvx340aJ9UoLX1zbzAI7OYOIgRl1WRMoR3sh/3E=;
        b=dL3Exx0njoI4ctFMBbKP5vf35mb6X4jepvX96OwVMQr8mwDlY6VNmoWkHwWm/bIOFr
         INwcqE83aqucEKnS/VoMZedgS0ZtVU+mKS6lG1wuAfh+RXb7hinIel9wD3K6iwrc31xY
         H0tXayEQWTEWKIQfDZid0Hp18pwaVlyTD3uM6f+eB9gdH3PwGlCgo9W5ju1inpSgrhlD
         pPV2KQUibEahFTJAeZ86lgNmR/w3SL8WDQxjySzY2WzyhY8ndO80j1i25xiyzbNQSxA3
         8Dc2TNQT2VOkIquEq1AmBxn1tdJHEdvX03VR3ghvhJWJZTajIUdnRgwQfLhKvkGUlUvO
         /Tlw==
X-Gm-Message-State: AOAM531BQc3iW8VH2b3LJ67zxEK0YY/2k3nC7okjRsRDbTl46fo1njjT
        fIYnaCtXBX3i0ATiCgUaglf4wQ==
X-Google-Smtp-Source: ABdhPJwOKpBOX0BSWWvVIHmaQ9Otc3dpDKHkytegGJ3V2bSQroVjGauUhivRRvqIF6S2knMM749pFQ==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr11705984wmb.45.1604330451271;
        Mon, 02 Nov 2020 07:20:51 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b18sm15138014wmj.41.2020.11.02.07.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:20:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        alsa-devel@alsa-project.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 5/8] edac: ghes: use krealloc_array()
Date:   Mon,  2 Nov 2020 16:20:34 +0100
Message-Id: <20201102152037.963-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102152037.963-1-brgl@bgdev.pl>
References: <20201102152037.963-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the helper that checks for overflows internally instead of manually
calculating the size of the new array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/ghes_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index a918ca93e4f7..6d1ddecbf0da 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -207,8 +207,8 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 	if (!hw->num_dimms || !(hw->num_dimms % 16)) {
 		struct dimm_info *new;
 
-		new = krealloc(hw->dimms, (hw->num_dimms + 16) * sizeof(struct dimm_info),
-			        GFP_KERNEL);
+		new = krealloc_array(hw->dimms, hw->num_dimms + 16,
+				     sizeof(struct dimm_info), GFP_KERNEL);
 		if (!new) {
 			WARN_ON_ONCE(1);
 			return;
-- 
2.29.1

