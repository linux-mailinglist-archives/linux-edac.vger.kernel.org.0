Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82812AB5E2
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgKILHC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 06:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKILHB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Nov 2020 06:07:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4CC0617A6
        for <linux-edac@vger.kernel.org>; Mon,  9 Nov 2020 03:07:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so1124269wrw.10
        for <linux-edac@vger.kernel.org>; Mon, 09 Nov 2020 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BZufo5GeZBBjJpVBhVfUUqf7bDRhIufHOC+GeAXTjw=;
        b=h63NN6JIr7BPg/L5K4tALUY+/tMHu7b/AohNm+Sq0AHtLr7C775RNCqPF5N91xMyBI
         MOiY+0CB7+nr/djuF77eQh2JjzNwZIgYaGZcGaavyRIGIDOMtNAYYoguPo3Q8xFlwx6L
         QddH+S2xNU+tvs03WMAyY063pe678sUddwGJwNwh+sGNbGg5ToLYxAiebC7qHygj5JKC
         wX/om83DYWGS2MTV/IcOR6891AOSOJx6pnI6tFAZh8FUdpFrpM+edanMCufFGJCkBefi
         wPu7sueEx5oa9fOWdtBQSKZ4a7oTEsuZvbf1jYwrHa9aigN1cKpCLLxVES7TkXXM96mf
         VUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BZufo5GeZBBjJpVBhVfUUqf7bDRhIufHOC+GeAXTjw=;
        b=EMeXHce0i5RFmAMsB2ZpnTODYMx5my8R6lr9OrCWxQzQEs0y/BqChPbvhDBm0d7/Uw
         8Qeus92o69VqJbB5eIUcMbFlxG8eN4OAfOunFfxqYTDa0DEaeLZ7fCf9qrQpP/z7DufL
         /yV7rKihSlPKTG8h1/VCwc4apWw85HgV6zenFer7DesSOKE/dL+oKU9y+jYxBEwftSBS
         yajWp7vZG1X/ocKiXdoLO8K/RZxDP5R0bU+g66WJtOmfvkm6c5HYaPsUcKYR66LmtvhR
         NEa1iIhuSNtnd2h+yA3u4ukW4dRg+B4FmemGyVtu2N0lVoMqVjrEZjope/OpgyMld/t/
         pXQA==
X-Gm-Message-State: AOAM53144GoA5rfraEiZSfrZ1EkB1YDHglrD0ZvRz5xTqIMQgihDhq93
        VhoLAIJUHZ3kNWqT7NEPpyTx/g==
X-Google-Smtp-Source: ABdhPJyoLN1aG0XKVyv+yWfCk24OCLDvJjyIFGdAfhV/HDRuWRPPB2x0i9RWfrD3NWEqtPTk5g+kWQ==
X-Received: by 2002:adf:9066:: with SMTP id h93mr18252220wrh.166.1604920019608;
        Mon, 09 Nov 2020 03:06:59 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id d3sm12815582wre.91.2020.11.09.03.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:06:58 -0800 (PST)
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
Subject: [PATCH v3 0/9] slab: provide and use krealloc_array()
Date:   Mon,  9 Nov 2020 12:06:45 +0100
Message-Id: <20201109110654.12547-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Andy brought to my attention the fact that users allocating an array of
equally sized elements should check if the size multiplication doesn't
overflow. This is why we have helpers like kmalloc_array().

However we don't have krealloc_array() equivalent and there are many
users who do their own multiplication when calling krealloc() for arrays.

This series provides krealloc_array() and uses it in a couple places.

A separate series will follow adding devm_krealloc_array() which is
needed in the xilinx adc driver.

v1 -> v2:
- added a kernel doc for krealloc_array()
- mentioned krealloc et al in the docs
- collected review tags

v2 -> v3:
- add a patch improving krealloc()'s kerneldoc
- fix a typo
- improve .rst doc
- tweak line breaks

Bartosz Golaszewski (9):
  mm: slab: clarify krealloc()'s behavior with __GFP_ZERO
  mm: slab: provide krealloc_array()
  ALSA: pcm: use krealloc_array()
  vhost: vringh: use krealloc_array()
  pinctrl: use krealloc_array()
  edac: ghes: use krealloc_array()
  drm: atomic: use krealloc_array()
  hwtracing: intel: use krealloc_array()
  dma-buf: use krealloc_array()

 Documentation/core-api/memory-allocation.rst |  4 ++++
 drivers/dma-buf/sync_file.c                  |  3 +--
 drivers/edac/ghes_edac.c                     |  4 ++--
 drivers/gpu/drm/drm_atomic.c                 |  3 ++-
 drivers/hwtracing/intel_th/msu.c             |  2 +-
 drivers/pinctrl/pinctrl-utils.c              |  2 +-
 drivers/vhost/vringh.c                       |  3 ++-
 include/linux/slab.h                         | 18 ++++++++++++++++++
 mm/slab_common.c                             |  6 +++---
 sound/core/pcm_lib.c                         |  4 ++--
 10 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.29.1

