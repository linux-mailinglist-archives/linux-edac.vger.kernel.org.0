Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8A50CFFF
	for <lists+linux-edac@lfdr.de>; Sun, 24 Apr 2022 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiDXGYm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 24 Apr 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbiDXGYd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 24 Apr 2022 02:24:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565A34B9A;
        Sat, 23 Apr 2022 23:21:34 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q13so487341qvk.3;
        Sat, 23 Apr 2022 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JD2cGHykXY18CFqiLDdhvgg74jaaMTK/r1iIe8nmJvk=;
        b=e1Qfcaf+YwUSeNLcSKmnsDi77Va4hqsZ8JtZaRyuqdqx7OQGGxJyBlGGqH4SrQJp/Z
         2HHvZipS8E5KLglzV2R97gG2EtZH9SGa8a27SITM25OQEUWOZfbuFK2/3WxRoz4sqGCB
         AFYWN+wecUox5x1YGyyFG+jb3Z4vs0Tp9+DJyWp2mC8xMAGleb3TTd5ftR4s27Rn3aCT
         OSMRDzhS/6zZDzJNqgLoAA9/d8jcJlRzlNv8pxRu/ZB8baMX5oL/4jgdJVRvoHrtoP15
         JhDmjxqe8jAwFlC+z29aoKDbScZzKnUAKn8t4iutTmgpX/oFrtNZGnOqer3QxZB/cUl/
         G4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JD2cGHykXY18CFqiLDdhvgg74jaaMTK/r1iIe8nmJvk=;
        b=bXQy7P3q+SVpUIvzzY8A1WHPjhPu4t0xMsptEqtgZOKbsDAly6NIirg7nP2RZ8aGDd
         HhM/bylVGWTyIKECVGV9MQsRhJIlaP+Xfa7Rn1D3Q9I/mtdBD1aaPocLRjEnO9y9/oji
         gajz5u2tU/c4FQiG7ohcNVHI6V5lc8dXy7AyHBcinijbIaoh8hZEuvmdqPrBLJP1MqQO
         +jgDDVKNcEKI+YzuzO/b2lUbHIcj1Yf9I6ley1QQYV1sDNundWyU5bgZGoCI48f+EhAx
         /xF5cQjjS2Lj5ywTyn+LruTAhrWT31AzgUhmxFPGurpRf0p0Ys9bRRUFPgmbX57ZSQdR
         daNg==
X-Gm-Message-State: AOAM530r70FaY2tPYH38JHkfNVnMUZalpXVK+jtgSqpNm0/6EJSzsUFa
        8LmHUwjMDawzsJSDfniNlkM=
X-Google-Smtp-Source: ABdhPJze1/OYL0QD5pEScxA78exsmGz25TAFOkdtrjI67qjHATvUH3G+5nJqYmJ7YyRNI8q2LIPSRQ==
X-Received: by 2002:a05:6214:2609:b0:443:d583:1fd1 with SMTP id gu9-20020a056214260900b00443d5831fd1mr8791225qvb.5.1650781294000;
        Sat, 23 Apr 2022 23:21:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bk18-20020a05620a1a1200b00680c72b7bf4sm3387709qkb.93.2022.04.23.23.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:21:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     bp@alien8.de
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] EDAC,wq: remove unneeded flush_workqueue
Date:   Sun, 24 Apr 2022 06:21:26 +0000
Message-Id: <20220424062127.3219542-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ran jianping <ran.jianping@zte.com.cn>

All work currently pending will be done first by calling destroy_workqueue,
so there is no need to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/edac/wq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/wq.c b/drivers/edac/wq.c
index d021d287eaec..ad3f516627c5 100644
--- a/drivers/edac/wq.c
+++ b/drivers/edac/wq.c
@@ -37,7 +37,6 @@ int edac_workqueue_setup(void)
 
 void edac_workqueue_teardown(void)
 {
-	flush_workqueue(wq);
 	destroy_workqueue(wq);
 	wq = NULL;
 }
-- 
2.25.1

