Return-Path: <linux-edac+bounces-1080-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597388CADCC
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F748282E36
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802A55C29;
	Tue, 21 May 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EtIPhM/l"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD7524B4
	for <linux-edac@vger.kernel.org>; Tue, 21 May 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292817; cv=fail; b=TWQrTAlfVVWntxA0pYcjxcHVSs/TkQsNFFuFskSCyVNIfQEeQI73D1hT0J03sanVmAPvgQe4Ung+XVly4vjD3d+bGfeaiLOPOerBqIXKSFiZ5RntL2/49iq7xaJF0/8b9FbjgzJAnVKRWgV5td9+YuXX94bXM5ugJUEvGW+hNeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292817; c=relaxed/simple;
	bh=kfii9JHizp18LHE3Soy3i4iRY/+sP5QSUXGAbhYyy/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BErbRNDkmLD6D7yf6vrSsG9i/Rs2FZtp5gwO73vA3Q4ekKW4N1NF69CZTOFjpwIyYlfm8Q0oIs1/WoIo8InEpgRATtALgR49GJW+eDWGs55QSBKgPUYhEcFCOAfsZgiPgvmS1BQ81WR0K1BGTr6HFVmYvVoGyPEi4ElF2I4NsCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EtIPhM/l; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=masea39dZP8FeU3ZRla/OOBMN49h4VOMULcCjocBrbcyF+b+uzEkN79pNdYx/OSbMZjpyk5SXYJoQdDmHPrlPbBiBl6MIqOdwpMns5IfvOx9Z3elv9peIjJFqhdPCZVTDhXqW4FpYd/S5WdnH6Rq76EfkZq3HzbRrQWZi1jrj6d1X82lheRILdKPTNkxHwPpeQUtKzkirxkylnoL2e08ImSyuMytzd9EktDLdWYmqtButIuhJGWhsZ367+6fvYmStNhReaIUL3OzCCkUknTSBYz+jxMZnhOHMaWOB5Yp5PYRaxw9B6epC1e5fHFV6hsNbM+T8egC1r0kU2+b/1sMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fCyrCVPrdBGg98LGNXAZGZ5GHOojlleRzj5KVY97I4=;
 b=ZArrelbwJA8VL8y/WHQZuVK8z84oCGH8MJn1psOgBfRApXOSWd0FqmmbtcEkQraV4v7lZ9hPVlSfakXzpx6bYpl6rVRpXDWWgEn/hacQ9jMbJNS6JIZIXA0BShMPEhMADAX0GiOjm3+FWd8MWQxXyCuTikBTcr+L6ft+SpNEbCjwY2Iqctg16K78zxmOuTBmRZ0ea8qe2Q/XRPFE/tLtcnShvNaJAFr7NVE2MbkjQ71Pu7mkhBJ1SvnI0M9aAEZ8gUTVLuSMxaJq3x5NSVcSrQfc5YXDoThVet20Cy4vNa5BbqAv4Op/rQFmwlfQIpVrvMMnuzU50PRVAozsVRW07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fCyrCVPrdBGg98LGNXAZGZ5GHOojlleRzj5KVY97I4=;
 b=EtIPhM/lUdiZs4/urDUHA2J3up2eFH2JqKpqxJiNBBfXx/IWNcoM2izse80QkMtYISQqcz8D6LdE82F1/TVDHQYGddkLXMkNn2okL+nwzB/ZrZ6haiyjf3hzgtdB+5cMz0FU9lwrugjQVBahYdAj6NRBhgUb47hIAAm44YjvkPI=
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Tue, 21 May
 2024 12:00:12 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::6f) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Tue, 21 May 2024 12:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 12:00:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 07:00:02 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 21 May 2024 07:00:00 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <sai.krishna.potthuri@amd.com>, <bp@alien8.de>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <michal.simek@amd.com>
