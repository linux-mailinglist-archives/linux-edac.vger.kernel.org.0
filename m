Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD291A65F4
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgDMLxK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgDMLxK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 07:53:10 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:53:09 EDT
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D170C03BC88;
        Mon, 13 Apr 2020 04:53:09 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z65so11681238ede.0;
        Mon, 13 Apr 2020 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YcI5BgHcI8+PEm1TIf305+wY+78vpeLYiqAUOMKmCLY=;
        b=srKMMj5E5btl7EDgNRotSH8CXWYnKfGMImdJNqDh91f8Rv1vZ7lRrE0WsNfJh/MYgW
         D52LS7TTE6OM+eyZggDWqG+xt7VThDdofdeZBiT4H/NUAO3K+zMGo5QGuw4XIa6zPv0r
         NtmuzQ5S9tuDP9RZmqbh0W6/G+RPfUmRvJW7Ir+gWGteM22ihV7smVL7FYp/gExiEFkd
         x/K7xJXeLlPhTSeTP38GJncVYDksl/NOqZKqnM22i4D4wJ2PgE94nOaZNoG9ie+CS0a2
         H1DH6hHVpnfoNZFpeA4BZ306Z7bIbDuqxyu41zrSoAJe4fRfu1VVc9mveule7MEfHyHS
         V2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YcI5BgHcI8+PEm1TIf305+wY+78vpeLYiqAUOMKmCLY=;
        b=ATfAv6Qppy0WWGc+BKUyeicyoZ9S2knC95+I7qx/b9/nCgHVyQTbjAnj9kmr+3msQx
         tsXRFuwhRRyM1wYtauF1emN0WESux+Y58DM9yjXPnVnJfe8UeBy8E5iaqZF//igAF+ma
         DC6qYQm5fm1/dA1AhBQZ9XXQnAjJhylOTnzwmfmb4fAWpXp2ZEXHzv+hq1bND2eIZD3M
         W1ZpiRIA7cn+OwfsWnr5Rx8DP4GMCN55npnC6wgGgHbqaJrebFEMy7wCUxeXtvGI/S40
         6QQUWOOvfrxnAeRaEL/RAAF9kbUwCcwoA6TkZu70lmPEikkKGQT/oHSQq6OV97l3KzCb
         MXxA==
X-Gm-Message-State: AGi0PuaxEjASwiBfL2cQBqXUWdlFUql8U+N+HFvNe8uRWjsdRFt2PRlo
        Y1d4K/SrRKbvMKU94+4NbPO/0nqMslo=
X-Google-Smtp-Source: APiQypJ/CBvkwGG9Yyj5knUDqEB3O733BnUPqBkLIME3imONmpvkwjEuOpYdkHxsPlx5hLQ0F9KLmw==
X-Received: by 2002:a17:906:374b:: with SMTP id e11mr16232681ejc.283.1586778787976;
        Mon, 13 Apr 2020 04:53:07 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:3165:1687:284f:4993])
        by smtp.gmail.com with ESMTPSA id l91sm1285275ede.64.2020.04.13.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:53:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] MAINTAINERS: place sifive_l2_cache.c only in SIFIVE DRIVERS
Date:   Mon, 13 Apr 2020 13:52:55 +0200
Message-Id: <20200413115255.7100-1-lukas.bulwahn@gmail.com>
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

v2: https://lore.kernel.org/lkml/20200413114702.6372-1-lukas.bulwahn@gmail.com/
 - reworked based on Boris comment

v3: v2 was broken, I forgot to commit the actual change. Now properly reworked.


 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..63839a920e1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6172,7 +6172,6 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
-F:	drivers/soc/sifive_l2_cache.c
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
-- 
2.17.1

