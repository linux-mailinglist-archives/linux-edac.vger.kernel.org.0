Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC481C55E5
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgEEMsw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 08:48:52 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8930 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728810AbgEEMsv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 08:48:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045CjAl2024879;
        Tue, 5 May 2020 05:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=k5Ukg43zFZHpyzctQwJziZN+uUGrkEcDIF93qtM1rA0=;
 b=BJNiU6648r+JTFbrXVxxaTC42YbgI4vGVeAW2Vx8zecVMGyuCASDJfko5WzdBumcy4i/
 +zj5QHaGudR8t+Mrk5AhNjmJPqJFCK5QElu1uAjTclDc6zP7FhUrSwZrrKQLZ9ukjmx3
 d3xc4G8jmmHBgom5Ca8Np42Rv+PnraijJQQpif4KOth9HZGbfyQU+dJ/WWFJino3e4ZW
 28Z0KnCgyh9IIspP+wigaT4npjy5zRYg7yWE1oGngLBVTVpSoF4EFxH7TrPiTiJE7+L3
 NpgI8IeYYBNuEJCQAVaK2s3Ejf7v0rMeyjEUtxFSWGMPO98UuI6clFZ2i8YEJQylHmM+ oQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 30srykrq1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 05:48:36 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 May
 2020 05:48:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 5 May 2020 05:48:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrLEYHeI5r6EziDJBOi9b/1/X6G3sxc/VmIZ5VwYZQD0Rfa/MM4FaeWrommZt1WRvl6EMJ9OceMtCsf7wX2UkAOz5sxoGDnyY0rAqVISGrC2Limsqi57W2rp6sw+tCaZYBuYoP1joHfTuXXjg39z9XX28G6nivEQIYRz48OSsSQat5YrU8NBWFVlKOJgraFY7PGDp5XkyV7XVts5CjAmESEbcNvvnAhNekNhuyS+wZ1RCkV1pd1/F0uAH5a3bpvP98GUfxSr1KJTX3ROAQogJikeYXcKMq42BqMhv7V/GiKrASwH2SvG+H8ivDAlbi/E8y1lPg53dIx+fel0mRV0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5Ukg43zFZHpyzctQwJziZN+uUGrkEcDIF93qtM1rA0=;
 b=AJABZcfsQ5+HWn1CPZwubq5lw75ThuZAwgI5drTopj+LFCf3Pj4zjPODR2JLLx3cYPYe66oM7sTjGYaMwF6eSg5ULU3M97N1HvXqHH20UDwrDX6hVZwhZs1b2Mf/bAwnxdHxEQuD1ulSZLkAW952sAZyrFBVOFCUZ2WCMQefkg0ZC66nNZljl1JD76VKsx5OPihP2bzMwX2Q3eUobbcv8YyeKCp2nPWV9kAMG/xbCOGdIVqFAb3gFssF9xReviDaDY7LATqPdTHeFyZQM+eCcfLyb/+XttZhmI636KoU3iUka6LAtka4vdlLfoi0JL6r9/PM9MmpNq5JegNSPqCBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5Ukg43zFZHpyzctQwJziZN+uUGrkEcDIF93qtM1rA0=;
 b=Bjm6v0uv93k8o/FBNvD9uFtIB03vERyNRGQobczo4mBrd9bszON3N2+RZA38EX+wxA/3zcF6NEmo8QFAz31WbqR1fC0rLBuGZM2KXAElpOwC8I+eoi//5LsYiF3TkOy7ZLiS6mhj65pSg/FSUUyNq9W9hp8Nj3YY3ywOAv29aak=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2581.namprd18.prod.outlook.com (2603:10b6:a03:13c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 12:48:33 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 12:48:33 +0000
Date:   Tue, 5 May 2020 14:48:23 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] EDAC/ghes: Make SMBIOS handle private data to
 ghes
