Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780DA17FF76
	for <lists+linux-edac@lfdr.de>; Tue, 10 Mar 2020 14:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJNsO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Mar 2020 09:48:14 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13500 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbgCJNsN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Mar 2020 09:48:13 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ADheAk008603;
        Tue, 10 Mar 2020 06:47:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=My48sBqpMiHz8gZOzD73kt62jfDvD+0R5QX0Kc5Qa9c=;
 b=PfDYnxNS3T6SaDjaM4+BHX0g0KtGz7XVXjelmPxDBigY2cYKuZ0QA8xWs2z6qKPi2ww4
 CwS4hGpvMrtBSqtkAgT6ZsDrRMIyVSmAWLGmZizgMuYoMCepYS8yxPB2FWKe+S4MO00y
 yAdoXEvgiJGKXgHg6hqPyiBqPYSmO9CG7dAZ4UVID9U8kvm5LrbAvtTAmvTdhulNOVnQ
 ePwTow9kP1RmkJCFfd7UoGDCss2vAdAvkii4aG4ClP3YCuJ6KluwduCSZUoUG0HO7epc
 RD149HngShiCKlvryvNFWw88JooLSl2zG7bCo4uDA5IAJwA8HRmTcEB8IZ6ORL/wvoTs KA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yp04fkjpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 06:47:26 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Mar
 2020 06:47:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 10 Mar 2020 06:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQfrgV2rgSKg+phCL4vEAqBYJHxWvW8L9AroomAe2Nbis3B/F0hXF2VWNZcwZi5e++w2BRtmXcBnLC5DAiHYaSj+Y8waDaqjUqHcsUsgD50eOMftBexf6Y11puvv01t0WEo7BrEExUs38rxjBQEpcxwHoOCNHK6RTs8D58NUdhx0vHHes5Rnvvmsxw9dyTffPHIYuTObPlKgCTT87PZh0xsUc1axzsTS+VFVw1u3LynT10KOFv6a9MIr4TOUlIJlKKqOBFzSkJmdEZw8RgAhn+n/iZhFEO0/QKqibzB8K2su+4q5XFfaFcueURr4KTyW/vk9OQ5HbvZ7/T4FymxiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My48sBqpMiHz8gZOzD73kt62jfDvD+0R5QX0Kc5Qa9c=;
 b=kzAudi0ZyTjrWcvlEITRHxQ39Jm2N2uDavIs7QwleWQ6j8xYOSzROS6gyEIGsVIb/w2jeVBDx6eLexi3wpD3jkrI6MsNeg6VYvQgIK+DukNJ9pHgH1DMIifXBZuvHG4JpmP8CrNjAY3KcinSBGdH3qVI42DnwcF3egdbcni8fPKU0vOvJO6pb33+ojNj7J+a+Dp6eY+kS0dRU4fWyNcbJlqmSODOXtE6pUl8M2uDOoFyB3ny07M2V/kbof7vOwD5zb7cDd2p8IsMt4WxHC5brv4TalbwnBsVGZiVGan+tnvOpGHqg/z3fxnF36pcji+Yjuo6an4S9OMIlxVCeXfoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My48sBqpMiHz8gZOzD73kt62jfDvD+0R5QX0Kc5Qa9c=;
 b=DhhbvSZJI4nrOJND7NzCPVUNfuCMe8qAwYsh+G739fTzVYbtQBmOlpGiJ1KX4uBIaNnBnCH9MkxqG8NRtOEhFYtq/q4Y5AmoNEfkqbz81AftavcDg601JVifSXD6A56dpULha1Egbgh753rifIxAldLAkW2Q4tf11h50wAEgidQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2637.namprd18.prod.outlook.com (2603:10b6:208:aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 13:47:23 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 13:47:23 +0000
Date:   Tue, 10 Mar 2020 14:47:13 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Hanna Hawa <hhhawa@amazon.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <Jonathan.Cameron@huawei.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>
Subject: Re: [PATCH v9 3/3] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Message-ID: <20200310134713.n4gtrgtjdjymmgm5@rric.localdomain>
References: <20200129195016.956-1-hhhawa@amazon.com>
 <20200129195016.956-4-hhhawa@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129195016.956-4-hhhawa@amazon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:7:66::17) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR07CA0031.eurprd07.prod.outlook.com (2603:10a6:7:66::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.7 via Frontend Transport; Tue, 10 Mar 2020 13:47:20 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81566fc2-4bbc-4ffa-be50-08d7c4f98fa3
X-MS-TrafficTypeDiagnostic: MN2PR18MB2637:
X-Microsoft-Antispam-PRVS: <MN2PR18MB2637E1FF1C4DE324D6C4ADCFD9FF0@MN2PR18MB2637.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39850400004)(396003)(376002)(47630400002)(189003)(199004)(9686003)(4744005)(26005)(186003)(55016002)(66946007)(8936002)(66556008)(16526019)(66476007)(6666004)(8676002)(53546011)(1076003)(81156014)(4326008)(956004)(81166006)(5660300002)(7416002)(6506007)(7696005)(52116002)(478600001)(2906002)(316002)(86362001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2637;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iDPY63OFmKeEvxkYoUabbu/05T+TPyoPb08LDX9pJ+TmJYsHZdIm4MaKygNjRMXSUDuzcErYEcTBQQWmXootgCGYaWmH00biqMTCujwo47Gp0WA5fAHlqqeu8C1D+Ka04KIY3J9ZYk6SEV4xXcsGnLOaqko/F2gWtEcVa9srBk8B5Ii6w0gw9J6Kfv7ljw0ltUHyf+yNd0jM/QJvUu9HRgLLXSTzWR6ZUw5zlJKwxexZNzCB2FPRq2PT61wBGwb+DBI7G86833zaVp99KQvec+6hbYUasqkX46uCmWuLtTkSpyH2WfpFiA2QqH3VhgFjbkDHs1I+1DfWKT4TaiGah+EKFMzxdjD4d/yFiCPKy70/emx/YNO4y2AY4T1NCS+XQsjs4o+eXrtdUORlIE0bCxAhkzNLxmZO350K2Xnbmvfk7ZShQOQ87GQ71s0niGz
X-MS-Exchange-AntiSpam-MessageData: ZDeLOLbfR76Mc9JtJpCvKO5Ao4Vr7gMwPWX9x7ljlsQ5/a62Ff9oIvp0AUsylfFWX+cnMv4OS2QCCRMz9VLSOsxWgNGShhfF2XPyWyxcDI7puOTDrub6xvxV+kf3admSCoMv5q1AjpVHO1m+oA5wEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81566fc2-4bbc-4ffa-be50-08d7c4f98fa3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 13:47:23.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggssCBrCi+hHedYGRAFzuCAbIIF8XRQF9tfv90kVxC1x4rTU5d3FSIspTJ/Thc+ErvnnHkRTDjUDfCm/+tHg5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2637
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_07:2020-03-10,2020-03-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 29.01.20 21:50:16, Hanna Hawa wrote:
> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
> report L2 errors.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  MAINTAINERS               |   5 +
>  drivers/edac/Kconfig      |   8 ++
>  drivers/edac/Makefile     |   1 +
>  drivers/edac/al_l2_edac.c | 270 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 284 insertions(+)
>  create mode 100644 drivers/edac/al_l2_edac.c

Hanna, most of the review comments by Boris for patch #1 (al_l1_edac)
apply here too. Please address them.

Thanks,

-Robert
