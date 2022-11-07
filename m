Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52AE61EAE8
	for <lists+linux-edac@lfdr.de>; Mon,  7 Nov 2022 07:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKGGYv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Nov 2022 01:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKGGYu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Nov 2022 01:24:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBAB10551;
        Sun,  6 Nov 2022 22:24:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8GdLeBqp/UPURR3c7tsaKNC8EPrw4WaqNkt+bIEnkVXb93NS7f2pmVn6CFbxgGR4jMOVfh0qdhrLN5sFpk+DolrIhtJwrDaZ9wbrTqkJtPr1OzT+0X66cfaCL+nhjy8xnOTQubVKVs1etKuNHhqTjlCXEPi5IvBtdocC6Shzarj+Tvv595CNAgGGkay7r3A/mvd01Rt959VVp0GyrgB2ResyCgbFfqPNyy/IfG9CJy8mFZflJ3O+eDumXZzgndnUqYofT4azLDCOkea+IoHtKaadkMMX9pgvDBIqHFQs78ybEgmwLNYIdUkGNvWFuVY1LiVY6zFjHtelzzCfbdowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2HaQqYFjJby3VzVPbv7f/v/MUZZDV6bzEvBlji3tSo=;
 b=A4PhR8+X+o+2rP9PiCP67wKE8NtCnmjVgwj0O8AivfRM9ahGX0PJsj5cGvKNVmAYcCK3fOQ0t3mI7wlpgGgxh/Oypp5ecy6gsZdIOQwUdp7NAMjV93OKuQMX4NuWe3/CE4NhMs/tM7FnV9yfObNk+3sl11u98KW25R7DqQJVIAsewJ5BKKASOSS8Fl1LqQXpPmsz/6mJsnSr8n8f6q0MH9A0ev2sobG4pNOCdsOWoXDGqWZRuB2O6kCVv9bwt45T71Qff5Ajfr3gmhIxCY1uFl0i20I2E5xgClS/pu43xOgeTYEx/wbpclYEsZ0lK9kNZe/343PT4VFrCzJZLasu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2HaQqYFjJby3VzVPbv7f/v/MUZZDV6bzEvBlji3tSo=;
 b=SEUntx8VFLfmwHsywjj4yIwBXo9M0TLOn/U2oXjO2C/a7RjJw+qd2jl6J2oBDav0L68VyfYajJONdl1w4t+FzYzT3Zdg0p+iC+WVo3OgjWzWl22q7dTF7b0pzL+EtRE9scz+FvyQOCFjqqTR/K5OzB/nr0ShWVkt8QHnLv7syg8=
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 06:24:46 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ae) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 06:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 06:24:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 00:24:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 00:24:17 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 7 Nov 2022 00:24:14 -0600
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <michal.simek@xilinx.com>, <rric@kernel.org>,
        <james.morse@arm.com>, <tony.luck@intel.com>, <mchehab@kernel.org>,
        <bp@alien8.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Mon, 7 Nov 2022 11:54:11 +0530
Message-ID: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|CO6PR12MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f34ab9-b0eb-430a-012d-08dac088c40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTQ44gSwNO7/nqZVPdjXezFpOQB0mvpIez5sBAcvJUqWNIFTRd5Lp8Q9iovYX+biE5gfX8VvnuhwFnkhxswKL5vz9wY9WE/v0jJyKH2/nhChYOVRP7KtaNhT3oiwLaU3uz0LuP7gmK/EQXfnTiKlfOJ/zHo0ECa+vVc2kbGs+4c1r/JmiaPLy+e+5gRr4eKFEU+G9tHMBfoXyqHlA1DNKz2DB2XPoVI5OT+ioVIS+uYnm42SRPj6pSJy2fghsMGe0v8ebBDBCbno8Z0SL3d+hLRkb+X6r7PxW4p3fsOdYInYC9A+fBhLcueJaznUfoUgOKfSL9bllsGNZrIaTRVbRI6fGeEQ9jmWUY5svM8NYFGWhXJE669R5r8qXanfhnh+auJsAjfJTUiWHd6jT6cqd9j1HKp2yP6ugasZHYP5D1wVXzUALaAWzyznAZQaA0P+7Obq70E3K1xAYyP7eC2AUg10LoH759AFQY7eMmePeHrerFWjpqnXvFPY5GlBPxcY8D0pBbPMRHqaAgIDf8/AlqXyj1z3IlNmcK0PqAuM1w7/Hbmq/T8Y9uqG693HEzKwOU9pBj9/JhAYb3mke2P5NBpq3KRW94045tZZ749icX0MOzk+pL/bNjHEbhxAML8NVocGOmzH0zha4B9MwncI6AnMvSmm9rHPxIYJbpXyJ6swMUcT/qBisH9PAyRVkGZ7IuMRYD+LMi7rda3/LJiEKLwpPjakb9mMF/4h/loASkDn1D1/SrwN9SSm843pcBqkbfttaaANNz5rs056fEZTaQQt2PVw0JiQdX5VSykdvp5yjA/pWUj7D+sw/uPKuyke
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(86362001)(44832011)(5660300002)(2906002)(82740400003)(81166007)(356005)(47076005)(336012)(83380400001)(426003)(40460700003)(54906003)(316002)(70206006)(4326008)(70586007)(1076003)(186003)(2616005)(26005)(8676002)(6916009)(82310400005)(8936002)(41300700001)(6666004)(478600001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 06:24:46.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f34ab9-b0eb-430a-012d-08dac088c40d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/4X
memory interfaces. It has four programmable NoC interface ports and is designed
to handle multiple streams of traffic.

Optional external interface reliability include ECC error detection/correction
and command address parity.

Adding edac support for DDR Memory controller.


Changes in v2:
remove edac from compatible
Update the description
update the ddrmc_base and ddrmc_noc_base names
Update a missed out file
remove edac from compatible name
rename ddrmc_noc_base and ddrmc_base

Shubhrajyoti Datta (2):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
  edac: xilinx: Added EDAC support for Xilinx DDR controller

 .../xlnx,versal-ddrmc-edac.yaml               |   57 +
 MAINTAINERS                                   |    7 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/xilinx_ddrmc_edac.c              | 1251 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   10 +
 6 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/xilinx_ddrmc_edac.c

-- 
2.17.1

