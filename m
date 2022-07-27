Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CD583306
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiG0TJF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiG0TIs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 15:08:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD416249A;
        Wed, 27 Jul 2022 11:47:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RI7CSV025629;
        Wed, 27 Jul 2022 18:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=igywS/mDqZY8hNgIZanoPLwEhl7onPXWh2O+Pnrs910=;
 b=HKnLtDklal6E0ElLzg6T0j04dT2bGTNzx2quak1meediaLAN45zOYeZd6Ms3qX2O6yvU
 YxeOx6vZewWd1K9mwWATWtl2gCNi9bM39+rXnrxOQZp/QhIyRkTeblYSb+NqA0gjED1+
 Uy8t8S3POr5TdoC/8cauUwoZ8oraPO1uwVMAGX87nqI1IkJIXcXKFTOFqIFGzSAK2ACf
 zhV6xIUwGQI0/8KzGes0yWTjXj+YTAcep5voWptrgzxh9vHxfEoxJu+d8lbDCWQ3EnGN
 hoy7eQ3ldHyJpo2mQPn1fGh9ccvvPPUyIPPlgacsZM9jIQmF8H1SZ7S+B7ToJ9p+a5z8 aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940taeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 18:46:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RH6MWK023015;
        Wed, 27 Jul 2022 18:46:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5ywn36j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 18:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+C6xSKbg98lsK23Umb2Ym/08u4X85S7Yat17k41izhlqcRrQiyrMCa8PQ3olxRopqGUL5clNV/pRT3z2+RoXLWvtU7rfqtU06bP494DKbFzqb/6ikYnbmMySC3ULDhN1XQmBTK91nqZcV0RO1ApE0KzHYTi+SjxS94Ddlbeanp5cieiFrksnLpHeb3LFw24V8SG8gyJb8JdLAIPb7WYi6uzAwTlg94wTMlpiujH2hEBi92U6rEZiLIrQ/lnX5N+RJNHOY/bg4bNBD/2xALA+X/vIHuBfeJB10VVo6oET9SauRM5k/h+ForHKH+acQ/bIFfUByVA7bSQBmrX1nEuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igywS/mDqZY8hNgIZanoPLwEhl7onPXWh2O+Pnrs910=;
 b=UmYXB+OrqqbJ8YVjlLeHyx7BXSPeIDpMfTn6ZtlzYzPzPWsurrGoA8WbHyuhLTxYa21LstnXbBlDLi0ysarNL33yuiuXgU1BXm5nnJAPXyF6LanimZBg4mEVBcOaobiaZuyGeg7Ik9TCDtQpwKBwr5+k/qg9AKdjy1u8++DW0zV58VKyZ2y9TqgIK3AoDVjIM9qwGgDcthmVEGr8+ElaXEvx7Lcij8oVaGEwlpK/xDsRiTDH5EVNmBJVoU+/8dplSF/PgPnx7g25WWZ6oHLjjx0G84GKjJegtoxaG8OfsBcjx23Y7XbmtF0s0OwHumFid0vo3E6UKDynMkLR51S4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igywS/mDqZY8hNgIZanoPLwEhl7onPXWh2O+Pnrs910=;
 b=ux0EQHjYvGUTslZDnx/a8EST4kusG6hw7hwtjBxlNAXKi3Y3z5LSfOXvqP3UH1dxoMTZZSDCWs0FYmQiDfKaQIf7EqL6wDqAvkmuA5qD/h//T2EU7/1vPC5SyYCWw560bUUhNmSsPeCT68D3WqlKr0c+6/3N84KNQKB6A6hH1LA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN2PR10MB3423.namprd10.prod.outlook.com (2603:10b6:208:130::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 18:46:54 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 18:46:54 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v4] x86/mce: retrieve poison range from hardware
