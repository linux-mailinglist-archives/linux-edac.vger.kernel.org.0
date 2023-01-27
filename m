Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC84A67EBFE
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjA0RFo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjA0RFe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:34 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB3D1DBA0;
        Fri, 27 Jan 2023 09:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=med6Fjn9wsnfTF/aBRgZujymY86RLqe5JuZYj5osFXabJHgYfJxi+LuApiKKblHBeMBBhMWgOJcieHF/6nCl1sn2xzTM3yTYDluz/+nHzohkVCI0ISv/bKixDgnbAv9wfuNp/evQ3TOtzigFjBeCAFsBVwFugFl/tRku1gUYkUbw7DloEic/DeawZYVWJ0GJ/c8ypFkDlUldvSCm9TagN6ykk8CZpQKXttbY031XGGOVEd13X8YEHY8N/DOt9FQKuza8pdv76ugrfNRLJJB1zFm0E9WA3EK+4OPLeCrEPuigBmcN/mC4tXtun/ycgh2JFYoAhNieWYzEVadpptUtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5zIhcKDC1tqXiankphBpWnld9DLg/4DpD6SRlEY9Fk=;
 b=kdL2Go8Itx7e54eZvYEoMySQzHiUXe/vFQfbKi2eIoQhn6IdTVPF97HulBmjQbRNr/SUhrF9lKXlXYn9+o7zKxJ4PcENhvcRvcdJi4I5uMXoRv399Oe1br36qWCkD7WbY5jrghcQm2lJMiDqTP0IQpur67r+RqUuV9tLUgjDbWe5tCC39iVapssHkbKM57wucvNe8mznTvU8F6m059rxH20AmhaM+GbbEtLAyCs2pMdqbin466/06HQD5qdO52i4xtlINdnNEBS8ooEjvZBcA0XjF+58E0iNgLZ60GOMbWZcXnAKsFw0T6qbcrWE0NgT/trG/NXARD0ovYFjLigYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5zIhcKDC1tqXiankphBpWnld9DLg/4DpD6SRlEY9Fk=;
 b=GZ+53SbAZtT+Q7ZUcs5Nn1pNRlXJMP+5gID1zMp8GJWvpkt3trsDopZiSEUJe3VPnbuD06uv5ZIWsV8c+4OPD0BYGnB+Ox2CBJld8rcrwuiG1OricWBaQNx+Nm+QSDZpPbohSayuPoBbOOvz2owGg9mbyQ/dfe10HYQIq0/LLuE=
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:37 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::58) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:37 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:35 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 14/22] EDAC/amd64: Split determine_memory_type() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:11 +0000
Message-ID: <20230127170419.1824692-15-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6c0dca-e3b0-4ccf-a90a-08db00889226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOTHtJmveHIxxqEjNGdDAjhQ7i/kh02Xr4vhPBvVy/QkRRVrpo0A0e9VSVm1e2XkfWQW/wzH15/6QEP5Czzy8lwN0bWHEQBEjTNPhyuYZee3xT7OEMnp55HMG+wBqJbveDNywKP1nMLyj8EunHJMRGBPLpY9gOSP/N9IHIjtGrA+ci1tRazIguLR7kBmxmCCBwW0AssCj4Gp8zIw0Ihccvh1KQ45R8sPbSjXQS/wut0KOANEJu7IuuvfV9H/Wn1NTjlH0HhHKO3oI9kOcRhzJDF6rcxRLTdMfsxSgrbA8iNVgOcGK6zlg7PQj0YoPjWiMs/1ZxNPPaoDALwRrtUpcxbG+IyfKN8lgmtogqO1Wwk6FxYAIPaW11mXbNA+VtJ05sXReogSxHLfzhaAOeBt8LToROCeORHVruI2cNuZOmp7gEnGrqDxV2Si7491TlFO/k7lV54wXUA2ou7h8LEoRB4W6RrQLG+zpIYaaS68GW/TYyExULgWpq7HYP+eAcjHR/C7hi5H5yyrSSjvNTdaUcALUTv1zl/UuNSaBVESebflFCV/3aGtvp1cGSWrdpmMmgxXG7hnWcBkHoUMCe5rksKZALeIDE4NtDCg0x+mgEVkqmJVvSQqLDmv79b71U2CXC20RVVqaKZ+uZU/kZSdNbktwBaVkj3c/Wtc7kgGzRavbiDOJ77axcwiWcL4PDMI98TxBrxAgIz4j7e5YqYbIEJlgEjPn8cEXWbO3KYR8kRf7vyXBByCRMTnJKvAc5OElNAFudv/XJhvBqgZlezbWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(26005)(2616005)(4326008)(8676002)(70206006)(336012)(70586007)(7696005)(426003)(186003)(16526019)(47076005)(36756003)(82310400005)(2906002)(86362001)(83380400001)(8936002)(36860700001)(478600001)(40480700001)(966005)(54906003)(316002)(110136005)(1076003)(40460700003)(6666004)(41300700001)(82740400003)(5660300002)(81166007)(44832011)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:37.0147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6c0dca-e3b0-4ccf-a90a-08db00889226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

..and call them from their respective hw_info_get() paths.

Call them after all other hardware registers have been saved, since the
memory type for a device will be determined based on the saved
information.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-9-yazen.ghannam@amd.com

v1->v2:
* Call functions directly instead of using pointers.
 
 drivers/edac/amd64_edac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9310c0fdeb22..0d0e563c99db 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1735,7 +1735,7 @@ static void dct_read_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_memory_type_df(struct amd64_pvt *pvt)
+static void umc_determine_memory_type(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
 	u32 i;
@@ -1772,13 +1772,10 @@ static void determine_memory_type_df(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_memory_type(struct amd64_pvt *pvt)
+static void dct_determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
-	if (pvt->umc)
-		return determine_memory_type_df(pvt);
-
 	switch (pvt->fam) {
 	case 0xf:
 		if (pvt->ext_model >= K8_REV_F)
@@ -1828,6 +1825,8 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
 		pvt->dram_type = MEM_EMPTY;
 	}
+
+	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 	return;
 
 ddr3:
@@ -3183,10 +3182,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 
 skip:
 
-	determine_memory_type(pvt);
-
-	if (!pvt->umc)
-		edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
 	determine_ecc_sym_sz(pvt);
 }
@@ -3664,6 +3659,7 @@ static int dct_hw_info_get(struct amd64_pvt *pvt)
 	dct_prep_chip_selects(pvt);
 	dct_read_base_mask(pvt);
 	read_mc_regs(pvt);
+	dct_determine_memory_type(pvt);
 
 	return 0;
 }
@@ -3677,6 +3673,7 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 	umc_prep_chip_selects(pvt);
 	umc_read_base_mask(pvt);
 	read_mc_regs(pvt);
+	umc_determine_memory_type(pvt);
 
 	return 0;
 }
-- 
2.25.1

