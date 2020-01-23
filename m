Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE4145FEF
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 01:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWAbJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jan 2020 19:31:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33608 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWAbJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jan 2020 19:31:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so440882pgk.0;
        Wed, 22 Jan 2020 16:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=I1NWWVIHGXoG7VFbe2feJQfdiQOYXTHsoIp2sJtnPI8=;
        b=HQz+kC3Xpm6aWDCXfQNE4n+bC+wKNzsli7HoknufUNIKNIAMtFf3rT2088xdYHgbYD
         03oAN39sE5tPfE5/zXqzta4ekmSXp1WySkdNtzyeMpb6HOkVfqoBC8xKREkUfO5P4iyE
         TFMWqU55yjJ4s16fHQN/6tCvqjvm6GO+qUyuJI/x1UVc27K+/6PB6gSqqpBTwg7xVTxj
         HPGv+yzFzmhoqAnIvnceFk+DN97r9XrLxsBCrFpErh2m7Et+S9irgQO/WSId+RbAPOZB
         mL/gvWQO2/YbY0TgwoRUiJR9PR3DDfqdKiVMDagKXPeRq+ctGq491uRUB37H86ELK064
         +9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=I1NWWVIHGXoG7VFbe2feJQfdiQOYXTHsoIp2sJtnPI8=;
        b=mJdGMBZZYZ1Q345tzohFabbjk4nN2zF5XTtaIKifz4V+FOAKKo2rMGARriAtJvy1Gz
         5XNmd+y4IneBEbJU55lZ1gL5c+Jr6Hz3uTyYIrppAOFU2Khcdfbgh4Ofi/5Ui4u0MJr5
         7EJzVaibw8pmvNL+JUVez9eYFAVgvd9EAW8Zkmf5CVCx66pjgXwsnrYLfGFg1H7HR1qt
         /kQDQrDlM/Fyc/9QzHOJ1oNyQ+NgCBsQdSU7H+AfIFmhOzoJwa03ycESjGk62Pvg/6qO
         uhHaBbI+usd7CgoyUy7EPpxmUnaQu//0S6fRmH0PjxBINHVgdaiuBnsHnbQWUXdAd2cN
         MU3g==
X-Gm-Message-State: APjAAAUfhZNV8rwbVy8/5UuKQ65AprOjIttcTPxhABeY2VWSHnPTeMZ6
        PZcuffOLdJmByzzYFfSrcFM=
X-Google-Smtp-Source: APXvYqx1qO1eGORTmIN0owFT8xYr45XG8x/ePyvdZj93OO1vfLtYaPpqyeCTYgKB4CUl7DF4DYGVeQ==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr5213655pfi.10.1579739468778;
        Wed, 22 Jan 2020 16:31:08 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:140e:bf9b:65a6:dd72? ([2001:4898:80e8:a:941b:bf9b:65a6:dd72])
        by smtp.gmail.com with ESMTPSA id s24sm94177pfd.161.2020.01.22.16.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 16:31:08 -0800 (PST)
From:   Shiping Ji <shiping.linux@gmail.com>
Subject: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Message-ID: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
Date:   Wed, 22 Jan 2020 16:31:07 -0800
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
     Changes in v10:
         - Convert to the YAML format for binding description

---
 .../devicetree/bindings/edac/dmc-520.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/dmc-520.yaml

diff --git a/Documentation/devicetree/bindings/edac/dmc-520.yaml b/Documentation/devicetree/bindings/edac/dmc-520.yaml
new file mode 100644
index 000000000000..dd5982b227b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/dmc-520.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
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
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: ram_ecc_errc
+      - const: ram_ecc_errd
+      - const: dram_ecc_errc
+      - const: dram_ecc_errd
+      - const: failed_access
+      - const: failed_prog
+      - const: link_err
+      - const: temperature_event
+      - const: arch_fsm
+      - const: phy_request
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


