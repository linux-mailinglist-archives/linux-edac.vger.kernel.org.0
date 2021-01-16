Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5D2F8DCB
	for <lists+linux-edac@lfdr.de>; Sat, 16 Jan 2021 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhAPRJx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 16 Jan 2021 12:09:53 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:25952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbhAPRJs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 16 Jan 2021 12:09:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INDcyaMDbHUhLzP+JpyPBte99weOn+8D0LGGt20TTJmMhwV716kyQgL8syqyckyJOhXklAsU2kZg5t86tt80E5asN+ganMJE3il8eF/ZVB4lmefz3e/876EsyycRLEv2VzmvKKvGdhcn2RQvNHv1z7NlqwrQyrk+SeWQfo4F+eAbFT5PwKo48YgXn0sG1MNNbtcNz23lyLUC7iKOo/4b4VNDg8HnJAIZ5zFeMaFkiMeu38aeUHWwnD67SmmPJuDDjGTtOZb4IWONEQ31fxb+ItQByxGHoPwlvVG6u95PF5bH8OPSRDFvKC9AdZfUJDRXhqwmVUR/I/7stdezAT7FZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBHVnx4hROj2KGKmdV9T9ZifZ3Mv+wbskQQcetX5r+Y=;
 b=clOVEEqSH/d1z2aZQDPCKGK8dIl6TonYq29pj6+RD6KvTkzPX63Gbnl7NoXVqMpJ/rX65ch6XIKVz0t80bmQ8UW3BL6V3FhVXNegSX0HWx34ZhRmJr0UkQojeQ3FO0B9awYQqSJJhcocUDPdC4wDAW5R+zAY8ogDedGi0k01AEUn3AUbYT77mLF0aJ0ol9AWxMdmoDJZfr/2iNukmdSjmkoLfalTM4ygUsCjEYobURTbiAaVWvpIIl9l+l2kaTJp+rPxN3PuLUoOVR1l5RGGM7SHman84BUA41Ot/JqE5lLfbDYBo8HnRFHeCsD/vIRaaPUX7ua7Tm2ZgcADw7BVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBHVnx4hROj2KGKmdV9T9ZifZ3Mv+wbskQQcetX5r+Y=;
 b=vp6MUprEySR2xo3gO1HC0w+qsEh4675RE1TDQdKS8Lr+uvVeg/bDeyxOLWTHyCgpeQxp7jQO7f0fNLx4HsGVQ2tigSXhDpPSfkRIzSBb9Lmvf9XJSkFGCzS5HW6tyS8usD2wLvR2ECbEfGialyahrY1ot77H4qV4ffBF8WRnXGc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1458.namprd12.prod.outlook.com (2603:10b6:405:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 14:34:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3742.012; Sat, 16 Jan 2021
 14:34:05 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        Smita.KoralahalliChannabasappa@amd.com, wgh@torlan.ru
Subject: [PATCH] EDAC/AMD64: Update scrub register addresses for newer models
Date:   Sat, 16 Jan 2021 14:33:53 +0000
Message-Id: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0401CA0023.namprd04.prod.outlook.com
 (2603:10b6:803:21::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN4PR0401CA0023.namprd04.prod.outlook.com (2603:10b6:803:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 14:34:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4e58f30-2312-47f5-4701-08d8ba2bc653
X-MS-TrafficTypeDiagnostic: BN6PR12MB1458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB145828003F21EE707115107FF8A60@BN6PR12MB1458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzGmmJ1MfWDj5Bx0luzl3uZvdDAQIayEiGsO5By96zT32IG0hV3MFtQs2WJ3bYPl8v9jeZn1+dLHUP3MDqtRMK6oPq+9l8rR6oDLnyOQQQqvcp3F3B6vd4w2eu43nKZklZuPJvJTiTu9PcseJEJpi2F7yGuhsiALAkF1bGRPW7VCNcFaXK0jp2N+95cHXZWs86o273yBWpPlisadKLe/nr6TyTcnlxr0sgRWQk0kntxB/aSuprC2DCNlpgjmfqEEjR9+v7MA0/WqiUx6N8fvVUbisBuMWsGtFg5HRTo45C99xi8d67/0lw+dpkNbhV5Kq7T6z5FmgqAXcHrrjZCCJwWLRSjmXrjIAdJ1TpC1ET1VZG3tK2JKSw0Usato3VdK2OqkBUxmlSuUh9NCy5pi2rkeF6bB7lk6LUzrnZcMRX66GGMcm4F70nh0WSDDFhzgVb6BWVSGWJONmpDwXUfRK/lMGisBwkCNDccrjj8GpgdYaJQRp5IZbOWfC6jplUj3zdZO7JBacMSJDWdlki0OikM9dfEvYZZGPR2ECls0J+A5JXyRHtuBvC5U1ZrUUo9H0Fsht/6R1J0dQe+qFPEmhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(52116002)(83380400001)(6916009)(66476007)(36756003)(8676002)(66556008)(26005)(8936002)(4326008)(66946007)(2906002)(186003)(86362001)(5660300002)(956004)(6666004)(7696005)(1076003)(6486002)(478600001)(2616005)(316002)(16526019)(170073001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KqkztuGeABa4eBxlqAyKLZPlTsjHS8ZpUntdfGbOkHc5VcNMMDB1soF7+0Gh?=
 =?us-ascii?Q?SuBYgMIW/BH8vMukZWD+J7E/boJGgZoxH0WxbPGi5zn12/wZlC3IZwUgVYqa?=
 =?us-ascii?Q?4sMDRboe1GAhjp3GzakukmPoo16RQV87PIQeYN8hVqQTxhZMp4HH2dw0rqpq?=
 =?us-ascii?Q?mxAkSAFeKBQVp4HwxPCjAd2RJZUX7Huk3eH54QqqMQcWCOjb+Ajfci0zs7Jb?=
 =?us-ascii?Q?HwTqS16G2/0wICLsKe790IuR+qpwGZBVcDZlSPCjdqG7V5l5k+CgKyYyofiL?=
 =?us-ascii?Q?ANxfdZjdhHPs2x30P170x+6xsNCUbjYONmgWXTytr2XXwgEXxxv+dWX0Xkty?=
 =?us-ascii?Q?shTMiAgUOvjni9T+SwaIqxVh+GbuvQP/01kCEX4atvzETvTtK29tJ87HM1Ox?=
 =?us-ascii?Q?nSlAlgufvCHKVp63BJRRK4ovwt8ilV0A7BmCyNZJRHEfscHsaYSfRUx3T5c6?=
 =?us-ascii?Q?w9D+LvtB9LwYYs2+Kf6F1TlqMysSblUm33ntmuxDxy70iJxbAVSGS8eFnz1f?=
 =?us-ascii?Q?B0P60GvSQ+dR7XHO/kZbk9qFf4cBjG0BPx2MIrbtXc6otS7sGP8J6u2D/0pF?=
 =?us-ascii?Q?ucPRUfZEall+laVvF3a0lHBjrLiNvA/3kF2DL/9ZYJF20Wchp8v+x3PpFOnE?=
 =?us-ascii?Q?2rc5zojchtyNIMoRznN3+cO7BcOFKxTd+R0UwU9Y3x7hXP9hvIh8Fc5sM5M5?=
 =?us-ascii?Q?F4m7aByJJqWIp5R/pL2I7SCCf5pA02uNRPoZL8UWZx1fv+KFhr/z7b8D53Zp?=
 =?us-ascii?Q?aGjt1CYk1ce8qGiJgew3o1Seahfjy3ZbcIOZYlqdhJ10xKHvxG3ht/Fm/j0b?=
 =?us-ascii?Q?g4lxsHWkK7ogzB1QsxVRuxLblPAZoxjhACVbxBYNFlGf+QexAKS4Hz5VVSSO?=
 =?us-ascii?Q?2S4xB59ir3+qN8b859vsLdHODQpI2nRG89iJzFrDW+fbIeXqVDCSYbUxmU0O?=
 =?us-ascii?Q?uV/Xe6oqi7kCSMQ+mu5zL0rT6sgjL+WQ6XryBz7lECelxvA7wJqdoUUSWpeL?=
 =?us-ascii?Q?XIlQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e58f30-2312-47f5-4701-08d8ba2bc653
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 14:34:04.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQgIjn+zvKInssuuK5O0wOUZSFsZCXaHvV6bs1wdVIpgjaDxT4LMVIzJRpS8xRMUKEVUagVWsouq3o8k+AlTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1458
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Family 17h scrubber registers moved to different offset starting
with Model 30h. The new register offsets are used for all currently
available models since then.

Use the new register addresses as the defaults.

Set the proper scrub register addresses during module init for older
models.

Reported-by: WGH <wgh@torlan.ru>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 23 ++++++++++++++++++-----
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9868f95a5622..b324b1589e5a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -167,6 +167,10 @@ static inline int amd64_read_dct_pci_cfg(struct amd64_pvt *pvt, u8 dct,
  * other archs, we might not have access to the caches directly.
  */
 
+static struct {
+	u32 base, limit;
+} f17h_scrub_regs = {F17H_M30H_SCR_BASE_ADDR, F17H_M30H_SCR_LIMIT_ADDR};
+
 static inline void __f17h_set_scrubval(struct amd64_pvt *pvt, u32 scrubval)
 {
 	/*
@@ -176,10 +180,10 @@ static inline void __f17h_set_scrubval(struct amd64_pvt *pvt, u32 scrubval)
 	 */
 	if (scrubval >= 0x5 && scrubval <= 0x14) {
 		scrubval -= 0x5;
-		pci_write_bits32(pvt->F6, F17H_SCR_LIMIT_ADDR, scrubval, 0xF);
-		pci_write_bits32(pvt->F6, F17H_SCR_BASE_ADDR, 1, 0x1);
+		pci_write_bits32(pvt->F6, f17h_scrub_regs.limit, scrubval, 0xF);
+		pci_write_bits32(pvt->F6, f17h_scrub_regs.base, 1, 0x1);
 	} else {
-		pci_write_bits32(pvt->F6, F17H_SCR_BASE_ADDR, 0, 0x1);
+		pci_write_bits32(pvt->F6, f17h_scrub_regs.base, 0, 0x1);
 	}
 }
 /*
@@ -257,9 +261,9 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 	u32 scrubval = 0;
 
 	if (pvt->umc) {
-		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
+		amd64_read_pci_cfg(pvt->F6, f17h_scrub_regs.base, &scrubval);
 		if (scrubval & BIT(0)) {
-			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
+			amd64_read_pci_cfg(pvt->F6, f17h_scrub_regs.limit, &scrubval);
 			scrubval &= 0xF;
 			scrubval += 0x5;
 		} else {
@@ -3568,6 +3572,14 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 	}
 }
 
+static void f17h_set_scrub_regs(struct amd64_pvt *pvt)
+{
+	if ((pvt->fam == 0x17 && pvt->model < 0x30) || pvt->fam == 0x18) {
+		f17h_scrub_regs.base = F17H_SCR_BASE_ADDR;
+		f17h_scrub_regs.limit = F17H_SCR_LIMIT_ADDR;
+	}
+}
+
 static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
@@ -3577,6 +3589,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	if (pvt->umc) {
 		f17h_determine_edac_ctl_cap(mci, pvt);
+		f17h_set_scrub_regs(pvt);
 	} else {
 		if (pvt->nbcap & NBCAP_SECDED)
 			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..4606f72f4258 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -213,6 +213,8 @@
 #define F15H_M60H_SCRCTRL		0x1C8
 #define F17H_SCR_BASE_ADDR		0x48
 #define F17H_SCR_LIMIT_ADDR		0x4C
+#define F17H_M30H_SCR_BASE_ADDR		0x40
+#define F17H_M30H_SCR_LIMIT_ADDR	0x44
 
 /*
  * Function 3 - Misc Control
-- 
2.25.1

