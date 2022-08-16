Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3259560C
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiHPJUR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiHPJTf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 05:19:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832510892F;
        Tue, 16 Aug 2022 00:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGgDe7QWfJdi+7im/kIAAFsq+HzaUXUxNjr91v03cC+aVMd8kFAALDQZgVBmp8sCIl/I+LEVsCh5CbBh09x6Uo87q1QCMjyRPF+jbsUdmvJnBMiX7fGS5QSB3KegjPKgEjk0q+DNws1Up8mTaVZsU34QDflaxUgzWXj7PVyy4Dnm8rTCJJIDSDQ68ckimK0WolbM4678vT7SEFz02RcbVk4r5n1FUXaq0wQCmt5cQoTAIymYRPk1UMNejRZ07KM9yrBTyhRl1B7L8ensskq6s08mzZpl5uVX4+AJ2qVnRcLzVFxJ9RfVGKxaRAjYMxCUWfAJRULtOCLF1LZL3B8mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maeL1rpcEeXphNTlq36PXT0mMKtzHlJTFkviXKw2HZc=;
 b=iiBDI+hR/Gt7V0eNtvDxNTEobtzhM7hs2qhUuhHsBjDTaB0phZnSsYfXikSdqcfwaJT8cuXfkb6RQohlfxkZa1/6sm5kn2Hgwwyro4QHkpqCbYnbjNpA4vCAXUBskFqulml/ErJBxqoPr6FAAhQKsd4FplaEedmjGWdaU77lSkNhFv4L7dT18owzArUOz5jlz60IuMLzJLBYvwP1VMW5fuHPqPnm4+778SAwfbduXiKVuggUpYSlZpa/t1nZWHny/Ehif7aiBHwR3F57w0wCV4H12Kp0hEa8K7oByPuxFxAkyNEmSdpqqUqiX6P/y12NFhizPDbEv6Xzu1GljV11KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maeL1rpcEeXphNTlq36PXT0mMKtzHlJTFkviXKw2HZc=;
 b=jx7Q0xzF1kyrY0cxdlW30ve4Kc872laf7/SQXBcDNVnCTibWZXOArdZ7jQZu/0JdqII9CyL89nhJKzsBYmxjeVtKQrIA7tephi2LLR0L4WWZU3E0zyzDWXFXVbHFpeL5RV5K2AZNcScHT+xVzotl1KhqOjjHd8YTIEXAVjxUn1c=
Received: from MW2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:907::19) by
 MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 07:35:09 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ed) by MW2PR16CA0006.outlook.office365.com
 (2603:10b6:907::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.15 via Frontend
 Transport; Tue, 16 Aug 2022 07:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Tue, 16 Aug 2022 07:35:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 02:33:24 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 16 Aug 2022 02:33:19 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Tue, 16 Aug 2022 13:02:02 +0530
Message-ID: <20220816073203.27314-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
References: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc98fb9d-a564-48cd-a27b-08da7f59d896
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cIVUrxeStDLgmx2W6aHRM0isa5ffXk+kz7hlW0n2QTXmYZPhA2ECXo7RU64t2sM1N2wrbwq33f0OPcf4H9ej6e2jqIbED1vGr/MuQkMTaTmsT0n7+2X8eKHuT4z6qMCii+0khdw/ctPuZx3l8/hwcoXVYAzQoiSkfAcVnvm8bIskfuK4S0U6XMxfgItAJcJGZQKCR504awBt75OKApDbcobr61nCCKttsbv1X8TyCsdvGAas8JNQb28bWlxuX4HUA7RLHzkovN7+YO+NMHhvE8H+fzBVxD8swcitVuoqg78+NXTkhRF+/kfAMHjUsWeQT9hJfh42iBwQjpGTHWnk1+nuQBPD+1TLvk/LXJFWwZP9zncnrFDFGqwnaOPvygUJIb6vBd1Pe6Sz8iBBw8hGEwRyaXGvCptyg+zHfJjR0tLSZOXx9sTTqLya3e9TuXqfCd8oVH7oRHeCSu8ZMq7ihArEC2ZrB6trxROTQMzCw8MMl6DjQ7plLDqhWHnfW8ysMY8omvbVXwobakYSKOtmGVvKTWeVU8YTd/FaGlqAXk8BsUpkrfnJ9knxSue4pSL2igP/7ZhyWOY1B+Kd7mnPB1tGPem7K2z/KsY3Q96qDqBaUteSZsIVJ8k8B4ZKjwdRfvLI3jEjLB70mAy/NxI+xnJi3bT76VSXf+7Mb/3q8K+vjDrdxQMHb0ze7/nDs5iKPuLYRCo5BqRavZbx86Ap5x0ld4BcPuUfQbXe3KEIseMJOwXMGPBWTDC+jfbvWka9S/f/e6H2DLJyIG8nUe+zxKYTUlGaJulKciq0xqzk+Ss3FF2Di0bTsbo+j71l4RYh/tfxndBXV/Hzkj2p8Kq6RmR+fxA632t6+gk94OEFDYAwIKC7uO6igs5Av+uDXQU5gQH2c+3dQBHdM5BsLlh8KkXhgAEsi5HCO9RGhT5QdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(36860700001)(7416002)(82740400003)(8936002)(47076005)(36756003)(2616005)(1076003)(186003)(336012)(426003)(81166007)(26005)(6666004)(82310400005)(356005)(40480700001)(83380400001)(316002)(110136005)(86362001)(54906003)(2906002)(41300700001)(8676002)(4326008)(70586007)(5660300002)(478600001)(966005)(40460700003)(70206006)(103116003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:35:08.6570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc98fb9d-a564-48cd-a27b-08da7f59d896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add bindings for Xilinx ZynqMP OCM controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 .../bindings/edac/xlnx,zynqmp-ocmc.yaml       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml

diff --git a/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
new file mode 100644
index 000000000000..9bcecaccade2
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/xlnx,zynqmp-ocmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynqmp OCM EDAC driver
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+
+description: |
+  Xilinx ZynqMP OCM EDAC driver, it does reports the OCM ECC single bit errors
+  that are corrected and double bit ecc errors that are detected by the OCM
+  ECC controller.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-ocmc-1.0
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    memory-controller@ff960000 {
+      compatible = "xlnx,zynqmp-ocmc-1.0";
+      reg = <0xff960000 0x1000>;
+      interrupts = <0 10 4>;
+    };
-- 
2.17.1