Subject: [PATCH] EDAC/versal: Report the bit position of the error
Date: Tue, 21 May 2024 17:29:59 +0530
Message-ID: <20240521115959.17596-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb5037b-9313-4439-7a30-08dc798d91ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yB8DupbTbxjFart9b5lBJgSO3IQkc/vhbp2bWDlZu2Se/XWlCpZzxuLNho7q?=
 =?us-ascii?Q?1jO0CeFmBkfpHyeVUSttBlnUbLX7/nBo5nAs6BadsWMEixDgxmbm6b9RT60t?=
 =?us-ascii?Q?3lMRhgrpRLaGrUvHN01WeeanJ9gp6nwgW1lkgkDnvwCn/WaLM/0WY+pDPM8e?=
 =?us-ascii?Q?dpDPwe+48xjxh/4Zbei6F+E3vJi09j5Shkz3dYeIfSS+W89uoin+nrBLn+zP?=
 =?us-ascii?Q?oLMKrHfsyKzKdFqpnWGTHPsYQ5zIoT0lZcJxrytpoJSbMJQzZdVGQrU2FK1v?=
 =?us-ascii?Q?0u1iPObp7BZtMwygxBXzXJMkb5FagioqodrgdeHZ5v/6Sjp4MwJoi6Qxpwfx?=
 =?us-ascii?Q?FemLQYkQu+NKvgaj2G4+Rc5o/xPnluwIc1tkNgQn3MzrG/zVOuCv/k3NvWBT?=
 =?us-ascii?Q?ioU+XhS2bm4WIDeQVEimjGEWUUangdoxEVMdgEEXnEyoKYWAcJsz4iiFvJ0a?=
 =?us-ascii?Q?eftmpuNVmLKcSVea4pnhV034HyBm4qA+jT1/0vnHZiLU1UHa9BgF6IT/Eetp?=
 =?us-ascii?Q?z5jXmA3etAjXo/ZIjx94tQnDLccfMY15+yWArpW5edvPnRJ1ytRJVMI7492I?=
 =?us-ascii?Q?vOLy9p3kabdZTpMYuBZ6MOMVgoRMbYGjrB/rZ/GLclS/frdE4wtFgUIVg6vn?=
 =?us-ascii?Q?6MwuZQiemSe/8Gd/V7/2hH6x3DCSvYMDMScksfJdLMmzMwddbkdCDHCjhfKo?=
 =?us-ascii?Q?exLq3US1MhWATPnuIJGLK+Vg1E/eS4H5AoObLqBL/6VR8RvzhCCS5oPhjdUI?=
 =?us-ascii?Q?toJEcCVhWEIcBthIdy1Co9GAG7T/UkNTRklcvzJmyzSfMh9B1NsIn/EMtQcH?=
 =?us-ascii?Q?2+mDidV+0IJbi8rp+kB7wgW5bbEc5ng1k4s25S/vhXH/EGHgo/rWwEFq8ao/?=
 =?us-ascii?Q?ewZu2A/VNb7IyzZUBKL3OPU/ih1bvt1ruO7GPEsgEmS+3Ppc7oJDSZnAZq3n?=
 =?us-ascii?Q?iKIczHjFRfDh+Rd8Ii9pD6A1oGzfYHC/6wUePlYTu8LeO+xbbzH8EAI490na?=
 =?us-ascii?Q?xzQ+FS4ecrvIRVfmx1l31AA16u1NYit0Atgon16zKr4PR8tTb4zTGE9HCg3I?=
 =?us-ascii?Q?uOfY3CiP5/uvco0sM0Xetd/DDzGPM5Ci+5lY91VbKRv276s9lWGNjqOhR4Xa?=
 =?us-ascii?Q?UkXUDjn5N4JZTihJY31A+mlc36SOsL+7P5qQ/qT9D4e//RGp5wsAuGzqeLdQ?=
 =?us-ascii?Q?1pIQ6USjFiAg2EUfHpcSLFHjy53mVgwOfVSyAIDYpcZI0JS1WMXVKTnAF+w4?=
 =?us-ascii?Q?hE87xKYBJDPKJowO9KdfQphNJDql2Emm3kj073Jh3j+L6Ab3smBLyP+nX4oR?=
 =?us-ascii?Q?KTU2tA4+tCDkLlNujFJ0h7rJuBn4ln+RWE2hoeAAtNEHTQuRf7hlO/yNbmD2?=
 =?us-ascii?Q?xw0d9xk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:00:12.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb5037b-9313-4439-7a30-08dc798d91ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

In the case of CE, the bit position can be derived from the data
and the parity registers. The values are read and
then from the fixed H Matrix the corrected bit
position is derived. The hardware already corrects the
CE errors however it is derived from the registers and
reported for debug purposes.

When a correctable error is detected, the driver reads from the
registers:

eccr0/eccr1_corr_err_data_lo
eccr0/eccr1_corr_err_data_hi
eccr0/eccr1_corr_err_data_par

and along with shifting/XORing fixed H_Matrix ECC values,
calculates which bit location is found, mimicking the calculation
done in the DDRMC ECC hw.

The H_Matrix was generated from an old 1950's IBM paper.

