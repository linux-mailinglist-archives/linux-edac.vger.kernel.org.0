Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC872F389
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 06:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjFNE3I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 00:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjFNE3G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 00:29:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773041985;
        Tue, 13 Jun 2023 21:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbsZ+Tyo4Z2nPU2tC1ra+QJnrPfqOvi5PqmgJib9AJch0X8a1ng1yoW7IFUs7nh0E0lcZvE1AOpwroSTfhD3NXUT51kyK53+1U1H4Q9xNg9P94sNiOQI+C/FUWpupIqMAXNSetIC7E8cna9tlwTIZ1EHPEgupK29mRMJaSQ8sN/ktl9FF9XHn7yx0uEkTrDEYIgmSXLWDxgySdZRC//1009Z5PJDpqo++CT1L1tbGMrUn4JwS1DHdnRPi+NuCANO5F9+d3uOr9pXxZJEReB8qidNBDivb3T+a4UPyVwrSW4PridsuSjTeyum2ok88Un7DyrgDzCJ64mKtwtw792ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUc5T1nmlQWxDjAkKOSx0phfhlxJIoulmd3iCJqT5rw=;
 b=VJmwA/X7ss0f10pMhLIf3athzZSk8DZkk8wRk9BX+kSmjoa27ahkCqr0uIlkbqSCsIOsfOtOSc3Q+GEYj/l3I+MOKRjI6lZhkImRR9SwDkCqfX7QXDmOFyRbZcpSzFfQTzSYjFwA0zZL5IhNof8Dze/PZKjFbsTD2pGKJU+EjT1XcaevGIhOKsoYM/fx6bA029bzRujzCsnrqQzz0WnFNUOmL9iwEd2m2FVx1zAUDHR4kuOpjHTGGpt40C5RgLzHvm4DcIDGv2Sw+8Oz0EEshF3fCK+djQpoxnBzTgR3Cc8w+EvuvIiuY/Fd/VaO08ffBI7uvf9rnez9h1+eBCDA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUc5T1nmlQWxDjAkKOSx0phfhlxJIoulmd3iCJqT5rw=;
 b=a/g5qhDXrigCKkmRS/9LtBbT8LhO9EO7+to5UKh83OfW9ibnkonqLOuASsicYIgSKDQjZvEnFznzEYAe6sJoapPqC4qzw8dJndL6fWzINTjVNguwquzX5zvc8awJckkK9N9TpUJM9xRA55HMmQldg3ohIxWnPMg3PANhHaqZu2w=
Received: from DM6PR07CA0077.namprd07.prod.outlook.com (2603:10b6:5:337::10)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 04:29:02 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::c9) by DM6PR07CA0077.outlook.office365.com
 (2603:10b6:5:337::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Wed, 14 Jun 2023 04:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 04:29:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 23:29:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 13 Jun
 2023 21:29:01 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 23:28:58 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <michal.simek@amd.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
Subject: [PATCH v7 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Wed, 14 Jun 2023 09:58:50 +0530
Message-ID: <20230614042852.5575-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a867f2c-93a2-488c-4559-08db6c8fe18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqhLo84IpEfzihwm3vgQjw2DmRFuyogDdocinvZyQTHk+nMSp5bJYeTnP2d/KSveAM+HBj++Pezpx7oeh4/XOGvsHvnfTYWem6+BoG0A45KgM47g2X0TYAwAJXSvp9199chTeqiiN4jCAYx9KSJTjtCIVV6yZ9WXwTLBmQ92T61TjEDNjCyDDPzmug/YHBEqtiGSYQaPPvc27iBe1mu7rjz20lvZWFoDem1eMi03czbgI5ngXKmDal3ktEL/Hx/cqQHXMf+wGh9wJU1M4ER8gWixfAKJv6jvT7kW7khW6lkaxGZ4mixKyLp3dz8bMT8e4RhSo5iSJR4buH4nxJJ01mwW6VR9AFX9xiworb4cNE1ajRObycjwwKqhUfiQ3jK0JpnRBS7WFaNCmdju4e8NBRDcj26THNGhH5NtNaj5O67lrlFesHBUYreIjXY7ds1+YWyyKlO+o22dkaCJnsa4rUP96ZLPaRmMi+ZoH7CMAsdfYLh141yMZg+2EUeeLICe5yWifTv5nU1A8T6t4sKtOwAbqeaePlbJ3eIcy2ZDVmn99M+LfBZJX8L30WrxfEZJgYczain4YX1SU60AnbVt39ngIIJlhaLVcgkmKoG67v3+IacYfq6NhNhutObs9JriJ69Es/HFoxaWPDApnheEHz9lgwCnBVyS2gahFFe6QAbdpXS44+xWz1K25gKSH7+8Ztq1l0Xd3DuGjcH4AIHAF9J0xlOtAHhRhaEVAKO67plyInmgIduuNUJkIEDVXCWmjG/pRBvmhGb4EHQMQjE8iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(7416002)(6666004)(40480700001)(186003)(478600001)(44832011)(86362001)(40460700003)(81166007)(4326008)(6916009)(70206006)(70586007)(356005)(316002)(82310400005)(2906002)(8676002)(8936002)(5660300002)(41300700001)(82740400003)(2616005)(54906003)(426003)(336012)(36756003)(36860700001)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 04:29:02.2440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a867f2c-93a2-488c-4559-08db6c8fe18e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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


The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and
LPDDR4/4X memory interfaces. It has four programmable NoC interface
ports and is designed to handle multiple streams of traffic.

Optional external interface reliability include ECC error
detection/correction and command address parity.

Adding edac support for DDR Memory controller.


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
 include/linux/firmware/xlnx-zynqmp.h          |   10 +
 6 files changed, 1151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
2.17.1

