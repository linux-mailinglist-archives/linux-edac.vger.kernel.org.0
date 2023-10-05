Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4C7B9F13
	for <lists+linux-edac@lfdr.de>; Thu,  5 Oct 2023 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjJEORV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Oct 2023 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjJEOPL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Oct 2023 10:15:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9F1FEFF;
        Thu,  5 Oct 2023 03:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhlL5y714dGS8lW2WEd6uLP0NwHPRjV+2ZaZe6I0Gy/tQTA09KHe+bKO1tiWx52L9IJiC0ZOeUVz6YwtwAUWwPBXB5zH5Sx9WRTr4Efwqg0PC7FhgvhvTSG+VnJqtcYoY2gI14ZerRRtW2XB+TipZLdn+tdGp/bJICgXEznO+hvdPxQ1NRe9XtCuqOC4YzGNM4TuDbrI1tVThlwm/5VxHkuFEbySaT0xRuLezXNrD2CZMw7ETt1GmJlpPQ5qddXlX6xK4rTE+0bwHqYIkoRP+8HqkBWjet8ifAHMPKK0oVHx6XzySWIz7k82pitsBUz/bAwPy07Axd51Ak8EkPyPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAdPP6AGOMVIHpt6SpOq9y5zuWl/2/h364Ql4ng3v1U=;
 b=Hsqi0agJP3+SjTMYrNC7QK0ShNVVDGelTZWj/IU9wl7I+Di62mgmMYoLcxL099H5Ianq08DMtJnOzzMr/Na+yTaHvpQc8MRA2rYV6EkjZE7mrFi4wT6JPp7ORSDr3GkONPc01zkddqgRvg++UQjdiG8P/0R2NJxxsoC+AZlhVHb1rUkS8Adx0Sa18qLA5w8JHIxQ7N8s7wfi349JlRZ1t3yxF5GhGlMkZjxBhTZGuf22ywW4p9+THpznyN03JdWW+6S0syAK5PWDtuUTJYGPe3e/1EVaTNbtDOlDHPi6M5XpHSbY5CLPIMxRX05jtMLF9ehugyc0dca35CzRoH4XyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAdPP6AGOMVIHpt6SpOq9y5zuWl/2/h364Ql4ng3v1U=;
 b=AOSkNsIqYO4D7ZM2qJe82K8Wz9Y+Xq0exwPeSJ0EDHleWxGDKIFjrfXydad3bNK4RYeSFZNUWcmxnw42X3dMLiFqBWrz0mjvjdO2pRVCuN58l8l2zoHSRe7TB/k+f6OkUPW0UOJlgEYYSl8oGC0g8wQv7uWLLS+JxvKQ3bMLLXE=
Received: from BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 5 Oct
 2023 10:12:52 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::9e) by BL0PR05CA0029.outlook.office365.com
 (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Thu, 5 Oct 2023 10:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Thu, 5 Oct 2023 10:12:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 05:12:51 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 05:12:48 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <sai.krishna.potthuri@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <mchehab@kernel.org>,
        <rric@kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v9 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Thu, 5 Oct 2023 15:42:40 +0530
Message-ID: <20231005101242.14621-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: c26fe05d-a57b-4a9d-bd26-08dbc58ba288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JwftEMjinYYs+RPIbHRny9NeCXMbkLiPNnSpM+Z9P9T7hZbgqR50V4ZwXN0U93xpicooWS8ruTcmd2H4tB4qgUa1QoLJrx4qpjyJ8IW+/MO5ohdKrGdV679vopEvJVc+Nl4B1rgj3ZLl3IiZWwFQQIHPjNUzIvVx6lSkUedHz4gJHXqjzu5IGm18Rxb086C978gq+/wD5xKqQkZMivheKUZasrxnaCP7ipcBIuPLT4l02zW+FUcAZVIEO4T4rKm2mCbVBQMLxkXhiMRqy6ghNtd0dKqdGN/jI+rX/QcrKK9QSLmMZsQ0R0X1A3wIbrkzIzLxBDX0FjYhHWXUBOBxDdBkpmk2jErRkGeVbSBsVBA8iGGGrY5wYbXsytIX9Acuw5bcNsTqAGFMO5GAWdUgLmbTiLLdUe/m9Iu1BrYiYoNEaOTy8hzVsduXrLYUFfajUNQ0Z//DqafHSv/t+j53bP6dwQZnOK8DPaDiIRrMb+vqUxydhDo/mMNHPqNbNU3bvDERUBn+EM9HyAkTKVRTHNxjPnfXvpDmBSXnaU2/f1tTCtZVQKq7Uy8nHfvjg6nvuNJAG9YLbFQkQLvhoRrCpv5I4mhZGdFUuTCXmlVDVDrtrelEORWz4pzy9N2Au8Q/RPiTEOrMMy4taJm21fBEY94OWJzz/UrqRDgi/52IpZCDC8fUTIVPLY9ZPsYPaT7whEfvax0v/fODRa+4DSdXuuRd0MxgubCAXYrjpXo1PWoNTXb/q/ick7GVTFI7LQgK/SJnGrwwNnghBLHWuAZDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(356005)(40480700001)(26005)(1076003)(336012)(426003)(81166007)(82740400003)(44832011)(8936002)(41300700001)(70206006)(5660300002)(2906002)(8676002)(316002)(86362001)(4326008)(6916009)(2616005)(7416002)(36756003)(54906003)(70586007)(6666004)(478600001)(47076005)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:12:52.0740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26fe05d-a57b-4a9d-bd26-08dbc58ba288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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


Changes in v9:
Update put the disable_irq out of DEBUG flag.
Make the union packed
Update the wording in the Kconfig

Changes in v8:
remove disabling all interrupts

Changes in v7:
Update the subject to add memory-controllers instead of edac
Update the message
Clear status after handling the error
At probe disable all the unrequested interrupts.
Alphabetically sorted diff
Rename unCorrectable to uncorrectable
Use mask0 for  GENMASK(0,5)
Add a processbit function

Changes in v6:
Fix the warn.

Changes in v5:
Update subject

Changes in v4:
Update the reviewed by tag
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
  dt-bindings: memory-controllers: Add support for Xilinx Versal EDAC
    for DDRMC
  EDAC/versal: Add a Xilinx Versal memory controller driver

 .../xlnx,versal-ddrmc-edac.yaml               |   57 +
 MAINTAINERS                                   |    7 +
 drivers/edac/Kconfig                          |   12 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versal_edac.c                    | 1065 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   12 +
 6 files changed, 1154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
2.17.1

