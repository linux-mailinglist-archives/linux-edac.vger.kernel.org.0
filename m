Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC822B0499
	for <lists+linux-edac@lfdr.de>; Thu, 12 Nov 2020 13:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgKLMBr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Nov 2020 07:01:47 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:42880
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727934AbgKLMB1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 12 Nov 2020 07:01:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN/vTo+yHRoZlemuQKgXBVOaEov4d7aYz2HTxxEBIMzNhsixzdM5G7WPErPyPKrxO/J3TfoANuueM39VngED9jF37dK5HGVslyRc70uQa/nYIPD6RBIkBQpJD4jnSS3tq6Ddnc7B5ZqAmzDD8eMJ20GWCPhYsCDZBIIB4kTcaxqG64PrkB5Rs5DGZl3LMr2QAPDnZ7Odxf8ixl3DFNQ54XB1uwqLjFz3JXMY9z2vGWKVpAjHhTNPU5CH2J432RyJERul92b16DJvORZ61aKiofv/4+vx+8biCfYQrPVXZsnRHU1MHJrjBFYDH5wTB5NOvJj41YwrQADmxFKt4HUZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8OBlsS7A63dZW1tRakBnxsQUjm3Xy7LciOTf5OSHeE=;
 b=Xzzy0SXJDO9XicqbexWnuapNeb9JCKTK30Tsm2TN6cL8bIbJJl2maArdWZpP1rst8+BuN+TxI4DWzoZrj6hYrb4VrZqqwuCrrajHi0lKT4b2/yaKdUJ5Xi94uZ/0hVIRMJZedUkLG9Dt/NgjKOA6qCtlTYVNl55PySFVErbjegTRRWGqxXMvIkOONQDUzN95eJCYrifGEBamBI5mvifUe71/XovOUAqSzknF6CcXsIREYqfNC9qoiig9QQ0iNuSriQwgHMGirjo65dyRe/Rl28VQB5PERul7WkMOjho3NQzwiotmlRIctsvlH7O1Bavr25bmA6UOzzKAZtJ3JHDk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8OBlsS7A63dZW1tRakBnxsQUjm3Xy7LciOTf5OSHeE=;
 b=OPeURLMMUc+x4No6ER81FrHdqfKHV892cgXAPtVpqgcGmqCUDC1eKLd3TidnV1GGjBDB+w2qt1QLHAVKR0fQHckmdTzgeBxqCY8ALH3IE9tjFEiBDlLEeKx56POBpdL7ZbAmlYaTpAzCIzuX/uVhiN07Tlxe29xfl2dz3OsvoJo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BYAPR13MB2392.namprd13.prod.outlook.com (2603:10b6:a02:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Thu, 12 Nov
 2020 12:01:24 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513%8]) with mapi id 15.20.3564.021; Thu, 12 Nov 2020
 12:01:24 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/3] dt-bindings: riscv: Add DT documentation for SiFive Bus Error Unit
