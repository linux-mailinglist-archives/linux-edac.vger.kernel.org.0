Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D412A2E1B
	for <lists+linux-edac@lfdr.de>; Mon,  2 Nov 2020 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKBPUz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Nov 2020 10:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgKBPUz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Nov 2020 10:20:55 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940EAC0617A6
        for <linux-edac@vger.kernel.org>; Mon,  2 Nov 2020 07:20:54 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so8229095wml.5
        for <linux-edac@vger.kernel.org>; Mon, 02 Nov 2020 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Z+wwi/tFfEYyTBQIvrIHI75+eOD/rtT/HKhEUnLNfQ=;
        b=e5kjyidWL8cmpiZH3KN4gbQ7mPV2yzGx2nkYanw2be0opJ+Vz0F/h7+cASkSpyPvft
         Cq/QKHKgAn39kkunAelTRvo6+t//6O8sFAxBBIWVN/D/sXHLN0TcApD154vCBfBKfHLt
         cLayxxCVPglJdryRP0qymWqoSldB8VezR3ze+ww/h6mL64irtmyW1Iv/4QeMsHgFEmU1
         EnCxPQadIxfRrkqDHNb0AWnJ/TDZd1tbaPxP67i/kRiJU0AadmF8tkFzS5SiBFs65eHd
         s2porevmNAwd7EJUylR58be5iKdfMpI6Ofog3Lr78MGsAlfmarg/IAiyvFrSdsneofbm
         aJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Z+wwi/tFfEYyTBQIvrIHI75+eOD/rtT/HKhEUnLNfQ=;
        b=dXFh+KbALQjGQotcPEBfJDeWSGyfaw7VxL4QF5wJ1HwvMhozlraDvkEKq0cgYbmvwn
         VbUe6zs3RnmgybwSnnzdqdhnvs/EU/cY3cOr0ItktNV44TOk+7ZxdIj4k/EwqJjGjysY
         K2z01CPLQJ8BFOnfe8fMn3Ni8nbyYRwTWWPzqw1l4fnXsa9t2ZsqdrDvj/Kv7Lcw38am
         4axmrcSqmsxaNfEcG5zNj5ck/dE8If0VLq7WkWcatmyU/M2tOLFoaoTEeDctf3ws2V/2
         BmuLvznwZe/LP6x/sANYcjoJvphYP61S9KLO5jTjngOSHmnzeEw3EeWLxJbJPhJw6PGe
         j7lA==
X-Gm-Message-State: AOAM530ZLfKBuELWBbjHr1YYICs67jLdaDuTD+vmoOxkZhlpkK4TInRm
        DWWyLkZhD0sTZ1nsc2NLcFp35g==
X-Google-Smtp-Source: ABdhPJwLl/Yb+dmot3Qj9GobH6d2VSIEqfIwMoXbr9WYE4ZivqBC7akLVHb/L/C2gNGglG2Ytc/IgQ==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr17871137wmz.87.1604330453311;
        Mon, 02 Nov 2020 07:20:53 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b18sm15138014wmj.41.2020.11.02.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:20:52 -0800 (PST)
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
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 6/8] drm: atomic: use krealloc_array()
Date:   Mon,  2 Nov 2020 16:20:35 +0100
Message-Id: <20201102152037.963-7-brgl@bgdev.pl>
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
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_atomic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 58527f151984..09ad6a2ec17b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -960,7 +960,8 @@ drm_atomic_get_connector_state(struct drm_atomic_state *state,
 		struct __drm_connnectors_state *c;
 		int alloc = max(index + 1, config->num_connector);
 
-		c = krealloc(state->connectors, alloc * sizeof(*state->connectors), GFP_KERNEL);
+		c = krealloc_array(state->connectors, alloc,
+				   sizeof(*state->connectors), GFP_KERNEL);
 		if (!c)
 			return ERR_PTR(-ENOMEM);
 
-- 
2.29.1

