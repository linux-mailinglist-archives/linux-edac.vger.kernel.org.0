Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6248E5E7BA2
	for <lists+linux-edac@lfdr.de>; Fri, 23 Sep 2022 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIWNSR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Sep 2022 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWNSQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Sep 2022 09:18:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0513A971;
        Fri, 23 Sep 2022 06:18:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so49592wmb.0;
        Fri, 23 Sep 2022 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=UpbywYD5dZveE6j8/nHijxGGqbg9BB0wCIFvahSS3x4=;
        b=TmiT+DqBukLmUOWRcaVJGAqi1mvaMmRRcfyPC2kj+zGmCeE71YSGoaC1nSYyhRKeRJ
         TvMtJW0dYtwuOx2zZqV4hQF5o+x1pG3EzihMqsD0ul1SUoyF2c2JHVchsFPz9EaH3ioj
         VzLqKWCAec7Yc9MXrH6P8CxhzUN92nTjvy3x3v3l4fW5jTMkuyutDAvjeUrSAsQ72s7Y
         h9OaipolywBGcF82kh9eZBhnsZWfQl3J5fVTfaxZ0VCmi2ugRpWYNZlICuol+gGZGIF7
         OiKVbB/h3p+UrtDos6OGgEPyambuITDbHVOhn8JZfzNNpqGy1zJEYgsI6EXwJcG3S3LR
         fmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UpbywYD5dZveE6j8/nHijxGGqbg9BB0wCIFvahSS3x4=;
        b=PM/fNG+L/MfLeOTitXG4T/bUhwEhMQeMztK6Qo8+BPUqyTnDjFdI53WAB5HZCUtDGr
         stlfjXvoUrG7p99eOzjf7octXOr+yOGl8vCvVFAO5BCagRMMLjwcnB2SzZki66th57jq
         vkKHNUrnikztUMX3+dRjfUNTlpnI7xLVAVp4/YNIS/LHprtTcevEVtQ05AsG6jrk4SHF
         /fF4Nzancmnu1AvhdxD3Z+/96FSCkRGCznNHbWVTLNjY8xFWrTwtMBhUTTts6TzOIHKY
         rmHexPZXvaoRizPOcxZHMrG6ihzH90LR91kfR0LiAUMh+zdPrqL6F6EoHz83lW8jDAH3
         0Oew==
X-Gm-Message-State: ACrzQf3KXncFkGilXOqYMRHpTmAeR72fMhsk+uaB8Wyg/xectFZJi4Ce
        tmDC041HGZsRK+NxQ1ZoPDqmofRmejZakg==
X-Google-Smtp-Source: AMsMyM6couknobUEIGyWOhOEJRONDDH4qrtDHNZN8OSngygLAqRWbQIO0PFfd81+bRjj+J/D8VBh7g==
X-Received: by 2002:a05:600c:3844:b0:3b4:becc:e43 with SMTP id s4-20020a05600c384400b003b4becc0e43mr13025633wmr.33.1663939094229;
        Fri, 23 Sep 2022 06:18:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b0022afce9ea93sm7451388wrz.40.2022.09.23.06.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:18:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mark Gross <markgross@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: Fix spelling mistake "Scruber" -> "Scrubber"
Date:   Fri, 23 Sep 2022 14:18:13 +0100
Message-Id: <20220923131813.2486294-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a edac_mc_handle_error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/edac/e752x_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index ac7c9b42d4c7..4290b02e470c 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -429,7 +429,7 @@ static void do_process_ue(struct mem_ctl_info *mci, u16 error_one,
 					block_page,
 					offset_in_page(error_2b << 4), 0,
 					row, -1, -1,
-					"e752x UE from Scruber", "");
+					"e752x UE from Scrubber", "");
 	}
 }
 
-- 
2.37.1

