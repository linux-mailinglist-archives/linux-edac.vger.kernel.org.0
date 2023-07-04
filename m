Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C71746E20
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGDJ7s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGDJ7r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 05:59:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A1F2
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 02:59:46 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 562A23F19A
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688464783;
        bh=tzatIeUkesboP8srHNWXkntXJNQo5yQ2O5oBQ6pkKDY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=DVmma5qBFZs/AzjEJvuEWgfHuTjXf69yESN76Z6ONJWm09ORqMMLc61hYwLgv2PJQ
         dWAYCa+VijNR7SoRHSwiDvPH163OzG/jFnCu8cKrCeX3PRpwvSmJVelnn4et76qlVy
         MNExUOfhkuVcJCT1aeOXrm3f2nlQB2qzUAsFW6+uK/Sl6NjyI6sE7e5GoaT0cY1eDQ
         8wAZRZSl7Wx5eiOpgONM3V/YRzGncK/cHzUu3i5nxqHS2CrE++2QIWSbuUvwRH9j8h
         pA9OlYmeRM0SqjKWgJ+GMpNHhw8jzAdVhepRknXlOyFEKcrkxd5QCbsjE8qxPYkORL
         jWkw3dvCZMTkQ==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a1e869ed0aso3433935b6e.2
        for <linux-edac@vger.kernel.org>; Tue, 04 Jul 2023 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688464782; x=1691056782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzatIeUkesboP8srHNWXkntXJNQo5yQ2O5oBQ6pkKDY=;
        b=EsNDW9EudoXn8HibSJJppoUoxCT34scz1sFJDuoPU2+UhrGdqMZtTLY9c13jJM6QZi
         dU3HvfX4TzZwaRwPoOl7XKAqgHpVrmEES8NqCHdAQr2lT1ovnulhfVxvY4yRHzHrF289
         SffA4IQtuKdO0AyqwNCLku1s6q5b8v7JuS0RWljKxvb92B3BKTzY11DuMGz4BPa8h0/2
         nL8hH8wxePye1FE8b0PON+ujuC56jnApKQGg7iVP3xtyoTSPPpHXKaCOoKAE+UAuUBgV
         hXoo0cyp9vEKENgN5N3F75yshZP1Rp/6RPrJpy4RtACmxMRUDFJuPSECODz/GYABarb+
         MhxA==
X-Gm-Message-State: AC+VfDwBHhItpYglGFcBn/4xbLKXl4khh6zeILFBv37YgKBZbLLrIkvZ
        eGi7cEUKla7h5vPX1fln27gp+nouj8JYOJCUTWw/bLnR7xXHn+AfiDYSgFxTB9tOak7nmqamC5m
        bZtTMIvKqzSM1npgY+OxiBXOuf9LMgXcsIFACHaQ=
X-Received: by 2002:a05:6808:2203:b0:3a3:69f1:f982 with SMTP id bd3-20020a056808220300b003a369f1f982mr11881579oib.31.1688464782278;
        Tue, 04 Jul 2023 02:59:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jzlZBEd/SQq7P5FvTxTpI4pGG7kbACUSej88ZGxR7nxbEKflz+pUTuV9N6QkHgtDNESl7dg==
X-Received: by 2002:a05:6808:2203:b0:3a3:69f1:f982 with SMTP id bd3-20020a056808220300b003a369f1f982mr11881556oib.31.1688464781935;
        Tue, 04 Jul 2023 02:59:41 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id p66-20020a634245000000b00528513c6bbcsm16086231pga.28.2023.07.04.02.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 02:59:41 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] EDAC/i10nm: Fix an inappropriate shift exponent
Date:   Tue,  4 Jul 2023 17:59:39 +0800
Message-Id: <20230704095939.119620-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A surprising value was determined after a read failure from a DIMM.

Software analyses pointed a data processing issue out.
`UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
 shift exponent -66 is negative`

A special value combination could not be handled so far.

Check if an invalid value was detected by a call of the function “skx_get_dimm_attr”.
* Print a corresponding error message in this case.
* Return zero then directly from the function “skx_get_dimm_info”.

Fixes: 4ec656bdf43a ("EDAC, skx_edac: Add EDAC driver for Skylake")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
v3: According to Markus' comments, simplify and polish the summary and add `Fixes:`
v2: make error-print explicitly

 drivers/edac/skx_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 2a00e0503f0d5..ac61db72d2e6b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -330,7 +330,7 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 	u32 val = GET_BITFIELD(reg, lobit, hibit);
 
 	if (val < minval || val > maxval) {
-		edac_dbg(2, "bad %s = %d (raw=0x%x)\n", name, val, reg);
+		skx_printk(KERN_ERR, "bad %s = %d (raw=0x%x)\n", name, val, reg);
 		return -EINVAL;
 	}
 	return val + add;
@@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
 	cols = imc->hbm_mc ? 6 : numcol(mtr);
+	if (ranks == -EINVAL || rows == -EINVAL || cols == -EINVAL)
+		return 0;
 
 	if (imc->hbm_mc) {
 		banks = 32;
-- 
2.25.1

