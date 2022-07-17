Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90035778E2
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGQXtW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 17 Jul 2022 19:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQXtV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 17 Jul 2022 19:49:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6FC10FF0;
        Sun, 17 Jul 2022 16:49:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26H94DXb023581;
        Sun, 17 Jul 2022 23:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=k2FgqLGux5x474BSt6NlIQFr6H33XXLTPiF6haA/4cU=;
 b=FSK622OASZx292QPaZcrLRfN1IKbSDjmkY6gDYrF2sc5yxF2KGa3pJ8GG0i1ihcfE9NY
 R6rQZ2owpB8TWniFB++mv3v3O/vEgFEDa/0bVpw8Q6MLE4isP069eZVy9tHrO6C0IlOV
 Cn+Tgx8zqZGopwcY4u/Etrq5rauAJGmvnjsAXrr8QESjEuMbL0lw7oNTWqDY+lfpQZJQ
 7eb5cuSXFLYshHXb+gGVgY6fuDEdzOx9rbEdn1ayv3do9SYOXFvIbjlg2kUSLii8yKKR
 FsKYXgKNIZ/6YGYqL3dsgNTZMxZlwVaEbBgcse5ouoi6VWgNSeTtN0sa7WI0/X93/RHt Uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs1vwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 23:48:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26HKTv4o004064;
        Sun, 17 Jul 2022 23:48:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3c74f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 23:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz6oEgzdHCnGFsAoD3S+Zyj869nC69o77sTpJ0llI87zoWoP7k5wI8t2BJvopa8aFIcJq7Zef5GPv4QsEL9IrQG4wdZ6SUdk/RkUedwesD4TZQJfR14kXuUrDXHdKbtZ92R3Bhd5xBGTABFubDQ/hV91L8me2cPK9QYsMh30LWDSptqiGQd2r8Lq0xbJxpifS6nvVw92q17m5cDF5ClJBI29BYGfiKpmppTcDVQ1IHxix5+Vn9LEJcbZtWe7l986JtqpJ2IW9FY9AGfDP/bloqlFbSqn/jaKpMFu3ahTOC+osfxbKPUNUhunuJcusqaxnPKzZ/+JbbRKTYyKSTCZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2FgqLGux5x474BSt6NlIQFr6H33XXLTPiF6haA/4cU=;
 b=KosxHMszDli5lLthVkKca27sFsZGOlUF2AffrkXqxR3QSYJkRYjKEdVAO1lWHdeXInRreyFoIRewXtPcY//IeHemLRHYms2XH2hYdXfoix7ILXv+T+I2QYcirsaDhXfxEORAaRrCV296BtjZTW9vhJ/jCY41qQEvvKtaSF9b0Nn1uxZN+M30wNLZbryLgnyrbe77G67zhHEz2JuPfrwYq12Oj7Ll5KjsO9jXA1E/Ts20c/mNHpLIMiVWuewwt0ioOU7rxoQSrvWl88HPxj5zUy46VI1KnEFz06xTN4KER/ee4fK6VcBYSUoE/ylgolHXR6x0sEwX+cXMC/1USBw/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2FgqLGux5x474BSt6NlIQFr6H33XXLTPiF6haA/4cU=;
 b=0NihJY85Cko1Pl8qGUCxk1iZXfUjab4rdfN3eooeQHw4dBI58f0bq4y8FuZgBeKPTuqxGUGEL58wdPOJ+oPo62/ySxWN7YvRJRiEmtMUHU/TWqyR/Nd7H3CrUZ3Nupg57KQ/on2ZSBJcmP/0N9pyy0DpeKekcerpP4ZJV6sJFz8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Sun, 17 Jul
 2022 23:48:24 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.023; Sun, 17 Jul 2022
 23:48:24 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v3] x86/mce: retrieve poison range from hardware
