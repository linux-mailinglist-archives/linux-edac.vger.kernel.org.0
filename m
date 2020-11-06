Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0212A925D
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 10:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKFJTo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 04:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgKFJTb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Nov 2020 04:19:31 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A22DC0613CF;
        Fri,  6 Nov 2020 01:19:29 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i26so482604pgl.5;
        Fri, 06 Nov 2020 01:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gbK9LV/P+tPvAYfKi87cJG5c+9+YYVyHdjHSk9eK97Q=;
        b=aWzCWhXUPpDXUK5fKoHnqJ9DuKlVgxafpPANQKZ20ngBstpHALDDUqAf6ZCq7qyVD3
         n8tpET9KojA//w7opNFPgmx5YpNpAaNL0UEZ99GJYlf8kcbRc2Vq8wwMWNrnGELv8QwP
         nJKKvuwQOdL+KsmPEbrM4w3D/qA7ddRUIEacSPkXykbzg4fZz4A/yT5g3SYxsn/oIn7c
         etVl65BiKh0qX71ZI+jO+Or+2FDEjP+Ycq1lzA4IrTlIHeBUZymHCCUJxoBQsxOXo+QL
         3/m5fNRz/Eot9dYH8vupQtjZGArewAO0PsgSbTRLvW5UP2pVsI0T7kefU1WiNkBmyTAj
         9/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gbK9LV/P+tPvAYfKi87cJG5c+9+YYVyHdjHSk9eK97Q=;
        b=WZdztdzvcuBS1Z04DM2/t4ZgbTv+P8v9F+iNetKBthpiN3Lot+a9I5LiEi8NbEZSPI
         QUc5Sw2oMBwV/0fbZDbrYF/59Z1hdadf5WiWwhRFuyED4STA30dGy/rsLhqYixBhA3WH
         FxcDujyv15xem+jcrTlOxlMWRpcIkfHcTuFrBTdLUxdmucifQFENhWIrkVw6ug+riMJd
         odHuuwEBGX4r6a2zjZlhPIiFmGkaII7uqguFNuNW2lOV9QE89EiYpPhKF/borJdh7Psh
         aTCh1lw6B+a4T0rFWl7cCaLfnDSxfqUS3E7mKmbTziexw1fyY6ohGeeNChKvgYZf1mhI
         rvZg==
X-Gm-Message-State: AOAM531zWMA8kpk1ewj6cwhiTO4hVnMGb9V3oAYrXB5vw1MkNRyYuWyr
        kaYtSQ7n/NHbdqkcbvTe9SXisetVXZ0H1iQ=
X-Google-Smtp-Source: ABdhPJw6yOPMV7i9xgya+5xdR7lmvPLbE69tIzIQ8vkBRF8ylXXhnAMJ1tY6HyBxEfLC+rrdv77A8Q==
X-Received: by 2002:a63:fc5f:: with SMTP id r31mr993658pgk.90.1604654369055;
        Fri, 06 Nov 2020 01:19:29 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id e10sm1433898pfl.162.2020.11.06.01.19.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 01:19:28 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     tony.luck@intel.com, bp@alien8.de
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] x86/mce: Use true,false for bool variable
Date:   Fri,  6 Nov 2020 17:19:23 +0800
Message-Id: <1604654363-1463-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle reports:

./arch/x86/kernel/cpu/mce/core.c:1765:3-20: WARNING: Assignment of 0/1 to bool variable
./arch/x86/kernel/cpu/mce/core.c:1584:2-9: WARNING: Assignment of 0/1 to bool variable

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..962b61c19f5b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1581,7 +1581,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
-		b->init = 1;
+		b->init = true;
 	}
 }
 
@@ -1762,7 +1762,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		 */
 
 		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].init = 0;
+			mce_banks[0].init = false;
 
 		/*
 		 * All newer Intel systems support MCE broadcasting. Enable
-- 
2.20.0

