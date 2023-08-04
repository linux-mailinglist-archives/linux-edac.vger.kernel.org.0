Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB37A770011
	for <lists+linux-edac@lfdr.de>; Fri,  4 Aug 2023 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHDMTe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Aug 2023 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjHDMTd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Aug 2023 08:19:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9A46A8;
        Fri,  4 Aug 2023 05:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFV9tDIFIayv6C6MbZqFRrGLCADv4jdZNQUKwtxX6SLUztn/Qu6c4RKnEKg0BQ3YXKaU6jYQOi2kC4b5kw0paSAgoA8UDyRgxP0AE84UjpCZbMlsm2j+a64M09IvETrvrT8vU+XPiAnXNwY+gkpZ6NqbiWDbilCOKL+R89UDMxZcLRPxElbZ3fgB0wFgUvuMT8aVQWjgOP96uN6x+FTJ7irYCudfUH1VhCybLQUI4mrIHmRNACsTPbylnXSt6TAhVEFfn8o1zTBDefjwUWsydMVnYYP6TZuhGN4p3z6vZ9na88vbsPjQf2YuNDN3G+XJbxMk3Xsnh7nA/Gybz2l3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Vc7qx7LNcepYfj1bWYp2jvDau1kYOF1meySNCF/qEU=;
 b=g/RIt2WnB/i+h8Ni59ElTs5T+CPiUMrFk6YPK7ZMCAlPrfBANfF4AjqMw8Hv2aXr4DHdEI/+c+/hVXsYt6jMwg1iI5wDEf5X4EjPHVj85NyuoyfLNr7CWLsFqOftrSa7ykMVUiKoFM+XknIJ3V3UUAwOyJAwFfCzMqa1QrKGBjkUAARSMFc9WdN6VTSMOkLgTba+Bw1IoFOhBLbi43ahxIrgxb9Huxyd+cFjFOBviXzFSICnFGoN6exq2YYbGnze2Ij0EyHwG4mtyw3TWMpGZT1Riwo/7gWh9brSYmtADUK6tCjNs5dmCESe1XO0x/UiWi4YhAstetk65axHwwuYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vc7qx7LNcepYfj1bWYp2jvDau1kYOF1meySNCF/qEU=;
 b=AowR9V414xxONw1GjQgpyuzLgk6oLrlImCEiw60nXoN38VE2bplmGNEG12fJtBYx3U/pUpFXrjCJvhhtjA0ZIepiggoHKomxo3R3cQS7O86k7to2Mr3yz9xXxa9PGL89OHf3m5oPSeiDAwCHH16rWwYe5IGuUyvccRBnI+PIYNM=
Received: from PH8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:2cd::10)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 12:19:30 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::e5) by PH8PR07CA0021.outlook.office365.com
 (2603:10b6:510:2cd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 12:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 4 Aug 2023 12:19:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 07:19:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 07:19:28 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 4 Aug 2023 07:19:25 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <sai.krishna.potthuri@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <mchehab@kernel.org>,
        <rric@kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v8 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Fri, 4 Aug 2023 17:49:22 +0530
Message-ID: <20230804121924.18615-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 793dd596-10e2-44a2-ddd6-08db94e50d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUNSeNVH88eMryiyakI4d5FsWMEhBNJho1YHoH49S7a9jim9o+Hm8bSozjP0Bo3mMp8ULohNRigSNvVhO2AalnXhVOEdchb8k2AcSNfxowAraF7OXlPydts2dc62mKSn0o9rebMB8CRN6Zglhe6xdgU1fO4kVo8iBB4IDWT9ltEmjbjBAiITbpdGBHlp7LI8rH0flttJApywNGex8hRGHsXJp2b+2EK78cCuqlO6WWVRtcuVSn3Y0zpn02LBDz05nAENcuPXxHNNYUrNNqmD/pRKI510W8UolUIvrVv1l2fXZU8p0it1xxt3QRmpCvzPdF//5SHXLEo1DpJ4RnRf5noBfEgqdzhM0VAT5DnHYFvEs7yk22qgRSqYv2LXQYUNzvLYp5EQkVZf+D3HMGgHsnJcwvTAh+eKaY5B2mEqfmVdOYBt5Cy9rgd7MtmYtWZ+B1ep19h3NLTSOr9r7H6oobekaYK/Z4XdhvNqiqr0wtAiG17gsYAv2gumCvZ3Ee1wMggMLLL5MFzJVKXpIVt7xmvsl9Lus28yxImBKnZaO7ohoL7DlwPUWJbWt1rX1kr5T/+G+C/tIWPyKelLzDAUXIMCx1ULPimyTUjh9cvGlr3YnEsTVGW6+hGmZkld5gZosUg/65J3RnwTBynPIyY8AZh4ebnBUta/0j2L2qxUiPmRPP/dx9qxWm1Fvxrkfnzgr52z3IcZHhOxbHR+bnabSA1onLk0YAIBfzaVbYu1n1gI/PL8nmLb5a84FRuh+3T7jcmSZAOSml9Hh7kNzO6l4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400008)(451199021)(1800799003)(186006)(36840700001)(40470700004)(46966006)(2906002)(1076003)(336012)(26005)(81166007)(356005)(82740400003)(2616005)(36860700001)(47076005)(40480700001)(426003)(83380400001)(44832011)(5660300002)(7416002)(8676002)(8936002)(70206006)(70586007)(4326008)(6916009)(316002)(41300700001)(36756003)(40460700003)(6666004)(86362001)(54906003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 12:19:29.5830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793dd596-10e2-44a2-ddd6-08db94e50d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versal_edac.c                    | 1065 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   12 +
 6 files changed, 1153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
2.17.1

