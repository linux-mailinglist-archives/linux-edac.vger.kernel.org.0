Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286876A97A2
	for <lists+linux-edac@lfdr.de>; Fri,  3 Mar 2023 13:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCCMy5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Mar 2023 07:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCCMyz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Mar 2023 07:54:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149123B64E;
        Fri,  3 Mar 2023 04:54:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323CftIr016609;
        Fri, 3 Mar 2023 12:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pdzEJHOffFOpO51eB4vzYdshxDMXYwyy8+Y2GPttXws=;
 b=VNp2mxmY7MwY+JEnqtJh7fJY1FvRBUWGr+8EYhaTSFaKPTCdL2Gf6o9xdXIaBMalOqbV
 I/I2SoTnVEIPsfgfj/Z3YU2Jq+mAhWHoYfDOBPdV56+0vLF4XRVFAk3mTby9WcdE8sjA
 5ZFFae4A9X2kiHouA0gOzVDIZ6S/18QCDTCfCXLFr1vGzRGJExGzSTa1iP/tAPG8Ygbd
 T2P+UdzOAsIvgArpeSnNrraoilcUTf6Z9duT0ZGFvLNRp8aRW3XoCQrvN1IhnIL9mULX
 6pxfpSYaMLYDKZ46jRAWwalnSTbIgSgHKZ9EcQtIaRPX6wSVVjR/q6jS5hRBQIWrmetg PQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3bry8yf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 12:54:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323Csj4G025565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 12:54:45 GMT
Received: from hu-kamasrin-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 04:54:42 -0800
From:   Kamati Srinivas <quic_kamasrin@quicinc.com>
To:     <james.morse@arm.com>, <rric@kernel.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_stummala@quicinc.com>,
        Kamati Srinivas <quic_kamasrin@quicinc.com>
Subject: [PATCH 2/2] edac: Add support to handle DE (Deferred Errors)
Date:   Fri, 3 Mar 2023 18:24:08 +0530
Message-ID: <20230303125408.26971-3-quic_kamasrin@quicinc.com>
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
X-Proofpoint-GUID: Ds1VqcCMVohYPB3XB_s2kPU65fNOvME_
X-Proofpoint-ORIG-GUID: Ds1VqcCMVohYPB3XB_s2kPU65fNOvME_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The EDAC subsystem doesn't handle DE (Deferred errors),
due to lack of support all DEs are treated either as
CEs (Corrected Errors) or UEs (Uncorrected Errors).
To solve this adding log, counter and associated sysfs
entries to allow EDAC driver to be configured to
handle DEs.

Signed-off-by: Kamati Srinivas <quic_kamasrin@quicinc.com>
---
 drivers/edac/edac_device.c       | 53 +++++++++++++++++++++++++++++++-
 drivers/edac/edac_device.h       | 30 ++++++++++++++++++
 drivers/edac/edac_device_sysfs.c | 38 +++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index ddfa094d0f3a..28c355d07304 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -131,9 +131,10 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 	dev_ctl->instances = dev_inst;
 	dev_ctl->pvt_info = pvt;
 
-	/* Default logging of CEs and UEs */
+	/* Default logging of CEs, UEs and DEs */
 	dev_ctl->log_ce = 1;
 	dev_ctl->log_ue = 1;
+	dev_ctl->log_de = 1;
 
 	/* Name of this edac device */
 	snprintf(dev_ctl->name,sizeof(dev_ctl->name),"%s",edac_device_name);
@@ -544,6 +545,11 @@ static inline bool edac_device_get_log_ce(struct edac_device_ctl_info *edac_dev)
 	return edac_dev->log_ce;
 }
 
