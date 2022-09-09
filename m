Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB75B2E79
	for <lists+linux-edac@lfdr.de>; Fri,  9 Sep 2022 08:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIIGGX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Sep 2022 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIIGGU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Sep 2022 02:06:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403B97EE9;
        Thu,  8 Sep 2022 23:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PexduLA6PDpsQ+d0Hk8qck+IlCvAJknk/kgAMAz7ctRIDg7MXgLnPUmVPaHXgMjvRIJ3qugEQc9W2CEOMM0LNh4U69qy4pTS0Wh+T9oQPMzd41LgzLOPVE/ZWl8cep+YlEqG7xXOl0Aoh7oF5ZjIqfv42EAk6Znfi5CDEq+VGgFRuV6vOqt98EFl5kQ3YU3rq02i4pHCRpDz61wgDb2Urzo+sCCGOphKABFY4bXHvs7I5oDED9nN8SxHhsopQLrbxnZUT6+9WWDDK+j2oob+QPnTpZM2OiNrq9c8pThBHponuzbHVhKdSPdIU4T4ScKpIpIcnnzCBtum9cGKxhz9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pQq0Qk2CdwhXuREO69DHtLiQTjqn7560DfLMMt6Zcc=;
 b=VmXdFy6lQXsOSgeQOtotmbPb8HjjOiKqldeAP4K5MyqMOoUwNb0uA1m2kXrT82CqI3EBjzpP/5gKOV7fHgm61x10Q+ubPhmFIN0fHUlkZ8grjZqzStx/RxelvZZSBD3edU7+tJNCY/PRY/FENHu/Dv6usQBqBQQfekfsRUhBvNn9phcX+IdF+JkxtEZiD1FMhzqI3MAG7ir0tFzVqmWLD2qGbB1YHNznxktV3ejbYaB7KXxHj9Q0bySm/sd4eNx17cLK+2wjVGQFcuCviYAP8KC8HL0W0fTWDPFq00GIr1pOk1q+YqFlLTEKRb6dhkKQkjWUicWL5gFSARFXZyleSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pQq0Qk2CdwhXuREO69DHtLiQTjqn7560DfLMMt6Zcc=;
 b=ITar5l9pGxAJoA6+4D4zvR7i2zStgpQGTMFbuzTeuwgXbQx/UVezzdFlFhjBkVH+YBwTXW6gXtAEEZpduYXllTSlLyKpyCsHpr3S1/oQsz/7gGCxBd9v0S1pUla8WI3GX/ekkzIZu9Tzehueeioi9q0sd1fEUxuBigXjX683jkY=
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 06:06:14 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d4) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 06:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:06:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:06:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:06:12 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 9 Sep 2022 01:06:07 -0500
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
Subject: [PATCH v5 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Fri, 9 Sep 2022 11:35:47 +0530
Message-ID: <20220909060548.24694-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909060548.24694-1-sai.krishna.potthuri@amd.com>
References: <20220909060548.24694-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|BY5PR12MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6595ec-6053-47d7-4464-08da92296692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxBNJp8VQwBVAFN0E9cbmSjOjJfEgC+YxGdb8m2OQn+YsoYWxkRQ2XfdTeDTW4mOv58ktrfEGukeLcc9bT2gE+WK/qjftiwGVa5EK6WK2kdSQDQMvF4ONVfrZpYmLlEl+L0c8iiNJ9Xel3FaU1AB+i9cxPtZZzhGRZgJdXqLTV22/8RdtKMiiM3MKHA/QxvwFVRIZPklFxJQR1EMAKDo+1pcSBVFbiP/zNgtZoTC3MASnWSnuMkS2xH0j7VDuSQLmiJ1J+zWXuDqLo64vUTAGREZbqIrtSXZymaDOoo8IyX7IUOzDnpBpzg+nN68Nj/NKkah3Z4hfSrI/+kyAEWTxQGE9ySLZCRmaDFTQyK4vwNpr43I3aoDOWc5WpT4JDTwtfQN0i4zRoM66oECrk7TpEeOAvausXxCabHb0GHvYc1SbvSwxXcjvwBZK1U8cw326gdVZq8fyG1elWQeJMCICoH/zVIFXHE/MPNQaWMKquQxGJ3b6U7CxOA/lKghLInnslXFnXuz9JhMjOHp689zYRqDFBDgsdJE0P0NJ5LfWta2F3velVwc9Zh7LE0Vk2E1cFWOqp4268IWrdL2TtxdbObmbl6vBa1vyFMyJPtpWcrzNx6KDywdHGDPiExtjdbDSmKjdZV1suws+1DCogtvsfRFyQyxib7qweJLQ6da1b3OtQb2WvBfzHRULZB+rXJFH+drLeYGYLL8gGkn4zhmO+zJCJCzNGi9zgud4KFq1enf//AGTmQ4zhRjbP+8HRrlLhSJ7LugYcsilOH1FHa1TYZVC28ANrcIdRM9hXRhLQApGnRDAP60oaziVvrXf5mKHLBe3Rde+KQG1lk+n+9YvxXi8GhhxWqXt+DIqZAjfPEly9lCt1OA8IJiFnKgG5ke
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(40470700004)(36840700001)(46966006)(82740400003)(5660300002)(82310400005)(40480700001)(426003)(47076005)(186003)(6666004)(2616005)(966005)(41300700001)(478600001)(26005)(336012)(1076003)(86362001)(40460700003)(81166007)(356005)(83380400001)(70206006)(36860700001)(36756003)(70586007)(4326008)(8676002)(110136005)(316002)(7416002)(2906002)(103116003)(8936002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:06:13.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6595ec-6053-47d7-4464-08da92296692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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
Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../xlnx,zynqmp-ocmc-1.0.yaml                 | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
new file mode 100644
index 000000000000..ca9fc747bf4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynqmp OCM(On-Chip Memory) Controller
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+
+description: |
+  The OCM supports 64-bit wide ECC functionality to detect multi-bit errors
+  and recover from a single-bit memory fault.On a write, if all bytes are
+  being written, the ECC is generated and written into the ECC RAM along with
+  the write-data that is written into the data RAM. If one or more bytes are
+  not written, then the read operation results in an correctable error or
+  uncorrectable error.
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    memory-controller@ff960000 {
+      compatible = "xlnx,zynqmp-ocmc-1.0";
+      reg = <0xff960000 0x1000>;
+      interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

