Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300F117C172
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCFPN4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:13:56 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:65114 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgCFPN4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:13:56 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6U4q002643;
        Fri, 6 Mar 2020 07:13:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=gGmTLw/nI+ckxz9eV0WxMxXmJprvIcLPEprNoZ0g2v4=;
 b=XB2FcrgOVd9XPJA6zwIEuJgoG25sXbL4XGtCw5mn3lfsWCjzP13ttCN4M2nNLerz8MfA
 rqCfAey0aifH6TI3lQCLTGhbci6s1jp12xdT63xbr8qe4hdWsz5/UuM5ruTzdH/rJWPb
 0XRDyPDjthVzZi4ZMYiNJiZQg9lILhHYje/5DZ77fWUmalhuT1cG9zi81SNoW+z/HPtS
 fEX38Ch3NhaU2YaLMIPR//7Wmx7de/elA9mPpKys8UYu9WT8BtVo3EvdMzC31oj6WrRO
 AIIc6noSK9UMNBjEuZlq4CO9uiVsuh+TV5bOTWA7EMa4qEx5yqnlsComO/71Fs9RQEP5 +g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yjnjhb2cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:45 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:43 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7IRvkpguQRc0jjW+MJp5sDxh7qtepej+PABESVdolgHbiahVxy3/AZPj0MScbBhPA71YaB6WcdDVpWbGpNHzgWcyZjQddwDRT/OSD9d+ENo1MZR87lGjSGbdRrjSiYI3c48g4UIWQFwshrs/LfZUxBMGrguWo/sngS20+JDRM3d2IMcSfg0suPw/4a4stAPixpP6GZSAj1qRZ4UUAS2Sz3sWzg9U0WoTscAEybVao6ddOkAJMqJ32mYuhhn/QuqyENo1Ug/Vf2f/68iqr0lKCBlUGmMpq5zkSVZiX+Re/uGMtK3SDDwPh2bdPmIwRAzqbtwO7zS2L7wGctkrQp3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGmTLw/nI+ckxz9eV0WxMxXmJprvIcLPEprNoZ0g2v4=;
 b=WUweoKsfA3iRRz8uLDpbrVkeUCgivNDmQCFlRwOdLoc45Tqru2347NKTcK0Dw43jsfeJP4rYyoYoDqpmqTt9jpRFKfMhLDrTg3UA5n2glbh/giab5WECubNCjJKkKYj9ACzudPRqyI1U5iCfHrsCQpScgnLXNXwcG3DIF0xmZ1zYqQwz12jhkdD8eIZtkkycAea1Vr5UFU4ucljPBJ6eIUendJE36xgPD3Jgx7IvdLjnBodlLdCr99AtStP9Tzx37gwgGiKzcmpI2A6jxrhqMIQWN2W00g+EkS4DXskpI63ypgQUU+/J/SULicjgzWRUcq5U9MUBNqpz5xDNADb0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGmTLw/nI+ckxz9eV0WxMxXmJprvIcLPEprNoZ0g2v4=;
 b=ZxbMN36Ic5Gha4Yjb25Xo7hTC5ez1OR4I1LVDaHoA+eecDwS+oUnmiPPlM/J3vc1hPZhz0BAObHsIMso07BQhHUWiOx7yjtwv6/YVfUIL0dhERrNssLsQpptfzbAQQgMcWf09NTfr2frqd8trFLgxptI5HfZA1nuSwWkemS41WU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:41 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:41 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/11] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
Date:   Fri,  6 Mar 2020 16:13:09 +0100
Message-ID: <20200306151318.17422-3-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:40 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d198430d-b193-4dfc-66ea-08d7c1e0f485
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2400B755E5DF1349D49FD3E9D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xogkaX6Gx8EbnGG95Kmi+KStwn0Pv78+OTRSMtPsKTvOwLKuz3yhGsPF6+OFJTLL06G6HFH+Yj4bwcz3nfuLNQ9i7N6YdQkmwJsj6p/zf5rBingvqTew8ybNa1wnfOqUw1EUqK/WrKpsoMsPx+tdXQMyaoH2mmDmjP1S2dAV1fhP3kv6TJG07rYf2x6vaH1eCrYzmrolomZWpiM0KICfnEe5zv5VezRU/Olz02lc4F7xVpRkUJhULxz5VUphRZD9IR6vu9V+TY/mbk4lD4wV1RiSq55M63yx2sP1u0jcMBmIwnyLzPHKhkc08kiCEPwLFdto1ayORs7H5kCChaPq+nF/IIK1BDnOujA3m1OmrKnYBIRKTB4YbwoJCN3lSUZDyygQt7dFNdyfrhPQEeIWTu7oG2q/HP9NY5gTMneloXHihdLF2phFPrlZGvUTp0SJ
X-MS-Exchange-AntiSpam-MessageData: WaXeXa8PwzACbbRgOqZuPszan+Lnt6FBI3BOWTd6t30MyKrMcIK2Li+/aSrAQu0jejxCkJwgMdU/2MgE4t7wjU9y+kxF8OZrH/S8Ao9k5RA0sO9+WERzzOfGLqxWBITDYK+Z+nq7AoBPM5gb5YvzWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d198430d-b193-4dfc-66ea-08d7c1e0f485
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:41.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n276Rlj3yFf5uxK1/3BcU8WaPyQ9ZgFcllQ0G+w4sLS3sEcnjRwpRUyi9BnV402m/hS5hfV2S98R3OEHSkLY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The ghes driver reports errors with 'unknown label' even if the actual
DIMM label is known, e.g.:

 EDAC MC0: 1 CE Single-bit ECC on unknown label (node:0 card:0
   module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM location:N0 DIMM_A0
   page:0x966a9b3 offset:0x0 grain:1 syndrome:0x0 - APEI location:
   node:0 card:0 module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM
   location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
   DRAM memory)

