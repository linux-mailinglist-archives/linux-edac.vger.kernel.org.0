Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B71A7796
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437740AbgDNJr1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 05:47:27 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43284 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729436AbgDNJr0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 05:47:26 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E9e6O6026959;
        Tue, 14 Apr 2020 02:47:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=TvQVpbn4o3xIc7H71x2cghVVdIRQkk6QtU/PgCZUcVU=;
 b=f/ERMo6Hzu5MfEoeChbt0NzTZ05f77oEEcWU5FfIPLaPhXVIMHXz9MZTxrlGtJXQz7Fa
 j+r9y87NSFfMasOoqhmw4YPk+vzUcBX8MkdMdJYvpaVkAhmrPg7XMIqiIPwR5x2fQe5M
 E9Pt5g3sfJPjesuxF43eN6lNnScX3rdKnuhvBooDIaN+0lzopj63BUsyALtolzeMRzXp
 xttPe9ggOzFuuvw8dPKe0KsTpbr6GzPGC93okdJaMUSikArEOQvBxLs77BYRUKzOTFSf
 uJ7Rad4U7kot69Nj7RQpyWbIz7X4KBQKVp7EnLnPpFZB6xW+GVPAT6DqueERhqrSFvKr vg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 30bb8qj7k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 02:47:03 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Apr
 2020 02:47:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 14 Apr 2020 02:47:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7i5QaywhebbwweNDlk/Hi5R3pfq08X5Lhifz0pQP4i/Qp+YaywbeisYqsRK9ldfoQjTNFuu56wkt8DaLy2yTaE5L2OJlsIwlG4YrJquGaRewS9+4w84nN/NvCsL6aVmzejKG1+rws0FyAt1hkmDkkfF/ps/QuF2a2NCe4trUGwd5ckBJsHcvnXCb+w4mLFY/U6Z+PNVjD1oZEiFhYAGlMHOZAJyza1eCVEnnZSyZ0PQQk57ISaQU9tg2+lNPbpAhE3Z0SJWv43BCEeMdbJnH6MwdK9hdADfNfnuwqf0uqzy7PDSexbu042IvIRpYVoblsSHJWYq6Yhv0VZhfUQf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvQVpbn4o3xIc7H71x2cghVVdIRQkk6QtU/PgCZUcVU=;
 b=YPWpCEuC4ieLMm4miV+F33MTKH6fjW9p8bCp58QeJWrGR0fsHRED4qfxMD4AbLKS0oNtVqiBWCVILHoPkMhqkwNfMA3tZAydDDhxEGCNp9DhxsCrZe2opWSZssGJ9UfbI+6d77aZmOHsIW8YY6pMsVfJj8Oibx/qbuNbqs7XbLFBsBqPRgktFGjJ0sxnIkzl/BHHgvQwc2Vv3+kQZVOcmZijIWt/VZ1GKCCKPn7NdHObaf9M84cRuBCjhI8oH8LYFlx8INgnMQK0/T7J4xmvjaMOOXDevjlLC71hkovCSeIkD6LRH/C7vniWxANQ323a7gq0BfYDXCwMuOl6pVu2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvQVpbn4o3xIc7H71x2cghVVdIRQkk6QtU/PgCZUcVU=;
 b=qVRcl7y6vYTAhv2jk7WFRnkbp/wvuC3p3060AYKjB7EVY1eFhWlb5u3jOgghXr2SoIdfkEczdQ9ss+pD+ZrrHIx/FOuRscQaDlHtPNHR5bu05bGviA4aUhvqtxPnS/yGD3QY6rzFw6LWU0d1RRp7ljbK7nK+j4uLJMI0v45igCo=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2742.namprd18.prod.outlook.com (2603:10b6:a03:10d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 09:47:00 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:46:59 +0000
Date:   Tue, 14 Apr 2020 11:46:23 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <jlu@pengutronix.de>, <bp@alien8.de>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] EDAC/armada_xp: Fix some log messages
Message-ID: <20200414094622.45hrvmf6lz24trgx@rric.localdomain>
References: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0101CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::14) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0101CA0004.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Tue, 14 Apr 2020 09:46:57 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db77304f-25c0-4b97-09de-08d7e058c6f4
X-MS-TrafficTypeDiagnostic: BYAPR18MB2742:
X-Microsoft-Antispam-PRVS: <BYAPR18MB274201CD2F3F2E6CB81D4903D9DA0@BYAPR18MB2742.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(136003)(39850400004)(376002)(346002)(396003)(186003)(52116002)(6666004)(66946007)(8936002)(6506007)(15650500001)(66556008)(66476007)(2906002)(4744005)(956004)(316002)(5660300002)(8676002)(53546011)(4326008)(478600001)(86362001)(7696005)(55016002)(16526019)(9686003)(1076003)(26005)(81156014)(6916009);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+ESl1JY4XoxsdlRLRKBtnEbfkswFjzFV6oLdOy9bkQ/IAolDTeHBA11m1duNBGiuyYDcllWyv5P57OrlLNM/Inyx6eTr1MB08yW6R7akQAGRHKqTrJvI5Rw1rEvRfl5MLD0StAhLmHVW6rLSUsz/h89X0qhR7HizlbZoPx3f+252cqijxIJ1PF119OsVcQk09ZC0xir21WLjqClbbe1J3pxHug7sMjCBbgzN6kVz1xEXIhepVOmAedgrIfEHulfrzIw+xefp7KfPMfQmtyzKrewL3cltSkXSTsG3KvazP2CjQFj/aCEjUFycBfz+h5DyuNkSrmLzd7kvENrGuz19gAEUddQFU75dunOrj6Zr8z/ZlpbEzYlUpTC1Fq59V6IeOyFPSJmtGbtNy1RhptxjgOBOr8lc3KXEakORSabGBv1lfMJNamlfOHAX4IwQVrz
X-MS-Exchange-AntiSpam-MessageData: Nb979xg7pP6EVhbBn9h9FM0PZnshs+l01dfCealoAWg9g4jqqFRSX0ivHBsRtp89bgVmhJKXP+ayexK7OCIaFvOnuqby2ZtUBZD1WlKiJ9OrWrasB0isUJgM330wkdc5om1HarrIknpYqlGmOMR2xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: db77304f-25c0-4b97-09de-08d7e058c6f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 09:46:59.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7yQOhK2wm72hBVljD5cOvW64Hmzmr24pyJmh0WRznCztobzeoIqWlZsnFC0BnNxFwpC5byn/yaw1JOeUpxekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2742
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_02:2020-04-13,2020-04-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13.04.20 06:15:56, Christophe JAILLET wrote:
> Fix some spelling (s/Aramda/Armada/) in 1 log message and in 1 comment.
> 
> While at it, add some trailing '\n' in some other log message.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Robert Richter <rrichter@marvell.com>

> ---
>  drivers/edac/armada_xp_edac.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Note there are some other "Aramda" occurrences in the kernel:

linux/master:Documentation/devicetree/bindings/rtc/armada-380-rtc.txt:  "marvell,armada-8k-rtc" for Aramda 7K/8K SoCs
linux/master:arch/arm64/boot/dts/marvell/armada-8020.dtsi:/* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
linux/master:arch/arm64/boot/dts/marvell/armada-8040.dtsi:/* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
linux/master:drivers/mtd/nand/raw/Kconfig:        - 64-bit Aramda platforms (7k, 8k) (NFCv2)

Thanks,

-Robert
