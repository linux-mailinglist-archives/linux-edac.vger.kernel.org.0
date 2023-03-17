Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4246BEAA9
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCQOEh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCQOEf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:04:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDEA59CA;
        Fri, 17 Mar 2023 07:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQjmZId3g9Yh5hqgRXon8qNmW+m2HZ3cPbpwoIt7PaaaCabYcb55+Ys9nhYxrLpqSVAJtOua3/t+dxvTG51+3EC8gNx7IdMFebsZMVs+L36wQW0obWvy7rpbqZGPkE3/8BCZ2tGavCtUH42OHTNXFzC0TUE6PFHluwoX5o/pS7YtYWfz2Eb53GLECg6CmUrd5hN70/ucRExBoH9ERCsREAKb6rD2y+Sz2AlXY5vMqEkA4hO3QglfoOsP+C+hAIsK3SK94J9boaWPgum7Q85r7+pKVi5GWK2AssaJPEH4nz3pgnPehj/29PQVPcswaF2c2poGiQ//1Kh7XeLNHxu7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY/B00t4af5ndxYjA07SoA6lW8wM+JHkNP1FdNdTfVo=;
 b=jgIpoq3O8ZnHNkhml1HgiFmknHyML617FtqhMX5GbY479wo/QGwyQ3SqFUaMLmoYawRPsD8AtME1Isg0GZJ9/yZ4+v90VE8L+W18l7aw9LZYEf4IrfLGV8WREO1v9X9z8y8aEyY/DGG2iVudZSvQl4JQPIJzg6raUbdX3frzEcXo7f1IxHzsg/9Zzr+Tk7bxrSVWUBTKVte8eqW+RajOARLaKF83JjdVAo+pQAbGLtHzrI/tDWtwH6OfgvqVjM0J6hOdAzh6PrxzDPXHQFQCifit/8SAXxYP8I+fL7XO01FR0leAdeWnvUPATrQ4K3FoKiT6sPJUfs+7DlWSEyjvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY/B00t4af5ndxYjA07SoA6lW8wM+JHkNP1FdNdTfVo=;
 b=MqzciPmmbUwD4ZQJcGkpHre0QELoJKOjtzs44WxBKHG1Im50OgdgfCK1KDRK//sZaM+gHyW/er7c4ma/2qNR0lEECskBml+hssvvKE75ByUHadIiDG9XuzEhtjwIt7+Zx39m8PA4TnTruQucK5kAMGQapIXA5FDH0vd3v78sANY=
Received: from CYZPR05CA0034.namprd05.prod.outlook.com (2603:10b6:930:a3::20)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 14:04:30 +0000
Received: from CY4PEPF0000C980.namprd02.prod.outlook.com
 (2603:10b6:930:a3:cafe::9f) by CYZPR05CA0034.outlook.office365.com
 (2603:10b6:930:a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10 via Frontend
 Transport; Fri, 17 Mar 2023 14:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C980.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 17 Mar 2023 14:04:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:04:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:04:28 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Mar 2023 09:04:26 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <bp@alien8.de>,
        <krzysztof.kozlowski@linaro.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        <michal.simek@xilinx.com>
Subject: [PATCH v4 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Fri, 17 Mar 2023 19:34:23 +0530
Message-ID: <20230317140425.16827-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C980:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 3941cd52-2e4f-493f-551c-08db26f086fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BblH4SMwaqdcbaRNekOoZUK0RSdtMJ39nK+3XqB8JatUlLIlshmFrscfc9uNhgx37Irc2foEeNUq8t1pZ7lKX9S8UaG4LWY3zJGtxKlUs0p+WAcfvmh+nhOZQMFR5WB5FmtnyQZiHmRTBn7BFZsXpanJyQ9E2SoT2JsNGSlXociq1/tCfLuFb+sYsh9UNZOqvu4fE/cNBNCl+VOotmh0VTOhEmsb8EF036vxjvQljoR0h731IAno+p3N45TKkbB1vEUYhwJwwAkLInoPlvFTHZT1EpZZG+s8kJ8K20R8LAWjrAokTL4GzzlQa6OpQIkq+z0tzMydZLhCLv5NPui4qcuGx79VUogxVm5bgIialXksqcn0GLB5ddqUrZ0QehgHDiUagmf+PL7hShiBoetYMN7Yr5Kde7lDM9gJTsCIZGctWCS+L8mkm/LwOvkcuJ8aScNznPxuJieIDHMpqGdOejYciVHdXq73Pw/aSjxrAzsDF69IoH0NLrBShxaHxCfE1wj/SpIk2yRgVIpHxh8kX2AP+pN3UQLTKZHAIrqtDGUvi7vAw4mA0GhcawXK1iFNMqU93U3+P84zPUMoYzKvhFTXY53zlM7VhI6THzrHClTL/sHU+ZpGsjGa4w4+U9FvA1S7HUrkZr0LaoHsv3xQVP9wvCxJ+x7Pyn3ajpDR/8oMLnPh2Xy5LMl44KpB3wuH3FtDZbuPgEzI73kpOW+Q1pNyjnNdiffJnlv4WO/Fgas=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(40460700003)(36860700001)(356005)(36756003)(86362001)(40480700001)(82310400005)(2906002)(82740400003)(81166007)(26005)(478600001)(186003)(1076003)(2616005)(426003)(336012)(83380400001)(6666004)(47076005)(6916009)(70586007)(54906003)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:04:30.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3941cd52-2e4f-493f-551c-08db26f086fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C980.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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
  edac/xilinx: Add EDAC support for Xilinx DDR controller

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