Date:   Sun, 17 Jul 2022 17:48:05 -0600
Message-Id: <20220717234805.1084386-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:806:126::30) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e6051e-0b56-4518-b888-08da684ed67c
X-MS-TrafficTypeDiagnostic: BLAPR10MB4961:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vNKhN0ii/cvJO9j1wImvkwf1TsfUbNjjnf6kcTxyBM9u+KmZUjP4W++oI0Eiy2KM6hIAcJTnDk5bc/8bseLSJ8oYO9gprMeJ9n3C6dPpPeynes+1quauL+sf3dYVzUoc0mMss2U1wHF2Rhe/+aW91OANxgsaQ5K8xBy6WbygoOz7jR8DXo4JhIlqyxJF2ISPeII2d2j1OSLqPLLfuIhVBTXia+RQWfe91dzAvZvibfGcs2k0Qri4uwwvI4d2VwOVcW++I14yR8wXqjZjgLkaXV6TjlQG+kQ2cKdz/wAwxgu2JN7uNC7BCCT4KLNTBBzuOgg/f9G2A9Q4Q8ptoMfTB9qtIOSbXorpgdZV+pIu9AqvRLE7ZPb5LT7x+J2egdhfnbJJXa+t5R4LyZFrviujO9UbtJxk9OUgbdBuLD777SMzSDcslKqTEgDe3fES7d13EXWwXmtzXu3muQOKBYLEJ7WevA/WogNqFdPwg5vuw3BZjsieN8fhhzyTmGyQWwfFqdVJ/iGrfuVWipzuEsT0UOG7hWgUtcNmYnqQwZUjl9SDz7UUbg/C+EXM3eurXEKLJ6VtLngGWecWQIOTJK85/572wvqIt6xVVrNWuWZOKMd4U8EoHlxRXD9nQrOwTVEvm0WZ9Ouiep3xIhP90eaMiwppHi+NvG0ztIwxAZ4YVqd4P+hwpoNZI0I1xUEfBM83xVcrvKF3sYzMQjYpSK+F3pm6+8DH0M/4lBp72lbS4sdwikfjXX+FpRtGn81ObT8WgYGwPrkoZ7BTyNf+juMi81r/AptKjFCBrqAJi6mRt+xGVy9yLD+Ez+YXjVfAKDfn/0odu0sP9C+Kvz5K35QnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(396003)(39860400002)(136003)(38100700002)(921005)(316002)(36756003)(66556008)(66946007)(8676002)(66476007)(44832011)(2906002)(6666004)(41300700001)(6512007)(83380400001)(186003)(2616005)(7416002)(966005)(6486002)(86362001)(5660300002)(8936002)(1076003)(6506007)(52116002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htRNCr1SiyrzcVx0j3Ds5RWgnWRhSi3lod+rID07nav27ugCCVmpQfO2bE5q?=
 =?us-ascii?Q?jp3tsH+x3YW8TGjY6Tms9HEDDxo1Ios4h/ecVl8eleLOUlTV4Llql9pRlCax?=
 =?us-ascii?Q?Wlfruj07Me3A3jlZ0h2ZcTyX5Slw4peEF4chFmcNvTV/Xh+aOWgO4+jLVY6m?=
 =?us-ascii?Q?I71bkX9FMuug2dXKvnptHKz/3ULaJK64N1tXy3tqiR+zHgjQFAzjYppzvaVo?=
 =?us-ascii?Q?Kyg8V1qw0DwePQD2YEd9iVWVBYaiUHEMBsZ+VF1xgWW6RJypEVpAzxHawc3c?=
 =?us-ascii?Q?OWw4r6DODX4AuV4gul5QvGI+cUU1qmJEnulzQbnRgC9/Hd3fZ3XVUzoId8c9?=
 =?us-ascii?Q?fM+EcE5NDbl8z4GB/tpbM8tYyHJo886YEnJsIV5UXFKLd+uzusJXtjI47eIh?=
 =?us-ascii?Q?rbmSUatJK967NWTnZ+d3SaXNY8ymxLAT6zVfc32xrcujf91guBtJltp2nNwh?=
 =?us-ascii?Q?VtMospRlNkZCDceQX6oXNnl78ABnxIxiK0js3uUDhU0Xo9Sh00Gq9+VXR+wQ?=
 =?us-ascii?Q?LhVrzjaj8gFLRqGLIEpE1H+gOkv4AKiHSoneOJNh6FoERzu0/76YI1gztzP0?=
 =?us-ascii?Q?p+Brkf5RkfH9NV75mhPIT4tPWn/j/AfYt7LuJUaIinXeEodENfs+3nX2t8hy?=
 =?us-ascii?Q?xXyifVyF9g38cWiGFnrg7YujIzvCofW8RxC/ZIAN8qZnwWuX1Tv3t+6TkCZF?=
 =?us-ascii?Q?gv0jNQxYYhqkLrmcKMHSBRFkGmPSmmA8fWiZfoF/Y4tfghc3oDZPdQ7Gf9e1?=
 =?us-ascii?Q?pR1w4LT50N9vVDYjutUgzViF9c6Rkcrkgy8vE3rC0QsK9JpOXCoYde5bCOH9?=
 =?us-ascii?Q?SZ+fp/uwLYSakPMXGoS057XwQQfNnLltgUEJNAUYnhauFY/x6bUnAwZMWq8A?=
 =?us-ascii?Q?TEXb1xi4fsf1B+kExhwwJR0CHwz1jjZ6ndW/WqekJM8iRRY1wXwsU3/wlLvs?=
 =?us-ascii?Q?ge11dyH1FsPzJSe7DlXAqlrqJR17Xa2z13isBIMR/8oKUD5SHXa+H7zwz8Xo?=
 =?us-ascii?Q?MsTqQpHb4UPpNU6+hZAp3+2IwVme7fLAp+UHP6Q+19ISTszc3XUnh8ejK+6N?=
 =?us-ascii?Q?U1ngSLcsvlULq3SEknyT5zmH1AErNHFFyTs3nOqc6/lamzXUB3UsnuzcruWx?=
 =?us-ascii?Q?MuRygdXe3AjopjK4g5fCvWFbRpxyfD8S1S8ttzNXve7mqEvinBG0hqO1iIgF?=
 =?us-ascii?Q?Hj1EbHGKXd4jVoMVE4eFtY1aE10hs6eVOqcvfl5g2toNJvifvjwIzQmpf4In?=
 =?us-ascii?Q?lZgd7bG1P6wYRYQVD6A++5nX3CTayF7Lcent70hr/y8k8nNfufm2oqckTLMA?=
 =?us-ascii?Q?te0y2B09aE67WE7WeHUTS+XxXRBLjriPCM55n5CD0bwwYbyW9h+TyH7RAiR6?=
 =?us-ascii?Q?lVmkKpi/KJLWbH8+sBWlS6+oV+yrpnkyjOP//RGfkr3L4Zj1A3L5TVr1sttc?=
 =?us-ascii?Q?CrVdZ7saFthjuizouwLvyc5puKuDte6gZDFW+XUM68klSRxVzC0H5Jp8co1I?=
 =?us-ascii?Q?xXVHHyC9DFvJ266FQ3sMZ3wbhfomqSpWcukP5iBr2zTjZMAh/p43q66PdHQd?=
 =?us-ascii?Q?F+rk+eijWk8rPUlB09IUFX8Mdna/RieBRXR29tieFbtYgoBOWAat6FLq+fdV?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e6051e-0b56-4518-b888-08da684ed67c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2022 23:48:24.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ret1Sec4293Aril4hWwMKC81GuhTEcZSIGRqNsJterIetYZq5VKATl94aS84fDTh41hP/GUFHklilK5A6WVydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_17,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207170113
X-Proofpoint-GUID: Qn2k2y3xVeG4TTpwXstYbzBQAyHhILre
X-Proofpoint-ORIG-GUID: Qn2k2y3xVeG4TTpwXstYbzBQAyHhILre
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
 arch/x86/kernel/cpu/mce/apei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 717192915f28..a8274fd57add 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -37,7 +37,7 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | __ffs64(mem_err->physical_addr_mask);
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
-- 
2.18.4

