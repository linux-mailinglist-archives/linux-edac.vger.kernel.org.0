Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB45874B5
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiHBAHF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 20:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiHBAHD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 20:07:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D402AE1;
        Mon,  1 Aug 2022 17:07:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NwuP2001708;
        Tue, 2 Aug 2022 00:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Ite1YGbOiaN18mXN6IyDhTd0LquhgWbVhYkulx2o5Bw=;
 b=xu6zj66kogdLZZeYPhuiMpIx6fsYuLMbz8/kDww8jf448Yq3/KOhRu2O28TmN14usg5y
 Ir8gkJzXX3VrOPJQPFZbelcb3KHLnLSTo04SLkwJN8RHipXBO+hj8qHoZ84RfK4/Ei4/
 alVaOvYEXaZOEAurJlXIVuYoWX9MiB/nkcjq4Cuh2VX+8yKww5NnIbJy5IWoqcK5rQ6b
 dC7rd4gq0qIAm8y+3Z0DDr4E6JJuCp9kvvc/+Gemc5Hu4WdS8Mvm04584mJBt5W9j1R5
 ZYOSiUbRsgzkClm4YTxdrlqHSicQzBTMcCGZQVZSTH6ghuAe0as/7wM0SM/F51QUbrlt NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6td85u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 00:06:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271LPjNG030864;
        Tue, 2 Aug 2022 00:06:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31srnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 00:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXCoGUsAdZgwvnbNpOF3nm/wozoh6/34y6Vb3yTZ6AxITmxtWVPWNrzhx715IKI9Ufy7WdfDEUraCLHboR2o5Z4KBvWHryJNnUWm6p2joNvcmeRA7dJtUuKGnV/+nrAVYCZJgt5wbXjLVYChjTMxyvX2OlVXDDAEJNSG84q+m7gqqTSQ5QqBzNEVSwrMcw+3EvjDEp+MdGgSs2Iy2JIe0xJ1F/PUxZg8nl3UVFyi4/Ud+WwZI61I/exUyXokOwGChObVKgFOJFdf1LLxlSm0I2sr9hiVmPw4ApvZISeR87thCm3RPaPCmUFdZNSe2rUmye2lGP1UDUR6anDToNd/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ite1YGbOiaN18mXN6IyDhTd0LquhgWbVhYkulx2o5Bw=;
 b=NoyPCpmwAY4USlVO14ewz4AaLrDTjd9a9CvyjzjSBMM+GRCgYiGmE5vtPmVfskuHUjG2lhfplG7lFUPfYIKqzsahLoC/iqM0AkJ0KXLnrytzLW5E22ZdPWDi43XykB/vfY24YLPKTdAJodz6jSTxjRogV2e/IGAkhmILMASOSLOKrMh6kNfXoI33DUYfKPkXmDIMGc61GH0/orFPXaWVN6wmlg+FSmpHLrOBLMRBvTBjiCqLoDf/2MyZ+BnEDAPesXDTY4Aq5tR9VW0uCfGSktS4OW4E1DJYEwHQZOsI23zpQvFjuNGIYebTNLytQS70SCoUxEiei5XLCh2rKd0cjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ite1YGbOiaN18mXN6IyDhTd0LquhgWbVhYkulx2o5Bw=;
 b=owZAo+bwzA6gXLm5hfyhk2ftvapOGWf2GSgWbwWYXXS8TtbK9qI2SkOHuy27idGO7L1GoJRd/zDPdnRMQSYDou0zuAAO6CXQJD+ut6KcupkZux/LSC58761K7PcOp2KPcYtb8Fh/4+bPz5YmQa+CvBgE8Mp3tpUMsRGjGvuJqis=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Tue, 2 Aug
 2022 00:06:32 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 00:06:30 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v6] x86/mce: retrieve poison range from hardware
