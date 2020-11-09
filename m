Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84F2AB602
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 12:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgKILHo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 06:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgKILHN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Nov 2020 06:07:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E8CC061A52
        for <linux-edac@vger.kernel.org>; Mon,  9 Nov 2020 03:07:09 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so8204330wrc.11
        for <linux-edac@vger.kernel.org>; Mon, 09 Nov 2020 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iECHQmtOjlKNpXGH67tnBHQ9XW515B1GPzEiiSpCWAs=;
        b=xWDYj2fBLmHGr/Gy85P06U2gKM3D4irotg7Jdhw1AyiBnRSDDMWVsz+UsdmoIiJ1F6
         nBdb9dPDrCjuHs2goVBwrr6i6L4C7nSkDDkQ52BSJEmC2Sc+Lp3e/ArXtKhoYyq2tjlm
         enDVDKNvTwWmAC7ozqpXJrCXGsNiuZH44PQN4c/a7dPfoMS2oPpYh7i3mNmXgbZlJvFE
         GIrrnt+rSBU33vfETv4kqGiEQcGPEdca2Jt17hBqqYBDAZWSOPL0sA/n+Zbdml7GLRC0
         DkMxtT7MSeOhKhfcqgYLWG72cc/mZ35Yq91+n4gnXf+cL4HS0AnCOswBrOImbVlmN+XV
         kQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iECHQmtOjlKNpXGH67tnBHQ9XW515B1GPzEiiSpCWAs=;
        b=dDuSQuw2/ipbE65ama8H73CHxzPI9UlIdO69j6vZCAE572K9nFdh7qpv8xy74KG+VW
         wHF+e7m+4SQSRYbR4JofNzsBu2NRWQzG6KWMxvNTa0KJYnX6KzCr/5TpLoIB0LyFOedz
         u4EdgDiM9R+nyceYP7375QzgRE+enK/LAW6npE3DJvKjFlAQxUcTy5FyFKrkktDNssGV
         /o7eteXR+6ULRPX9I2o3r5gJzeD5KjNgKHH9VzrAiO5LwMV3uKDj8rGssk6A4b20RDMg
         wV+bCI38A3c1QQRJJy/PjKcTqv4noozru4erYgPuDWZIVxXC93q9Et8hhLkbxY0SRsee
         HJFQ==
X-Gm-Message-State: AOAM533+tUVUiMQBCNA/f4prn06YkRtFg3jtbw86PDgbWWesxgJxigu2
        tNUHGQnIe8IErSxIeP+CiHdQvw==
X-Google-Smtp-Source: ABdhPJxJIoqvvP9l/776r7Kb43HV1AC5EVztuqTnCOgkzEIqxPExxehDC+JhspQEHF3syfUB3O2Rrw==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr17320974wrn.165.1604920028177;
        Mon, 09 Nov 2020 03:07:08 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id d3sm12815582wre.91.2020.11.09.03.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:07:07 -0800 (PST)
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
Subject: [PATCH v3 5/9] pinctrl: use krealloc_array()
Date:   Mon,  9 Nov 2020 12:06:50 +0100
Message-Id: <20201109110654.12547-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110654.12547-1-brgl@bgdev.pl>
References: <20201109110654.12547-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the helper that checks for overflows internally instead of manually
calculating the size of the new array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-utils.c b/drivers/pinctrl/pinctrl-utils.c
index f2bcbf62c03d..93df0d4c0a24 100644
--- a/drivers/pinctrl/pinctrl-utils.c
+++ b/drivers/pinctrl/pinctrl-utils.c
@@ -39,7 +39,7 @@ int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
 	if (old_num >= new_num)
 		return 0;
 
-	new_map = krealloc(*map, sizeof(*new_map) * new_num, GFP_KERNEL);
+	new_map = krealloc_array(*map, new_num, sizeof(*new_map), GFP_KERNEL);
 	if (!new_map) {
 		dev_err(pctldev->dev, "krealloc(map) failed\n");
 		return -ENOMEM;
-- 
2.29.1