+static inline bool edac_device_get_log_de(struct edac_device_ctl_info *edac_dev)
+{
+	return edac_dev->log_de;
+}
+
 static inline bool edac_device_get_log_ue(struct edac_device_ctl_info *edac_dev)
 {
 	return edac_dev->log_ue;
@@ -601,6 +607,51 @@ void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
 
+void edac_device_handle_de_count(struct edac_device_ctl_info *edac_dev,
+				 unsigned int count, int inst_nr, int block_nr,
+				 const char *msg)
+{
+	struct edac_device_instance *instance;
+	struct edac_device_block *block = NULL;
+
+	if (!count)
+		return;
+
+	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
+		edac_device_printk(edac_dev, KERN_ERR,
+				"INTERNAL ERROR: 'instance' out of range (%d >= %d)\n",
+				inst_nr,
+				edac_dev->nr_instances);
+		return;
+	}
+
+	instance = edac_dev->instances + inst_nr;
+
+	if ((block_nr >= instance->nr_blocks) || (block_nr < 0)) {
+		edac_device_printk(edac_dev, KERN_ERR,
+				"INTERNAL ERROR: instance %d 'block'out of range (%d >= %d)\n",
+				inst_nr, block_nr,
+				instance->nr_blocks);
+		return;
+	}
+
+	if (instance->nr_blocks > 0) {
+		block = instance->blocks + block_nr;
+		block->counters.de_count += count;
+	}
+
+	/* Propagate the count up the 'totals' tree */
+	instance->counters.de_count += count;
+	edac_dev->counters.de_count += count;
+
+	if (edac_device_get_log_de(edac_dev))
+		edac_device_printk(edac_dev, KERN_WARNING,
+				   "DE: %s instance: %s block: %s count: %d '%s'\n",
+				   edac_dev->ctl_name, instance->name,
+				   block ? block->name : "N/A", count, msg);
+}
+EXPORT_SYMBOL_GPL(edac_device_handle_de_count);
+
 void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
 				 unsigned int count, int inst_nr, int block_nr,
 				 const char *msg)
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index e1645332eaa2..883557bc0182 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -74,6 +74,7 @@
 struct edac_device_counter {
 	u32 ue_count;
 	u32 ce_count;
+	u32 de_count;
 };
 
 /* forward reference */
@@ -159,6 +160,7 @@ struct edac_device_ctl_info {
 	/* Per instance controls for this edac_device */
 	bool log_ue;		/* boolean for logging UEs */
 	bool log_ce;		/* boolean for logging CEs */
+	bool log_de;		/* boolean for logging DEs */
 	int panic_on_ue;	/* boolean for panic'ing on an UE */
 	unsigned poll_msec;	/* number of milliseconds to poll interval */
 	unsigned long delay;	/* number of jiffies for poll_msec */
@@ -298,6 +300,19 @@ void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
 				 unsigned int count, int inst_nr, int block_nr,
 				 const char *msg);
 
+/**
+ * Log Deferred errors.
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @inst_nr: number of the instance where the DE error happened
+ * @count: Number of errors to log.
+ * @block_nr: number of the block where the DE error happened
+ * @msg: message to be printed
+ */
+void edac_device_handle_de_count(struct edac_device_ctl_info *edac_dev,
+				unsigned int count, int inst_nr, int block_nr,
+				const char *msg);
+
 /**
  * Log uncorrectable errors.
  *
@@ -341,6 +356,21 @@ edac_device_handle_ue(struct edac_device_ctl_info *edac_dev, int inst_nr,
 	edac_device_handle_ue_count(edac_dev, 1, inst_nr, block_nr, msg);
 }
 
+/**
+ * edac_device_handle_de(): Log deferred error
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @inst_nr: number of the instance where the DE error happened
+ * @block_nr: number of the block where the DE error happened
+ * @msg: message to be printed
+ */
+static inline void
+edac_device_handle_de(struct edac_device_ctl_info *edac_dev, int inst_nr,
+			int block_nr, const char *msg)
+{
+	edac_device_handle_de_count(edac_dev, 1, inst_nr, block_nr, msg);
+}
+
 /**
  * edac_device_alloc_index: Allocate a unique device index number
  *
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 51a3a90d7404..76fc50ff8503 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -62,6 +62,23 @@ static ssize_t edac_device_ctl_log_ce_store(struct edac_device_ctl_info
 	return ret ? ret : count;
 }
 
+/* 'log_de' */
+static ssize_t edac_device_ctl_log_de_show(struct edac_device_ctl_info
+					*ctl_info, char *data)
+{
+	return sprintf(data, "%u\n", ctl_info->log_de);
+}
+
+static ssize_t edac_device_ctl_log_de_store(struct edac_device_ctl_info
+					*ctl_info, const char *data,
+					size_t count)
+{
+	int ret;
+
+	ret = kstrtobool(data, &ctl_info->log_de);
+	return ret ? ret : count;
+}
+
 /* 'panic_on_ue' */
 static ssize_t edac_device_ctl_panic_on_ue_show(struct edac_device_ctl_info
 						*ctl_info, char *data)