The maximum bits in the data read is 64 so the data match is run for
64 bits.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a556d23e8261..f02df3cd0faa 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -144,6 +144,8 @@
 #define XILINX_DRAM_SIZE_16G			4
 #define XILINX_DRAM_SIZE_32G			5
 #define NUM_UE_BITPOS				2
+#define NUM_ECC_BITS				72
+#define DATA_BITS				64
 
 /**
  * struct ecc_error_info - ECC error log information.
@@ -245,6 +247,79 @@ struct edac_priv {
 #endif
 };
 
+static int rowa[] = {
+	0x7, 0xB, 0x13, 0x23, 0x43, 0x83, 0xD, 0x15,
+	0x25, 0x45, 0x85, 0x19, 0x29, 0x49, 0x89, 0x31,
+	0x51, 0x91, 0x61, 0xa1, 0xc1, 0x0e, 0x16, 0x26,
+	0x46, 0x86, 0x1a, 0x2a, 0x4a, 0x8a, 0x32, 0x52,
+	0x92, 0x62, 0xa2, 0xc2, 0x1c, 0x2c, 0x4c, 0x8c,
+	0x34, 0x54, 0x94, 0x64, 0xa4, 0xc4, 0x38, 0x58,
+	0x98, 0x68, 0xa8, 0xc8, 0x70, 0xB0, 0xD0, 0xE0,
+	0x1f, 0x2f, 0x4f, 0x8f, 0x37, 0x57, 0x97, 0x67,
+	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };
+
+/**
+ * calculate_ce_bit_value - Report the bit that was corrupted in the CE errors
+ *
+ * @eccr0_corr_err_data_hi:	ECC error data hi register
+ * @regval:	ECC error data lo register.
+ * @parity:	ECC error parity
+ *
+ * Return: none.
+ * Report the bit that was corrupted in the CE errors
+ *
+ * The function takes the data and the parity as inputs.
+ * It derive the corrupted bit from a fixed H Matrix and the data
+ * and parity.
+ */
+static void calculate_ce_bit_value(u32 eccr0_corr_err_data_hi, u32 regval, u32 parity)
+{
+	u8 bit, xor[BITS_PER_BYTE], match = 0;
+	u8 rows[NUM_ECC_BITS] = {0};
+	bool field, prev;
+	u64 data;
+	int i, j;
+
+	data = (u64)eccr0_corr_err_data_hi << 32;
+	data |= regval;
+
+	for (i = 0 ; i < DATA_BITS; i++) {
+		if (data & BIT(i))
+			rows[i] = rowa[i];
+	}
+
+	for (i = DATA_BITS ; i < NUM_ECC_BITS; i++) {
+		j = i - DATA_BITS;
+		if (parity & BIT(j))
+			rows[i] = rowa[i];
+	}
+
+	for (j = 0 ; j < BITS_PER_BYTE; j++) {
+		bit = rows[0] & BIT(j);
+		prev = !!bit;
+
+		for (i = 1 ; i < NUM_ECC_BITS; i++) {
+			bit = rows[i] & BIT(j);
+			field = !!bit;
+			if (field != prev)
+				prev = true;
+			else
+				prev = false;
+		}
+		xor[j] = prev;
+	}
+
+	for (j = 0 ; j < BITS_PER_BYTE; j++)
+		match |= xor[j] << j;
+
+	for (i = 0 ; i < NUM_ECC_BITS; i++) {
+		if (match == rowa[i]) {
+			edac_dbg(2, "bit found is  0x%08X\n", i);
+			return;
+		}
+	}
+}
+
 static void get_ce_error_info(struct edac_priv *priv)
 {
 	void __iomem *ddrmc_base;
@@ -271,6 +346,15 @@ static void get_ce_error_info(struct edac_priv *priv)
 	p->ceinfo[1].i = regval | reghi << 32;
 	regval = readl(ddrmc_base + ECCR1_CE_ADDR_HI_OFFSET);
 
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG)) {
+		u32 eccr0_corr_err_data_hi, par;
+
+		par = readl(ddrmc_base + ECCR0_CE_DATA_PAR_OFFSET);
+		regval = readl(ddrmc_base + ECCR0_CE_DATA_LO_OFFSET);
+		eccr0_corr_err_data_hi =  readl(ddrmc_base + ECCR0_CE_DATA_HI_OFFSET);
+		calculate_ce_bit_value(eccr0_corr_err_data_hi, regval, par);
+	}
+
 	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
 		 readl(ddrmc_base + ECCR1_CE_DATA_LO_OFFSET),
 		 readl(ddrmc_base + ECCR1_CE_DATA_HI_OFFSET),
-- 
2.17.1


