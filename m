Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB396BEAD3
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCQOPV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCQOPT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:15:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE41ADFC;
        Fri, 17 Mar 2023 07:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2XmRMLYzS0Nmu06PRwQbkBkSQ5MFSF8/0qOMD62bkvNIqi94ntHHaIzJEgDfNqCocrt/o8EQI4kA9LLfILuEnDTu2WTx9x2CMNpd4zsLWauj/bsOGNvfKfNzAGlMWKA0FVSuo7RU9/sDoeL88Qevobl7XH/Jf/6DeoyP75LKCSTpBRI9hdjFxeTr5vEEfTlghbdKAfOjyBWRROFn8yDQq7duHWT7gvNLUW0cUoUBCqKjoKcypb1JRN3tf+XXG8AImMrq0ri0d1D75FOuzha8qJ99pCRvfp6RFqRjIc9H3/RY/4y4nE30uOt5Y0uXFMDfDFbUXEH6j1nW5617Ixrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYojKO5+nEy/LT8yaqFlx2nTh8QECSIpqP6sbZLF8w8=;
 b=Juq+jpgm8ieJF5tQ8+a+lpA3W98MTr7nt7L0SsrovUrVixdSX2z2ylQfI2Pe7lh5vY0asuUJW884HfLAE3Ln0ubst9KbarVU1K/6ebon8jUhIGb50dsGrMTLRM/Y/kaZ6uJ11/1WKJAIU1iaLpJc/YQrISfV9a3ffQKYN44Usnyn8GZRxN0vk3fq1Sttv6a8c0OHteLfqF0GecnMyATjH1CnkQZBbY/Gy6gJS8f+ShML/3tdIa3J5om8e5vGxkXbm0/6LvxAlJQmHOeSgiUCxLcL3x1TWePG9K+6M2SneKZOLYgLWiv5a/cXrR9BSEZvKa93aZpfsW2q22bTto5h2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYojKO5+nEy/LT8yaqFlx2nTh8QECSIpqP6sbZLF8w8=;
 b=xCA71Q5nHIgjxt8M+8nIi8t5FV+J/u6aROQ8EMXwkeryTw7FWShKSvLz9bEWup5TVvzTabgSOh+YYYTyYdKSxaSJxzwQKc5P7D30E0W8iSJ8kIdM2/q9eZpg0NKw3uJtBrRoLH/+jZXZeCWmSWw6nsoqh2GwHqmPOKm2cfWm6uo=
Received: from CY8PR10CA0019.namprd10.prod.outlook.com (2603:10b6:930:4f::15)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:15:15 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:4f:cafe::a) by CY8PR10CA0019.outlook.office365.com
 (2603:10b6:930:4f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 14:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 17 Mar 2023 14:15:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:15:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:15:12 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Mar 2023 09:15:10 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <bp@alien8.de>,
        <krzysztof.kozlowski@linaro.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        <michal.simek@xilinx.com>
Subject: [PATCH v5 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Fri, 17 Mar 2023 19:45:07 +0530
Message-ID: <20230317141509.17534-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: ae124814-f87f-4589-2626-08db26f207af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhRs+NFoLLxyAklSMSUP10skbUPHvoi4wPDdaGWe6zC3zT8pEckWk7tOZb5j+uIhvvs2zhkwGwpe6fYd0mOxzs+gWM+lFbCqJ1zaTFCl8IDM7JypBJMaM/RLip2U6qZyrIoujE9L/4y48O2w2p8Z4/JBRz9BZBvHOfsKQfzlDv+nT3SSB0u4tpN4Rtjl//aTa2ve0l80i17sHY8MbyexPXMYgdXxjO+nHhCntqtA7aVUVLaIaveRl8GE3AvG74Du7dmHE7/sTv5rbzpKw7XWuxJJY2J2ov10JVsUfCi+Gx3IFKwzFJ5NMCOjFFjhUJMCgMKKfW+/U5BeHTfpuX2CcydXg8nRFvNuK6rOuMZQ1oQcQ/8bI3EVxdZ23Ywaym6AU7Dzi37PhCxRhCVXUr4WuniyeUcXESN6+LFPa3yquodaT+hbw4A90iCN5ovkziBUVoaDKYseM67TT3dSW82/oH4fU+N00YZIXVUtHKxtYDYr0aqPqrLbD8DN+h9chGP3W8/rvi/2DVR56/h5pIFo1k2bm+/SYQgyo0Lfi9KrG1WTVxFck8LK9e1MVa4BVtGpWLJS8W5qPdmykx0JZZH+yAXmiamxQC3HrRXYG7cSVpDw/CflxWIG3kga+5BX/lpndUK7VF9IYFe3XPwYJwlotJqEYwNrhABY1i+YNyS22ebbzXZwvNbbMTdELBrJkfDTtQcpXX45gdAhplvb4c4VgATqFgbwArEpAGJA1lcQQ+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(36860700001)(8676002)(70586007)(70206006)(4326008)(6916009)(40480700001)(356005)(36756003)(86362001)(82310400005)(81166007)(40460700003)(44832011)(5660300002)(82740400003)(2906002)(83380400001)(6666004)(2616005)(186003)(426003)(336012)(47076005)(26005)(1076003)(316002)(54906003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:15:15.4667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae124814-f87f-4589-2626-08db26f207af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and
LPDDR4/4X memory interfaces. It has four programmable NoC interface
ports and is designed to handle multiple streams of traffic.

Optional external interface reliability include ECC error
detection/correction and command address parity.

Adding edac support for DDR Memory controller.


Changes in v5:
Update subject

Changes in v4:
Update the subject
rename the driver file.
fix the debugfs file.
fix unneeded capitalisation.
refactor code

Changes in v3:
Rebased and resent.

Changes in v2:
remove edac from compatible
Update the description
update the ddrmc_base and ddrmc_noc_base names
Update a missed out file
remove edac from compatible name
rename ddrmc_noc_base and ddrmc_base

Shubhrajyoti Datta (2):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
  EDAC/versal: Add a Xilinx Versal memory controller driver

 .../xlnx,versal-ddrmc-edac.yaml               |   57 +
 MAINTAINERS                                   |    7 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versal_edac.c                    | 1076 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   10 +
 6 files changed, 1162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
2.17.1

