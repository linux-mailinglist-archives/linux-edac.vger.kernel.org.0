Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B81F4E7D
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFJG67 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJG67 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Jun 2020 02:58:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8AC03E96B;
        Tue,  9 Jun 2020 23:58:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so557672pgo.9;
        Tue, 09 Jun 2020 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P6SRipZ1zBnUnTTKuDyAG9Zsu0cS2pULdCBVZ35wHNo=;
        b=QTyx7TXyp9+BAlm3j+htxNwSwoU85Euw811v4PPybhg3STNtibDKnOTSs0JnujwcsI
         XtQ98uUxonoHHp6Zjc3LPG7J90+eT4pFyqGLfmrPJ25cEuCmAz77uYvR9YkO4tEfjXL0
         OgfFQYVbSBotWFv8x3EfXrx9lv3ZDHJlDWDw45vt9ANXyt4a/dHj8+hIhZiIASm/dauB
         cE2jnHTdH+IfQKv9meGofHSVFTuV4BjTvDSkGxG/vAGsBIfRn6MqrWwx5AiMindJ17Vq
         mosv+yJvKb62wL8NTpxgjMKIUaAzVAOodGMP/fbMQVIOED2Bb4h0Ts7q3KuVw11LjCXK
         6BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P6SRipZ1zBnUnTTKuDyAG9Zsu0cS2pULdCBVZ35wHNo=;
        b=kXHKsUBkhoGkpaEZD08iQM6p0Sa/2gjoMiRehlC7GtZGngi+c3BGugcdgQRckx5Zh3
         r1gwjiboZgy8rlLDqJMRVxM1mOpb/7q5aCzgnhUpjbkL730iU9/3gg4HNyhoMwc5/px6
         1EisW5dJ1PIWnBeOIaSgSNxi9x8WRI0oyqTn4P1AvJptlaWCWitiTyB+y1vKqLexd6Dy
         X4fomwzwJomUpLuWk83rxizVZO3eeBWmNIrnJ2EXgyM155HoGB7wQszB2qMvIsWCKqze
         pZHyAKheXJ+ny5TwIFIvad1dWgCMF/yuk2+Th8kFK4U+5Wfyz0MarxWysC3O5pYws14/
         0cpQ==
X-Gm-Message-State: AOAM531nCROuwpGC+Mg4jRFUUtCBqb5Ma5zMmfS+kKNRjYEvr7L0tojQ
        yNv1dN47wg8Hs6oDDLmURknn6RQC
X-Google-Smtp-Source: ABdhPJyjHrdr/mLmD2Usix7oiCDcp0FdS/6DKgRzZaoNwB3SChMIddPPKNUXbNBCm0RXdkoFAHT3PQ==
X-Received: by 2002:a62:e40b:: with SMTP id r11mr1450030pfh.265.1591772337793;
        Tue, 09 Jun 2020 23:58:57 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id v9sm11948108pfe.198.2020.06.09.23.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:58:57 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, rrichter@marvell.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] EDAC, pnd2: set MCE_PRIO_EDAC priority for pnd2_mce_dec notifier
Date:   Wed, 10 Jun 2020 14:58:45 +0800
Message-Id: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...or else it has MCE_PRIO_LOWEST priority by default.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/edac/pnd2_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index bc47328..368fae3 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1434,6 +1434,7 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 
 static struct notifier_block pnd2_mce_dec = {
 	.notifier_call	= pnd2_mce_check_error,
+	.priority	= MCE_PRIO_EDAC,
 };
 
 #ifdef CONFIG_EDAC_DEBUG
-- 
1.8.3.1

