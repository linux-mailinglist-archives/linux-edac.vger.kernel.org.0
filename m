Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2926D4DBCBD
	for <lists+linux-edac@lfdr.de>; Thu, 17 Mar 2022 02:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358400AbiCQCA3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 22:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358386AbiCQCA1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 22:00:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A661D302;
        Wed, 16 Mar 2022 18:59:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t14so1544946pgr.3;
        Wed, 16 Mar 2022 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3REtX15upPnaASwcpch/4bkCB1kjQjGAtbk3icoBvk=;
        b=TMdefDfEnXg9fSYoW/nR7FkPzThM2vj7YfZWpJnnmWhU7GjFNC30XIdWhdxwMAV9Xi
         xDkp6kPsoS2/ooMfEiLzDQ9nP6o/WWnIVHHKM/4LMh+HgDji/nNth4KMeWWd0JZtzf1v
         H55UJrOKP6OKBs2gCo3+O5YOo/oYncJcl87HBmezTsOOtLkzfKcQUz3/90uflBhJUtm9
         SZLydcnwY3t0xjsa7EYFBJvJREjE+1QbPhWOMkd8Xc9Lp6zDhvO9FcOOJtBEXid01Eyj
         OvycwB33PUA2r0ca566SR4c4ElTDx/dElhO6VSxlnIZk+qjqkc2vsjWHSY3gQm2MYvA3
         7AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3REtX15upPnaASwcpch/4bkCB1kjQjGAtbk3icoBvk=;
        b=PAYHkEVlb4QtnbmuJrvdL7qSE9wszTT7Tl0GlN8OIVSEyqixhcByj2+k3W68Jd5Xrk
         fvEqnC4TBXv126rawSLLqPpEd6/mOkit0KdBL/u2RPh4ATor9ETjvTT8sISfdz5AGU4H
         +Y1WMMDPh34AG4mrlIMEA4HRS+wXFnIeVYZV7ptyfbIlm71bzE5WF09nXZOCN2x5f0d0
         XLqdh31/rHY7vUZwAoIyN9nF7TdKUlNcP/8b15EP9Y38SDKct2F8yvtyqgLucDMOaews
         DGVZ+b5MdYXykV3T9EQQaOegZ50raFQHfEctT7JwWXjDhIA3y9RLQvsXwb7WjFA+Fspe
         2k3A==
X-Gm-Message-State: AOAM533JytO/DnAjumDVDgG958ln5w1k+3WSdeH9Cbx+/PWsWcSFQM+c
        GusvfSXhykEJZ82O364RakU=
X-Google-Smtp-Source: ABdhPJyB3IAXLEijQfRy1kS/pAuXHeG5lluXUNlksA/nDfe5ml0jiTFgTTinaETeSbOaVCeIjshTHg==
X-Received: by 2002:a63:ce51:0:b0:362:c4fd:273b with SMTP id r17-20020a63ce51000000b00362c4fd273bmr1858353pgi.540.1647482351327;
        Wed, 16 Mar 2022 18:59:11 -0700 (PDT)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001bfceefd8cfsm7945528pjb.48.2022.03.16.18.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:59:10 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v5 1/3] ARM: dts: nuvoton: Add memory controller node
Date:   Thu, 17 Mar 2022 09:58:52 +0800
Message-Id: <20220317015854.18864-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317015854.18864-1-ctcchien@nuvoton.com>
References: <20220317015854.18864-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ECC must be configured in the BootBlock header.
Then, you can read error counts via
the EDAC kernel framework.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..ba542b26941e 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -106,6 +106,13 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
+		mc: memory-controller@f0824000 {
+			compatible = "nuvoton,npcm750-memory-controller";
+			reg = <0x0 0xf0824000 0x0 0x1000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		rstc: rstc@f0801000 {
 			compatible = "nuvoton,npcm750-reset";
 			reg = <0xf0801000 0x70>;
-- 
2.17.1

