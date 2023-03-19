Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FF6C028F
	for <lists+linux-edac@lfdr.de>; Sun, 19 Mar 2023 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCSPCG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Mar 2023 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCSPCE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Mar 2023 11:02:04 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477022107;
        Sun, 19 Mar 2023 08:01:51 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id h83so4400277iof.8;
        Sun, 19 Mar 2023 08:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679238110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcynOfjIuREpUDqg4X2bQ6SnlpBnwbLqLNtaFgxSan4=;
        b=bTqLEVb/uBSSvsU5lpXgxGgrf0fuFwbG3Em8TfiNXbzSRTbbPBprdQ0mwx210/pSpC
         /WGnpNp2RVij5SRtnQF/xOD8OYgTNJWwVSSfXVjoX3curPq6S9X+jQnyZjn8RBWAUG5c
         XwlpDBEInKo23YpaR7uRz55X8+FsrXBVa7TSmgKrX/xhoCuOAPvJ6Mh9aArf5Z+UbiS3
         rsTiY1t54PlQuBSqpUFQRbhdTp8kYGLaKoXsb84TOdbj7B3YdQt/SkGKqlnwe187HVCo
         U904yxoahyn7liAEQytCT1d8KEgfmbWoPk6CX5skxeaFSmhXjENZIGU5nx4x/xKGiq1Q
         uNAA==
X-Gm-Message-State: AO0yUKXSdfZ57xX+RQTGRpion/ke9RcYHK/q4VECqpi7nws71yVLh4l9
        qYdqaxY4Ok5GiCoYpi6etA==
X-Google-Smtp-Source: AK7set9z8akr7zP0UlxXNKqvdjoKU4aalgZfpNrcG/+V0aIKBuMAlMEaq6AsXxfdMm1vqSCECQ9/rw==
X-Received: by 2002:a05:6602:2c4e:b0:753:87a1:3198 with SMTP id x14-20020a0566022c4e00b0075387a13198mr4139847iov.5.1679238110713;
        Sun, 19 Mar 2023 08:01:50 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c4:7b93:58f2:478b:84fd:941e])
        by smtp.gmail.com with ESMTPSA id p5-20020a056638190500b003ff471861a4sm2419377jal.90.2023.03.19.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:01:50 -0700 (PDT)
Received: (nullmailer pid 67940 invoked by uid 1000);
        Sun, 19 Mar 2023 15:01:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] edac: cpc925: Use of_get_cpu_hwid() to read CPU node 'reg'
Date:   Sun, 19 Mar 2023 10:01:41 -0500
Message-Id: <20230319150141.67824-2-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230319150141.67824-1-robh@kernel.org>
References: <20230319150141.67824-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace open coded reading of CPU nodes' "reg" properties with
of_get_cpu_hwid() dedicated for this purpose.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/edac/cpc925_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index ee193aae8e14..0182436c1b5a 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -557,13 +557,13 @@ static u32 cpc925_cpu_mask_disabled(void)
 	mask = APIMASK_ADI0 | APIMASK_ADI1;
 
 	for_each_of_cpu_node(cpunode) {
-		const u32 *reg = of_get_property(cpunode, "reg", NULL);
-		if (reg == NULL || *reg > 2) {
+		int hwid = of_get_cpu_hwid(cpunode, 0);
+		if ((hwid < 0) || (hwid > 2)) {
 			cpc925_printk(KERN_ERR, "Bad reg value at %pOF\n", cpunode);
 			continue;
 		}
 
-		mask &= ~APIMASK_ADI(*reg);
+		mask &= ~APIMASK_ADI(hwid);
 	}
 
 	if (mask != (APIMASK_ADI0 | APIMASK_ADI1)) {
-- 
2.39.2

