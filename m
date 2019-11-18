Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CECCBFFD03
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2019 03:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfKRCKq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 17 Nov 2019 21:10:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35442 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRCKq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 17 Nov 2019 21:10:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so1008942pji.2;
        Sun, 17 Nov 2019 18:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=X4uePLRePHS4hFCHmPpfI5ZAvCNjVU1IE4m0Ocmm4jQ=;
        b=f6bk9r/k5TpMLqq0Ob0TJCq/7aO6+JwJpJBM0zcy4ojXPy1Aa+D5bRmtkFSkY/IhqO
         Kd/etfVn3LqXtW8tgJfP3KS7z/F+QDMnp+7y4rUxUIgkiIK8VAQL4Y4wJBjK6BtSqfZk
         7dAFzI+1Ojgm5GxePsbubeAcH1XETsk3WTmXVW9pS9BIs/4aDwSkBOsp7M/1RKWZhQs+
         plnsXvkHkCS27kkPP7WD7bwjKE64ehzX/2SsDKCfsU9fMtu5X2c6snUl2OqUq7SD9Y6F
         qE3ECERajTJ2oc0UtSMTfsqqW0fHQMNFOvBGDDW62gtnNwmYlQ6jKJkYiSdLZ5Alpdh4
         xxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=X4uePLRePHS4hFCHmPpfI5ZAvCNjVU1IE4m0Ocmm4jQ=;
        b=BRhhCgstWk3SVs5YYGitsK9jIFMMxm3NzbaOhUxwHI7pMIu4KFSHjl9/vBTMwSOZc7
         zuefypCrOOId3wPJbvgz92a7QG5EN9B/cEQEbeGqETTDGE/YLSt+CSHy3S2bcQU5VqJh
         wQYdoIE92V+EyRINKshUvGliH7QixWHIKDrNo6IRiRBTn9xzWxIqMzLvPtqqS1rO0jvV
         dydJu09af+N3HTaajr887N+7Wsj+aHZQJj9eqgKJVLL0lUtJpfngEJ38PeDDCbBjODk0
         8KY8aeDeKPOxQlLDkdfA+E5JnjZ486Y23fhOLjZrSG0FDqngMxkWmBL2SNLg4FKbppnO
         CZ+A==
X-Gm-Message-State: APjAAAVLssW15D/GUt46/2c0j7C4HQ/7MAolunvjlq8Xih67mwHnH+JT
        /fFJ5Lw66zxjgeOWSC0lCZrvwjNTsB4=
X-Google-Smtp-Source: APXvYqz95c35KUbPSpI1G5JkO7oKQKCJL2Wdc3NZlImF8P1+3lVEgs5EVjlqzOYxjUyN0hBArkUhoQ==
X-Received: by 2002:a17:90a:1ac8:: with SMTP id p66mr35524738pjp.24.1574043044004;
        Sun, 17 Nov 2019 18:10:44 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:1009:d42f:7c91:4399:b8b2? ([2001:4898:80e8:7:6421:7c91:4399:b8b2])
        by smtp.gmail.com with ESMTPSA id 8sm10976987pfc.42.2019.11.17.18.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 18:10:43 -0800 (PST)
To:     bp@alien8.de, james.morse@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com
From:   Shiping Ji <shiping.linux@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, linux-edac@vger.kernel.org, sashal@kernel.org,
        hangl@microsoft.com, lewan@microsoft.com, ruizhao@microsoft.com,
        scott.branden@broadcom.com, yuqing.shen@broadcom.com,
        ray.jui@broadcom.com, shji@microsoft.com, wangglei@gmail.com
Subject: [PATCH v7 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <f947d821-8e67-dcc7-d753-5b04d099792d@gmail.com>
Date:   Sun, 17 Nov 2019 18:10:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is the device tree bindings for new EDAC driver dmc520_edac.c.

Signed-off-by: Lei Wang <leiwang_git@outlook.com>
Reviewed-by: James Morse <james.morse@arm.com>

---
     Changes in v7:
         - Added arm prefix to the interrupt-config property

---
 .../devicetree/bindings/edac/arm-dmc520.txt   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt

diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
new file mode 100644
index 000000000000..476cf8b76f2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
@@ -0,0 +1,26 @@
+* ARM DMC-520 EDAC node
+
+Required properties:
+- compatible  : "brcm,dmc-520", "arm,dmc-520".
+- reg   : Address range of the DMC-520 registers.
+- interrupts  : DMC-520 interrupt numbers. The example below specifies
+     two interrupt lines for dram_ecc_errc_int and
+     dram_ecc_errd_int.
+- arm,interrupt-config : This is an array of interrupt masks. For each of the
+     above interrupt line, add one interrupt mask element to
+     it. That is, there is a 1:1 mapping from each interrupt
+     line to an interrupt mask. An interrupt mask can represent
+     multiple interrupts being enabled. Refer to interrupt_control
+     register in DMC-520 TRM for interrupt mapping. In the example
+     below, the interrupt configuration enables dram_ecc_errc_int
+     and dram_ecc_errd_int. And each interrupt is connected to
+     a separate interrupt line.
+
+Example:
+
+dmc0: dmc@200000 {
+ compatible = "brcm,dmc-520", "arm,dmc-520";
+ reg = <0x200000 0x80000>;
+ interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
+ arm,interrupt-config = <0x4>, <0x8>;
+};
-- 
2.17.1

