Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86C2A2E26
	for <lists+linux-edac@lfdr.de>; Mon,  2 Nov 2020 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgKBPVO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Nov 2020 10:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgKBPU6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Nov 2020 10:20:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8DC061A4A
        for <linux-edac@vger.kernel.org>; Mon,  2 Nov 2020 07:20:56 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so1146375wmd.4
        for <linux-edac@vger.kernel.org>; Mon, 02 Nov 2020 07:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J57Co4keOJLPpkOAtm30WeNaGboSbDo7KGbxSzSraLw=;
        b=WjUcLw8gDcHIiMrch+N57kyIWhFBESoNnwJbo8ozbR4u2s7V8dYOCGUGcrdCQs0A8c
         eQ33JQCo7FlLI/BSLX3oyaROh6lCmluXX5jsXGGHEInxOXk5kMdE5EkChmFgZmNwn3eb
         RwlsVtsZQHldyPx0J11ujW5fXjWbCiWcVuULMO77gCNRB/nW03qXSgrnoTEFhuGMBnUK
         sL+IQo1YUMwYJSK40SS6mEwNb1VtEI53RpcVxfuMkInp0D3aXlaGqbYsVindMPO71Ke3
         cZCq5fRNyBPIQZcN+ygz0gPhtpG7oZ2WlcrEtOMJ/4DQH9LXLeCfvwg9MCDRBNLrjhq/
         00Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J57Co4keOJLPpkOAtm30WeNaGboSbDo7KGbxSzSraLw=;
        b=bsQ4bX440883aCSpfxO/wo6srNwzUxjmnhEyj0z9oAhQFVL7B/auik3KnvIl7IB/DM
         rZVtnukLNcf7gQj3hwL278J547B+0b6ThxrbaFg/YKcQMHWgIm2nQvgpexKHbZTRw20y
         mmX/yHksqMmiRkxHfzhdAC48zwaRGdzrCfzGEVgD6lRtKoP2FCtxiRne1flcP7pYQL6M
         RHkQvdZullBIs14OZc09HXlQBSacE4IIc9eOTSEGeeemSF1Mkn5dDTCu5AdxvvcDuJ7U
         kWYVtK5QLgr3vrIA4C2zj7BEZrr/eId6Ce1vh5TljjSvjlkI2xDoaBlKLrMsEPnrGVry
         urNA==
X-Gm-Message-State: AOAM533v1+oS7gmw7PKNONTI5muoP0dRaf0DbcCZGx4NIOv3c6HjQz7/
        QOCt8B4+R9J7uLYtn9KDU0o/UQ==
X-Google-Smtp-Source: ABdhPJzrGRLOF2/QgV4EgJsGUrSZ+4C2XU14++PTKK4DegXurFNGMqip9Gki2NGq2KA3LkM7jho+gA==
X-Received: by 2002:a1c:4646:: with SMTP id t67mr18816040wma.40.1604330455334;
        Mon, 02 Nov 2020 07:20:55 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b18sm15138014wmj.41.2020.11.02.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:20:54 -0800 (PST)
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
Subject: [PATCH v2 7/8] hwtracing: intel: use krealloc_array()
Date:   Mon,  2 Nov 2020 16:20:36 +0100
Message-Id: <20201102152037.963-8-brgl@bgdev.pl>
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
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 3a77551fb4fc..7d95242db900 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -2002,7 +2002,7 @@ nr_pages_store(struct device *dev, struct device_attribute *attr,
 		}
 
 		nr_wins++;
-		rewin = krealloc(win, sizeof(*win) * nr_wins, GFP_KERNEL);
+		rewin = krealloc_array(win, nr_wins, sizeof(*win), GFP_KERNEL);
 		if (!rewin) {
 			kfree(win);
 			return -ENOMEM;
-- 
2.29.1

