Return-Path: <linux-edac+bounces-1784-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9F9699E1
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 12:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38652836DD
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CC19F42C;
	Tue,  3 Sep 2024 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cw8OPcyk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14045003;
	Tue,  3 Sep 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358593; cv=none; b=CKJU5opy6sXpZhatCrOiIHim/gWJUcc6czYJQhCiVmp4KwRK/Eg47FlpUFfyFSa3KLItjBxG9defHfObZnDvt1sv/sYSr50pnytKdNVEXJsTlNQmyHmkSrC1YCQkJE9oRI4NMHBGaWEWMHrtl7RD0WjP63EBHUrHvZjriLrpRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358593; c=relaxed/simple;
	bh=fl2RERz3XnvxlVkwwdHuXu69WgkZQGwQd65O2iqDXuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFSViO5sIxaJT4rfM/AYRVdRlo/BRvMap5+f7Ss6Y11ZypJv7Zw8HhPIb94RrWJdT5wG0zfDHW3fq2OxLZQuJL5h514+ZFtpR4E/5UfRDYNhBHwpFAtfZPaZJk0eF7koIwU/fqU6KLpnp+kHUUqQnZZ4tq+2996yZ0uW6dNqcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cw8OPcyk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4831LRvo000810;
	Tue, 3 Sep 2024 10:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Rt4e0Wp1JpQKmeXpaLaZ+s
	Dh0ev21DQIiB3rskjn1lw=; b=Cw8OPcyklQ5SMVY1mbmcj47M9zcvCjuOT2T5uJ
	Hkzhyx1SDv5RkhviFEi/jhO7OhRU1aY7yQGo4tT10K7KP2YY6ykPaSvBVPVhR0jS
	Qoe9JIiWNn2tpRg4/zWkbDZRDBU/WFrQxASfRYrjW4BKWSwOsI0j/sEGiRudm/GE
	SmhuELI63CPdH3RbkQvOnBp15W9jKyQSKQWX/v/tjtwpVphPP6bn9BrRrWPX0sw6
	eWc6vRytF9yRoUhgfFlhaJOowZgZUkeW+gJcvQNHISEn1dG6fDbWhhjXpPf3XKmw
	ZZYRM6BB89X6dITFfUc5cCPdpJcUgRjSPeVeJ3sL4+QV3B9g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe14ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 10:16:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483AGG85022358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 10:16:16 GMT
Received: from hu-rjendra-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 03:16:12 -0700
From: Rajendra Nayak <quic_rjendra@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2] EDAC/qcom: Make irq configuration optional
Date: Tue, 3 Sep 2024 15:45:10 +0530
Message-ID: <20240903101510.3452734-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jHzg5ZI-_ssh7s8y1HKWknH57sppkpVF
X-Proofpoint-ORIG-GUID: jHzg5ZI-_ssh7s8y1HKWknH57sppkpVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409030082

On most modern qualcomm SoCs, the configuration necessary to enable the
Tag/Data RAM related irqs being propagated to the SoC irq controller is
already done in firmware (in DSF or 'DDR System Firmware')

On some like the x1e80100, these registers aren't even accesible to the
kernel causing a crash when edac device is probed.

Hence, make the irq configuration optional in the driver and mark x1e80100
as the SoC on which this should be avoided.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Reported-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
v2: 
Minor typo fixed in changelog

 drivers/edac/qcom_edac.c           | 8 +++++---
 drivers/soc/qcom/llcc-qcom.c       | 3 +++
 include/linux/soc/qcom/llcc-qcom.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index d3cd4cc54ace..96611ca09ac5 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -342,9 +342,11 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	int ecc_irq;
 	int rc;
 
-	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
-	if (rc)
-		return rc;
+	if (!llcc_driv_data->ecc_irq_configured) {
+		rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
+		if (rc)
+			return rc;
+	}
 
 	/* Allocate edac control info */
 	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 8fa4ffd3a9b5..b1c0ae9991d6 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -139,6 +139,7 @@ struct qcom_llcc_config {
 	int size;
 	bool need_llcc_cfg;
 	bool no_edac;
+	bool irq_configured;
 };
 
 struct qcom_sct_config {
@@ -718,6 +719,7 @@ static const struct qcom_llcc_config x1e80100_cfg[] = {
 		.need_llcc_cfg	= true,
 		.reg_offset	= llcc_v2_1_reg_offset,
 		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+		.irq_configured = true,
 	},
 };
 
@@ -1345,6 +1347,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	drv_data->cfg = llcc_cfg;
 	drv_data->cfg_size = sz;
 	drv_data->edac_reg_offset = cfg->edac_reg_offset;
+	drv_data->ecc_irq_configured = cfg->irq_configured;
 	mutex_init(&drv_data->lock);
 	platform_set_drvdata(pdev, drv_data);
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 9e9f528b1370..acad1f4cf854 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
  * @num_banks: Number of llcc banks
  * @bitmap: Bit map to track the active slice ids
  * @ecc_irq: interrupt for llcc cache error detection and reporting
+ * @ecc_irq_configured: 'True' if firmware has already configured the irq propagation
  * @version: Indicates the LLCC version
  */
 struct llcc_drv_data {
@@ -139,6 +140,7 @@ struct llcc_drv_data {
 	u32 num_banks;
 	unsigned long *bitmap;
 	int ecc_irq;
+	bool ecc_irq_configured;
 	u32 version;
 };
 
-- 
2.34.1