Date:   Mon,  1 Aug 2022 18:06:14 -0600
Message-Id: <20220802000614.3769714-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4edb631d-102a-4f47-0340-08da741ad9cc
X-MS-TrafficTypeDiagnostic: PH0PR10MB4710:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dh0+k/+gUk9IsQ6QGqenSb5Igmf4OptNeYk+8b3CSWZ1sBRmY+0aUD2d6chs5O+mX6It/qfLUfWtEuCOEXYUhsQyc2u/X0VDs5VNwiIOuKOE5089Ainpkm13wJlqNeGn3ZWSh4Krua0GYm5nlNM9D91ULn0urRfsgizOUta9yO76l3tLgjvHyFUDH2J/zTmNooL63OPLJUCLf3AVmc5GTx7jTXDBxxiA2oGn2RPKPifexqw6B3HK5UuuSrppHZjiflkt+WlZsBDZQ9iL/HdEfiO9XERPxCtgBpXbQSf34Xfo42slNWXERlkxXCW9pVM6kE26NSEOkkZdr0X3Pf1AbmYYS8GvR/jXPNiqVxn2pCubvWfoDufWzmzOnrPFp5aB4AJUIGk0EGdrXJzrnIPvLmNSBjJB6Q7hExFDl6vAVn0OwThbyBPYZyAkH1ct1qpux3Yn8CjBJX7LlJpivnmIhMTuzRU/IWjGZa3+mfpg04WdSRJdYrmHdlPyvdk6VS+p0SBg8wMDkedblDTFYEB39Hv73KMC6Ss0WKH4An1dB1yvctfFO/ZaWmmLRLnNG1jkxaYg+rhrhciQLwtJHV97NbGFC7Ea5hZG/8YzCx9TriY9bX2CSk+7mBMyh7B7gRV89DogQvzKwJg2DRM9oQ64vwOsbCxfe6IBk1hcajpdKqfpSHoKpn8i8YA4G6h4mnnd/9MXgmgY1QeLp44huEyS6Q+cmw+6O8OuyyrLBlRU4xxcfaO4a714JfVa+97KbJ6hQb0tjkCwW97AprAsGTm6hZE/FrH45lyUIccYALomSysTnVEt3IKfPZSyikguqS8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(7416002)(8936002)(44832011)(83380400001)(966005)(5660300002)(478600001)(86362001)(6486002)(66556008)(6506007)(6666004)(6512007)(2906002)(52116002)(2616005)(66946007)(41300700001)(8676002)(921005)(186003)(316002)(1076003)(66476007)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cehHCe/m1G9L2N4JvXT2osGKPGX4P5poyokbFtWsGZLVhNAcRphS4NyxwMBs?=
 =?us-ascii?Q?GdhPEqC23drBiT7qk06rRm2aj4yjr9Ta3lv3Ue4RIx29dvjnPFTo5yw356q+?=
 =?us-ascii?Q?doRJAcBoAmsgkEyy1vnIKiqBPGx/OeZTBn3Sse0XWYhjvc0CLq5wB398DlfT?=
 =?us-ascii?Q?fTuyQlYSxF6jt2RfYNqQhjnQaX1EeBcVMrt8kocsFGqrNGELpRKKYnGLYytw?=
 =?us-ascii?Q?AzWT9J1/4h/bfeoi2IU+zvAcQkiNANnjByowroEwyn4JHom2DADhi1c5e9VI?=
 =?us-ascii?Q?3QlyrvVHH7YvpYWGtvQnPoMHHELYvSdRc9qmh1kNWE9eWf1NfE406o0mVzS8?=
 =?us-ascii?Q?mX0SN89569kwbBF04znSTtKh1mlNCXB2VtVyogmjcSKVzwRGhVcYAlr+inMu?=
 =?us-ascii?Q?CVrFzGSIH8LheLO35VkVWaeNj7RCjPhlXVC6LSxL/ITkaSnPoVz3iCmLnDrU?=
 =?us-ascii?Q?DWOhtU29UPDhCTIokySfB+FOmJ4VvG8GQ5MpXFX3Ol3Qf7yqYgo86JF0ay4v?=
 =?us-ascii?Q?ovVfvERyjeZvP7bK5xEFczmF4ug6yozdaWZxonsL+s/2/Ut8L6dF+qgnKCtj?=
 =?us-ascii?Q?N74F1BkNwHrXDghZPCECgotGA147+J/Pe+/c7nxAp+7tTCFsGq4DtZamZZxR?=
 =?us-ascii?Q?fxT6/efFbD92p6fxykNbtfsO9tJ536vnd7vohQlZILngSRWq440USRzxo9K3?=
 =?us-ascii?Q?kvoNtsMwsYAtaVKxrKcWD1NJN/y7lDEyCZaAkkwS6NyYP46fUGaZJOYr6hmn?=
 =?us-ascii?Q?+7ajFAkT8saBs1EUbvkpvF5PQcJkDet7RS4bvcVv8yzQmaH4zxNFqkhQB2JT?=
 =?us-ascii?Q?Vmo0tx1QTiEXgFr0912VyMhBlB++U5moB5d60zfpfgURzpXRNqc8Fb2ZR5Sc?=
 =?us-ascii?Q?zFGYTpYt7U2YDvIGiVNb//oY1mt5dJffbby7G2U/ZmUJsF/tX2s5uA+a+WqZ?=
 =?us-ascii?Q?9G+bIjzbIGXOCd8Y3yLaffTDL/Xdd/8ynyhbDEKY/oq+fhO/F3AqmqMl1DLi?=
 =?us-ascii?Q?fcaiOAvEWuN0TE7l1KqhpPWYf9CFEEwJIWif4aAFmoCaLy35uIRlgaC+vXEq?=
 =?us-ascii?Q?+oArElb9OK8FuzK+hclrkB6326QuBpitQ5NCYxrW2WXVIxwlQ2u8nF/kqKWw?=
 =?us-ascii?Q?JDcvafd0Jmle6zZgRB3hh3zJq7U6MNQ5vCB3c/jKQ1CQPphsB1S9Ixy6hSa8?=
 =?us-ascii?Q?xiLV3MrH8PgbC7DCShz8gS+lAAiDvFxdLYS1WjJk3GEF20n0oKMaJx5AJkXs?=
 =?us-ascii?Q?gv6P9O9Wap1Tmgnlr98q2frn4D0htVS9e4gfx0iSDXN5GJEBabYedYd8j9vi?=
 =?us-ascii?Q?k13Qa+lIERtrkIJWTErfOpwia95r6+I1d6PP/ZmQIqBOaqKBVIphl7AFgEc4?=
 =?us-ascii?Q?tP3QLyhb767yJMgfsKM1tabTz8KWkxIaUqhLLpPU+H9LMQFSNDbpWjqkJNn8?=
 =?us-ascii?Q?ieIBwt1PIVabp3d6tuip2Tvg3BjiGx3uS/73F3UkDcVf3eChzF6cO+uRjiFl?=
 =?us-ascii?Q?s15NlYbDUkolILNMT6DzO2YufDLoyeds3t88cXZFSCKgS57Z4y/dSPDtgP1F?=
 =?us-ascii?Q?SiOhHezKmavVCo6tarKR6/tJXl7v7l+9wzJsTt013kvrmsEwDB9nH/83p1Hu?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edb631d-102a-4f47-0340-08da741ad9cc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 00:06:29.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex+k6jWXLEV4ZA/7qb2D9ZJg+3225m6BEYFa9VSt6uMGqnmV4fi9Z4XonHLYdDn/0nx0HgWyHorJu2NcMnDbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010120
X-Proofpoint-GUID: M5P4pD0JM4dLa0y406u69z3r-FiwWN-m
X-Proofpoint-ORIG-GUID: M5P4pD0JM4dLa0y406u69z3r-FiwWN-m
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
index 717192915f28..e2439c7872ba 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,15 +29,27 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int lsb;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
+	/*
+	 * Even if the ->validation_bits are set for address mask,
+	 * to be extra safe, check and reject an error radius '0',
+	 * and fallback to the default page size.
+	 */
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
+		lsb = find_first_bit((const unsigned long *)
+			&mem_err->physical_addr_mask, PAGE_SHIFT);
+	else
+		lsb = PAGE_SHIFT;
+
 	mce_setup(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
-- 
2.18.4

