Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373997BA549
	for <lists+linux-edac@lfdr.de>; Thu,  5 Oct 2023 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbjJEQPi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Oct 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbjJEQNl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Oct 2023 12:13:41 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952021D03;
        Thu,  5 Oct 2023 03:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meMVXrH73P8aCY3AMwAtLj4hb09AGkpTdsdRdl8NFWnqLUn0POMHh49IAQAdiWatjJxKCBGoDuuUOuDQ/Oaw3rTlMMt/DzIPFvuvVhGvknq+crKdq6Z6h+QjxfT/fXgXoKnbAlh0RpZMkzDqfVZMjeqF2L60wK/jE9zvf1+CWNG7KdhsaEkHmLaRSwLoirfFb+cigkZSPreDmjHqE2dSnLFEj1KCDSw59d6sJ6VUYEJgtXzm7e19AEkApfYB2qUi/FsTirbYTlVzR7VjCLaag+VZhxSRqdpPWE1zpoPGyF+9MT/Al3wHCeIxNrEIGiwky0n3HI0sG6UeSFtwbruXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crF9syLzrsh29YMf9SO5rhjeVWlnX4EhIXqYmU66Ko0=;
 b=UcudvmUVyjzv48vNGg8Qrdkp72ISpDuFhQKW+nL51QKrdZvdmek8KXfAFANHNqD6KZmQEXH11BZ/VSHz/BogXQTGlWVKAs4f9rnAnI3jma2De2HcbkUbV/p2cqtwUUe4490cm/dhHzVVMWYWF41sVxouYmzmhobd8nsSrCYOiuDg+IEAkEiDCXoiVxKbXZiA3vAgjDt4AQhhuMlGQJQqkLX38fdAsOcDVl5GA7X1NbkoCpA/nChrihdsQrC6N3v+/F6+pdH7FAHobqXCexfu+eruEFHOuoycfdNFtZZOxfIfeWCzHEbJqulbRnuABOea9hpcrN5lImImY9oSPbseBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crF9syLzrsh29YMf9SO5rhjeVWlnX4EhIXqYmU66Ko0=;
 b=sTj/yEgrphvHiw8mKMmd0Blj+H5pcSoYfEOsR3kexhLz0cUYlU7tkXe8vvHxMsHfk7J3DYONuupaijd/S3TL0nyv7TWGDhDEsirdNVOJ/LeTyOBdZVO2bEogeGPGQ4YzZ0V47tjsBcBY7ijgebwkTBQkEOI7xdORZ1MZAjKkQOo=
Received: from MN2PR04CA0022.namprd04.prod.outlook.com (2603:10b6:208:d4::35)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Thu, 5 Oct
 2023 10:12:55 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::5f) by MN2PR04CA0022.outlook.office365.com
 (2603:10b6:208:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 10:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 5 Oct 2023 10:12:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 05:12:54 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 05:12:51 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <sai.krishna.potthuri@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <mchehab@kernel.org>,
        <rric@kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v9 1/2] dt-bindings: memory-controllers: Add support for Xilinx Versal EDAC for DDRMC
Date:   Thu, 5 Oct 2023 15:42:41 +0530
Message-ID: <20231005101242.14621-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231005101242.14621-1-shubhrajyoti.datta@amd.com>
References: <20231005101242.14621-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1baaac-eab7-431b-78d2-08dbc58ba4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xylfc26VBkcv6adMwkydl3mbS1wX4Y488AekF/tnaA6bzmGJsckU7mdFQzKuA7XOtlV6EWW8IlBXabcWE50CxyMnoVuVK3OElVxteCYvFjGpiQUkZtVZlMwrG2K3PSXLIc4yBPL8RJlAu6WnIze3BmZ1iKgqVlfGn2nosgD8J2h4r4lutq9vQZkQ75ZFo246mcafpMJ4+31kNSF9/t3Zd+cC0CH+p57sDxGF/MI0xhaa49rB6GLjvlbfytQai7PsgOSfMOsOW8of0+olyWgTe2K6SrzvSAQ7PfYezxdaE8ZDhvy/jX/dnlqQN/SbLDbR23L26EItVtqDglSYudC3ysU3lMpgolmRmBCNAUJuWR9olPndYfyouRSNpDtDGlaaRAkzL0tpOIhU9kxYrlpzKrnR6Zop20mBRT1piYsCfVUfgYaNfnCh1FswOgiyVWcp81jVZMS4sFtcu0O2W4QpGzOlDR/jXqlsiQl192xmI3vwj6GzwHy545uvxqf0iyefuH2HtJ11mvEIXR9JYUdV+Z4YdLj5k6bIMYdeJqvMAOxQb6We3Yv8vCPG8CCsvb1KXZRgN+uCKgqevpQFWxYb3GehwZdmztcB2EMee4Axlsqjl7tQa4JX+AlHER+oxZTpgTU2XFTrRLX59xnngQ7ZuG92XfS0slFre92vCjpvrhwxVp3ppkAm0WTVBALRzzDVxM3+aCJ7QAHR7esopbAwzYIOO8jgDGurKHkoZvYM7265x6DQ/kG35ofj3Od9vQWgCNNdE/+hpA5xasLkHlQj4YAqwqoXrp3bu+U7lDbPwQE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(2906002)(44832011)(7416002)(4326008)(5660300002)(8936002)(8676002)(41300700001)(70586007)(70206006)(2616005)(40460700003)(316002)(6916009)(54906003)(36860700001)(40480700001)(26005)(336012)(426003)(36756003)(6666004)(1076003)(356005)(81166007)(82740400003)(83380400001)(86362001)(47076005)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:12:55.6022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1baaac-eab7-431b-78d2-08dbc58ba4a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree bindings for Xilinx Versal EDAC for DDR
controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

---

(no changes since v7)

Changes in v7:
Update the subject to add memory-controllers instead of edac

Changes in v4:
Update the reviewed by tag

Changes in v2:
remove edac from compatible
Update the description
update the ddrmc_base and ddrmc_noc_base names

 .../xlnx,versal-ddrmc-edac.yaml               | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
new file mode 100644
index 000000000000..12f8e9f350bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/xlnx,versal-ddrmc-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal DDRMC (Integrated DDR Memory Controller)
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+
+description:
+  The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/
+  4X memory interfaces. Versal DDR memory controller has an optional ECC support
+  which correct single bit ECC errors and detect double bit ECC errors.
+
+properties:
+  compatible:
+    const: xlnx,versal-ddrmc
+
+  reg:
+    items:
+      - description: DDR Memory Controller registers
+      - description: NOC registers corresponding to DDR Memory Controller
+
+  reg-names:
+    items:
+      - const: base
+      - const: noc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      memory-controller@f6150000 {
+        compatible = "xlnx,versal-ddrmc";
+        reg = <0x0 0xf6150000 0x0 0x2000>, <0x0 0xf6070000 0x0 0x20000>;
+        reg-names = "base", "noc";
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.17.1

