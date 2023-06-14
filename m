Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D5C72F38A
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 06:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjFNE3K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 00:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjFNE3J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 00:29:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9C1985;
        Tue, 13 Jun 2023 21:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STePVbWTboXwBOhUDrlYfiecAExhvyIlmyNoIXpT10A3VDJsV5qzt7ySNXCki6dc6HC0SeQINFNvJ7oAR1wc2+0q8ME3MW2+I6gNEcoy9WXlyb2SwalJUja8uaeSMFTeXOEgq+GfnLYwRtcdzRcF4eTqgZuU0sHVk5f1j+RaBEP99DMeLXtWh2eGNqDuzhfqw+Rt9yu0+jf/OqmeAllXwRYIA44F+Sa8+Mujqwa4iHHt84xANupXATQHwzXUyqgjjSpGggilpxLnm+VJ+LUxZuVcry1rGHdLwgyLLc60pdovfxKv7sDAovvujFzVOPK3f2klWuPcNQmu46QjGp/V3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF3WBMHN4hDy+AFK9/BwISmReUZIfU3M5sbrDduQBQY=;
 b=Eh5xCiAUaK2o/G3aJv+y7IVop/G28FO+aZRnU6pDmbvDp7tBsA0+gSwGOE2lB3U7XmpnV5D8vglyKgU9jGTLgZ+xVvoX/op+8zoqfCn6q2wZQeIV30GmMA+iQG9Dx8Ncv1FK68+VKDLC7zBTcOFpUACUVheyrZurF+faHsnIuYzRvlbOJvo4mrLPgSQhz0C+aM7ecO6dKzzo/tT1IlfCaM5lwHB/cj0zol3o/EUALMaS45KMAQ+RGEg9VAe18oY5QRoY9Jew/zIGWmCbqxdlXdhkbzTiBfr3felGzuXQ2UfyA70VHVRIEgEjMouXJ3xOggcpzWBXip0Zo4l20ufy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF3WBMHN4hDy+AFK9/BwISmReUZIfU3M5sbrDduQBQY=;
 b=y0rA1RNID0c3Q+euUT1mRikVA494dmrwBBfiDksySphSs866shV/7cLXP3pOi4l/0cAMllir6fKSYlXHEr45BE01G1a1qJLGP4mMFH2r46Pdo9BCdeJMLKZ9X/Ny86W14f4BLzxOB1WsULaoTgkbCDOTWS83EpLlj0e3E6CXTW0=
Received: from SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::25)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 04:29:06 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::55) by SN7P220CA0020.outlook.office365.com
 (2603:10b6:806:123::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Wed, 14 Jun 2023 04:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 04:29:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 23:29:05 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 23:29:01 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <michal.simek@amd.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: memory-controllers: Add support for Xilinx Versal EDAC for DDRMC
Date:   Wed, 14 Jun 2023 09:58:51 +0530
Message-ID: <20230614042852.5575-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230614042852.5575-1-shubhrajyoti.datta@amd.com>
References: <20230614042852.5575-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: ee91b95b-4ea2-41c7-74fd-08db6c8fe3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA0hBzKdozULM64l7hP5FhmL0jv7Gu9aLZ+mL8nuQLUjcOU9IN3mornP/fFr5sxa4lkoLuHR2GYWZt4nT3F/dMx0bBYuLIDy3vZFFQ40ranaJgxMHWq300CKDRVCba64sVezHAf049AWx0RP++aF0+iLrNnJAws85/friJ3ZC9ba3QOVWXMnSXwtFqrkwEKZKf6Br1WiW1Sq23FlxNf8g9gd6Ue8P5KkE4cMU2HJ6PUFFWxgQhr46VB4wkQlMwZYk9xPhTmM/VWF9NsaYqm5CfstkVtV70dGD62dAut4OfYxHamg4XqH85GP+fHgpeUS3CeUt7lvccF7FSmj01CfY7YKIfE9V1tUY94jSQ+9AKlhFeQ/67EkADBFsafI6M7dRpUqByuDo08kjunX/1CgYvPaS3Z8xr/O80WARgao1ovwECj13Mszn5sNzh1wMbQNKtve/zvwzbAxQMDH6lKsKECb/SogInuRT0vYt/9j+v6i85wuKnQ7XwvxBvOv9SqWnjfjn6kXiwZ++B886zLi7YIKnVJ51g7tESm2J5VPKB9+z45UPz26UCU9sf7HF8TdjJNeXsYw9JAiBf75IPiPLpXJzyfmAvkYbiVC0qrmT0KRM151SOfTW+zC6q6sB6Of/WKXnwjLxWlwWKtgZlxIFAh++D8nWTY2Cci6fqLAzR95dKRGjwTYQrIdsL4BE4COiaVA4QXzGbAmhMJJRaoN49akuHzPkgDIgYsXLh5Igx7SlzVvf1OlZ8VBS+LE+muvt4kJpWdDjDqGgC+GjJC28R5f8XnDhcwHxTv0CBFNqgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(6916009)(7416002)(4326008)(44832011)(41300700001)(316002)(70206006)(70586007)(186003)(2906002)(54906003)(478600001)(8676002)(8936002)(5660300002)(6666004)(966005)(40460700003)(26005)(1076003)(81166007)(82740400003)(40480700001)(36860700001)(356005)(83380400001)(336012)(426003)(36756003)(47076005)(82310400005)(86362001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 04:29:05.8285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee91b95b-4ea2-41c7-74fd-08db6c8fe3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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

