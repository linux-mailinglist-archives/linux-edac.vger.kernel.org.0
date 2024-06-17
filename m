Return-Path: <linux-edac+bounces-1301-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2290BC08
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2024 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381DF1C2326D
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2024 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B419DF8D;
	Mon, 17 Jun 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fo+ueEWx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896719DF81;
	Mon, 17 Jun 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655500; cv=none; b=ch1lxOElGrjShJD11KijpAOO0ipmWeNPcn10DNRFTwgeuPzFxbLkeeTZCX7z6F+IzHe+cjk5XZT2BTTc/OAYKYlEBZiAZijMUxWgXNXc2QBogl0nAzplsjZtfIHRglkPCbT+5Fb/SJtT1OAjyPhgA7G6qDJX1FOplC18H+pgiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655500; c=relaxed/simple;
	bh=pI8S1fTmLevYqlSJ2RmuXBG1RjiHQm/2Y+Jibhl8KCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JzyCokqalzx/tDdsJQs718rFGk9mRowrjNBO6pgBhEC5kLdBFak/JdCT8wQ8TuinlYoA+vyr+7dvzY59AcnPvL47JUSK2q5ZIZDkoSnxFM0S86kHN/nuMGZ6i6r7UKAYkPmOK+GeVeToiZsWdDorDL5oUIBT5ioruFLrvItotFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fo+ueEWx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAdMtY022524;
	Mon, 17 Jun 2024 19:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OWEmTilDE5Bxmu7DUuNISj
	VpdcVGU0wupZbmMvDx5ic=; b=Fo+ueEWx6vUz8qUHIsEoVu9JjK8rTmDM2RyQNK
	Lic48hKQtD6ya/SazzFSEk3bTB615yvogOJNLtEWrpqCWnWaUroz+FyG7r6bsVLP
	f8jv2/C64eraSuG0BbeOV4bkMNFi1Jww+hpykAnygTiR7N8OEY6R1KMW7xXeVdkv
	4SFFneLwS9yeVgCcUsbgDOOxK6egC398bF5LLvh9LRVMxDGhG25goWqioDlLInSK
	WSJY2ehV2UQICfTxKY6CTccJLQFt0nnlvBger6VNt4t6j5Aj+17fUNZHLBUqQn36
	HeExBVbhjOizS4xXIPoWo9qwpk3MUMev8SFDqoygyeeCwoRQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3b74n9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:53:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HJrskd017640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:53:54 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 12:53:54 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 12:53:52 -0700
Subject: [PATCH v2] EDAC: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-arm64-drivers-edac-v2-1-6d6c5dd1e5da@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAE+UcGYC/4WOSw6CMBCGr2K6dkxbKkZX3sOw6GOQSWzRKRAM4
 e4WLmD+1Zf8r0VkZMIsbodFME6UqU8F9PEgfGfTE4FCYaGlNrJWFcQAlmNtIDBNyBkwWA+6tUZ
 XlZHhchYl+2Zsad57H01hZzOCY5t8t7W9KI0zRJsH5M3eUR56/u4vJrWF/g1OCorM1ZpWtrVy7
 v4ZyVPyJ99H0azr+gO+bJd52wAAAA==
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James
 Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tzT8BRGZZ6xqabbT97xOx6oZWxCefee6
X-Proofpoint-ORIG-GUID: tzT8BRGZZ6xqabbT97xOx6oZWxCefee6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170153

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes mpc85xx_edac.c and four octeon_edac-*.c files which,
although they did not produce a warning with the arm64 allmodconfig
configuration, may cause this warning with other configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Updated to fix all missing MODULE_DESCRIPTION() macros in drivers/edac
- Link to v1: https://lore.kernel.org/r/20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com
- v1 subject: [PATCH] EDAC: layerscape: add missing MODULE_DESCRIPTION() macro
---
 drivers/edac/layerscape_edac.c | 1 +
 drivers/edac/mpc85xx_edac.c    | 1 +
 drivers/edac/octeon_edac-l2c.c | 1 +
 drivers/edac/octeon_edac-lmc.c | 1 +
 drivers/edac/octeon_edac-pc.c  | 1 +
 drivers/edac/octeon_edac-pci.c | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index d2f895033280..b70d5d258fcb 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -69,6 +69,7 @@ static void __exit fsl_ddr_mc_exit(void)
 
 module_exit(fsl_ddr_mc_exit);
 
+MODULE_DESCRIPTION("Freescale Layerscape EDAC module");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("NXP Semiconductor");
 module_param(edac_op_state, int, 0444);
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index e8945d4adbad..d0266cbcbeda 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -704,6 +704,7 @@ static void __exit mpc85xx_mc_exit(void)
 
 module_exit(mpc85xx_mc_exit);
 
+MODULE_DESCRIPTION("Freescale MPC85xx Memory Controller EDAC driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Montavista Software, Inc.");
 module_param(edac_op_state, int, 0444);
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index 919095d10528..2adb9c8093f8 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -201,5 +201,6 @@ static struct platform_driver octeon_l2c_driver = {
 };
 module_platform_driver(octeon_l2c_driver);
 
+MODULE_DESCRIPTION("Cavium Octeon Secondary Caches (L2C) EDAC driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index 18615cbcd9ea..4112c2ee34b8 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -319,5 +319,6 @@ static struct platform_driver octeon_lmc_edac_driver = {
 };
 module_platform_driver(octeon_lmc_edac_driver);
 
+MODULE_DESCRIPTION("Cavium Octeon DRAM Memory Controller (LMC) EDAC driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index b8404cc7b65f..d9eeb40d2784 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -137,5 +137,6 @@ static struct platform_driver co_cache_error_driver = {
 };
 module_platform_driver(co_cache_error_driver);
 
+MODULE_DESCRIPTION("Cavium Octeon Primary Caches EDAC driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
diff --git a/drivers/edac/octeon_edac-pci.c b/drivers/edac/octeon_edac-pci.c
index 108ad9493cfb..4d368af2c5f0 100644
--- a/drivers/edac/octeon_edac-pci.c
+++ b/drivers/edac/octeon_edac-pci.c
@@ -104,5 +104,6 @@ static struct platform_driver octeon_pci_driver = {
 };
 module_platform_driver(octeon_pci_driver);
 
+MODULE_DESCRIPTION("Cavium Octeon PCI Controller EDAC driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-edac-2fa423340d75