Date:   Wed, 27 Jul 2022 12:46:44 -0600
Message-Id: <20220727184644.2685405-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ac4834-3c81-4449-8b9c-08da70006038
X-MS-TrafficTypeDiagnostic: MN2PR10MB3423:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWUx2nEl0LSXryhaBbChPJJ/UNOMlOizIci+5angNLMUIXTf5NKnEhS0mjsqn35fDd+l9/Pz4T1lwC85KvraKOdbFCGQnjKvR5SnLAaTWWp5/pLZbw+2h1oy8cuVKOt6bLhceuFoc0r7+NFjnBOreX1bv4R/lRPf+QgDpE1BFZ99CVtbQbC2iHD1ojWcaAy6kbMnqWh/T1zDoJP+26YVj1iUo6f4dTl6Ftvs3ORSBKvsfXRL6K0edyfoaFu8toFD6LiGJfeZXIbuTL4+XVqFI/qEYl+GB/rmiSBlk6k8gaqUsB6g3Dp9i0mfV9zsyv3g1oT41dMiHDu9kn8wszcFYAN5qMuzW+pCeZqsoZcdX6jsw2+zIlvUmFdpS7T8zJL80G3Wt/9lLRUYVX1tSG1BvaEZDrBZq5Qlxa7IBzvZouH+Snhc9UaqvrdJjkeCLi1HuaMR/rtcYJfN4pg7GF6hRxrGyx2dR6RC+0EW3vJkzuSo7ZGzHftDXgiDGieg4tW514Ey0+zVuq53tW9elhcpXed2zfMc19druUEiyKhHZ3nEVIWwIKyIwztnFWSAw5+LpoUhG6HZq6Efm4JkMMroD4M8H1o+VS8kGWE0opnT/N4NSFTA3Bkj4sh3gP8JbYCHrm/ZIjSR8nHVVEf0mkthPAIBm5bLOPsOgVdXqgxvoBzJRrWXI0LMbTCSPRktf5/IcNlXm1w2WfdyXwqVPCnBAhzYMgD0/kFHijQbVQVDqGzhhITiLU36Zfs5QMo1a4aNSrhGNwCDD4+3AkqKnJZOndLxM/oOgOsIS4++2KM5zJgNXK/2ja1JIeNbCNwPcUGs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(346002)(376002)(396003)(66476007)(921005)(6512007)(38100700002)(66946007)(6666004)(52116002)(8676002)(66556008)(6506007)(41300700001)(2906002)(5660300002)(966005)(7416002)(44832011)(6486002)(478600001)(186003)(86362001)(83380400001)(8936002)(2616005)(1076003)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yzLETFoEvpZMJW0rhTDNXaXt+QOQG+4jVSEwwzoyB/9wxEu7S3qgLrQ4REA?=
 =?us-ascii?Q?A+WIp8oj47rheVxbqAQoX8duQwC2a5+z/Fn2KdLD5HZoRWZkwdK5t1Kc8dua?=
 =?us-ascii?Q?wpOV36MZeuLGX3A3j6oa/swxV/lO69jTfNhHrWiIEk6ccD/99I1bXc0qd2wf?=
 =?us-ascii?Q?hHa2LjUotFaQe7lYly9gP4hIq5/NQw2+vBsoYRpoQKdfW/ggDIUfsWuFyILV?=
 =?us-ascii?Q?zn/Yk1S1rDdlAU+OjIvy8gX/Csge5HMRsnKNLJcG/BrI8Jh4D2TbiMgrswZ0?=
 =?us-ascii?Q?p6ez0j/jnrua+abQxyksyGUwWrNgR0oUg3KP8fKI0IEabyheQ0w5XYdnQHFE?=
 =?us-ascii?Q?pAdYkRY8g/1NahZKqZ6YvTLur33z2Xu8m8JXWYkUHmWpYn/0TVy9QjqL3HWt?=
 =?us-ascii?Q?hAzEYaLK3J+WS5Y0D4TBUCtDwBxR8uhQEsaL9FgAM7erYQKRHXxuoA1Wnctz?=
 =?us-ascii?Q?GPv4lwIsdA7TFfjQsltURStlK/BhoLkEYOvnTShDKul8ZBqAjGvSFw0TgpJK?=
 =?us-ascii?Q?AFIB6RY33qzLwH6uL87MBqUc/Kysje6Cj4ZVML2quunC08OjOLRTBTrXphe9?=
 =?us-ascii?Q?uI//8USxUVh/4jsMOf5RjYALfuYj80m9zixStiQAJaeKjygzDHRvptJKj5rA?=
 =?us-ascii?Q?JiAHPNGFfa22QPkpXHMS7dG+8fqcQlk5O7TX5sYzrJ7Ero9BCf/TaM2piJ8g?=
 =?us-ascii?Q?aw07cvm/I4q1vTEZDZhmiuNd7ZF07XAMHHGxQwAUwE3Ho6x2NvumhkXmyqSC?=
 =?us-ascii?Q?N8iOOd379V1SHGzm2r1MfbrY4rWK9xcQVMACSU4RQjlmRxVFp5iknHF6UlUV?=
 =?us-ascii?Q?3qCEt2KMqYWmoMWp5iZv4dZh6GKRsWaxW8Zkz/QgEuj6rNft0PK6z4NJPSJ0?=
 =?us-ascii?Q?6eDXqFTf6EpW/9srcp4+N7Hp1DFyQ5gURPq7vHbZVoZb2m0IO3CYjxP/SQaq?=
 =?us-ascii?Q?8AgL0IzFmhjL4PesikTSUyHCpC+NqdTb5qDRZ4nyboyusZaws+mk+ry9D4M9?=
 =?us-ascii?Q?avOB0rv64ZAYPGx0djcw7X8YK6KjhcF7QPyAVApPqUPrlzeu3Ym29yTYxdd3?=
 =?us-ascii?Q?hY5XaAxnRfNAkHMuIzCiXa8sWqRXB4XtzjBLA2UTXr/rRi3k7vJW2H2qOkvI?=
 =?us-ascii?Q?3g0iJB0M15TKmoGVu9KxFjLEg2SBP2zIbxKu10Cl04tLkOJFjkdnQKOCxnYS?=
 =?us-ascii?Q?FtJtDBPRGCFhTa2sUywATI3TVlEjLAafCLuwX4+xehjJSnuBFUCjd3LU6iQC?=
 =?us-ascii?Q?tGqKhlQRFXDoqcjAs06CPvTixmPqwwzwDLnyjt4aQPR6L0xUDAr//5RWPicl?=
 =?us-ascii?Q?6z5PHHPOP62ywz+AK+vXfd5liTpxnpVvd6rhC0cc0hMAlcBubt4qlvmUrEE8?=
 =?us-ascii?Q?rJU1RqyVvsZhDN7n4eBvi2N9DYD4G7lGhYpooMnCRoNaPo1/kTg94qvVS9PH?=
 =?us-ascii?Q?zE9C6t9+oODkATb7vFrgIEcLuW9IKllfc36cMVvZi2ZI5mbKNRVoMxVJoUPt?=
 =?us-ascii?Q?Yje2a/xzQetcBTymS2YDaGMmw6jNBcnlqM1BdIF8Bg5Adn5j2u8lLEyx+vMs?=
 =?us-ascii?Q?PtUcFgblBkU0eDb8Kz8BZefaEVXTTefL+T6IupSNqqUxMsKI8WoQszhkucnX?=
 =?us-ascii?Q?yqdGyoQbz0a4HuOSfLHe1Yw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ac4834-3c81-4449-8b9c-08da70006038
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 18:46:54.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDZ9cInUDFlQOzoRyQiqMalbCt7xJcZEvSvTCUCPnYc7jJWzGKW7sbhYgPlMc0Ww3GfaAiU71y5zCbPAV/kjrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270080
X-Proofpoint-GUID: 2m0Km5-oD6rOswvGJP78xdVmCGjBbji8
X-Proofpoint-ORIG-GUID: 2m0Km5-oD6rOswvGJP78xdVmCGjBbji8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
poison granularity") that changed nfit_handle_mce() callback to report
badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
2 back-to-back poisons and the driver ends up logging 8 badblocks,
because 0x1000 bytes is 8 512-byte.

Dan Williams noticed that apei_mce_report_mem_error() hardcode
the LSB field to PAGE_SHIFT instead of consulting the input
struct cper_sec_mem_err record.  So change to rely on hardware whenever
support is available.

Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 717192915f28..26d63818b2de 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,15 +29,27 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int grain = PAGE_SHIFT;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
+	/*
+	 * Even if the ->validation_bits are set for address mask,
+	 * to be extra safe, check and reject an error radius '0',
+	 * and fallback to the default page size.
+	 */
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
+		grain = ~mem_err->physical_addr_mask + 1;
+		if (grain == 1)
+			grain = PAGE_SHIFT;
+	}
+
 	mce_setup(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | grain;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
-- 
2.18.4

