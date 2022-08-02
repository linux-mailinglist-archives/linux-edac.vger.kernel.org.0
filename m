Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D275882D6
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHBTvf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 15:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHBTve (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 15:51:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F413F24;
        Tue,  2 Aug 2022 12:51:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JIuct017356;
        Tue, 2 Aug 2022 19:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+9HhfHfiWfb45ELEv1FSXIZxQDPGHAARAHd60SdYE4I=;
 b=WMKPFAX2E2kKfe9DINkMuKmdBC6xpj/jn4RIx1sppAOi13vYzTsY0KYpkSpDmcy2fd2T
 ja2vtYWfMtUCYyQmJuxupMWxdAYyLBFlv695muM94P/UX2Wg4rpm74e99ZVvpZjhvXc5
 8poNmjVGnCWRTHd0iNT30J5n+2fuspXwPBfXN+bofzXIG97VRJBnQxaRoouP4oT+Q9IZ
 9bgw+yyzeXv2IM2YzsftveMiL53XQDVr6dgFJ/FXZPp3Uc7YdHv18CwVHdD+s466EIn8
 wXRKHye1/qkBv6huoOk5xBl4U9OvNXnehd6C///9LjorHw613yf+MUf02bv5XSC2zYHv BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2r4dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 19:51:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272Jf9jI007660;
        Tue, 2 Aug 2022 19:51:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32cwet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 19:51:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGOzp5NmPf85bVheSdHfCU+tma5aW/tEjcciLJjk3Zb5kiryzps0nZZTUYdYrXuMQuqdytbJE12SoX6SGhwycvGkj8LfrsadWhe7fvhGls8wf7iC4doHG4ePxTJeGInm6ZWwAo0Wn+WjMUR/Q7oXoNuPMyNXwIAK55HsjnMrXXAeCdfiLFHHwIb4QDop7IOvhDMNLOVlQcYDU5XmxzHL4NJlm4V7/WoMbsp7CKdYsDQTGkn7dp1gXdum3sy8IsydvP3/THPKcwV/RIBGjPq3+moRTa76e9TrrzIS3dRWMC0xv+58mkvmzZIazrKredwYloJ4wKsRvTkkmo3dOspqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9HhfHfiWfb45ELEv1FSXIZxQDPGHAARAHd60SdYE4I=;
 b=Y+ApKGZFu+8jojL/IHq6TX58pfpviCOGctpa1C11n0UbRLi9839hnGJFL6mGE6C2RHC0erHyf4NaMF/I8GViiTX6J5hMDayr/0Rqaha7qHEQqeAdyzlA3dXg71v5wOK/5MjMssg8/muHOeSy9Z4UW1Tt2jl9hiTuVtPQt0SebQfa+1r8EysqEDp2SxgRTrQHu9yaRw7KWkIeeL4NS+IXyiOS3y6TaHFpK25/lZrnDSgTEi/6Z6I00uhg9huIeQlJNRd6eW3Xj0GHBljg+yAxiJE6I7l3DkaULiRr/qBP+fPFXzASLpu6MdS+LampLNtkune5rhQQynuAjkmy3SaEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9HhfHfiWfb45ELEv1FSXIZxQDPGHAARAHd60SdYE4I=;
 b=xR1gc1ytx+hfWS3YtEL8Z6+6vtp2SQswB1Sjsyg4NcRNf3bmd+9kikUaHvLWNxlBVDRYu4JYAtrAMao+dXsooNd8dGoeTgOU8SRQv31lSrkR6i4NBWvIl38MLUf9R7fPkW9qO285SRuD2LnDlVRcbKBFe/pHYWSZWbuloN69CaU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN2PR10MB3534.namprd10.prod.outlook.com (2603:10b6:208:115::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 19:51:10 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 19:51:10 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: [PATCH v7] x86/mce: retrieve poison range from hardware
Date:   Tue,  2 Aug 2022 13:50:53 -0600
Message-Id: <20220802195053.3882368-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f10284af-b02c-4012-2fa4-08da74c058d1
X-MS-TrafficTypeDiagnostic: MN2PR10MB3534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjiwhYd9KeeYnQ5pmzzDe4ZHvCbvdB6rFmKPdBJyHQ/JJhS1Nm2W4IoS6zvgY0dMF0RPzKZPxhtj9yJPulorWHNUjYvfWPhnsi3z7m2UzXtGRfNO/1Po8C0qPJqrV4RU6VkuHL5Z4nHv6ZV7iUvXOmY9SUI7yWViMenv8Do4zTTSa8C+GaNtfm4jP5BwaUBnPGnYFmBREHZMMlp1pEuvVFLnDndwrD7Ze9xJsRgphXzZa1KBTrJAqePQfQttN046XPn0YgGFXMuvBvDF/FeUTgajYkHUH4j3KMr0TgFWeKlY2/XKxEllrB+BrDfg9NmGqcnDyDxiLbvNXqCuIPZ7nB+tXTtijr/I9VIDjKofS+rWczC1U4qqUT+xzjj8ZWVBj/8g5MTQTRxbk+I4Gr6jDmrFJMflKNkimEmw985xDonqAnd8gd6qUc26ZvsHrz8p6G+VjSuKlKu3mv0Al0YYjtP7cMZ/omHpjmvTT+qFf/MBHMZiZubwMO0dkO8X5ky59B+fXGQLyBAHWn+i2Ft19UqnzuMaRjIWXSK69Jbv2gmEwcFW5wgr5QXLBwY7435ZX5SzUefHvRtgiIQ1ahGb9vqn2Vw3F8qZ+P4CNvvgcmyWobAbfmaPEopo/RMSbbib7k8GlwL0rnQqImfmp3EMEEBowwGlphj2H6qbFI2+TBcmToUmy+VLSfqISgU0bzQmzYpIcPnbCGv0YJRnRzdHrhtLZcB88mKRjy00EXzKOHmjO92LTY5qooRcbPEI9sHlCyRMnaZNxaQOwSmcbC+qGEHw0gGLAKM8xTillx34DB8ingztUln1jt7U95FuKL5F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(346002)(376002)(366004)(36756003)(83380400001)(8676002)(8936002)(5660300002)(86362001)(7416002)(2906002)(2616005)(186003)(1076003)(66946007)(316002)(52116002)(6486002)(966005)(44832011)(38100700002)(66556008)(66476007)(478600001)(41300700001)(6512007)(6666004)(921005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSpBt8u8lFGRDYsdSkaXbDhB2YOSQAQVzzKIqN2vM5NuMLE1y57lfUe20/O1?=
 =?us-ascii?Q?MgBqJtNGXzSFqZScZxMDciKJkXW8xNk/rYC5aUBITp8A1mmUJnx8LY8FYijQ?=
 =?us-ascii?Q?urS8IldbhKAp3g9rhjPxIXHadTiOnyYxkmE7I2sIybETvk+Ne0gA6RC++ewn?=
 =?us-ascii?Q?etxx8/ft3awX+8tfKlIpPQC4m2P/M99Uet4k+9URXULp8DyW+oU+4s/R/l82?=
 =?us-ascii?Q?KPfc3eXaTmdONuYqRYqdBNpoe4iOuayzFZ55mCPK02DTkUxGP6NA128Fp0zE?=
 =?us-ascii?Q?SPQLjEqLcWxzfmbkTfbgbzBNvyJip82XJ5lEiIzskuLEONd6RvsbM4UvI4Im?=
 =?us-ascii?Q?QI7ZVJMkuZuFQmf31pYbcI1iW5TTbKSoBncKO4Vx7Wh6GrsjPoBhQ5LnL4KM?=
 =?us-ascii?Q?7gkuLJOvIN99+EUPv+k65Gqh31/a7LFjBU/ERBKaWV5tdBlUJqXa6OChv3Jr?=
 =?us-ascii?Q?wLa7taHyRNQ5wGWOIf/E8G7hdUbBiwHaP/sNZ6rb2wEc1/lM5TKWIDVSii4U?=
 =?us-ascii?Q?Kq7s5kjl+n6PkP9WhPnMkPTCdXk5tVG3Rr1L+xlqm/bCis/y4U1rpzqPWiCf?=
 =?us-ascii?Q?M6TrEzs1apfkBhqHvdjD90Ok3inPwWtEqa6uaruz50ExC5yCWc+ao2IPr6cY?=
 =?us-ascii?Q?JNm41WLbush1CSOj36OyJ0XlCMCbum4Dm3YRhtre1mEiXZe6iW+6AwD5Q61b?=
 =?us-ascii?Q?Gk4kIKPOkYmDt8JLa/H8PLITjwiFKZg/1ZGNELglgwVD3AqznWKo0wKmmip9?=
 =?us-ascii?Q?vwwJcAhzst1xVcfmxuKPo//KJhSVrGINfPH4ru2QdjglTjaUS0cFsuJU5x1l?=
 =?us-ascii?Q?DBGUXOUcpKIKvffqTHxmR3XcQ/UiL/1UvjO9KtPg1bIJbaVzMakS48/1kyjK?=
 =?us-ascii?Q?TSckVPS6enVdnmj2qoIKde2tdbzEYOS0rys6POvizP8V6tMllE6wkkQmRD1v?=
 =?us-ascii?Q?+DelUVdxlCUWqXx8ekaobvfBhvmNX8dtfqIVmu8CxBbRkhQaYhNYIxRoGsEU?=
 =?us-ascii?Q?T17+31CRHBs3CkByOtEuLWrlTwL7hdegaTQbgRlnx3XK64gOmEZAiaiGLZNo?=
 =?us-ascii?Q?vzzAKO8VUoAIL8qAxWa2HQ/W0QmEuBI6LHz3CcdgVkSolX2U7k6xBLkJTHCi?=
 =?us-ascii?Q?TsgvRoXduJ85u/AqbIbqCKOpQJM5ev9SMR5aktXmCMyqz/LcdIk+xBj5pFaS?=
 =?us-ascii?Q?+0k95zNRAoauGaoL0FhgPOzvLu7Zlp4KsSTgMuiq7aRdaB2GQMLOeUZ8tbvW?=
 =?us-ascii?Q?0/PQzCSo5noZWOG8edZY7D9ScID9HksAEx2zo0ekLHjg9Lgkt+Tf4xhPOa7b?=
 =?us-ascii?Q?AJ2pcAbxApfn/gc2LF+1ywSizU7lZR/SffoUqo/IXx6iTRs3jzdYNAllaDw5?=
 =?us-ascii?Q?AqdYBSZ3KDyV5cOMIpJCc1AiJLX96Fye/BwtRTTNtYz+jS+gwg/s4WgG7ztu?=
 =?us-ascii?Q?DB0kS3l8IvUARbmj/2TUgWyutOUM/Ua11KppqjwtKabywHy9doQHiQSI/Ykd?=
 =?us-ascii?Q?B6WYX1DTMyMuwvVgR55Ai6yVcgalmUGT868B1TYgAY4p+5szBpzmt7BR25+b?=
 =?us-ascii?Q?E2eybDvYsbYOFC2JCWR9wYvd1fwbiTyKGEsaMgXPbnQ0d3V0NCZ3CSuN8WGd?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10284af-b02c-4012-2fa4-08da74c058d1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 19:51:10.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vww/4lPIG4pRgXZ0xSX0jd27g8iip3jJqvvHt//4Uwr8IT8OUxyk5gYk3RbdZV8JhLV6s5pllnQ4bWLyVwedFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020093
X-Proofpoint-ORIG-GUID: Dbx1rRSnqdVtS12Tqe_qawoWZxK1BkF3
X-Proofpoint-GUID: Dbx1rRSnqdVtS12Tqe_qawoWZxK1BkF3
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
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 717192915f28..8ed341714686 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,15 +29,26 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int lsb;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
+	/*
+	 * Even if the ->validation_bits are set for address mask,
+	 * to be extra safe, check and reject an error radius '0',
+	 * and fall back to the default page size.
+	 */
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
+		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
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

