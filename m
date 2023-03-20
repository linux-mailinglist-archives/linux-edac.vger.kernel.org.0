Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4DD6C0D60
	for <lists+linux-edac@lfdr.de>; Mon, 20 Mar 2023 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCTJeT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Mar 2023 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCTJeS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Mar 2023 05:34:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DC1C597;
        Mon, 20 Mar 2023 02:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImlYh77P+Gy+3x0dKpW+1RHKdnZ1s5TUJDFWeSOGyAX21VEcje0myCYY/LX1dcfiqVOtXc3WRZ8Av0PYx15rbIy+KzuIMnJiyAr2XfbLGndRWPK1Ia+pzFa2ZpFdZCGhrp9o7iQS/O4Z9gYJ32M+zDznUuCrbDdgsNhWiM3z+n//WNjLu1KlUx6ydtL51TBe9YH2Ik9RkuvTNiqf8BpHSjKyqgVFvtLGxXO1a4uN992L8Uh4kAgMchE7+rga8ipGvuBw11tr9Wm4Yvp7nJxbm3hYqkZHwx3PvLhOht2AxT2pvl/5vUUo1HnWzHlHJCWDXigTA+oozHsMBSoAA4Wapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEKGBlobRHtIIYvLwPt3fJj3q6FPWQhVhfUiU+Kh7zw=;
 b=cUTqF7giY5OI7LrdH0fD26zoQCiGF1NjWbtuNJGE5ZbOhhmt7zEIITo8VnLdOMWkwVXLqKJpmBBB1qOGHQWXEwlwdxl0+jRj/7OlR5G7LQYGNBavkkK8Sob5pxSmH/PUg9aSC4DMW6Lvtn4+EaIleP1KZwK8eAg2wDMZ/+8TuqokBsTx/307NFwo0sy1ufelPu4dJiuhzLzhcVPfgV+GROP9tw/Mx1NFKKMLHDB3+rt/1Qx7XznqIXiYE3DnlO+NQIBvUVDCBIm8uR0WhzPUqriJ6WycDVhkoL72HzO8tDJQlUy/XALNMcnuqzS6XRVJRxMEFNOIY5EgAH9tjPgaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEKGBlobRHtIIYvLwPt3fJj3q6FPWQhVhfUiU+Kh7zw=;
 b=fOPyjg81ZPpf0zz2qTOv+fOpYkjmDW3S85jni+F9JpgaZR+bkf6k9APrPVevhIBMLrqU9pIAb5yWtgkhaZHJh4V1bLzDXGb2ZXk8WtVQkO0JZsHK0ESMt45LIcN74ZJUUEEFf+QMwk3EcqKuK80swyhEMR/omPlAgZTPibCOs7I=
Received: from MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28) by
 DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 09:34:11 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f8) by MW2PR16CA0015.outlook.office365.com
 (2603:10b6:907::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 09:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 09:34:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 04:34:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 02:34:10 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 20 Mar 2023 04:34:07 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <bp@alien8.de>,
        <krzysztof.kozlowski@linaro.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        <michal.simek@xilinx.com>
Subject: [PATCH v6 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Mon, 20 Mar 2023 15:04:04 +0530
Message-ID: <20230320093406.2045-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f152c8-43b7-4282-9a1a-08db29264327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mVyHyAUuyhmh0CVmKjYJ/P9fSuKYugdzjrXJB9BXRudRDf22hCXzy0ToQ3FvSGisfFM+76MgCuwXk2abJHH+w0HfU0Uw+0JeTiUZveP32IsEX0rZUdLntYfb1iFbTZNYEZaaqFq3c7bmbS9sxc9cNGcyvRVzc+GrwiS6W1qJ3u2Wf3UhzQHHVOmsZc5Sc978fnewqm5+zh3H6jERmAV31RWV8BP6Of1Pgm0njYF6ajqpOz+NzL9y3G5s9Yq+bCNeJrEc4Bnk1aybdyg7OzWzrpVlpeQ7jUbZ5smCCkP6aF0u6q5iXvLsWjvG2F49knsJvHUEbFp6j6I4fcIl4uM54rBE+za5z56qb/EThX+vXJAMi9gMKEdB3FRvrGap4AJgB52gOzF8oFLTzcnPaDY3NYTiLeLJHVmUljmvzEsvX2LOxZdxxp8Hf3CAsZord9HAGQEwrAmTLrHP56kujRMW8YchuXmg+lMejmjICBTsEzqKv0iu7iCd53hwjlmNw37oonvhhQSOxkXZnTeONib5JVDqZz9qM+o1Qm51gJ9F+hSVT+BU37fqvGcnj2FMYZXIYVmYJKMDakwXfmnk47ps67xSm8tbJu/tlpJEcWSFLW7RSLabRgk87otTBLIuXn+9zU3SvVW3W6QbaJI4rD8v1kJ4MNSBb4Yo4t02P8vxCkNlyO/GESrAspQtOLezzpOVaJQlBDoidq7VXb7lHfl/L/ihYymYzpKE0dMVNoUZLA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(8936002)(44832011)(41300700001)(5660300002)(4326008)(36860700001)(40480700001)(356005)(82310400005)(86362001)(36756003)(40460700003)(82740400003)(2906002)(81166007)(54906003)(83380400001)(1076003)(478600001)(186003)(426003)(47076005)(6666004)(336012)(26005)(8676002)(70586007)(70206006)(6916009)(2616005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 09:34:11.3503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f152c8-43b7-4282-9a1a-08db29264327
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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


Changes in v6:
Fix the warn.

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
 drivers/edac/versal_edac.c                    | 1077 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   10 +
 6 files changed, 1163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
2.17.1