@@ -156,6 +173,8 @@ CTL_INFO_ATTR(log_ue, S_IRUGO | S_IWUSR,
 	edac_device_ctl_log_ue_show, edac_device_ctl_log_ue_store);
 CTL_INFO_ATTR(log_ce, S_IRUGO | S_IWUSR,
 	edac_device_ctl_log_ce_show, edac_device_ctl_log_ce_store);
+CTL_INFO_ATTR(log_de, S_IRUGO | S_IWUSR,
+	edac_device_ctl_log_de_show, edac_device_ctl_log_de_store);
 CTL_INFO_ATTR(panic_on_ue, S_IRUGO | S_IWUSR,
 	edac_device_ctl_panic_on_ue_show,
 	edac_device_ctl_panic_on_ue_store);
@@ -167,6 +186,7 @@ static struct ctl_info_attribute *device_ctrl_attr[] = {
 	&attr_ctl_info_panic_on_ue,
 	&attr_ctl_info_log_ue,
 	&attr_ctl_info_log_ce,
+	&attr_ctl_info_log_de,
 	&attr_ctl_info_poll_msec,
 	NULL,
 };
@@ -318,6 +338,12 @@ static ssize_t instance_ce_count_show(struct edac_device_instance *instance,
 	return sprintf(data, "%u\n", instance->counters.ce_count);
 }
 
+static ssize_t instance_de_count_show(struct edac_device_instance *instance,
+				char *data)
+{
+	return sprintf(data, "%u\n", instance->counters.de_count);
+}
+
 #define to_instance(k) container_of(k, struct edac_device_instance, kobj)
 #define to_instance_attr(a) container_of(a,struct instance_attribute,attr)
 
@@ -387,11 +413,13 @@ static struct instance_attribute attr_instance_##_name = {      \
  */
 INSTANCE_ATTR(ce_count, S_IRUGO, instance_ce_count_show, NULL);
 INSTANCE_ATTR(ue_count, S_IRUGO, instance_ue_count_show, NULL);
+INSTANCE_ATTR(de_count, S_IRUGO, instance_de_count_show, NULL);
 
 /* list of edac_dev 'instance' attributes */
 static struct instance_attribute *device_instance_attr[] = {
 	&attr_instance_ce_count,
 	&attr_instance_ue_count,
+	&attr_instance_de_count,
 	NULL,
 };
 
@@ -427,6 +455,14 @@ static ssize_t block_ce_count_show(struct kobject *kobj,
 	return sprintf(data, "%u\n", block->counters.ce_count);
 }
 
+static ssize_t block_de_count_show(struct kobject *kobj,
+					struct attribute *attr, char *data)
+{
+	struct edac_device_block *block = to_block(kobj);
+
+	return sprintf(data, "%u\n", block->counters.de_count);
+}
+
 /* DEVICE block kobject release() function */
 static void edac_device_ctrl_block_release(struct kobject *kobj)
 {
@@ -485,11 +521,13 @@ static struct edac_dev_sysfs_block_attribute attr_block_##_name = {	\
 
 BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show, NULL);
 BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show, NULL);
+BLOCK_ATTR(de_count, S_IRUGO, block_de_count_show, NULL);
 
 /* list of edac_dev 'block' attributes */
 static struct edac_dev_sysfs_block_attribute *device_block_attr[] = {
 	&attr_block_ce_count,
 	&attr_block_ue_count,
+	&attr_block_de_count,
 	NULL,
 };
 
-- 
2.17.1

