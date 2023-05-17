Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27813706F81
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEQRdu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQRdt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 13:33:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4213E;
        Wed, 17 May 2023 10:33:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaef97652fso8943215ad.0;
        Wed, 17 May 2023 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344828; x=1686936828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrF5yS6cG4ArCsSyuJuqnjZQppR8Ovu5NwuC6zh+GBs=;
        b=mf/xeozwy4EntcmgnD4pPDMN8dzeCKwtLCiyNgW9eJBuRUBalMBu0Hj+akcv2NwAC9
         bdXjByYS5CNkn1dQbCCnGMxaYxCuYKviJqNtT7ya/CKs/LdPYd7oitHNHspQjrmkaj8R
         BoyjwkpvEkZpSJg1vH2cRazt8Gw9nDWlQ8YtpudN4qhbrVUgmdlD1PI/fxxLtGWpD6T5
         jOi8el1u64dOOQcvCWYSnxdCBw8t5MZ3tKPFfm1xbMjSdjhjBDv+05tdUuM7LOMgMyLx
         pNIv7VvikRhkJogaNi4rRGM30V6jqjyVXV61s1AeiEWw887O5mKfPQsAKO/fHbDwCozx
         ITSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344828; x=1686936828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrF5yS6cG4ArCsSyuJuqnjZQppR8Ovu5NwuC6zh+GBs=;
        b=a5jW3Jyo2fohlWyrmW5vLD52h/i3kYybsp7n9kPg7XvH3sVi4y2tSGFzi/BRBicC77
         g8lVtnLJ+oq4NUOvx48zIOX2X+7pUz68OlfTRCqWlewGEEJOPGwR4iMJPN6AlbhhbrWR
         nVeOD/W74XuexcPAMKYkJUVszK/gZPz1v/QOTcoSQJFonJONSYhWvI6lt8a5Ij2fRrbw
         Me1WgvS9kS6SI5UH1DMSSFb/4EkIirjoEBt/EKhKFDieB6f4kxAwhI87LOwaJi5ISwQ1
         sOCF6g3HX7/lX+vS/SZsGIr6Zc0kiWLDbxrFj5ra2WT47Skb/PNr+ak6rQNpmLxMv4Sx
         oMVA==
X-Gm-Message-State: AC+VfDybQ9EIQA/lPkOD4vRpZBteQLUQYjL2Pg8eS2ZqbVS63kyqZQiT
        vB1HaZX0A9yj++KmqcUywqM=
X-Google-Smtp-Source: ACHHUZ4CZb4AT1UxLVMjk/DEUYbokvO1qFAA3tOXwb6SBqUof8L9UoTbNHRmBw79wpN3jy7dGQzpUA==
X-Received: by 2002:a17:903:2291:b0:1ad:f407:37d1 with SMTP id b17-20020a170903229100b001adf40737d1mr20360791plh.52.1684344828499;
        Wed, 17 May 2023 10:33:48 -0700 (PDT)
Received: from localhost.localdomain ([111.201.128.95])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001ac896ff65fsm17829000pll.129.2023.05.17.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:33:47 -0700 (PDT)
From:   Yeqi Fu <asuk4.q@gmail.com>
To:     rric@kernel.org, bp@alien8.de, tony.luck@intel.com
Cc:     Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] edac: Fix error checking
Date:   Thu, 18 May 2023 01:31:11 +0800
Message-Id: <20230517173111.365787-1-asuk4.q@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The functions edac_debugfs_create_file return ERR_PTR if an error
occurs, and the appropriate way to verify for errors is to use the
inline function IS_ERR. The patch will substitute the null-comparison
with IS_ERR.

Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
---
 drivers/edac/thunderx_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 0bcd9f02c84a..b9c5772da959 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -481,7 +481,7 @@ static int thunderx_create_debugfs_nodes(struct dentry *parent,
 		ent = edac_debugfs_create_file(attrs[i]->name, attrs[i]->mode,
 					       parent, data, &attrs[i]->fops);
 
-		if (!ent)
+		if (IS_ERR(ent))
 			break;
 	}
 
-- 
2.37.2

