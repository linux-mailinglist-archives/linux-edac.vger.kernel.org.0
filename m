Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA31A65FB
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgDMLym (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgDMLym (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 07:54:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C045C03BC91;
        Mon, 13 Apr 2020 04:47:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so2914059wrg.11;
        Mon, 13 Apr 2020 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ma5Z+ECsZBFx2q5FvmtQfMSDeLdqj1C7WfsxB0TOu7Y=;
        b=dvldG98lbyzYXAj/6EuEtw0i/B8r9upKEzAGdcyxUeaYblGloU9RoMqu97f8ivsJQn
         0Lf+mtVk0TEzpkUiDIw1WAgNE8jq/pAjIN6qKbZj9hGepjBw3M1Gz7LZfh4VKrzycZLK
         XrwNsP7biMAAcyfjCgWaqyU8HaMGh9OBCCdXORiGJz0Ufnw8HMFC+BVIkVM3viDPpwPe
         gJKotzCPaWvQboGb67M8+EbNKNzYMDzlef2w7meb0zfNZbmkuLx5ypAwkPPN6nNcvPb9
         AvnL/5whdGcnhuNpjWxAKULO2Yyhm0bDRfipay5fvbCh47uLRlw5cB/gt1IphFF9QLfx
         aPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ma5Z+ECsZBFx2q5FvmtQfMSDeLdqj1C7WfsxB0TOu7Y=;
        b=fQ0VXzRDgAVET5cBBJifC/DktMfw4g10aNiIGPrP33OrjZLdG5etLLJI+WgWGjYJhD
         ChhD3qr0v5IJ7qZl9RE9nxsS3RRRNXhnXXGkELtA8t2vkeuwlP/0/b/r+SBmISUeYjul
         fhjufFpynMQvvYlFk7QMEmlfbcxQ94r20Ebb6x2JmJ2YU6uqcV6RuoI5Mz2Ubuj2ErfE
         bMZHz83KalxMZehAL0y+iTpxDOaf8QOMezhHd88e0E4h6JCshHumH9MI6iWS7Tk+7qSY
         VWQCiKYR8UnV4s9fduZcL8Xk+ijQSsAKKdUOIlX3IXnMdtsFqFM2hAXWLjZ0/1K1HND/
         WXOg==
X-Gm-Message-State: AGi0Pub6h1imIXptjPWNLH961Cm6g2hfizlBGAqdU8DS9DeSMi5H9meZ
        zS7btxYrqtssVh3Z9nvq5Vg=
X-Google-Smtp-Source: APiQypJ8XpcmMfL9rBNlOD+n3vOrA1R0IYnODT1p02mmvU2zd1OfA9y42vimgSsQJR03p9fU0PwPTA==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr17975869wrv.78.1586778434998;
        Mon, 13 Apr 2020 04:47:14 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:3165:1687:284f:4993])
        by smtp.gmail.com with ESMTPSA id l15sm14008827wmi.48.2020.04.13.04.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:47:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: place sifive_l2_cache.c only in SIFIVE DRIVERS
Date:   Mon, 13 Apr 2020 13:47:02 +0200
Message-Id: <20200413114702.6372-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc") moved
arch/riscv/mm/sifive_l2_cache.c to drivers/soc/sifive/sifive_l2_cache.c
and adjusted the MAINTAINERS EDAC-SIFIVE entry but slipped in a mistake.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/soc/sifive_l2_cache.c

Boris suggested that sifive_l2_cache.c is considered part of the SIFIVE
DRIVERS, not part of EDAC-SIFIVE. So, we can simply drop this entry, and
by the sifive keyword pattern in SIFIVE PATTERNS, it is automatically part
of the SIFIVE DRIVERS.

Suggested-by: Borislav Petkov <bp@alien8.de>
Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Paul, please pick this patch.

v1: https://lore.kernel.org/lkml/20200304144045.15060-1-lukas.bulwahn@gmail.com/
  - was not picked up.

v1-resend: https://lore.kernel.org/lkml/20200413073447.9284-1-lukas.bulwahn@gmail.com/

v2: reworked based on Boris comment; applies on v5.7-rc1


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..e28676766b26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6172,7 +6172,7 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
-F:	drivers/soc/sifive_l2_cache.c
+F:	drivers/soc/sifive/sifive_l2_cache.c
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
-- 
2.17.1