Date:   Thu, 12 Nov 2020 17:30:55 +0530
Message-Id: <1605182457-86046-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: BMXPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::34) To BY5PR13MB4453.namprd13.prod.outlook.com
 (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 12:01:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09f871de-310b-428a-11ce-08d88702ad64
X-MS-TrafficTypeDiagnostic: BYAPR13MB2392:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB239244F159A8739D260A545A82E70@BYAPR13MB2392.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVMHETvUiGZyQuAdiFJZZJn6/JIgeis7YOzV1E5Ob5hT6eV4IzRKFTnNXs5JzzZeCdPnv61xG4sULG2lXOZ5Y4RT6gFBwdTWz9YKy5kMl57DmMCE8oTib6Q0ymFyFtZcymySJNmBbefdne57ykKATV0IW9dh+AZHmQIZ3yU3eg0yMmJj5Nr8CToSN++9aOsycZLZvjLsIDHk/pfPkbQWuQVjplHIRCpF6Jeryt1FroJRMKLNtZ1grlq8kmbzDl3Qrck2R+SuyE4SwJT0GqyOurmH3BY96qHb8PAwsbJWrbAP+xSVnuPJLEbiq833czMjY5Nqpiy1+Gx9QQbYy8KjQxt4mBER/tMRyyaiwQNsiMmHc7xZc2YflUR2A49Hc2ocNL5bJQa9elQDY8byhYBCLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(346002)(376002)(396003)(39850400004)(136003)(366004)(8936002)(42882007)(478600001)(5660300002)(66556008)(66476007)(6666004)(6506007)(316002)(36756003)(66946007)(6512007)(44832011)(26005)(16526019)(52116002)(107886003)(2906002)(6486002)(7416002)(966005)(83170400001)(8676002)(4326008)(956004)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q1Tuz6UKRXsjDl41N0LkOGU3VTrexliKfZhTxo5KCfe/c6OiIDZQelz3b6sFG53RRhEciGgUoOph2/EXia03uH/Nw/ul4ajOCyVGytxMHaPvZN2Mlkaibmdjcv5mzhdVmi5ZyHHzHj7WOQZqnUUay3WDb+J3TjV2SIqH+IJSuNCeUTyVNRnL2Uhtp47BkWqKtdyvlE6N34hPfPJGgIrqcTtdqeIOlbG8P3/eg0eSOfIXpFNzKSawzfBOE6Mn1jpbXdwfRS22PwADy+rHv5h14dNkYAJ1g0U7GLIvP2UNWIGdXGX5eB8EZKYNtur/PtYNR4P863DWhXXPABFWr7QWF28PIkXPetXvW+C5lmd53n01nz3qQYWCUTz0DZboTKZjOmhBeEoLAcmPI+gxdJSzSvyvX2lQfFHpYsLpKItB7YWV3IhrMIwUVUIVjgMNwEHO1DQ7oKs2T2oE3imG9WHrhPlDETB7wUGGOXuldHOh+dUytYI3P/k8a/47elv08Qz9m9npttCQ7M+9sOfCBzUx5UfSI7ioQZfivT4BmdDvvUdJyuhyw56sfwhgI6G2mnHNkoXy46iV/nx8yn4XOoyofa2DaNxYQPBrHe2EbP+9Fb5THe4KEWzBnWZqg8L2F+t7ziiyU+vZDKbMegeBay/8/GqDqtj4+aHwukjbLKKeLjMkt/SjeQVPyOrTa2RHSlVikakdJCQYxDdkT/uloUt4E0UbRHeiJ8POxN9Q1X1ZeWMeAHaNXAmt7/AdDw9YTC3qV4Pk4WpH8K8EcfIHqGIW0t3k/CB9QE/iz7x7tXGFf8A2GL3Z1X0IBG/ZNp7lB51BYeSmFk+philiCWHKnE5PhZtU+iPUb9CKK70wS+OEc/dqON2lP5hGjbuCTeLAT58fvHpZsstROrx1yxkOEodBPA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f871de-310b-428a-11ce-08d88702ad64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 12:01:24.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcsfSmLahV7XscyHJqm0HsRm8uEvcXKfnQxchID0esNG8Pc27r4SytC6BkBd/6l9na5uaBXgHUUlFqL9inkUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2392
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add DT json-schema for SiFive Bus Error unit present in FU740-C000 chip

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-beu.yaml      | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-beu.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive-beu.yaml b/Documentation/devicetree/bindings/riscv/sifive-beu.yaml
new file mode 100644
index 0000000..4697787
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-beu.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive-beu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive BUS Error Unit
+
+maintainers:
+  - Yash Shah <yash.shah@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+description:
+  The Bus-Error Unit (BEU) is a per-processor device that records erroneous
+  events and reports them using platform-level and hart-local interrupts. The
+  BEU can be configured to generate interrupts on correctable memory errors,
+  uncorrectable memory errors, and/or TileLink bus errors.
+  All the properties in ePAPR/DeviceTree specification applies for this platform.
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu740-c000-beu
+      - const: sifive,beu0
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+examples:
+  - |
+    bus-error-unit@1700000 {
+        compatible = "sifive,fu740-c000-beu", "sifive,beu0";
+        reg = <0x1700000 0x1000>;
+        interrupt-parent = <&plic0>;
+        interrupts = <65>;
+    };
-- 
2.7.4

