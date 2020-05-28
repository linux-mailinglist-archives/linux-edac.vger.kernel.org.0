Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67821E6C68
	for <lists+linux-edac@lfdr.de>; Thu, 28 May 2020 22:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406966AbgE1UWs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 May 2020 16:22:48 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:40650 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407001AbgE1UWr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 May 2020 16:22:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49Xzdx6tc0z9vcjp
        for <linux-edac@vger.kernel.org>; Thu, 28 May 2020 20:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZToX5DckMRmh for <linux-edac@vger.kernel.org>;
        Thu, 28 May 2020 15:22:45 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49Xzdx5HNpz9vcjs
        for <linux-edac@vger.kernel.org>; Thu, 28 May 2020 15:22:45 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49Xzdx5HNpz9vcjs
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49Xzdx5HNpz9vcjs
Received: by mail-io1-f69.google.com with SMTP id n123so18718iod.17
        for <linux-edac@vger.kernel.org>; Thu, 28 May 2020 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lZzscT/3tcOZEypZ6BQTFArab8a3rsRWz2aMbBGNpZM=;
        b=n/r/SPAxJuSK6fzuLRA6eJjLW0iM2cuBPBlKEL8+JItm7xpPxeeKpltDjRFQLjd+sE
         VG0u8BXmd9rM8TAj96CVt7aOJxRm7yH4mg0TcQrruvfUhaHPPFozE+uf/hqxVcEtoNpP
         tQB45hy+e7YbR/dgE4XVhhx2F9A/qxnGLys2O2ZCI2ESt9fd86FjRimwlzBS6rQ1GOvW
         y2MaXcewaEC82J7EkRCUboyqFW6XLK9fMfEcZVxDhViXZnRy1pUMrl/wzZXyF5vrxzbo
         DtwTHT/xlAR/Z06pC8XFK20NHNsYvea7fHoHogfGJAtD6E69XdHoYKz2vWX3PuQeMhv6
         3Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lZzscT/3tcOZEypZ6BQTFArab8a3rsRWz2aMbBGNpZM=;
        b=KeVHfBLK59qUcqU3FoxtRaFzwN8URoFkyg7nN/tHXUKrl3Yfhd1Aphinpq0aQjOHdx
         EVi5bJXB/fkE6JOaLBPwtEeOmaaVAf7wsZ6FEAUHU5ohQjVdgwmbBaKxDBg/GPy6QkVn
         x6uBtq81Ynj9JQFwJnnyOwgCdrJqGsc7puP1XmXPITg3LE70KuevhA3LGgsWjMU4lIyl
         EORzFDnfruju3jbvQyLrchnxKWgt3PDiy+ZFPXj2oHOQAoDm+5St1d2OuJKTjcfCZuvI
         kICCVhdZAc9vo7Z2jxhyzxL/vim6z6e64ETrxYPwsrsRrz44Ohj9WLn1GRRmB0//pLer
         uOEg==
X-Gm-Message-State: AOAM533Wcr/o93CNUCaJPJFOYwk4ukPNSYB2EXsiszQJh9Gthcbzoru/
        +oSW5tKEZ9ftdulFT3RB6DXOSlx8WeK0ApGyz6GlN1oXwYnOqPWjxH4787DoZevCOLw8rLRojmx
        s0v7nnpDCMF0lMBG95KI5FW3Xpg==
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr4563927ilj.107.1590697365253;
        Thu, 28 May 2020 13:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtz4ZMfSdIHu7TCUu1HOBH8M3fDQBiyTjl5Y37TBKLETKbukmvL0ZEh0Ivr/TiHQwRQOb6nw==
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr4563906ilj.107.1590697364997;
        Thu, 28 May 2020 13:22:44 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id x22sm3731645ill.9.2020.05.28.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:22:44 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] edac: Fix reference count leak in edac_pci_main_kobj_setup.
Date:   Thu, 28 May 2020 15:22:37 -0500
Message-Id: <20200528202238.18078-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() should be handled when it return an error,
because kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem. Thus replace calling
kfree() by calling kobject_put().

Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/edac/edac_pci_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 72c9eb9fdffb..53042af7262e 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -386,7 +386,7 @@ static int edac_pci_main_kobj_setup(void)
 
 	/* Error unwind statck */
 kobject_init_and_add_fail:
-	kfree(edac_pci_top_main_kobj);
+	kobject_put(edac_pci_top_main_kobj);
 
 kzalloc_fail:
 	module_put(THIS_MODULE);
-- 
2.17.1

