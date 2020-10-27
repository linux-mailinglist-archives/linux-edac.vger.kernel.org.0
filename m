Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4C29ABD3
	for <lists+linux-edac@lfdr.de>; Tue, 27 Oct 2020 13:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899684AbgJ0MRn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Oct 2020 08:17:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899672AbgJ0MRm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Oct 2020 08:17:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id t9so1616687wrq.11
        for <linux-edac@vger.kernel.org>; Tue, 27 Oct 2020 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BD6BZhiJRXUg2mUZGG0fkwDlbzmZ0eUsKwHAsGlj294=;
        b=GYoAOUdpehA8D5iOITnO5eSHqy74EWPa2UIAtVbkWsImVc99HZ2Meqd4q5mrUiPwJi
         1APAlHnt2Cb4RjSuekciaevLzEzJMqfqHXfoSP/8Nqsfy2vu/QE/h1rKpHfgBNuem/9E
         bOYwNpK5Rv+6EItbQEiKit8Nwszh+pcjtDbIO4wjR4xJz/1weNgEVHMghJunm+Jmvs3D
         DwFELNR01LinoQoxBBCOkfLlLHqTKRB+bYhg8Wi8nXmI+1DlDpMCRqOKS/1P7aEomQVd
         T289FY4bD7H12YIHjVFYqTifMYdbsOOawVKJDDr9Ow0FRgVTPhbXfojcEyRGy0x+TbG2
         NISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BD6BZhiJRXUg2mUZGG0fkwDlbzmZ0eUsKwHAsGlj294=;
        b=KlAFWpFwUiyrt4cc/Rrt6aiOeSeoIco4xjU6N66fdAhvqc4cOI4ka+/1xOAYUomrx0
         bYlqsysQ1XwGoDqhSJbdPksgF4CY1GWnrAs6ZV/sQ9+WX8OgJF+zL61kiL4IREwBfNmQ
         IoCmVGUq1nosz5zKUcahd2VUB4I2djoQ8dYdUxynYWWDwSWmcGRbbaPbaifmShUTJSJW
         8neMZtfgboQ5CRFzjbX7E2DDrfFIt06SOfzcIi8tg3clfojQSDIA2I8KEOLXxp2rF+s1
         2qdn3fbTmWM7WkXje1Nzmx/PtkoFQmFzv8LfadkdDyP+Jz3QqiqHWR0cAwl4phEzhj2c
         MEug==
X-Gm-Message-State: AOAM532eDwzanJtufthOXARyuBJkD+s8kBHHhXtdFx+SEsEPWPjtzcDg
        7OjqPf+tYJ9qIYxWrwbyQ3fHWQ==
X-Google-Smtp-Source: ABdhPJycS5PuqPPHWbBOB4wuxjdkw4uku7T6ocjCFZm8vDs8KzBrNQe0wHUyzYWAYWc0X5WB+59JaQ==
X-Received: by 2002:a5d:6cc8:: with SMTP id c8mr2428078wrc.233.1603801060190;
        Tue, 27 Oct 2020 05:17:40 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id a2sm1731908wrs.55.2020.10.27.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:17:39 -0700 (PDT)
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
Subject: [PATCH 2/8] ALSA: pcm: use krealloc_array()
Date:   Tue, 27 Oct 2020 13:17:19 +0100
Message-Id: <20201027121725.24660-3-brgl@bgdev.pl>
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
 sound/core/pcm_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index d531e1bc2b81..c6f8f9e252e0 100644
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

