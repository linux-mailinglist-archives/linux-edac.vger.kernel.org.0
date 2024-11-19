Return-Path: <linux-edac+bounces-2560-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4A9D206D
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 07:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C18281E11
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5F146599;
	Tue, 19 Nov 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nbQshS7c"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A597126BFA;
	Tue, 19 Nov 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998844; cv=none; b=tSO/THmrvoCxsGgxtZPrkHv97I4kyvLZYWjmXLRtCPMO8G1X0Ee1QLKCB6/RYOcgZ8i7suBV9Oo0uKja5NFY0Fkedc7EPoMkZN/yeyrkdCmGS4NVoBzxW+QFNLePx4mKRtF/ifaSToraMereU8AklL7hCTD/VZLJ1GboVoP1+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998844; c=relaxed/simple;
	bh=FCu92Z2SXLEv3tbgSd+eQqAn0++ZjN+ua4UyYOq1lkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O9LBl2ud2Dq3Pl9d1K9hX1LCr2xTbQOeaRLYNU+eL06/PYZAgzPPvIxTvJkWDRkUxRo60k4AvkFHJyCvM7CVx/bNL/xiAq6MIhmUIgJTaveq04n1YIm8VjBhDK0vcidpta31LZVJ4AA3SnpFgXGD94PqfhQqEWWEAC2ajGc5cEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nbQshS7c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGHDrc005889;
	Tue, 19 Nov 2024 06:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o78pLanuuvGwctM3Jgj6w3
	e8k9q3Yb0rr+L8lIUMoDI=; b=nbQshS7cpTDiHGHlWTQE/k8kdOnxtVXX+EMef7
	tcE3ZNALycIY1W/CysLu1hsGQp2bfXPuCYhKrWOvifnzCm80kfRtSoLUaFLnlcQ8
	nnO3KuK9YMbUrtK8xt0rz7uwaqHbSkCpwrS/YXi+bGm1NYRV968+KFOcCqOVFLT2
	UMygAS7FZnFWD5iZ9vzxKXff7zY2fjpACe3enlSfdvkriGwg8DhLGtsuCOKWfw/r
	r5nRwUn1sDu8gOf5dnYqX05nrTrQ/j+aEbMAAvzdKw1OE6BcXb3wsI0iJf8chMfq
	R561awpg7mzbYb4AN5gaY6h+y0Vyi45LTOhuK3I9pKteB8oA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7sp0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:46:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ6kUYU019830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:46:30 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 22:46:26 -0800
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <andy.gross@linaro.org>, <vnkgutta@codeaurora.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH] qcom: llcc/edac: Correct interrupt enable register configuration
Date: Tue, 19 Nov 2024 12:16:08 +0530
Message-ID: <20241119064608.12326-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bf3Ya20YDV91Qfc6xDlv8zmpRjT1grFR
X-Proofpoint-ORIG-GUID: bf3Ya20YDV91Qfc6xDlv8zmpRjT1grFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=936 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190050

The previous implementation incorrectly configured the cmn_interrupt_2_enable
register for interrupt handling. Using cmn_interrupt_2_enable to configure Tag,
Data RAM ECC interrupts would lead to issues like double handling of the
interrupts (EL1 and EL3) as cmn_interrupt_2_enable is meant to be configured
for interrupts which needs to be handled by EL3.

EL1 LLCC EDAC driver needs to use cmn_interrupt_0_enable register to
configure Tag, Data RAM ECC interrupts instead of cmn_interrupt_2_enable.

Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/edac/qcom_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index a9a8ba067007..0fd7a777fe7d 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
@@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	if (ret)
 		return ret;

-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)
--
2.46.0


