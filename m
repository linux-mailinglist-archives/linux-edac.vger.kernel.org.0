Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DA251838
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgHYMGz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 08:06:55 -0400
Received: from mail-eopbgr700047.outbound.protection.outlook.com ([40.107.70.47]:33568
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbgHYMGy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Aug 2020 08:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFqe7vseEot8pBtjiXYE7GW44nvgPNzCeCdLc6lspVj+sfM5EOA6gDVzC/PzBRH9LHU1rqdR1rVIwDMcewv2sEByoL9DdGGyOstSzV1QLk2SvT+byIu541SR79LsuXJdkj2oYiNnai7R5n65YDcMjAU3SzRcH4ittTTZNiRJnQA6yLVtWPaU2tEXSi2uGQ3aqVQ5oCOEY8MAEo7qCPBe9A8t3zlVLQmJ9JJZxW3eZE45yR8lwnOoNooJxJUehQtVlBW+mkssLZYGFh/8kj6ZbQKGZtKRxtfQ/WTQkWoEFgwrXV0H5eA21ME5rX+yrRJKyY3bdHgVAqS8pK20OeZXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMG3mMAb2nWg1X8f1twtmFnUZI6uF+kIIY+RhsQnODc=;
 b=L2uDmQ4JZ7poY49l3hlckYRTXkYLWNDG+Jo3D5JuFgddPlJLCf2H5feJ5jFf22cfkqH8jkkftUYnetcUuvM6JDg07DQKIWg3vrmnKPj4IibCi0xiUSgzVq1vTfxK7ThKjI5yjeS+/Jc5xo9XKVaATY0GMFlKd1OyMHIdUsWHLDBn10OXvtBfyOb6yvw+017vLeE8/H/t9QlrrVazjTA44WzuElyb8M0kYxnaonc3I6ebbLkZxbp1NLJ945qHs8fdQlmNhXQsuMQeG5hZVZcua6PezvvsfpVtRymOwfKDQ3H7drCWDRQuPoi0x6dH2cXgCp7nyF0L3zS0Z19e5M0y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMG3mMAb2nWg1X8f1twtmFnUZI6uF+kIIY+RhsQnODc=;
 b=bogxS5ARNZeRj15SNQEEZnSDWz1qBgV4cM4MOPbpsuKv5ghzlXH6sWdlpGlT/knu/EjO3mTGneKcUOcsinWoJ9GZHsiZ0AIGtqf2bGaVBF8QQ8q68OIqfZOcKiBPHNe5aGACEm2NjvYw9onMrLtIf0fnZaDa9uJhNqUWudaap0U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR1301MB1873.namprd13.prod.outlook.com
 (2603:10b6:405:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.11; Tue, 25 Aug
 2020 12:06:50 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad%5]) with mapi id 15.20.3326.019; Tue, 25 Aug 2020
 12:06:50 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/3] dt-bindings: riscv: Add DT documentation for DDR Controller in SiFive SoCs
Date:   Tue, 25 Aug 2020 17:36:20 +0530
Message-Id: <1598357182-4226-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
References: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::33) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 12:06:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe1ef5c2-9584-4d2f-da8f-08d848ef5911
X-MS-TrafficTypeDiagnostic: BN6PR1301MB1873:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1301MB1873C12462C0CD4188394AC482570@BN6PR1301MB1873.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLDlEQkhmBXWkpKyHfyc7xkRWa0RTNAxdKdscWwLsZKgjKB9HT8cxsUpiNx02j8XZ8j8ybcCpIBJDr5uIF7o27K3wMoaRakpvUSeH9zrmw4sYpw9io9J6UMmVbRTUIFktS/9Zqv5k9RXjDl1bZnhpJa3HkEMi2gFC8ca5CL528wDsYHITDJjR84IB7BgMG3MFJT8eBBOhi1qP6wxS226kfvxz2Ra8GD6/Vqvnhm8ehtcyPLVJ0AghAJXygVR6ku130qZCcsL4Mu7aN/ETTtt2Adx4dssDMu9y2YABFH/s3tuP9tIrGR4/SE0f/2aEmxbTuNQ8dCwlHQYvhYelIF9JPJdiMaGjeOT+NpghF2LS2t9uraUgPLxqSaLJXwDsu+JcLezYvuzBNooxAOeeho7qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(396003)(366004)(136003)(346002)(39850400004)(376002)(7416002)(4326008)(6486002)(66556008)(52116002)(26005)(66476007)(186003)(107886003)(8936002)(316002)(83170400001)(16576012)(42882007)(966005)(5660300002)(66946007)(6666004)(478600001)(36756003)(2616005)(956004)(2906002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fMOX2sk3tsK5vsJ50TKOJb3eZ6Z+V8MT3KlU9+QresCAdY4RPfTwORZQEnrtCQqea9ooEDtcFeRKjts5Jb97Dch1Pfr6WfI5NGLu1/5GkSAF/7Gfq09C1Ulmrtuf3FdW9hqZFJ+HzCLsN/0YoLaXhrI1k1XqiOxYu5G3SVMuCz3kqkAT/9LihIBOZz2qw3kyoKExzzWHO9orDGuEbEz3U7ROUv3PcHF9USOEIRXFU3QtnQ9cv0qb3URuV+uwP+m3gH972IdjYpKOl2V74Cpr2s8FjQQfxao0AUQTGaVuJvRRRPzkGAbJ940wD7Cr4E/jRf2LqQ2LaTFXng7lNwYLR1H5hVneci6zQ+KhRCxDjmhAOLh1UguNTkDUUxDpA9XTGtoZNpwedUNL1cFlCEoSb63O13PO6mQcnZY1NmgufWMUG0Hg1VxeKHZPkyHXJ70vXDcEvBDhBz2VpkhgwtO7ZivXIHviH/UGGgFp/kiHDzuDHUARQqwFrGMakdmOxObi+PG48KfeEWC1PbIRf8EGgYbkjAb4x/4c46OrbCn/KVGqLerciey6haI2VCEq6jCiYXPix42OzbyWVZvEqM07uqOSVNQaaT5a3h49/Zyib2arFGOPuy5OeXzgeyC0waOvgZzbnF6SNR06aETnXaL3iA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ef5c2-9584-4d2f-da8f-08d848ef5911
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 12:06:50.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDJtNMI3YPe/8Wk/kuQTmJ8ZEpNFUbfKn4kcH5Kzqidy0OUvgYux6aeVRXNcJwxhxoZTywXrl+yWYmxSgf5FcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB1873
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree bindings for SiFive FU540 DDR controller driver

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-ddr.yaml      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-ddr.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml b/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
new file mode 100644
index 0000000..0288119
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive-ddr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive DDR memory controller binding
+
+description: |
+  The Sifive DDR controller driver is used to manage the Cadence DDR
+  controller present in SiFive FU540-C000 SoC. Currently the driver is
+  used to manage EDAC feature of the DDR controller.
+
+maintainers:
+  - Yash Shah <yash.shah@sifive.com>
+
+properties:
+  compatible:
+    enum:
+      - sifive,fu540-c000-ddr
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@100b0000 {
+        compatible = "sifive,fu540-c000-ddr";
+        reg = <0x100b0000 0x4000>;
+        interrupts = <31>;
+    };
-- 
2.7.4