Message-ID: <20200505124823.j3kmcv4z53epupvx@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-5-rrichter@marvell.com> <20200424162157.GB6916@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424162157.GB6916@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0902CA0040.eurprd09.prod.outlook.com
 (2603:10a6:7:15::29) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0040.eurprd09.prod.outlook.com (2603:10a6:7:15::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 12:48:30 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9408f2b6-c8a2-4ee9-615d-08d7f0f29e6a
X-MS-TrafficTypeDiagnostic: BYAPR18MB2581:
X-Microsoft-Antispam-PRVS: <BYAPR18MB25818D0B476EFFC068990935D9A70@BYAPR18MB2581.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRpJ5AEvDzJ7TtOAox6L2KrgX79cTHQzfftN+eCoZNjxEVIGZ/cx4C1s29IwDIJPD8tJpuWi962919Qycr/jxsivsq5qREj4B+DK+8Z3N2S0r4rWWTOLl9mSZLpIGnlgTAZgcG3hLH/yKQKbSBsu80ztavcept1AidD94VwV0I39Fi4INvXyTQI7Y4wH2AXwMfkS4XnlBDqDI7ikUgkT8/y/d/lyxtT5F7mkuxP0HOqvBMZvAJEjvgjW22ozOj/pLIEPleg2YB9mfVoe30RL6CljIiaMeEiJ7aTJ+zczTE0GDtv8YdxLQUV0mOAx1EMiWyznItPaaoEdKmag9m5TiX9Rd+kxfgwYDDQTmuLeLyyGwJ0FhE08KaZvGkM67glACHAt5If4jwnskJTRxLfS/tPD7DcAZfFw1psoi8qZyjjsx0G1jNIpMMV+W7kUj2C+tKeztl4omc3aCDvPc5uGpVXOrTcrMPhIzN1X7/0j5xUD0No3LXTahlDwMSY9/upujnqLqmHLr9+q5Rw+ts1P7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(33430700001)(53546011)(498600001)(86362001)(16526019)(186003)(1076003)(6916009)(956004)(55016002)(54906003)(9686003)(26005)(5660300002)(2906002)(4744005)(4326008)(66556008)(6506007)(8936002)(66946007)(66476007)(7696005)(33440700001)(52116002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P47McyVl055drOyxWwmGcfGpwXjJTq07M219Z3jJ3t3jtxQRPRVVHfNIbV43NPK84dHTl8YuQIontMFWSx9A8AcP4cwnZC/cK10t1OAR934KLtur/LpIXX+IGm1T0MFdOl/+t7VlcXbsm4AkFaIOUyTp3u9Mx5U98ObJZERTiNy2Ylx5Ve9u6mxew3tuqYaCrqw3meJqW8p3Fpqcq/Afnq+OSCFDYe8Bsu4Ax3i6gz9IiIRQcwP5tDLVGfDMTx2eYsQMEBrNH60uYnS/AdFvElrNgjws/ED+P9vwITxjx/rXWepmwaBXjaSp2qvfwb5ito7Um9AwPVLGEoHGfVNLV+mvcn7gt28Isj+5Gp2m4hgHLeqCdAwTU+ufZAEcN6nHjChq2tfI0DoeAz2mY+j4Fx8Nx6fJoYZ4YPfV0NHmWlwlTxYWr/UDKNoRWBSP7oGRESulD8KmvYsFhQo880FUo2vk0jTB8r1Lb8pYKjigNja1F/zRqbXzKo4LBcpYBJHajEOz9TB+HwvR1LcPTkZazuFR9Trfs70halO/03FxgzbSTLiUVn2koiMjqj/hxBQEENefFvDTcwVFDXX5qCOgNulQELPuKeQUmb9d3kTP1/2T9uX7pn0BIjprLNt7OH+RHset5VaPSYmrFYfXHz0C4fUyVDrjX0FkS5NUQ83n8sGEHMNbL5vxL2TB9ZolmEPwi0IWmF2+lzv6IL8JNEIWv/WEakBS6AqA/+8tFAYOC0KyxtzQlw/TUuWvc+3b+UrFObKM18zVQpVOQwKI/zstsTb+7Lb0aekJuzW0lJbq0zg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9408f2b6-c8a2-4ee9-615d-08d7f0f29e6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 12:48:33.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCIWvS0rGWleWIwQJgbND2ZP3gzpf1XNNvXDlaz/nE/9f3+gME0z7CooMdkBtEgMyus5hWZljMfRRWVMMfkf1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2581
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 24.04.20 18:21:57, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:58:08PM +0200, Robert Richter wrote:

> > @@ -562,6 +647,7 @@ void ghes_edac_unregister(struct ghes *ghes)
> >  {
> >  	struct mem_ctl_info *mci;
> >  	unsigned long flags;
> > +	LIST_HEAD(dimm_list);
> >  
> >  	mutex_lock(&ghes_reg_mutex);
> >  
> > @@ -574,14 +660,19 @@ void ghes_edac_unregister(struct ghes *ghes)
> >  	spin_lock_irqsave(&ghes_lock, flags);
> >  	mci = ghes_pvt ? ghes_pvt->mci : NULL;
> >  	ghes_pvt = NULL;
> > +	list_splice_init(&ghes_dimm_list, &dimm_list);
> 
> Why do you need to do this?
> 
> Can't you simply do:
> 
> 	 ghes_dimm_release(&ghes_dimm_list);
> 
> here?

This decouples the locking. Otherwise ghes_dimm_release() would be
called with ghes_lock held which I want to avoid to keep the locking
simple.

-Robert
