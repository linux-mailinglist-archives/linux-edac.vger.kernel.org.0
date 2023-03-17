Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E636BEAAB
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCQOEk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCQOEj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:04:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B310A99;
        Fri, 17 Mar 2023 07:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUlgpLguB+vt4tO6gYKexB/giXfWh7mwl0dfPjHTxCu+FABFutjak4kZmKzCRCVqgpqyhkYl09hzZO1ba79JmPKwiB93f69zpze+SowvSQA4xLdWP4hCU0tce4arIIpVa9OfCpbHJ9xlcLLtnIC7vxEs/ZkHC/2x3NR3qntD4Jw/iAzlPX7c9A42CpUpBHDJDN1naUF7in7xtE1w5LmAEt2SYgF7XqvK74wOAbIKAqobr1hLmtnSmnSuYUw9+9egEJ5+KNhIPkmgUSWsT9Sy+/ixJ9bYbFB4ObRO/Cs8etWk129dgXBfGMaR9lw+HhsBU8+VfmOhNPBsqVMa/FZ+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=hUV0zDSlWviN0CB4vhPeeXL86sxWKlNNUXeSzth1VRguK+hpR1S8X1dlPehG506yoXn40NFvtRNBxEVvRF+enpktFvqHG/vG0YbAnL1c6YK0a/DvdljvwoZzRkxcJ6N8FMap0fF5e39Z0IU7q0a6cbAPJvjILBPbWvRgt07yPPbuXuCVbNlPyY4yWbsiyTzfDmTFgRtdWxUfdaAgwwbzfBn2ys37RvcLEE+YVocE7uWmO1emfxR0VfnOHFijsypqHGFgFIViU4TpgfW7fE8giuHsE54neRmQApvgiKKDGpWCcSz/cLnPrsQv5/wveiqbGnWRJGEC3IexXZlXoVUpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=Bur8mN7herM2KAcvp/yLAWIbh1H02U/6SyBu9AChgmFq9iWaWi6hemaDNh3+oVUuYewdAiRWLiVZVgtzvvHcn7EAW4ooUHYaauoxfI0AsV+0FqeRiUmc9JHqnsd4CQmfOpPWm/PY1W0j7Fp9YF0JIQvOHvyiljaEsctAri07ZuQ=
Received: from DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:04:33 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::5e) by DM6PR21CA0020.outlook.office365.com
 (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10 via Frontend
 Transport; Fri, 17 Mar 2023 14:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 14:04:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:04:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 07:04:32 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Mar 2023 09:04:29 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <bp@alien8.de>,
        <krzysztof.kozlowski@linaro.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        <michal.simek@xilinx.com>
Subject: [PATCH v4 1/2] dt-bindings: edac: Add support for Xilinx Versal EDAC DDRMC
Date:   Fri, 17 Mar 2023 19:34:24 +0530
Message-ID: <20230317140425.16827-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230317140425.16827-1-shubhrajyoti.datta@amd.com>
References: <20230317140425.16827-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd264a5-4a19-41e2-13f5-08db26f088c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQ0LkRWHGOmosKRlKVAbZDC5JnNuDynwW0laMxklirxWKAcv++053YqO9guY1J/YgNebEBVbogTJ9XLiCHXpuhBHkzgkMmHN1jibcgd2pXRCNmJLWGKl9JPsqbx1bEAjYD4vzS3Ez7eyotP7lJjJexDdlMwnK/eUQ9X4X/pmJXbwefcRfMrt5XXysETw7qsJVacnkH+Q4Rz3ioGK0ATBumDMXHdJkthDQO+kEiK5cG7Oe0JqgE1ZK1PRCERK4aw//oTkX8AngMFnHkhbSWtE9GfL0iqnzGv87/F8s31fOKZYApflB7cbnpcjsu6PQP1PV8KebzOZkwxH0ea7anjqWfx2F3rDRmUO4RoqN9MCy7IXqHPfvI4iXVxl7mh3mWTITRLZ1XdmS168+5raIGqjEfy9kvSKlPetuorQ9I/4AREs/w/j+4TJN3mDH5ZQG9wrnxRQY6Tr6eK5Tk0ItNZUvuYGgOKa3sSKkEiCjAYljJ8ZYilPdF7C0b5UIMyQvBTzLTt8raI7gB7JcI00nD7sE3MlL9RrFqn5KkVGYNtBceYwCSPx58McxwY5uo+cli9ByQ3zNw3CFK74OYuC2Sy/ZuTJKrK7j1L4vZUMHYj+eQPvQfIN1bVzrFva6h8ZgIsa2UMEtcWA6ML9UFGqqNELwKAwgljZTsNhpf+nI7oLBL2A/o9BxBmk6zN8Gtlv+76ZlESqnWlzm14T6A9af2ak/vlngv8KoNiyMFc28pGThfmyEHz3/fFnTNoVyq72Hpx1taPxKCRV8l9zvYwdrzr72w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(4326008)(8676002)(2906002)(70586007)(8936002)(70206006)(44832011)(5660300002)(6916009)(36756003)(82740400003)(86362001)(36860700001)(356005)(81166007)(1076003)(6666004)(966005)(26005)(40480700001)(478600001)(316002)(54906003)(41300700001)(82310400005)(83380400001)(47076005)(40460700003)(336012)(426003)(2616005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:04:33.0546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd264a5-4a19-41e2-13f5-08db26f088c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v2)

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

