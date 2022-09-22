Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E865E61D8
	for <lists+linux-edac@lfdr.de>; Thu, 22 Sep 2022 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIVL6J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Sep 2022 07:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIVL6G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Sep 2022 07:58:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB6A7A8C;
        Thu, 22 Sep 2022 04:58:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so1181209wmq.1;
        Thu, 22 Sep 2022 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=y0QyeuPhDk8uxFx0nK/eAlzQ8Bem6mgCmbuKgEvACF0=;
        b=nE0JMsVyHqfw2b5Z/lYjvldXs7JYJZ5jv3r26+yQqUzUw/W+1FvfdORQdPs6q0egfO
         2Wq07+yRq38FB641HlEr08nkt/ZL0mTzqXUZJvP6+DKKNZ7wnRk5cY7EdLOLRUB+HBvd
         ToEH8a9BQs743qKc3TprsNf9yXzbLUFJ4dYPOTIXMw0gcF3rC70aS9V0anaWu2Q02g3/
         twIB2OdguQVHaRcHGF7vSZKQAyrTieHCgpOU3dBrXv7g3tN7QIry3CfKxtZn7xN95Z2r
         +zVFvBOCllPC3FRwI/8E+/gH/Cny2hVwY/knLqGY4uR4qfjDlGDIXNsnvOpgyON9hvNz
         Q4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=y0QyeuPhDk8uxFx0nK/eAlzQ8Bem6mgCmbuKgEvACF0=;
        b=G4aZaWSVAC1Zs1f5r0hJdWD+aDN8G16adKaCyDqNoLz5E8EPJtCYcPn7XJY3DZ8I9N
         IjKPRSonx+FwdpA+phlCCSRWy1UtfOxxHre5bnGUyEHFxmyOm2RdzzMgi0yGNBedjJZO
         joSqCZ0kYhQQtXSR0kxDZrgqYydb/27j3E0cyBrKMcwPwMrxkp/PakIoTeCF+tdvO1SK
         5EIZJJqQu9qfyYbWmV2YBlv2SuvTBpVl7bFtd2QWDbeESQN4NTh0V6DRidZS2EQ8voK1
         DTOHdA0ue7ixkInvc6LINHR9YwEe9JSTDtx5+g/3ynboX7V8vqMP2ccV+L9VPNiOhGaS
         LNmQ==
X-Gm-Message-State: ACrzQf3UXJr6sYt7dQXd+6In3XfiCTgty9sJ9aqRl5I7T8XNe2jB8v+R
        2JYXe4AaCOZvgeVpTJxIMrdVB/oM0Lc=
X-Google-Smtp-Source: AMsMyM5SYQwYXSbsvCmTlOmw/gUCeJuGDnYOZH7FZZkQtS1cRCKsSRv8n/Kn9qVWvyUy+P7SNKbFvQ==
X-Received: by 2002:a05:600c:4f56:b0:3b4:b6b0:42d4 with SMTP id m22-20020a05600c4f5600b003b4b6b042d4mr2083843wmq.143.1663847881832;
        Thu, 22 Sep 2022 04:58:01 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id ay16-20020a5d6f10000000b0022af70874a1sm6696472wrb.36.2022.09.22.04.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:58:01 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, pnd2: remove redundant initialization to variable mot_intlv_bit
Date:   Thu, 22 Sep 2022 12:58:00 +0100
Message-Id: <20220922115800.1372740-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Variable mot_intlv_bit is being initialized with a value that
is never read, it is being reassigned later on with a different
value. The initialization is redundant and can be removed.

Cleans up clang scan-build warning:
drivers/edac/pnd2_edac.c:627:6: warning: Value stored to 'mot_intlv_bit'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/edac/pnd2_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index a20b299f1202..eba2e6d9bd8f 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -624,8 +624,7 @@ static int hash_by_mask(u64 addr, u64 mask)
 static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 {
 	u64 contig_addr, contig_base, contig_offset, contig_base_adj;
-	int mot_intlv_bit = two_slices ? MOT_CHAN_INTLV_BIT_2SLC_2CH :
-						MOT_CHAN_INTLV_BIT_1SLC_2CH;
+	int mot_intlv_bit;
 	int slice_intlv_bit_rm = SELECTOR_DISABLED;
 	int chan_intlv_bit_rm = SELECTOR_DISABLED;
 	/* Determine if address is in the MOT region. */
-- 
2.37.1

