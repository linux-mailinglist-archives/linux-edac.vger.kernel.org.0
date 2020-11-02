Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35092A2E20
	for <lists+linux-edac@lfdr.de>; Mon,  2 Nov 2020 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgKBPVA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Nov 2020 10:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgKBPVA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Nov 2020 10:21:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187DC0617A6
        for <linux-edac@vger.kernel.org>; Mon,  2 Nov 2020 07:20:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so9760414wmh.1
        for <linux-edac@vger.kernel.org>; Mon, 02 Nov 2020 07:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2w+mckzOvrR699h8x/Xo77oVyHlYkQYkZ/tcGlQNKA=;
        b=s1X5Rn6M3uEqYAtmP0kMjZBhh9+T3p5FrLN+EMPkAgjibT+uR/uD2Ngl5VYCdQB9ij
         cQ6fxK8h+9iDfacQPynKZ5VyW7F6bKG7h/Mn2H7upcsowgEdGzkDXW0ZeoKAxWlZFX5x
         pqI6X7Y1SxJBUvvLsIqozUVcIl4kjDlk/82AQ/NKJkAUAZxchqqk6ZD/i9gwMOE04t7b
         WEkSas1VOVRvcMuWMty1ScX6mRMpJB2pYQQLO7hPytPI/lP2lQ51TXcmMAV2jxgLlrYn
         9vORg+bb2oQsagTOeapcQPmylm4ykQl2cpkCX5KomC0i7s4Qx+hD5CK4/4R0xv0vDrV1
         0OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2w+mckzOvrR699h8x/Xo77oVyHlYkQYkZ/tcGlQNKA=;
        b=DhaGn1x69M6cOBQw9tSD+OPd6pYdL5gCODXQc7S/JwHtLEmiyI7uxR4uc/y6Y4a6fz
         hQBW5XWg/ngl3i930e1dPeQ8UcB0i4V7RVVidarN6yuIE0ZfHC2SdV4w3t0flCdKmz/x
         jswePpylaoBXUfTNjpKJO+1hcsX96+GcfHPfnQpxAnjwaUhJC3bK7XiMQiYLcA/YntDi
         H8B75LELCLojJH23z2kWBSDBb2fAHHklbVZWCOZHFrhYfpXNeMm+SiUu3ux08rXTSkLk
         xh1mwHkWK/ZuMAHvsCOs+vSQMgk84oibulnUcFF/skKG63VvwLTqhgRUfvbAEaFwr/uy
         AEPQ==
X-Gm-Message-State: AOAM5329YUXT86HmreKJlUpymXV6AoL06ItdSPlATY4WQCKlkXYtRpYn
        RR0cVxzhY3eoaPYFG72DGSSsPA==
X-Google-Smtp-Source: ABdhPJyD2xFNQ0mA6fkAF0MmLHKBRwPoEVnTSJcs4kw8eo3aVlf+gVmqgA5IOaVwyXiBRsxgcVYV4w==
X-Received: by 2002:a1c:68c1:: with SMTP id d184mr17928489wmc.74.1604330457481;
        Mon, 02 Nov 2020 07:20:57 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b18sm15138014wmj.41.2020.11.02.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:20:56 -0800 (PST)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 8/8] dma-buf: use krealloc_array()
Date:   Mon,  2 Nov 2020 16:20:37 +0100
Message-Id: <20201102152037.963-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102152037.963-1-brgl@bgdev.pl>
References: <20201102152037.963-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the helper that checks for overflows internally instead of manually
calculating the size of the new array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/sync_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 5a5a1da01a00..2925ea03eef0 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -270,8 +270,8 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
 		fences[i++] = dma_fence_get(a_fences[0]);
 
 	if (num_fences > i) {
-		nfences = krealloc(fences, i * sizeof(*fences),
-				  GFP_KERNEL);
+		nfences = krealloc_array(fences, i,
+					 sizeof(*fences), GFP_KERNEL);
 		if (!nfences)
 			goto err;
 
-- 
2.29.1

