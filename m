Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE891D9365
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 11:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgESJfe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 05:35:34 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50922 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgESJfd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 05:35:33 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J9Ysli028361;
        Tue, 19 May 2020 02:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=wye2s7Y6/D7BeBG7MUQXejzVsp+2/j4jgeTmtRkOX8Y=;
 b=risA1237humi5+aTv19d1Nypx887gbhqyyWj3fRRlgNn1py/ROUUjiLg+Ds5PYlO/kQy
 TVfffa1x4vO4nPcV7fB68sgQQ0y6UdOfeu/2lRxswqDSbSbAV6/yybffxg7fPjP0baFS
 twasGEaofpitKZQMpDRXhmssMv89T8XxW6MCErMMou4h/4pjSrnyghV+ZcWUqMS/TO7F
 sa0/jHKAA3EpIILLn148l6TeEO4fvwwNY20CzlGQBR+upVRga276XncLQenpecHuFi5c
 H4kx3O/RAEXZymbku9DIa+DyCM5M3NG4vxqaq5zmR3MGnNBlVJxQidtZ7S7IIvBu6aXo Og== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2r3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 02:35:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:35:20 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:35:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 02:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkDkhjJUrk+MuCxPAgZjmd6u10KntwbNYBn41C4iRNgt7uPovSEx8Ta33n7XYCoVDn2F7wUGJKmMq3ahFQQCZ5guSU8HLKywP+8VGNuBVDC3mztsbjmPiwEBL84trViPc8aF/+0NPIvjOnw4U1cZUC02KHqxMSGaC148rvfZMH484Ng6/SS3fHAiS7xYL9iQA9fd5KnmJ4cYNTuM/KwVYhUJESPgR/EoKQU32TUJKaJvC4g+uOJEE1bDbehaPRm5ShTxKM4lmSf5JZUwBECDpN25bxelXOjfDUQDNL32rkVgcva/y6sTy9k5sqXS12OqBmxNZ90ATzCudtP93KTm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wye2s7Y6/D7BeBG7MUQXejzVsp+2/j4jgeTmtRkOX8Y=;
 b=YGMLfASy4J/7IQ24TS9RANfft4waCIC6ydQaZX6N00GonK2qXq2gdBAh8ll3NxP+bi39aU2B2+dwoPbUI+dxKvE/RW9JwfpJfbMlC0JUHHc1oRCev+XV0AoaAWaj9hyCrA1q7S+vCFiOQOK+71SRfh1DO7Msd1kpUhDMV8uD2u/YjXqzmAPeIV1zgQiVHhsJP6OPDyysfwdxYPm0AnB1WeiAHi68hRMHx5O7jFKycSze3rL6STlru40e4lqzJdLxmHCAyj/F/iL0bDR5awjUPDCWVTE1ijw5QNGa0Hc3PmVsd0pDHO+X5Ov/G5EExnM7CxkrfdY2kkFSanu0FWjLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wye2s7Y6/D7BeBG7MUQXejzVsp+2/j4jgeTmtRkOX8Y=;
 b=Je0VaSnce2uIiAxy+BTncEmrjH2woz4Cuh5QJDjoZjdeEP5YJtvV4jQ6N8SYMMHO6UkfSExi2gJHasCvKHGUr1bkZYBNMVE3cVVNYEu214R+7b4W7OuC+9So8G7dBCSBjcPnuArRCU+uRv1xUzWN6F1CIQTSrlQrRVYb3FTbD7A=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2534.namprd18.prod.outlook.com (2603:10b6:a03:12e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 09:35:18 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 09:35:18 +0000
Date:   Tue, 19 May 2020 11:35:08 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] EDAC/ghes: Cleanup struct ghes_edac_dimm_fill,
 rename it to ghes_dimm_fill
