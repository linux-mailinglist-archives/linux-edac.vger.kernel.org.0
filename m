Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAC74A2EA
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjGFROE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjGFROB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 13:14:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB081FC8;
        Thu,  6 Jul 2023 10:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjusqhFhwubiQmZOCwPg1f/zsBYA3s9LWHglSCe+tQgkyd9PdAFPYwaUcYreL/SksK6HXgT4KUX6kvd7dLGe8Y7Ws9sq8XzERXTlTdVXYRrgHFNRpTOl7fLIHEK3l7Lw1ePosmMJ4uIPTtz7AEauErLQuIYt5pYCxNNctnTbfyTmp52Dccekt8rXIQzcvp9ss3K9ZWwuPdOQenEpLVNnP3AIGzh2h6U3fHifn+zAqLNbms2blmForojf1iiHdWo5W992JdZ+mV0bFdRPqAtXrWXjkh0IcDMYJvh2TmlpFTdOUzY1tpyTIjtNKZLKV6Wy3U0HXeMbqR9veT7A6Ug05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CZzdcqNYjgBUtkv7aw3HRiS6Hi0VosdreprdCoFf2k=;
 b=IbIXE65YQM+eZNJh501jpYj3ZXBH+K97Gt3Jl8LNhSCPEL/5Ydbtt/yqPM4GjCyrDTPtux8coXEdsHPjzDVZIeFG1lswdJJ2WLD3Oy2GwLtlPX1uU+qswjQglfiXg3gkb+Up3EZ/Tw73OsiS4prZb5ky+xGonAqldC6A52dxtu/XLUDRtChTzCTExIb4BgFj3rOcNtr8BssKEm9HTOXFMQ1N/590PDBV+gOgPhkxh+HQACKAlcsnPos/vURRF5HsuMXbvTl5slbDwmxo8dn8pSLTWsMUn0OV+6vsDrjsMsnyLve1BNNoEKYyf0NH4T9WuUS0+B5B82jrmNRAQBNFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CZzdcqNYjgBUtkv7aw3HRiS6Hi0VosdreprdCoFf2k=;
 b=qF8mKX9PzlTyCg/DFO6ixrOR13DeDJsEbCy9ddsa8noSMjYxaI6kalEsFcOIxBkna/cRN6G3pl2l+iVvF+ixtWe0oNT6xkyp2cRIWUo+h5pyXpsIa4WZWMvTGK0BvGe8NO+QbbhL2qkrsq6Fk4KLPJnEFQekg1Hrmxdy4v7fNz4=
Received: from MW4PR03CA0237.namprd03.prod.outlook.com (2603:10b6:303:b9::32)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 17:13:58 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::cd) by MW4PR03CA0237.outlook.office365.com
 (2603:10b6:303:b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 17:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 17:13:57 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 12:13:55 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <linux@roeck-us.net>, <x86@kernel.org>,
        <linux-hwmon@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 2/3] hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
Date:   Thu, 6 Jul 2023 17:13:22 +0000
Message-ID: <20230706171323.3722900-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706171323.3722900-1-avadhut.naik@amd.com>
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e64d9aa-ec16-4cbe-a80f-08db7e446254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JOB6BhTrfwvunTl2frdBwIvNH9NBp8G74aHpYD9WWIl0XCJylJmz1nyietidEPMCc006MJjMsE1/ZGkpbQh3aQTO1GZgY1SCGzWPVfafZzX1pzhkbRuKx+4iOKXyQ7k1HoAcbycz+CCPPvLvnya1dHv4mGHXwWktnpxPZJRb5efQ4rZmZhPatE4e0FFEMq1T6bhbdNLK/rSKDT6T6YeiWdKgv1hBPkg85Ude07kWJHHPLeWWjiogLHT5JDpqcUQkEfRP0Pu5Ndpm0dRmcMH/yBOTUqC2+UBLEy4/Vxx5U6GJgdwFPXgJZXkMLrxRMXtno74KjC/T4Ikik1KWVbB1r1eFEcgJOeHoZ5NICb+1p28uFQ1sXC56f5gyJ5aT97xleDi0Q4XocxGpxvtnreode4ai2Jxx0pkXAIPg+xy046nWx+ny9+mYHEZqObRCKmDWwTTYfCqh/M9vvNHDHeJV0Maak5W0PmDnJh9qFWlBP35M/mBk7zaVAJev3gjGrCi+8WU5zyjKioXbgiCPN++aPeWaT/Gn+SL9qb61p32n4YcmlE+3RMyBacGIWDSw4FYjErDiZoUpNEg9YosIvodnlcwWA3mqIANouXE28XUJ+opzoGwRvABmOe3alQQE+BdfqR9XLN8DABbcT0/cXfztr0mEAoSAU1OmDByCZJE8lmI4eVS1y6EHktgr04uJr6/Y04vcpHkJZTLCRaYCp6J3XehZCGnF0YD6atmPwWEH8Vv+c6ujf9sw6aHFXVBZ4ouezYTkCgroJfI5FVls6yMbXcVqIsXtF2S3Pm8KmFs6sg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(426003)(336012)(47076005)(36860700001)(83380400001)(356005)(82740400003)(81166007)(36756003)(40480700001)(86362001)(82310400005)(40460700003)(54906003)(110136005)(7696005)(6666004)(8676002)(41300700001)(5660300002)(8936002)(478600001)(44832011)(316002)(2906002)(4326008)(70206006)(70586007)(186003)(16526019)(2616005)(1076003)(26005)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 17:13:57.3929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e64d9aa-ec16-4cbe-a80f-08db7e446254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add thermal info support for AMD Family 1Ah-based models. Support is
provided on a per-socket granularity.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/hwmon/k10temp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..c61837fbc315 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -65,7 +65,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
-/* Common for Zen CPU families (Family 17h and 18h and 19h) */
+/* Common for Zen CPU families (Family 17h and 18h and 19h and 1Ah) */
 #define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
 
 #define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
@@ -462,6 +462,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(pdev, data, 12);
 			break;
 		}
+	} else if (boot_cpu_data.x86 == 0x1a) {
+		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
+		data->read_tempreg = read_tempreg_nb_zen;
+		data->is_zen = true;
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
@@ -508,6 +512,8 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.34.1

