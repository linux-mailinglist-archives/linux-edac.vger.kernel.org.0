Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC692AB61A
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKILIW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 06:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgKILHG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Nov 2020 06:07:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9EBC0613D3
        for <linux-edac@vger.kernel.org>; Mon,  9 Nov 2020 03:07:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so8212051wrl.7
        for <linux-edac@vger.kernel.org>; Mon, 09 Nov 2020 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1txfIvaUE40Ou/j75EYKcgw6u17F5C6+DdlKPQ0ay3M=;
        b=bV0WOhcjc6Y2rIR+7HT+QGO/LnwlTLaGqiH/bueGYgN1eqaiyqgBu630Wi1/Fe4Izr
         My6WbzMB2G0+0Jww/tXr7Bv9T9tCSh7nAf3FDc9HnmXqm0/SZK/yuCq88k07niiSIbdE
         Kni1bJikZg3lnovvS5+pSl6sF1scmJC1eailBHWvAIqLxr8aFY7ZvU8r5E11qXi2Th71
         zhnarT2xZ1wCpMgNr9yCr/3M5lq5u3cCkFTpjL9pfSKNowIMNdFSn0mY3iQlibP5Tto4
         Lgmzc95ZSUUq1X+Al8zvn1+ubttScKkHoe5x6HV2U03u2h9rIhdyiJw4IDWSPdJhmDMn
         +W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1txfIvaUE40Ou/j75EYKcgw6u17F5C6+DdlKPQ0ay3M=;
        b=t35hNIHP21D8RekUXLtxTkQvSAWH7/gQl6DszCLetS6Kcdn94rXsodzLV9x62SWkBx
         8+saAJFbmD/WCaCmPcwwnbef0HlTSquVCVPU2igC8DUZmjWFDDFEfJusMnmR+OMTDTIA
         d0vq6llU/Dg+JZ08WJJJQcV8lbGF7BTn5a6FvrlmgfIJ5rFg4EstflofwnWLueKwmnOL
         xurRokU57UeGJK47L16hA8DdmKEGhOgiPyTmj+KUU5VS4LVFoIBaD6jCJNIZBoW/Omrm
         UolmzCM56a4+7e3xVyBMAFg/MwXCXC1U5L4hTlAfcCwD6eTIJ0eKrrDba97RRbuHidyB
         GaVw==
X-Gm-Message-State: AOAM533l9H/EuJkNJUk2Lc2E6SY4wu7EijSdi7CcfMrJtvxrvR4mPiJT
        co8er4VIZvCIDkHtiNQ6zEH9QQ==
X-Google-Smtp-Source: ABdhPJzHXOuOWGraTd+tlh1Rh/Cikbums2QDN+ELEwiirpKRCwDTD+P/KjLkxHpoeG3VOPOYn45WFQ==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr11725240wrr.303.1604920024684;
        Mon, 09 Nov 2020 03:07:04 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id d3sm12815582wre.91.2020.11.09.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:07:04 -0800 (PST)
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
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 3/9] ALSA: pcm: use krealloc_array()
Date:   Mon,  9 Nov 2020 12:06:48 +0100
Message-Id: <20201109110654.12547-4-brgl@bgdev.pl>
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bda3514c7b2d..b7e3d8f44511 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1129,8 +1129,8 @@ int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime, unsigned int cond,
 	if (constrs->rules_num >= constrs->rules_all) {
 		struct snd_pcm_hw_rule *new;
 		unsigned int new_rules = constrs->rules_all + 16;
-		new = krealloc(constrs->rules, new_rules * sizeof(*c),
-			       GFP_KERNEL);
+		new = krealloc_array(constrs->rules, new_rules,
+				     sizeof(*c), GFP_KERNEL);
 		if (!new) {
 			va_end(args);
 			return -ENOMEM;
-- 
2.29.1