Message-ID: <20200519093508.towjo7ryoecaxb7h@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-8-rrichter@marvell.com>
 <20200427135923.GF11036@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427135923.GF11036@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::33) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0202CA0023.eurprd02.prod.outlook.com (2603:10a6:3:8c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 09:35:16 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 054b35ff-920a-45a3-2eed-08d7fbd7f16a
X-MS-TrafficTypeDiagnostic: BYAPR18MB2534:
X-Microsoft-Antispam-PRVS: <BYAPR18MB253490AE9B01D5DDFAA73333D9B90@BYAPR18MB2534.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KblXvX+VDJcA/zPqagY/+C5eccXUYJ3EM+1kl/CToJ6Hx06TEY5QwUz7ZaZccOpOP3M+9ZfTn/X9yZraNH+7Ugus39cy4w+iyKpOq1nyVj1DwuuMJWb5JX6V4o8M0g2yRf+/vEqMuodfbv4jv28W1Ap+NeKWbgBDZm6mPN38IjVekc0sejAmx+UJwZnoCoSSZgBLQGaPb12Jqg/GsOKtsXu1HuQctu/e1ksG+nqfSfKUfJI5zFMLiK+gFuZgVoeO7rC4vL3vooszE9EwklWXbr6vlqOxV6N8qsji2ly52Zx5ASIjO7CyCJz4ejpxNoYfrnUP+5HFgs5ffPtBRiieiKthSe9SdpPyj8FAoDlZly5lLBBQpRoYeKewpezw/9GF4mAWotw4Vi9JyKj+bhyZS3wvaD20A0T21n8c6b2mhQZZnZ9skY0RtB/7a8pZoO7W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(54906003)(316002)(956004)(26005)(186003)(16526019)(53546011)(6666004)(6506007)(1076003)(4744005)(66946007)(66556008)(66476007)(2906002)(52116002)(7696005)(86362001)(8936002)(8676002)(4326008)(55016002)(9686003)(6916009)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G7kYoRMOMUfe56ga9FRDPyE0RXmopcZpTqR7xl32LmmrOohGAt2fMCLvpIm9NIxQmuRxzK2NmuCMd+fbNMucQS1stPGBD55qN7OADOcBPMZ4TMKG5o7HkYoqSZn9GgDJlw00aURqmXuCHcBquYaK2ttCoaPjpKTez2mG2+qXJ0HkPTixBQx7irT0pb++rGIgE0/zjQcPkGLqot4/ZAd6zq8Dl3kVvAiSArVmjA0yh1vxv5O2f98sdmRnZWwUiY+FGwj1Euw/E8ppUNS4JY2nTQJlQk6zXVlbFFL6Y3rng7rytyygcd2LYvqoTriAU9tWq2u7lPW/qTbfwpEruMAm5D8RxaIkDHNycuzlpG9M0NFZGyEB7aa2qbwtJ+cR3irArVAfF6PdRSfd0u2AGz4Vp8qV5X1cqA7WIX1ulDU8s6qOgbGq3q0QOrAcYYiZz36auNAwfFaWeZwJpJz2OfTdCIR5JSsbeiKwWVeUZjQ3So4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054b35ff-920a-45a3-2eed-08d7fbd7f16a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 09:35:18.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk3qcu6VcWbaFNvztM6VJffOd7EXyD+AEe6ueYngf13tpvtv+WfC2CEvTkayfBXHzZMHLULbNBmAOQJCL6BJVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2534
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 27.04.20 16:00:43, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:58:11PM +0200, Robert Richter wrote:
> > The struct is used to store temporary data for the dmidecode callback.
> > Clean this up a bit:
> > 
> >  1) Rename member count to index since this is what it is used for.
> > 
> >  2) Move code close to ghes_edac_dmidecode() where it is used.
> > 
> >  3) While at it, use edac_get_dimm_by_index().
> > 
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/ghes_edac.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> Ok except the commit title is wrong. And yes, pls keep it "dimm_fill" -
> short and sweet and without yet another "ghes" in the name. :)

Fixed the title.

Thanks,

-Robert
