Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FD14A7FB
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2020 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgA0QXL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jan 2020 11:23:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34596 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgA0QXK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jan 2020 11:23:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so5141648pfc.1;
        Mon, 27 Jan 2020 08:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=s1wYdn87+QbdH7yDrIBJnkDyIXjQuBeptWWS8wzNNMo=;
        b=PNRhHtdXfR7xe9pyaeW6nR4xN4FfIBpa5TUMlIe5XvXCDWqeEq1lZ3y3+5XkgT7Bfj
         ZCBTBNYn+zoO9e3PzLapvjFurUz3AqSyfqdxD7PNvG1sslQGj8o17JW+1eOV6NFv6VFB
         j4CKvDL1lrkiQYiJWAILgOPiwo43rBDNbsn213c2xtXBaEmUFI8rXaBk11ieg4Qs2WyX
         JG8WDjUeXdGSZvUx84ubId4w78gWX/pYFZ3nSbxELgm/MthwRkyrN6N84dOgFGldmDtG
         L2aQpVvpeDQMN36toMMCOrKAQh9myZ2houXpyRDatnirmtuJzfmmyhqhOXLHYpmIfPef
         HeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=s1wYdn87+QbdH7yDrIBJnkDyIXjQuBeptWWS8wzNNMo=;
        b=lh0namky7/jRALeINUxQsUrt3zsP1kX80djmS9EpEV0sjv6/r4fFkiXsCfgQOytX+s
         zE87565QuEhS+0CsgpbzsM54MQDra+rJLrSw8cYC/PCufOXrjcrnYkAk3NQYNMr0DajH
         7NIkOwa+lU2WB05FWq5o0eQyvoQsHrUjMRqHxh0Tz5RR+ITH7bR7ueUImsqr6Uxn4HvE
         QjMv3n48WnLg3EEQRnANcHe25H2B2LK7mRvGWXLgrk81PptDhSO+KSB6mY6J0PWBDEJD
         5uucuRPVWHckEmQaNgnmgmq1BjZxmyfJuxz/e1myABcRm8c0N8R7JREMX08KETYha8G2
         WiFg==
X-Gm-Message-State: APjAAAWFI/I0QSGTEJSzcIS88nl4Dqt0CGXxpJXVitTFkJhIifbHtdRB
        ImSWHyKuKpeDpX/WJwNFbq0=
X-Google-Smtp-Source: APXvYqwLHA+1yaUGB1WFCjiJJNvaugK48clGnczqMUdMoM4p0Ze/m2q1KSbtK7Da248NXGkni8B/4g==
X-Received: by 2002:a62:f243:: with SMTP id y3mr17171790pfl.146.1580142190066;
        Mon, 27 Jan 2020 08:23:10 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:39f9:b91c:e1b:9d6e? ([2001:4898:80e8:a:ba06:b91c:e1b:9d6e])
        by smtp.gmail.com with ESMTPSA id c34sm16420044pgc.61.2020.01.27.08.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 08:23:09 -0800 (PST)
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        ruizhao@microsoft.com, Lei Wang <lewan@microsoft.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
From:   Shiping Ji <shiping.linux@gmail.com>
Subject: [PATCH v11 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
Date:   Mon, 27 Jan 2020 08:23:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is the device tree bindings for new EDAC driver dmc520_edac.c.

From: Lei Wang <leiwang_git@outlook.com>

Signed-off-by: Lei Wang <leiwang_git@outlook.com>
Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
Reviewed-by: James Morse <james.morse@arm.com>

---
     Changes in v11:
         - Fix issues reported by make dt_binding_check

---
 .../devicetree/bindings/edac/dmc-520.yaml     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/dmc-520.yaml

diff --git a/Documentation/devicetree/bindings/edac/dmc-520.yaml b/Documentation/devicetree/bindings/edac/dmc-520.yaml
new file mode 100644
index 000000000000..9272d2bd8634
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/dmc-520.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/dmc-520.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM DMC-520 EDAC bindings
+
+maintainers:
+  - Lei Wang <lewan@microsoft.com>
+
+description: |+
+  DMC-520 node is defined to describe DRAM error detection and correction.
+
+  https://static.docs.arm.com/100000/0200/corelink_dmc520_trm_100000_0200_01_en.pdf
+
+properties:
+  compatible:
+    items:
+      - const: brcm,dmc-520
+      - const: arm,dmc-520
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 10
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      enum:
+        - ram_ecc_errc
+        - ram_ecc_errd
+        - dram_ecc_errc
+        - dram_ecc_errd
+        - failed_access
+        - failed_prog
+        - link_err
+        - temperature_event
+        - arch_fsm
+        - phy_request
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    dmc0: dmc@200000 {
+        compatible = "brcm,dmc-520", "arm,dmc-520";
+        reg = <0x200000 0x80000>;
+        interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
+        interrupt-names = "dram_ecc_errc", "dram_ecc_errd";
+    };
-- 
2.17.1

