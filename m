Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F73B856C
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhF3Ox3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:29 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:40513
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235688AbhF3OxW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neCp70TAPGF4Wiot4KgD9woBccoFWph4+jEHxVzdiViM9221OwDY2bE5KQBrRCtfD5v5yb2kEoclpiEvXGYGTl59Uj7hrxWRB+PcFH5KrheoKcT22DaC3s4VhjK6LjMCYuwFumQQRz8Fqq+/SUJAbOKSMHttPOkf2XC9LlVnjxej12NZ0ZY98zHCRDR/ZsXxmjQpv9EO6k+vAPF1MdkgMGY/zfzsFxFnfvdJkWfrkradkypNGEpwXBLtBt/7qVl4dZbCxIw2o+WJMtDhWwy67TndBLPtymhLMa4PXSdY+X/m4SJlk+GGHJqno+9YSt97mECgyYexEeTv3QoYCU6gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya7cxcbzDm2Lf7APMLwWV7LvJxDpOFK9iM5sthOz9Vc=;
 b=aAKHBA05R/+LDblmxkCnedM9z4gPse9hjT5zO9PbnnE/mNAFPUJ7ON1GsGOibTlmn8q5mhMIF0/wzP9rmeye/FoOommRS27Wk7XXK7HheAeZB52KZLP3CIpcWeikU7F6mIfhahmetj+be9MEx/232zVVQPFUyLKnh1nlCfD5JvxoNV8hWRIXX+jqH9vZxtH4I7sWnuVVya1cWshFsE5wxyG/KDpCD2dyMq7Pr56Fm39hOAfuCbo+ohytLIsazIQqIUksDqKygjLunvNW+/USZa+tFkEKHPBgxyKuT0pLmWGJqk11/E6mRNjlmRSmp01kJ6SxjAr1p+J3KdZJYCGCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya7cxcbzDm2Lf7APMLwWV7LvJxDpOFK9iM5sthOz9Vc=;
 b=ekv1W3MqO3cKLQNwtsxeKzc9R87pS6mufv0gP8wZFTK/2292bvHfNMXMK1+nsx644GpzwtYdgKBRt8BGaswygY7e4YZm0JdBHZJeoB6ESGwwaSvENWhOzEba1rF4BZXskZmBe5Qye+qGR2Hdt5j3vsogZnG+UFChAfBIYa3ETKE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:50:52 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:50:52 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 3/7] EDAC/mc: Add new HBM2 memory type
