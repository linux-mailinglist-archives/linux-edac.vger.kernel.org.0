Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCED5B5943
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiILL1g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiILL1f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 07:27:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82D23178;
        Mon, 12 Sep 2022 04:27:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CBItZN008055;
        Mon, 12 Sep 2022 11:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QwhAhppyPMDhvZvf6Ew+xbVwUeTU2A/e6iTQtM4Rq1Q=;
 b=G4NBw+f8VDDqQ6EjyH1xRp9TQ8qBH2tpqrisJH2/L1MBJc5GCBOTyltfNFj+8VgIzj8Q
 JErR8EsYTsMhzCJmAKF2fyh3wxXvedIi5gnNKkqxVdqBeX99PAPGux8x51AEMbf0PwNj
 7ER79FtntjB2rzPW8SYcNTGt4V1ek6YMLj4JCRoaKUIH6eHYzGM0UfpKIYiJchmmV9wA
 b2XETQeXKcj8E+gD3fn/0p92nVBb0ge82QvH5v0Zuv+VOx1MfNBacnmAjSN9b1Q4UXbe
 yPXHHHnTYPNueFoLg6eQ/9Me3GW+POA55kp3XMYItgEfTbxiFOycVjd2AoIfsACjQfbM 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jghc2k7ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 11:27:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28C9rG6o029544;
        Mon, 12 Sep 2022 11:27:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgj5awpun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 11:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icfrVnWyl2ufSRbKVRNsGVyQl+E9eFrXV2OPHQMoqmW38dEPgwE47PnspaZYaT5eSBVvWACNVNGvmdanLtG1xFvA8U1CRnCxjNa02HLTt5ma0ITNDNbDPKf+sH4Zahf1CF8IvGYm3H3KrllIO4z2Rn32wpG8NsNRn6LqtLXp6L34WWNXPi0vTMWU/NmATjzd3RYaVSN3U+7A/58MKWkCqsLGHlLuOdZya83s9CIjVvHuHrZJBbQi8djcb5nM9VLsTqfAu6mgbMYH1GH53LaE9cSvLSbpHrswyg5GZTv6/ViYJUBWge2lSZfVwGDPsHome9mwdXlw8JJY+vyAtMHV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwhAhppyPMDhvZvf6Ew+xbVwUeTU2A/e6iTQtM4Rq1Q=;
 b=TfsqBl8MPOOy2kruDmXLN+KE4X2Vxo1Zand5tjRVEDt4KBNVckKlPo0rZyFZ3pDX6251stjBcv28LETUbQbOwmLWVaMc1qO0pNgTM7cYvYi34EVoUCpFRoXSpkAw6Tr625gzFL4/ljbLA+/lQEX/w0/KDvGogqSf+anHa5Omg4xUlz0UgwwSsgqZMrGC//wg/naiJpKXjpXE+ApCNRt0hzckXMKrITPNPqbAwScdxNLXfkK+gFMDxHXt6mQrZrvCXh8+OU1il7SxgTOTGtzM3EoU08WBG79jCN5PDwJwi+AeCzsmVsLq1YG+96+SnbxHL93OBZw1y9L7e6LAUhauJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwhAhppyPMDhvZvf6Ew+xbVwUeTU2A/e6iTQtM4Rq1Q=;
 b=pm5l+RO4UCMUwdcYEtNJE3OcpCD4L3JWMBITvEM7ZvyNf/EuoudfQKNRouBbt9xOZX6MVWNFnvalYiPcbDIWHbNM9tLkBrJpPcupQmnrk2BiSl3rwnO/n23QoWQbPRx9EM2EKQ4UsjyvZTJ0tIKX7jEsacmEWvM5dKQAklZMpU8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5668.namprd10.prod.outlook.com
 (2603:10b6:303:1a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 11:27:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 11:27:03 +0000
Date:   Mon, 12 Sep 2022 14:26:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] EDAC/altera: add platform_get_irq error checking
Message-ID: <Yx8Xds2BrK7PNjXJ@kadam>
References: <20220909053839.2293-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909053839.2293-1-yuzhe@nfschina.com>
X-ClientProxiedBy: JN2P275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 811550f8-d9f7-4206-8445-08da94b1b6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyrA5yNLidM4Y5X34IvYYU1OoUsaF471OlPVSCD2+CIkX/mRaHPVEIXk9VBWLRnX2FPjcLkGLeL/q9hkkmYVBr6Ko2ghjOAEqr6CWUcZavFA6+WSKwlESlFwlWXeDgPIQTlyqcU6eRosgBsAl/S1I97YlLwJbX3FR0epTYekwpQ1jANpbM0YQrjBLbP1W638IesEefqoI/N10QJnrBHAlEKPvYWIxQPNzuN+PEBx85lKVR+lEmzPAz5Qp0vQta8opUBJCKdQd9vC5sy6D5HazT5JneBzwkXRbVw+b/S3ghKHLBEV8jHEXlfOo/Sohw2SNXUbdwmy80p9mBIiq0B0iYBPKnfOsSLp4NREnVMA5AwcYUUalQmv39LCKLBo57Sq30Iawe7ypWSJr+JwV2wevibTkBb/01kyVC78zaDdNA4lHALMBfkaLA1i878hMHIA4KpDywqNrlVnDCuLKF+LOxuiLJRO6BGCcN+ZZvyhYoqSRK9HZz0Wp0FrDgevBw1Lg8SS98FCu6w4QgtLhpgljqg2L3E7GQr8e6prZSXVGgZw3L9g6W2ACU1BkmiUrLfNmqm8MKyLs5j8HspJ2mLC6mq7fSzC4IPE/4bKf/jwtTQwEWX9CJofrOG9XZn4b3qIP+g4khPAoFV6o4OnpPcrgDsnNCq4tJMXUEK9b5ss0TnTLuxWMCSJP5LTJ1UB0K9AIGmbAGGvpH7J3LSnwGttIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(396003)(346002)(136003)(366004)(316002)(6916009)(33716001)(8676002)(7416002)(5660300002)(38100700002)(66476007)(66946007)(4326008)(66556008)(8936002)(83380400001)(41300700001)(6486002)(478600001)(9686003)(6512007)(6666004)(6506007)(26005)(186003)(44832011)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DHxgjc8bYZ1z2tauk3iYaSVwYR25+XyahZDJtN2dCM+MgHqRdBwX3k9IIlsM?=
 =?us-ascii?Q?LPWoRiAu8At2aJL2i5z664elI5JYCKfWxHfCDAoKO44TQrk63EO/2o459m08?=
 =?us-ascii?Q?RUyyY16oDUh5qDD57S96QCH+n4KMJfn76dSQAjz/n430rLexrbm/0ldftOVU?=
 =?us-ascii?Q?EIMzn14mvdqg9uzYLGGESsThMb3upZ6K35kHOri1OXH3GDLXrMaMN4l+G5Zq?=
 =?us-ascii?Q?P0FEZ1pSb/ktEeo5pEYBcDWrUwGZrJoFO4sWWXAsrHGP/oJ81gXvJRPkj2bN?=
 =?us-ascii?Q?Hfd2PR7KL0P3NNQIgIS0me92YRbEexPzG/GX3f+i7oE3XBrUl/1S35oqOGuk?=
 =?us-ascii?Q?cxPii6OzBFitacgD1Kbwj0+cXVGS04BHtJOm1GDRoHzEZ5xKJObr/A25M5Ea?=
 =?us-ascii?Q?nvAXkm+pW4UMFaUyy9TCMw64CDK5lUMsmFIPu0s4X9rajP6YRtTTily8KoBb?=
 =?us-ascii?Q?iTZivdHQ04W70CHrvPPjG490GJfrfbwtgsDJ7D7eNrLEP7FogyJPOnD4Wyt2?=
 =?us-ascii?Q?OWGOxIoTol1tyhNc69bx8znP0jkh2WdcszmJJ2/HZE5NwlQLhZyEfIVvWu79?=
 =?us-ascii?Q?Sf2ACFhQsgdIWYfcAnEsxCw0SsJzh3PFc05UOCklwHRBV0pFmwcKNB78ozZQ?=
 =?us-ascii?Q?HgJuJQWwLAcLJvz15iSuOM28mKSG8lHo7mihMUO1MtcFHn32S7orGJu+kdhU?=
 =?us-ascii?Q?h0Qixp8XU+jsEzXBjlHmV7mVtjkJtKroVDbakXqJIiIFUUmqGlILya5ywvcZ?=
 =?us-ascii?Q?Ji3/pzDvgOFJsMC7GTfonHW10rg/Ny3vrkb8tc180GXHnLVNLypwiYo8nBfK?=
 =?us-ascii?Q?FMU8rOqo8zTaBrfQ9AGo3d6Afi5ljYyNwckgJK6N6sX5s4+YlFSZbil3jACP?=
 =?us-ascii?Q?IRRSNFrBDn+gfPCbO0N3TgLJQG1a88E8yaOsFrewduS69KtdiE36KlibhIIu?=
 =?us-ascii?Q?H8OLY9rVom2WNyV7FAX40WJLkjEMEzbS6/48D5QNEhCJag7dfXck7VQch8p8?=
 =?us-ascii?Q?1dxakSY0cqWw/PSGEBqTuJJt9geCoFzvozQ5XRfV+XVOtbiF7IV77wk/GC3J?=
 =?us-ascii?Q?IMpG1WjnU4jNaIDQZlCYQolB/krcZ6ilwhiEzmDxhsI+aHDdb8m46p/tuwxq?=
 =?us-ascii?Q?B7FkLsMaYpJ9sOFqjGd3trHkVLzZaDtRUD29rwXEdK1L4rzOG9yK1yy/Xad0?=
 =?us-ascii?Q?e881CuVUIAIPENTK1nTxuiF8tI0AQ39AwFtoOW+3fd802Ffv03mdrK69vAco?=
 =?us-ascii?Q?sfA7pv+R5/frIHlJr2Zx3Fqzbz/wKlFiS5YlcAzae9NzgHNq49FUhxlwq7+a?=
 =?us-ascii?Q?hzUdYFOMGXl/ux1NBlT6HUawjyUrVCcBzdhayac19VseghmioN9vt5XzO2Vd?=
 =?us-ascii?Q?OGbaMxyIoQX/LDR2Wod0kBi7e5fAsYwI8mkCfUpF4hvIvkdx2IIqVNr+DUjp?=
 =?us-ascii?Q?zQaweTnf6xFAGs3XyQd/9a6Qni36omS+It194easJYyuzIdl2+sI2qqiwXvl?=
 =?us-ascii?Q?EP3sMSBazWXQfDxTTQwVTBRYls/mI1jCQhtssXj5DoBmuCgKLzvg5Nz7JcWk?=
 =?us-ascii?Q?LkElvBpxPd/VYUxVrpvNjsoWssEjdrseYNxrSeSm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811550f8-d9f7-4206-8445-08da94b1b6f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 11:27:03.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZQPXPQIysfgvSShhoRP0vkTHct0laqffnub1xasTaSkA/Co2KRUDZakIbrJq2nL0CPeCaANGqs/pmklq8sttmQbSodurn7NTI/lnoj5Ksc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_07,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120038
X-Proofpoint-ORIG-GUID: kIxxc7mxmjIw_bkOAPnX-9CYW0BdfB0o
X-Proofpoint-GUID: kIxxc7mxmjIw_bkOAPnX-9CYW0BdfB0o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 09, 2022 at 01:38:38PM +0800, Yu Zhe wrote:
> The platform_get_irq() function returns negative error codes on error,
> check it.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/edac/altera_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e7e8e624a436..79c7c97c7a46 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -355,6 +355,8 @@ static int altr_sdram_probe(struct platform_device *pdev)
>  
>  	/* Arria10 has a 2nd IRQ */
>  	irq2 = platform_get_irq(pdev, 1);
> +	if (irq2 < 0)
> +		return irq2;

This will break the driver.  Only certain hardware has the second IRQ.
(Read the comments later in the probe).  In fact, the code works fine
as-is because devm_request_irq() will fail later if this IRQ is
required.

This code is not beautiful.  It should only request the IRQ in cases
where it is present, but it used to work correctly and now it will be
broken.

regards,
dan carpenter

