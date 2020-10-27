Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7982129ABDF
	for <lists+linux-edac@lfdr.de>; Tue, 27 Oct 2020 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439142AbgJ0MRj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Oct 2020 08:17:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40292 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411653AbgJ0MRi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Oct 2020 08:17:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so1201903wmj.5
        for <linux-edac@vger.kernel.org>; Tue, 27 Oct 2020 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJP6zUa9eBmdV8bx1jdaWyKmaK9MsWkK16il5Qo0OrM=;
        b=P+3tCIHOjCZAx0wmilW2GDFvIGyFUKkJ6kMCnuzTaqTK/WVy0FTiGFvqMSEeEaTSDi
         lidtNcACGQa4FsZTJSv/WM+PJAWcMBZ84eqrsFS5cBt5SmJFi36Zt8P8jQqLDmjkvqeW
         khRH3E+peGeaQTCIY3Vt2p8gYCX0QOu5toB/kJmHKtw/28SJ6BKumTSSq2MJytdIAdgp
         oJxR5uAJUIN5EhwIO49GT3ZmC5B5ob3NU85YWSk0gy8yt2me9ot389ODzNeNzE1g7isf
         BjKSBXgUK2OMn2MduiDvTrDfwsn8XX/eMtY9lahl6HLlIYN8j7wdAJNYVoPtfuaoSs+h
         PRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJP6zUa9eBmdV8bx1jdaWyKmaK9MsWkK16il5Qo0OrM=;
        b=ZjnvnH+gPh3kmPXWJWizfn1vts07mN3OFMviVtVh/eT5CfK+Ad4lH/1HxVhcZquSce
         RzfBeZhhKWvDctmEuCgk3PKE1j2F9IvU4+Oh92v5bDgaS6vbOY66ZSBJe5xy1nFz/dek
         UvLY13AKTUiltFOsRNsk5LKE+XXpM0RQGfJfO+UJWUuj2XHdbA/PiAfRQtWEgRz3EQBs
         HN12Uu/3ORusNR3Tnw4HS0wxHhwp48FNlGP7cYnMhJ1bCwdVMZ0gfHmMcmGusVnI/yKT
         4sWwXt6/hk2SGhum5P530/jAZKgH83VlH77EOUQEsvI2jDQyGVRYIgE4eI8BOlydKdFk
         LK7Q==
X-Gm-Message-State: AOAM532L/wv5AaIRwxfJ0pYOgFgg7Y1hH+tR8pMgFapYIFdOvNfIqrdk
        NGcVPJXAqpJvw1sQyulfVoEioQ==
X-Google-Smtp-Source: ABdhPJxUDPfM7/G4w39/lM3kfVBbiG37Et7vUzW73qIzYGjUaK5vAjNfvCioGZotPrXrgX+P7fvBjA==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr2477389wmd.10.1603801056147;
        Tue, 27 Oct 2020 05:17:36 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id a2sm1731908wrs.55.2020.10.27.05.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:17:35 -0700 (PDT)
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
Subject: [PATCH 0/8] slab: provide and use krealloc_array()
Date:   Tue, 27 Oct 2020 13:17:17 +0100
Message-Id: <20201027121725.24660-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
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

Bartosz Golaszewski (8):
  mm: slab: provide krealloc_array()
  ALSA: pcm: use krealloc_array()
  vhost: vringh: use krealloc_array()
  pinctrl: use krealloc_array()
  edac: ghes: use krealloc_array()
  drm: atomic: use krealloc_array()
  hwtracing: intel: use krealloc_array()
  dma-buf: use krealloc_array()

 drivers/dma-buf/sync_file.c      |  4 ++--
 drivers/edac/ghes_edac.c         |  4 ++--
 drivers/gpu/drm/drm_atomic.c     |  3 ++-
 drivers/hwtracing/intel_th/msu.c |  2 +-
 drivers/pinctrl/pinctrl-utils.c  |  2 +-
 drivers/vhost/vringh.c           |  3 ++-
 include/linux/slab.h             | 11 +++++++++++
 sound/core/pcm_lib.c             |  4 ++--
 8 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.29.1