Date:   Wed, 30 Jun 2021 20:58:24 +0530
Message-Id: <20210630152828.162659-4-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275ddce6-f39e-473a-c162-08d93bd67509
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB504568EFA94EA9EC087F7000E8019@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kvxidDwKsgR31EOx5qHoonU/UvIMtVdiys6NnijUvPG/4G9wJI/OP5wtP3U2jTDX1VV236OQ9+rneoU8l3sKq55FKrmxNX4WskKLJGITuIDRbwheKx93yTSdt5/D6h62nTq8pRn512BTEU5ml9gNktk3iEimdbM3Hjjq71pJYHEItiE40JFWho7RukPf2RpSv8I2EngeDHBGiRPMoGRAe9PICkjHwsvA8C46NdOzn/S5pg5gB8RFlXfIh6fGek9wL05W7UEuzJH3Ucf33CU3KPoGYWjmzqw4Amy6jXNNBbCuifLFDccd9gyV+jGFD0S1r+bfpJjQlAAqbbjPGWdEuDJSlvwWEMSS50SbLAXBHla6Grmko5q2uX5yNS6TOx2ZF2ULB6iUnGxVA9ein4gG679/wzzfZDzpyjlk7CX7762tkPBAra5k4RlBN7ugnO7ZbsvYu3+HxeTGo6BcHCdSJYj5hC7V10Np3LGwzLVKHvVo+3UG7pCgC8Kb5AW74Q9LfQomzcOfxBgJlV3p/ukC9UtHsZ925koPU5q1C7ZNh+zK/O3rsDFzmh8QC4F/U0LadC0cK5lrDYC8iHr0LxxCzInTgitOR7oXn2X/YIKEh+ZclID/JyYTFQ3r9yO+8uduG7E8CWup+TL4YzsdK9Eb+bBTWxDeFnlyjVKDlNOpVTtf7oU9+ZBy3AG5/A1ceFle/0W653yJuS7b6z3XfaXFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(36756003)(478600001)(83380400001)(6666004)(52116002)(26005)(7696005)(2906002)(6486002)(4326008)(66476007)(2616005)(956004)(8676002)(16526019)(186003)(5660300002)(66946007)(66556008)(38100700002)(38350700002)(316002)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xjJM6wsX+ExIaZ943k+LMUNgoKX7lhoFSaGEXX7/EKNbe07dx4tJPGDLoYvA?=
 =?us-ascii?Q?x6D+9gwALX+/R5NV9rzzfCu47yrMViXPHcZfYWPh/fREIenskE3BUbccYhwR?=
 =?us-ascii?Q?DC+j+Vgg3iXgYiAQpzBjUDkoQF1cJlWmOj1tgmgT+8uLrUfv+9j3lFFJHvz8?=
 =?us-ascii?Q?8aoAvmCCgHW7AqzhMx2zxkZ2AqgOezNZZ3nHcYZY6KBSLiol7HdZdSY2t3W/?=
 =?us-ascii?Q?ntdv2O8eG2r/shZwWvv0PPTIfzxVqcjHe78v2G7Lf5Vr4YWQDHoFRFLb1cjm?=
 =?us-ascii?Q?DVu+lgCWxK2ccHY2x/a54XELM+IsIr9KH8mYpV4Py03pIcu/T8D9YVyESyOV?=
 =?us-ascii?Q?nlGF0apZayFRdoFRCGemP5n4JDJ4vpwpmhuB+oTbfomwRrtctYtvDGNS9hOA?=
 =?us-ascii?Q?GblYOtN0N6vTl4lzzVyXpvzK2hUwAbZBm5DDsMbPevM59azr+9en4KUKv97i?=
 =?us-ascii?Q?NbRzjeOzIaZLQUYCQOTxmusP6FTDe1NEFaOSfY+vsziqIq7EDxrmlj5I3exh?=
 =?us-ascii?Q?x92n2ejzAr1j2pxztfy4A9y1J0EV2u4cwmKI7aX52H4QFkBi+b8RS/te/RIz?=
 =?us-ascii?Q?91XGy0kFYvcVGxxM4465o86Q4VCfNLQQTN6QoIcDT9CxdN/TNIBxspEqCSOY?=
 =?us-ascii?Q?Rw8MuWfrQqv3hueOK8ysBxmjjCOFru5AB08+qXDnsrTkJNDxUEvkvbTECoSl?=
 =?us-ascii?Q?+J7A4jNAcqg/Kdsd8u+cHi4ZX98jm0VuwfyaoR4prrEn8YXul1rBQMXTKCbA?=
 =?us-ascii?Q?KjGhFnsZZQc4DhW3F/gHqNVmeFcEYsDwv2TLRyOMGVfwCdUv7MoLWOERWtI9?=
 =?us-ascii?Q?QBYuBqkIU4aTxoISZ92rRYOOp/3BCfMD3HtjxD6PRDQVpdZuYm0iRsbyvWmB?=
 =?us-ascii?Q?vYjg1qtJ549kGQeFgLJhHhxbFBRE/AhDbQzWmu9ATpzkmSG2xKzqAZeUwSej?=
 =?us-ascii?Q?lGPotuNIzuaDPSyb08ydgdRq0I42pQTOBeFsfNI17Q5YxM6uH0VwWJ+mTihv?=
 =?us-ascii?Q?F9zXo8H8KVppLnmt3Jsu0kAMtMHSSdMaT7XrBwN5eLCOilRWbnURAyXvAgib?=
 =?us-ascii?Q?+MUSkR+O2caqd4HTVB7jKeS5VQ7dga06UwMvCtsacMNmjwjnX4K8YZ9WTWXI?=
 =?us-ascii?Q?tPNVPTwCq1cGlM8gF/8gFkBnDgP9PKMBgbRHVvMoDOLEgBmfC0SINxVDOyOD?=
 =?us-ascii?Q?wcSZHqD99xwx8SofEriDoXIjUJQCLyVtr+qGEp+Ofne9PdL4F8SIB7N5DwtM?=
 =?us-ascii?Q?Mp3okikknXsKAyPcgPc79uD91qUGyjqqQ1d3qWJNqI9DaeOKdr21t4n4l4BV?=
 =?us-ascii?Q?6sV66gjQNkFTEjJHSTGTn9XH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ddce6-f39e-473a-c162-08d93bd67509
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:50:52.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqJMcqXoGJGtdgBIHmo76Pim+U1x/9lvetOnU73yx1DZJlnqA4YDRzVddPW6Q6NJf+cg72qPm5clbL3mWAR44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a new entry to 'enum mem_type' and a new string to 'edac_mem_types[]'
for HBM2 (High Bandwidth Memory Gen 2) new memory type.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 drivers/edac/edac_mc.c | 1 +
 include/linux/edac.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..2c5975674723 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -166,6 +166,7 @@ const char * const edac_mem_types[] = {
 	[MEM_DDR5]	= "Unbuffered-DDR5",
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 	[MEM_WIO2]	= "Wide-IO-2",
+	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 76d3562d3006..4207d06996a4 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -184,6 +184,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_DDR5:		Unbuffered DDR5 RAM
  * @MEM_NVDIMM:		Non-volatile RAM
  * @MEM_WIO2:		Wide I/O 2.
+ * @MEM_HBM2:		High bandwidth Memory Gen 2.
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -212,6 +213,7 @@ enum mem_type {
 	MEM_DDR5,
 	MEM_NVDIMM,
 	MEM_WIO2,
+	MEM_HBM2,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -239,6 +241,7 @@ enum mem_type {
 #define MEM_FLAG_DDR5           BIT(MEM_DDR5)
 #define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
+#define MEM_FLAG_HBM2		BIT(MEM_HBM2)
 
 /**
  * enum edac_type - Error Detection and Correction capabilities and mode
-- 
2.25.1

