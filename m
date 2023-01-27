Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7767EC2B
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjA0RL3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjA0RL1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:11:27 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B0C21295;
        Fri, 27 Jan 2023 09:11:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILFfJ+1V8Ed25r/2GpX27+ezdXw5tdE4og4EIKGTWElS1NAKKJb+eaE+AOOfl+5vcrkhrbsVtYrV3NLUFsHImvht77FpK0Ht29yfWOByQ8ohrwYbRKOaDycPrIoGm/VMp7IhObVdNJB1sxCp0tsY40E/kcKb/Nf3Rk8Ns/BwC9v4lPItjFQGGZ7Y5NcdLq3MBeqKDnmM3042iUjNxHBWny5sWbwX9EunaNDyFq15Y+3G77X87ReUfvDvTPdPiXtlCcXDNpVLPjR4MpY5a/6ui5hdgqPQ49PBmiOthJwRD+peiO5Jf3/Ddwpu4Lgvyjn9vZvih0adObUVX7jAVbkEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBX/FwYDzvnwStj27DAwDVed777YXzgRY2WCVOxy7Io=;
 b=XOWo7NqlAXKNOYDOwNMBdMJ+f5Yj1wyMEeETn0pdk6nAjRABw3j3oTrV7qjtK1OxxWqP0QSN4vVP3Fi6aJ3PZG746gHazwlHchZgeS/I19qHmJf+5U4zOpYwA7zdFaly8PF8ROaVXcgCwlhM4gmw2/hhye8XKX8W88D158zkIQsn+WB6jGzshK83+D+fCI0Tfb+8x3JcMnP5MlVWhhOhkDzpAOlA2VHRGQnQRqmixjyl2n3RS+uOOCKwJesFW/L7SWxSII1jNf+klp8phGNsy3E9h+a3MA8ygMKJhnuEDwepuELABc8JnsZ3fykPVngesT6aDoDicDfc2tgHf5Rw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBX/FwYDzvnwStj27DAwDVed777YXzgRY2WCVOxy7Io=;
 b=OEc7bJ2FmntaLmPnXvQP2Nng/HA0XY2BdcO1NILkDFYt/lBNae2lUO9N5ZvEBgF6pk+Wp/MEFqDJIMzKQej+XZqtVCNFjF0jQ4VZoLTvh5uVqV6o5NZbSdRx66mPREJVKh863JClgxU0keVnWkRfAYEsalBfGzvrMEqThe1TCYY=
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:32 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::18) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:32 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:31 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 02/22] EDAC/amd64: Remove scrub rate control for Family 17h and later
Date:   Fri, 27 Jan 2023 17:03:59 +0000
Message-ID: <20230127170419.1824692-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 486ea70d-4863-4506-12cb-08db00888f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPsEfFFuY9KFvZJUDE8gE2CiSwjjKjXlBmw6Nn0QLdSQVqopJ46BiR3azMGrPtyEt3+qRvr6G4JU0JK8gtyGMnfpPZcfjoBYp0VEVu6Bs2RuTIVsgBB+f94Icm6HvmlYZX4wUhz6vyTX72L38TiW6W6hhDGfvMcrgF0T8qyxOAiRoY9DF1EJuiajoNaxnR7sTQm8CM/uyTzp/kKPsC3+YGrZ3+W5Z84yb5DtZs6dn+5TxEidf94oPFyKDJgsUnvcIIFTYXIdakkY7fxBEKHKlDKdgHH8XDE+/U2HPgGrZ3ZyW666UOhe2ChD2UegjvYtbpMiAOeXwFy5AZjM+4pqqXctqhqny7luQvxxcqD4tIDBmGXQvzeqY67KTEB97Xs0okZSZYOnexWgww/6w/EQ9OckeqBEQNwYguaemCnfAw5lDE4QjkA4afQl5Obt+oAAvXiA5ZCdsXY1RdRLWjSfyxKc0o1oFUgymnrE/wamZzCXDrFJUW/smRCY68xiG5Q43pn9NSVVyrBEJ3KBWR6zYqtGyIibF4UO8157yLA3BnuHeBttAtBckE5mS4Ve6Xv/KJIasgrO8q8UnwB1pTB97fP8xF5XN/oXofkibRGe2cqjSybnvoZj6Zls8YqS4tBK6nxoEWwUT9WdhNqZ/pg8YwtDvj9RSngNyPP5z7ada2Ev4y+VrmuV19V0ZLjmjY2pzaD99vYbZBaqsvGDtgsHX6mAmbKuZxAnp0xVi0NiVGCJpuY+TMb46a9rtcqV9SV7B0wwxNBnJaZFmcaMPVHDlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(26005)(2616005)(4326008)(8676002)(70206006)(336012)(70586007)(7696005)(426003)(186003)(16526019)(47076005)(36756003)(82310400005)(2906002)(86362001)(83380400001)(8936002)(36860700001)(478600001)(40480700001)(966005)(54906003)(316002)(110136005)(1076003)(40460700003)(6666004)(41300700001)(82740400003)(5660300002)(81166007)(44832011)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:32.5151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486ea70d-4863-4506-12cb-08db00888f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The scrub registers on AMD Family 17h and later may be inaccessible to
the OS. Furthermore, hardware designers recommend that the scrubbing
feature is managed by the firmware.

