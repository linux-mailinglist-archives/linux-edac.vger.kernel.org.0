Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823BE29ABB2
	for <lists+linux-edac@lfdr.de>; Tue, 27 Oct 2020 13:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbgJ0MSB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Oct 2020 08:18:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbgJ0MR4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Oct 2020 08:17:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id d78so1166540wmd.3
        for <linux-edac@vger.kernel.org>; Tue, 27 Oct 2020 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNS5tvBpA/i0H7p7l8m9y8bW5QzwJCcb9cwqd3juySc=;
        b=uINaxail9sUfALoEWstn2csJR9jE7v9clDsZtLcLiOMSXg2LAVFIQqN6lHKyyZUd4l
         jRiwMGMG4DxMFJH69rSCLOtob+027D28VPhBQtpIrjKA/W5lb5Kv+7Q+cjTTcQNW8hxv
         wUoV9A8I84g3amtYBnRWsQ9zCBUoSUYIxS8yqik5kvDE0D17HbZwhUPBEWV0xwo4eSQB
         xtGlMRrIXAwBsMOZYueqppFbh9JQaNXeAayhSnZZJNrW9nmKvVAevDfxEiP//pXPGQn7
         22ZoAAwvkiz2v+dHQuQfEfVqcnXh5D2KeVL1FBqvTUVKMuvl7wX7b6wRp1orV+Uuzzwn
         SgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNS5tvBpA/i0H7p7l8m9y8bW5QzwJCcb9cwqd3juySc=;
        b=R2GjepMoWb9gE8Lg8PjIfn32cTSy/3uIpJDnjQoPtgEsuNOs/ezr8ZnzKYz7tFPp85
         1FA1lSknXHs4970MPjq1qtMgQ6s9cPtwFu0Qg/VBihXLIOzwa9NfLiBY4txKjVT2Fc0U
         xXxVeBkejyGx6J+1D+K7d+VNsxo8V7qCpGDZ2xtDBWro5MHntKjkRpz90Sov3pjP1Zx/
         shhlhWZLkzje2pixV4J1qV2YcVN0sqstQaVf3kj9GUgJtuB6cuCeBlCaROgHhYUReqF/
         aJiQk0t6JOMFdI/KsWqb+vboqSejeZYLrVcy5EfkNoCMXTDVrQNxRiVghftN+bpwd6UY
         aqwg==
X-Gm-Message-State: AOAM533GML4Cv2BxCntoUWa9z3uyY1VPeKomXXcMsbqg7RQdgXB6/8gt
        SSBehies/IQKUrXYpB3YNGDv2g==
X-Google-Smtp-Source: ABdhPJwlnp8d7/fOEkypkqwExUCmIl2RKP9vSFIY6Z3TXZuynGv+gQ6ZzaCTjRN4xR7i9/EdKZccow==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr2460319wmo.143.1603801072719;
        Tue, 27 Oct 2020 05:17:52 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id a2sm1731908wrs.55.2020.10.27.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:17:51 -0700 (PDT)
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
Subject: [PATCH 8/8] dma-buf: use krealloc_array()
Date:   Tue, 27 Oct 2020 13:17:25 +0100
Message-Id: <20201027121725.24660-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027121725.24660-1-brgl@bgdev.pl>
References: <20201027121725.24660-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the helper that checks for overflows internally instead of manually
calculating the size of the new array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

