Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8CD402946
	for <lists+linux-edac@lfdr.de>; Tue,  7 Sep 2021 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbhIGM55 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Sep 2021 08:57:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59030 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232913AbhIGM55 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Sep 2021 08:57:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187BnGgT015634;
        Tue, 7 Sep 2021 12:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qEz+UxVNNiliM2C4VjNXFnm4suOpYTcXt1TunrkdQmM=;
 b=gNyWCAJyz1SX/J5Iccv08TJpvqbfJv54plJIbbAsq8tNrkCgMmSIOZFOBesYKxkEufBu
 t4FMncePTumBcreegVg52BIubhQqc1uLMO6wAc7cePkPDVCPYQ6ShMNw/y9WjXLPvcYF
 35lEKnJOlOwjm4pEtB0B2VgrPnS4MtzZ5Jy6drwK99VOXXjENVkQKj/3VHqrM9mQR2yF
 zL834rRvk3c0/k8K0640srmEaKiFs7sO4fYy3DZnwDS9KFmGPcgiHTG+Kn5uqewOkDNw
 rIi1Vl0+uo5oRukm08aXJytz+d7riOdPei/DceCwNNjeC68gWmXlJN71ZJr0s4Hzbxrw eQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=qEz+UxVNNiliM2C4VjNXFnm4suOpYTcXt1TunrkdQmM=;
 b=gGeA2UpHeGGtrnKu6jGLGZQQYZcxWkz5GsYmtVpTpgDZJ4ylNEtzs+wyV+o1Gy5+z+ks
 Zgnmul3qKQIaO52UK7nHrQma016J1DhiPY6cOv95YpCkifygKUGI9iSL+/QQRvd1R1FH
 heWRremCf9viLd45ZO74dD8z/vH4p9wYDPpmMF4B3itl2+kwwIFdJGVzu4ajpSrhIQfa
 W6um8/wqTYAIdKGNqvxNP1LfeHfqVfgZB5PvBt/xHxvvrLUmQDvZYxiXJOA4DUmDuMSA
 Wh/Pvol3D1ENvMQLNyYs1LIpz59FaFXHsH1F0vUAytcvmAHVm8KCuvTKcRDfTQOeSj7e tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq189ryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 12:56:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187Csk0H147876;
        Tue, 7 Sep 2021 12:56:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3auwwwt95b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 12:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWFVqqcOoa22no5CG9hHJ/OoRhfPamBvBMOlHgy9lFV/VJWdEquSP0oNulUaFTR96IJVpLrqh6f3UQlwuNc4vhTjXoHxwRuwy30UIc/vIT5nVz9etMA/VI2fwxDJzWU7imUlAgQdKoZ8ob4978TRKn5j4Wh2fr7bKk+aMM44If2Sd49hkhZcSA27xgBv8AWz9DETNpDmqsEAJ6j7yIjoQDoUMSNrKXTWqzeafLKojsAet/oUYAM9pPHpqbkncH4a+A/Ny+Anh7mVKOTV1igSXyCYebtj68qIRQFsXoTW6pqfcehURKz2VUjJcRbTkvJDTQw/u1sInbXkslWnzmZxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qEz+UxVNNiliM2C4VjNXFnm4suOpYTcXt1TunrkdQmM=;
 b=ErilXOozcxR098yAZBTDZcAMYKapVJqfTAv6s8xgZFE3nS9ImRofK74rQIcPC3AUQ0WWSScXsdNL6XBo7Hcs+VkNh86LSL/PLgWVB3QldisiCZIHY+oHnP/IPQyMgDyI42iBDXzNQ/WJI+K9X4wcUj7LmbWR3Z+SJXdP49w/e0FYBHZiFg2IGYyxKUI6j8uzJ4mAyq0D0/asPY0rN6+4Xk79OMuv8Z6l9bY41GNP6wvwfk9OFdy/5QKOwV1vPaAUPkRL6FydFm7R+uymD1vx2LvOzt8FtEGil7QRbRanEs1GYUuga6of3vsyhLCap9yfX0MKdyboccwjNDbG6cqS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEz+UxVNNiliM2C4VjNXFnm4suOpYTcXt1TunrkdQmM=;
 b=gaUdF2Bnk4gf1oJ+CKldYInblxQ0++kIR6feJVXkscOIh4Ia32mfvDkMoQdTE9hk/7UrnN6b2fRTuOf4+Inwtd0raio7qvgxTs1/+RLMBfbZaifWfozXBfMqC3dyHqWXybJnwMQ/PusWapgzyqTUHwHzIqvyM8F2T7rX8reNvBk=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1245.namprd10.prod.outlook.com
 (2603:10b6:301:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 12:56:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 12:56:32 +0000
Date:   Tue, 7 Sep 2021 15:56:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/device: Remove redundant initialization of pointer
 dev_ctl
Message-ID: <20210907125610.GN1957@kadam>
References: <20210907105913.15077-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907105913.15077-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 12:56:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c848c0c-58c1-43fe-fa85-08d971feea0f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB124501652A58AC3A3602BAEC8ED39@MWHPR10MB1245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3r5p93XsS5WdPGr33oH/os+iJrTzE6ltM7+t+Xswxlj4aea0c7qRTAUrctasjz5J4oG20IwOWKo1YIURGOBtXyqxgA8VGSA8nXR2y9DoxdEi3K6l+QRFaIgGNV/mk3n8apAO6FFJHcy2WFfp/YJ6fnPYee3EXuFzKhcrEa3BZehhMpL4TX9khchreefhzhyii+lytDvVDuQ4z7Hcd0JtDUHquMvqh3FU7iEzxX9wC0GgfHIlNjNP06/ccdLuvDA+40duAVmT1eX5prQW8mQl84MmJKNDOXYOZ1Vf5wv5XBg/UFa6C78vdeBddq6YOU9UE3vCtmWUrM74IqsMcYgjGef2zRF2DJi/+rNbxK7AecfA+o/rjeDjpFAEsXBdxbSyveM4aPgJrU7WzHuPL3ctLrVDKk+Ew0mupc4K5AbR0TDZyQCYDfNbxDFIpZJSnvh6/A2St8E4TG0RYFqXJRmGUFJB+YNfZmxWHM2MOULgqz2pyFz35cPNDW+n3O6SfBdGReNJ2k81kIvxpzxvM0CIIAGKNY1TxJVJAWxfXKAdadBXUq3KXx3/6lnGtXrF0c++HjPq3dRmnMgh4U0eXqbISBMfiwMzNqlXfJxpCLhHiWLJZ2oh9JE+Bezln/RdkD7IW2vQOKEs0LgfASNRThJWLGH5OqFT/RML3q5hr8rz8MjsrIIjsBUBhT7VNzCz+11ygbmMAk98mVk4329JXBJgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(2906002)(38100700002)(26005)(66946007)(86362001)(6496006)(8936002)(5660300002)(52116002)(4326008)(66476007)(8676002)(33656002)(66556008)(9576002)(4744005)(33716001)(478600001)(1076003)(38350700002)(54906003)(956004)(83380400001)(44832011)(6666004)(9686003)(316002)(55016002)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6tTOJ3JWNw0phhV13Jn1z9nrw8NuuzcIW8eoUMs8Wk7A0kGLAaPQ9eqJ0+Ij?=
 =?us-ascii?Q?bLFpSVtqPBw89Q3yf/JmGqQFoDXay60jhyju0QuT0ObvwkG+t+fncftKgQQf?=
 =?us-ascii?Q?KZ9rkeyJWjXQ+BprUhP7C7mlsPBRjxQVq41+jF6uZzvWK5ueHhuCp03/T+CG?=
 =?us-ascii?Q?f0bRRgOFWwy2Og/Ht2w1+f+7gINR2zjZVN+w53D1jbnsYeajuTvq32/fnd3K?=
 =?us-ascii?Q?U6qjr35BSa1ws2lBKyvW0OKveMLctR1JuJlM0pUNpNnbZ2csrs7WvOidVp8w?=
 =?us-ascii?Q?uDIe7W6voIRTQwfpaBh7VrbWx1VPBst8sxuZW5SuZBu8l4KcPA3GTLyJees9?=
 =?us-ascii?Q?IbyN5Wan1vC08Pxioel8YJhzwFVlQYKAFZosu6BPeoHvwII/BoLb3b+iLwUS?=
 =?us-ascii?Q?1/iXLCxsEIaNSoxwXCtRKOheCG0DN9nrDa6qKNuAm1i4tg1OTLVlWFntWwhI?=
 =?us-ascii?Q?dNYfSAOr3rBqNMVJhJF4BQ188AUS4nfXr3REdfC/BvcVmbskcwgIbd++drsN?=
 =?us-ascii?Q?DidiTtAj1IsdtNdCh0ijL2ys4vXzvUMYeuTss3XHXApjaX+lkUkFr3huHQ+d?=
 =?us-ascii?Q?w+jEMAr7UuIwzdosajvV5ml/6WpDjWjtFDJWRgad1DPk+8l1xxUFM2rO5a+Z?=
 =?us-ascii?Q?LnnVlcGHJQAYu3XLlNT270qeauG4kE2hwx63Bvt5ns9x/1o5Kxc0FENwSav8?=
 =?us-ascii?Q?y0pce3GBz71PqfKMHXOQNHcHWN0NK5MEgAohdf+K1bjFMER7gOF4WV4PjdSM?=
 =?us-ascii?Q?E+4YbBtvkk7DZCA18eSnM42d8tgSxXyf/Q4AAN+f7Znn81sBeFY6RVtwh9Nf?=
 =?us-ascii?Q?QnNKG6CsKMOXpUJT/mbJhf0A39VuuVUvmrs9t2hYSzKcZ2J53nFUc0cDJTNa?=
 =?us-ascii?Q?wDn5YWMIQ5yejKDYI+gCtenpjkUDpvG4oHWu60HzUayZMXFou1u50d4PYhl6?=
 =?us-ascii?Q?c3Wzb8hv4W1IceF1OH6dnzNToPzfYSu17IFCNgAWJUkuGBukT3FyaphWPSQx?=
 =?us-ascii?Q?mYCqpuCEwJisYIQIptG13itYvHdeQktrlbjg9wWGLMoGzS6Is+VJqMWUB3m4?=
 =?us-ascii?Q?8RQEqXNUjMRtwhSLa+Q6Q1oKt+cHFiD9aityc8bxGy1LWfpHPqAHyoH4pzOm?=
 =?us-ascii?Q?hD44y58se1x5MiFbHXW/3HA+DProsef0288jbXKnXN4EVTFk2Yp2toap1evc?=
 =?us-ascii?Q?lCXDWdSw/7OiqSbH8g4s1hl9ljmz52asE9oe6n9LuTGzhr9BeGuPbehypmDx?=
 =?us-ascii?Q?ceXR/hsDDMh1bNSIPufOMeAOxvaMwz2wEgosAVxF4o2DB341N60f5tG5PDTo?=
 =?us-ascii?Q?n7F5Abt2QehiTw5uIgq8Kmsf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c848c0c-58c1-43fe-fa85-08d971feea0f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:56:32.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT2ROHlL+EOH1KZmimTS+eTRKmARe8y98h7Kt8Z5yYKBfQozELhUDjh/IGNoGRqNavRnEwS7LLLRrx1XHpUwSM9hzwbtiG4upp9GcWMHCLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070085
X-Proofpoint-GUID: KcayEzrOwaie6XdXecX8SKZyU4CXwXsb
X-Proofpoint-ORIG-GUID: KcayEzrOwaie6XdXecX8SKZyU4CXwXsb
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 07, 2021 at 11:59:13AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable dev_ctl is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/edac_device.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 8c4d947fb848..a337f7afc3b9 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -75,7 +75,6 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
>  	 * provide if we could simply hardcode everything into a single struct.
>  	 */
>  	p = NULL;
> -	dev_ctl = edac_align_ptr(&p, sizeof(*dev_ctl), 1);
                                 ^^
This sets "p" up for the next call so I think it's required.

regards,
dan carpenter