Remove support for the sdram_scrub_rate interface for AMD Family 17h
systems and later by not setting the scrub function pointers. The EDAC MC
core will then not expose the scrub files in sysfs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-3-yazen.ghannam@amd.com

v1->v2:
* Don't set the scrub function pointers.

 drivers/edac/amd64_edac.c | 33 +++++----------------------------
 drivers/edac/amd64_edac.h |  2 --
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2cc7336a5121..07a89df0d4f4 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -182,21 +182,6 @@ static inline int amd64_read_dct_pci_cfg(struct amd64_pvt *pvt, u8 dct,
  * other archs, we might not have access to the caches directly.
  */
 
-static inline void __f17h_set_scrubval(struct amd64_pvt *pvt, u32 scrubval)
-{
-	/*
-	 * Fam17h supports scrub values between 0x5 and 0x14. Also, the values
-	 * are shifted down by 0x5, so scrubval 0x5 is written to the register
-	 * as 0x0, scrubval 0x6 as 0x1, etc.
-	 */
-	if (scrubval >= 0x5 && scrubval <= 0x14) {
-		scrubval -= 0x5;
-		pci_write_bits32(pvt->F6, F17H_SCR_LIMIT_ADDR, scrubval, 0xF);
-		pci_write_bits32(pvt->F6, F17H_SCR_BASE_ADDR, 1, 0x1);
-	} else {
-		pci_write_bits32(pvt->F6, F17H_SCR_BASE_ADDR, 0, 0x1);
-	}
-}
 /*
  * Scan the scrub rate mapping table for a close or matching bandwidth value to
  * issue. If requested is too big, then use last maximum value found.
@@ -229,9 +214,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->umc) {
-		__f17h_set_scrubval(pvt, scrubval);
-	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
+	if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
 		pci_write_bits32(pvt->F2, F15H_M60H_SCRCTRL, scrubval, 0x001F);
 		f15h_select_dct(pvt, 1);
@@ -271,16 +254,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 	int i, retval = -EINVAL;
 	u32 scrubval = 0;
 
-	if (pvt->umc) {
-		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
-		if (scrubval & BIT(0)) {
-			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
-			scrubval &= 0xF;
-			scrubval += 0x5;
-		} else {
-			scrubval = 0;
-		}
-	} else if (pvt->fam == 0x15) {
+	if (pvt->fam == 0x15) {
 		/* Erratum #505 */
 		if (pvt->model < 0x10)
 			f15h_select_dct(pvt, 0);
@@ -3967,6 +3941,9 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
+	if (pvt->fam >= 0x17)
+		return;
+
 	/* memory scrubber interface */
 	mci->set_sdram_scrub_rate = set_scrub_rate;
 	mci->get_sdram_scrub_rate = get_scrub_rate;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 38e5ad95d010..48f1d97e1274 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -215,8 +215,6 @@
 #define DCT_SEL_HI			0x114
 
 #define F15H_M60H_SCRCTRL		0x1C8
-#define F17H_SCR_BASE_ADDR		0x48
-#define F17H_SCR_LIMIT_ADDR		0x4C
 
 /*
  * Function 3 - Misc Control
-- 
2.25.1

