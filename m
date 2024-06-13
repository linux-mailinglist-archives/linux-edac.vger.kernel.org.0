Return-Path: <linux-edac+bounces-1280-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85A907E38
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 23:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FF41F25848
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF013DDBA;
	Thu, 13 Jun 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kPP+T7yX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2A71747;
	Thu, 13 Jun 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314631; cv=none; b=YQmgXkk5MoiOqLg0giVLzR1VNs1wkonirLcuHLyZ8+XrGVXFT2s285DEeVO/Uv5cSfxzAkBVPz7Zb/9WxMQjonNxf4yZW1u0TK/7GoDtUBslimwPongxe61hp4YNdqJFJ43oSMgZ8eSrBloRzftLA52EPRnO1OOXUhs0LeLnOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314631; c=relaxed/simple;
	bh=JbhWnVRwHYOcKn4OzP0YKh1BkZLEBKqwpyE6zStyX7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OT2aXXoGEAcFR4QZjkv0EyfKkwqj/U0PFQ52s+p+wQ4xScLZ1lTzvKs9Otu0aEkGBPVbnLIzl9cQhxiIM3QPyLtOdXquGpsGnTkebq38KTfTFo13P8/vXl2WRNRDQd6j9LhryRqJJLzVJO9tlu2xj8rWVsHdIm5sXIxhXo+F5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kPP+T7yX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGMae008079;
	Thu, 13 Jun 2024 21:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zxFlDvDS2ZXrOAEi2ahNLT
	O+mwXjt++ZBBrq5JCsaWU=; b=kPP+T7yX3hVGnuOdblPk0qLewQqfV36U2sY1rJ
	xdPT5sZE105V2oDkW8Frzy7iIio7Q3X4uE4HsqIYE6NjsMLEUlD/zJimWzaopVtu
	S8YbR2LCFCcHwaDRzat4vbvO14CHLTg9WiWSx/RQwwlzhoF/JoiF1xOukDod+KZs
	PxATKxLkpBRixTtOqy//gXlf/KeByNRAAiz4ml5/etP5qlvkhFtWvZref4RlYVgY
	5XzvS2qtxW+mmkJWt1OCOSaN4PFj9h1sI1vLnF1JZL0+tjtiEA+gPuIXWBT47Ovx
	mLawhPcvFcJ9stQzJFyqYc8UsceTRvGB0ik1c0uXKobVgZwQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q58brg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 21:36:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DLaMhv007667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 21:36:22 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:36:22 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 14:36:21 -0700
Subject: [PATCH] EDAC: layerscape: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFRma2YC/x3MwQrCMAyA4VcZORvo2jrBVxEPWZu5gK2SzDEYe
 3erx+/w/zsYq7DBtdtBeRWTV23oTx2kmeqDUXIzeOejG/qAJSNpGSJmlZXVkDMl9BNFH0J0+XK
 G1r6VJ9n+39u9eSRjHJVqmn+3p9TPhoVsYYXj+AK0GddVhgAAAA==
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James
 Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qx5vZ_mOmP87_TktJgIINlt4i4zrSx3W
X-Proofpoint-ORIG-GUID: qx5vZ_mOmP87_TktJgIINlt4i4zrSx3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=989 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130155

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/edac/layerscape_edac.c | 1 +
 1 file changed, 1 insertion(+)

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

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-edac-2fa423340d75