Fix this by using struct dimm_info's label string in error reports:

 EDAC MC0: 1 CE Single-bit ECC on N0 DIMM_A0 (node:0 card:0 module:0
   rank:1 bank:515 col:14 bit_pos:16 DIMM location:N0 DIMM_A0
   page:0x99223d8 offset:0x0 grain:1 syndrome:0x0 - APEI location:
   node:0 card:0 module:0 rank:1 bank:515 col:14 bit_pos:16 DIMM
   location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
   DRAM memory)

The labels are initialized by reading the bank and device strings from
DMI. Now, the label information can also read from sysfs. E.g. a
ThunderX2 system will show the following:

 /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
 /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
 /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
 /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
 /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
 /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
 /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
 /sys/devices/system/edac/mc/mc0/dimm8/dimm_label:N1 DIMM_I0
 /sys/devices/system/edac/mc/mc0/dimm9/dimm_label:N1 DIMM_J0
 /sys/devices/system/edac/mc/mc0/dimm10/dimm_label:N1 DIMM_K0
 /sys/devices/system/edac/mc/mc0/dimm11/dimm_label:N1 DIMM_L0
 /sys/devices/system/edac/mc/mc0/dimm12/dimm_label:N1 DIMM_M0
 /sys/devices/system/edac/mc/mc0/dimm13/dimm_label:N1 DIMM_N0
 /sys/devices/system/edac/mc/mc0/dimm14/dimm_label:N1 DIMM_O0
 /sys/devices/system/edac/mc/mc0/dimm15/dimm_label:N1 DIMM_P0

Since dimm_labels can be rewritten, that label will be used in a later
error report:

 # echo foobar >/sys/devices/system/edac/mc/mc0/dimm0/dimm_label
 # # some error injection here
 # dmesg | grep foobar
 [ 2119.784489] EDAC MC0: 1 CE Single-bit ECC on foobar (node:0 card:0
 module:0 rank:0 bank:769 col:1 bit_pos:16 DIMM location:foobar
 page:0x94d027 offset:0x0 grain:1 syndrome:0x0 - APEI location: node:0
 card:0 module:0 rank:0 bank:769 col:1 bit_pos:16 DIMM location:foobar
 status(0x0000000000000400): Storage error in DRAM memory)

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 44 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..07fa3867cba1 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -87,16 +87,32 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
+static struct dimm_info *find_dimm_by_handle(struct mem_ctl_info *mci,
+					u16 handle)
 {
 	struct dimm_info *dimm;
 
 	mci_for_each_dimm(mci, dimm) {
 		if (dimm->smbios_handle == handle)
-			return dimm->idx;
+			return dimm;
 	}
 
-	return -1;
+	return NULL;
+}
+
+static void ghes_dimm_setup_label(struct dimm_info *dimm, u16 handle)
+{
+	const char *bank = NULL, *device = NULL;
+
+	dmi_memdev_name(handle, &bank, &device);
+
+	/* both strings must be non-zero */
+	if (bank && *bank && device && *device)
+		snprintf(dimm->label, sizeof(dimm->label),
+			"%s %s", bank, device);
+	else
+		snprintf(dimm->label, sizeof(dimm->label),
+			"unknown memory (handle: 0x%.4x)", handle);
 }
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
@@ -179,9 +195,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		dimm->dtype = DEV_UNKNOWN;
 		dimm->grain = 128;		/* Likely, worse case */
 
-		/*
-		 * FIXME: It shouldn't be hard to also fill the DIMM labels
-		 */
+		ghes_dimm_setup_label(dimm, entry->handle);
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
@@ -344,19 +358,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
-		const char *bank = NULL, *device = NULL;
-		int index = -1;
+		struct dimm_info *dimm;
 
-		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
-		if (bank != NULL && device != NULL)
-			p += sprintf(p, "DIMM location:%s %s ", bank, device);
-		else
+		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strcpy(e->label, dimm->label);
+			p += sprintf(p, "DIMM location:%s ", dimm->label);
+		} else {
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
-
-		index = get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
-		if (index >= 0)
-			e->top_layer = index;
+		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
-- 
2.20.1

