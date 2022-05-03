Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDA518195
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiECJvW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 May 2022 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiECJvQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 May 2022 05:51:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0890329A3;
        Tue,  3 May 2022 02:47:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq10so14890920pjb.0;
        Tue, 03 May 2022 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J2a0MMW50oXViY1edzoxXF0rBee0FZ1e4ZEb2hYnjXI=;
        b=ZVT8AQlucwe/23CKJqCvDeAOwvBQmFf2sB/YvwjGyava+dh/iIFUFZqi+DSwQS7mUF
         BYh2LGYWin3cben2xVbBLQSFxJeN/I35iJlTthKId8oah15vmEYse4VzPThPuBmQQgtZ
         395+NMvms9eAq8jXn0ijruZZNonp4UU5AtGDounPl/xtBzQkR9CsUrDLmQy+3XGReDSD
         N5T8ohxbqR3CjamOuq0a5755lGRJBk+UWqOTGpVoBSv4I+5tpnI7YdOLSE8+ZBB6Y4DS
         yZ4bftTBsYeLIHcUkj+9X2S/q44vIdVWwFbNBnL5u8OP9eTkEM3q/OUzljCAFXXXPY6k
         Eidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J2a0MMW50oXViY1edzoxXF0rBee0FZ1e4ZEb2hYnjXI=;
        b=UotDnlrEkLSTWC4D17gWlQkjIfU2Rs+zcA++Tr3LD2ZHkiFx8hUbiRhM9Ekav1IYdF
         xe/yCF7XPzLxAAcCj5l7e/ixKKPS7ikxK7wEWqDv2ZvY1VsNOGeOnnQqGWuLwAu98jiZ
         Y05NupCmQczKU4zrUwfiPHJY7B7cusR6YkEyKWZKBP98NogGD6JtLlnML4ndF6KI2XI6
         DpLs0TZtjJAaNeCmyNGju8FyKYfJLxyHNPAEJm6AGn0dJNxJJjlm4AHsHFWrxFh5roJo
         pVWQBS7gmDsLw1pXscfIpqCwairHjjO0Rcatu8KVM8YEs5Xuv3mlcohO2uOoVs6q5mwd
         OroQ==
X-Gm-Message-State: AOAM531G3WuxBAMIoWygCXwTIMETf5uHcovg4A6XCuDMvCdrm+SSOlDq
        i5qLW6ihqes9NjGGl+M4tmk=
X-Google-Smtp-Source: ABdhPJzQmrPhiXDWSjASpCvUdxfJ6WR0xMjmoWJ3JOnf9QPzNoa1uQr5bmajgXycXfYA4X7Xr5rdlQ==
X-Received: by 2002:a17:902:aa8e:b0:158:e94b:7c92 with SMTP id d14-20020a170902aa8e00b00158e94b7c92mr15858104plr.126.1651571264172;
        Tue, 03 May 2022 02:47:44 -0700 (PDT)
Received: from cs20-buildserver.lan ([180.217.147.224])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090a421300b001d90c8b6141sm1015222pjg.53.2022.05.03.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 02:47:43 -0700 (PDT)
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
Subject: [PATCH v8 1/3] ARM: dts: nuvoton: Add memory controller node
Date:   Tue,  3 May 2022 17:47:26 +0800
Message-Id: <20220503094728.926-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503094728.926-1-ctcchien@nuvoton.com>
References: <20220503094728.926-1-ctcchien@nuvoton.com>
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
Reviewed-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
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

