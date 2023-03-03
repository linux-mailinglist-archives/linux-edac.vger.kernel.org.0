Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236816A979F
	for <lists+linux-edac@lfdr.de>; Fri,  3 Mar 2023 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCCMyx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Mar 2023 07:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCCMyv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Mar 2023 07:54:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4629427;
        Fri,  3 Mar 2023 04:54:50 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323BrNl3008290;
        Fri, 3 Mar 2023 12:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZKTCyGsWHFxInCFpgATZ0Seloa4K6uzTqBa0xx3tuE8=;
 b=UfBTcy+caITy5ipBs6WwKhAk8pQr20FJQiMqB5V9Yq83fkwxUq1k2xegGmob/u3GYTPz
 daQ8l1g09uqDkfWIvD+ndCyhfK0ZitXe9FEXWUS5V2NKL2XwoCViEyKoXvDU3pUX3Rha
 UTdWVgAQV5eQnjs38PWo9NJRtCDQz0tLEyCZ7iVlFfnlMXnsZbEyCCPR4PWTbmj4UZTP
 tZcibcFQOxrklRYZEolV6dgGUYCqLxdoN7a4Lh3XVfNkZ/zJTqw+3cyPlz3rNH59JSAt
 yt74ciiB1JKpXEX2VQp4I0j17N4QMcWWcVr7F+aBAbo47Z47tVTUyCr/9XkxSHK643t6 NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3dfrgq2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 12:54:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323Cse80025537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 12:54:40 GMT
Received: from hu-kamasrin-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 04:54:36 -0800
From:   Kamati Srinivas <quic_kamasrin@quicinc.com>
To:     <james.morse@arm.com>, <rric@kernel.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_stummala@quicinc.com>,
        Kamati Srinivas <quic_kamasrin@quicinc.com>
Subject: [PATCH 1/2] edac: Modify sysfs enabled values log_ue, log_ce to bool
Date:   Fri, 3 Mar 2023 18:24:07 +0530
Message-ID: <20230303125408.26971-2-quic_kamasrin@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230303125408.26971-1-quic_kamasrin@quicinc.com>
References: <20230303125408.26971-1-quic_kamasrin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VQaoqbY39XhK0PH8vypjL8WTLtUOV8AP
X-Proofpoint-ORIG-GUID: VQaoqbY39XhK0PH8vypjL8WTLtUOV8AP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use kstrtobool() since simple_strtoul() is deprecated.
Also change edac_device_get_log_ue/ce return type from int to bool.

Signed-off-by: Kamati Srinivas <quic_kamasrin@quicinc.com>
---
 drivers/edac/edac_device.c       |  4 ++--
 drivers/edac/edac_device.h       |  4 ++--
 drivers/edac/edac_device_sysfs.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 8c4d947fb848..ddfa094d0f3a 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -539,12 +539,12 @@ struct edac_device_ctl_info *edac_device_del_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(edac_device_del_device);
 
-static inline int edac_device_get_log_ce(struct edac_device_ctl_info *edac_dev)
+static inline bool edac_device_get_log_ce(struct edac_device_ctl_info *edac_dev)
 {
 	return edac_dev->log_ce;
 }
 
-static inline int edac_device_get_log_ue(struct edac_device_ctl_info *edac_dev)
+static inline bool edac_device_get_log_ue(struct edac_device_ctl_info *edac_dev)
 {
 	return edac_dev->log_ue;
 }
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index c4c0e0bdce14..e1645332eaa2 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -157,8 +157,8 @@ struct edac_device_ctl_info {
 	int dev_idx;
 
 	/* Per instance controls for this edac_device */
-	int log_ue;		/* boolean for logging UEs */
-	int log_ce;		/* boolean for logging CEs */
+	bool log_ue;		/* boolean for logging UEs */
+	bool log_ce;		/* boolean for logging CEs */
 	int panic_on_ue;	/* boolean for panic'ing on an UE */
 	unsigned poll_msec;	/* number of milliseconds to poll interval */
 	unsigned long delay;	/* number of jiffies for poll_msec */
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..51a3a90d7404 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -39,10 +39,10 @@ static ssize_t edac_device_ctl_log_ue_store(struct edac_device_ctl_info
 					*ctl_info, const char *data,
 					size_t count)
 {
-	/* if parameter is zero, turn off flag, if non-zero turn on flag */
-	ctl_info->log_ue = (simple_strtoul(data, NULL, 0) != 0);
+	int ret;
 
-	return count;
+	ret = kstrtobool(data, &ctl_info->log_ue);
+	return ret ? ret : count;
 }
 
 /* 'log_ce' */
@@ -56,10 +56,10 @@ static ssize_t edac_device_ctl_log_ce_store(struct edac_device_ctl_info
 					*ctl_info, const char *data,
 					size_t count)
 {
-	/* if parameter is zero, turn off flag, if non-zero turn on flag */
-	ctl_info->log_ce = (simple_strtoul(data, NULL, 0) != 0);
+	int ret;
 
-	return count;
+	ret = kstrtobool(data, &ctl_info->log_ce);
+	return ret ? ret : count;
 }
 
 /* 'panic_on_ue' */
-- 
2.17.1

