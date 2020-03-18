Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0436A18927F
	for <lists+linux-edac@lfdr.de>; Wed, 18 Mar 2020 01:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCRALQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 20:11:16 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47472 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgCRALQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 20:11:16 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I0Afu0014231;
        Tue, 17 Mar 2020 17:10:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=xPpOf9VGSV8QyFuthDDqxHJtFEn1Q141apMa41IYRug=;
 b=ODRuonwbMMlk8dMg8m/v0lStt6iUCIvW3L4nUX+/7cBme4nLSrgftJxZLTcQjkfvjlxK
 qTanXltBjVF+aRlSRSn1yFjgyMd8NpAsW9+mEX0bfKMkv2nZ9E58UIHgEGp4hhAxECx8
 +4xKPob+X9ZgywUxlFLJ2ud1zxGjhnT6k7vXoA/uSaCrh9EwrB/fb+Wj650+ElnkjYkq
 UhXPFVVnsWHiVLlsgm/C4eSiiVZ2ibKpW2bvrn4nZkglymor3ScH/YQAIpHsARp24v5b
 Gbjt2E1Y8xcW6PX46lJ4Vgef4evandrpU2tUTk0fR/67xLDosIqjvLJoSEhPUh0fXajm XQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yrxsmpfsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 17:10:52 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Mar
 2020 17:10:49 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Mar
 2020 17:10:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 17 Mar 2020 17:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKvQ9uuaZZoZdhzzYYft8ytq4pef5/HRfm5Yr5XyHdiFI+UyvNaa2pcKQi/BG3ZtamStg5IBSCdXTM9s74JqjAvdyQK4ZNwpw5pcVXRoHjshu228kvRvGzKLGo2Yjuo3nN/TR8yVY2v5HaxmcIM4REdxcgYHqQwPnYOFKl+kcKOyrLTdD1UcyZ+lXCn4z6e2Zxnrb2cr0pG92YyXok6EZLDQsw2P6I7XZOMDLGzUswnL8V2/RtouTl9rLfTRuv+BpH2keOa4yXohE46Phscb/GwAx98lm8xq4wnwP90deb89mjuDnqub1dGfAmjVI8g+HMLmG/neaBub8XMwa7+QIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPpOf9VGSV8QyFuthDDqxHJtFEn1Q141apMa41IYRug=;
 b=CnpTFXNBxQFj/qVFP042btC1v9FdwVLR/tyXYNiK1CN3J4/IXKlHdohxSK+n4NmV1P6gGXhnI2yOavKpbMtpgQ1AlTKLfPGiFDsvWz7qdO+z8cAKH3GLOsHIoqq9TnMITDrs1xBk4gk7gmhjSy238aKDEz6n2Dv5qnwfgOPWQWMAAkcUi5hkBSVb/Z7yF3POPcqstbVXU4/fuy3Zm+wxhc7CwZqDShSNVTyvUEdAXncZrtwWD4D2rak+am40tgnVhaxeujI7YH7dwAXrbWCAy6C6X8PgY/INAhVCdoPG5FcPW7z8A3qW/FxLuZ5QWJrVBJkrNQqhTt1PA3d/5vG5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPpOf9VGSV8QyFuthDDqxHJtFEn1Q141apMa41IYRug=;
 b=gEoJCagW+7yMfk9tBCTVRRWCTrjWnhldw+4vCkwgp1GzA5nuL5oDtaDSKSkALsa0B11H3e2s4XzvuYVxu7iGNqk03mfZNHuw3v1AUiU2OtMZuVYFU9JzU43y98P7uRPyeCGEFzRORq6k3lRbbjMkzkcvjZNBNiJiJN6keh2UJpU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB3606.namprd18.prod.outlook.com (2603:10b6:208:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 00:10:46 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 00:10:46 +0000
Date:   Wed, 18 Mar 2020 01:10:39 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
CC:     Borislav Petkov <bp@alien8.de>, John Garry <john.garry@huawei.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH 11/11] EDAC/ghes: Create one memory controller per
 physical memory array
Message-ID: <20200318001039.i6w3hd4cp6lh2ppr@rric.localdomain>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-12-rrichter@marvell.com>
 <20200316095149.GE26126@zn.tnic>
 <924f4c0e-1f9d-e7de-17cd-466eb3a74d90@huawei.com>
 <DF4PR8401MB073186E9C0F1514827781CC582F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
 <20200317225039.GI15609@zn.tnic>
 <DF4PR8401MB073148816BE1012B3AE729CA82F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF4PR8401MB073148816BE1012B3AE729CA82F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0164.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::12) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0164.eurprd05.prod.outlook.com (2603:10a6:3:f8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Wed, 18 Mar 2020 00:10:44 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c597d4-8b0c-42a8-1f37-08d7cad0ce77
X-MS-TrafficTypeDiagnostic: MN2PR18MB3606:
X-Microsoft-Antispam-PRVS: <MN2PR18MB3606D2228029F3AB143849ABD9F70@MN2PR18MB3606.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(66946007)(2906002)(296002)(316002)(9686003)(66476007)(66556008)(6506007)(53546011)(55016002)(54906003)(956004)(52116002)(8936002)(7696005)(6916009)(6666004)(478600001)(7416002)(1076003)(26005)(186003)(16526019)(81156014)(86362001)(8676002)(81166006)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3606;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHlci0sxtPeBlaZUbf6mtM1kiKHlgo9UpIdkCb8YwEq4jO1FUYGdVD+XgLENzkwB4kjxk8PJIFvT+Rtn3wYmCi9nXO3mSFjmC7nI8iN3fkQXWzLwmRrGPv4mntIN/TFD9rRi67n4mMlPGMmKOrlBBae8mEVTJ9LLGWxkyOJoVOI+t2jcyEnJnQmBCQpKA7P0bkoQj7ihGOIGewIm4SOWpvLXL4+5/Nkxp2yfexuwyEqyFCXjfu0oPSnJ/E06qnWMhTlV7MEp6HSKy7TRvyDIi6O99B/oiKSlPWRFa1hj1WTt5ApZa5BdUp3jc0ciTMx3kyQIu/CoJtOpCoLB47FtJawf6VfTCQ+jsyspTo18jpwFj66y6UlCzgfhnmXFeefYGUL+QBpgwCgkSsc5y7SESMzZgrWOs9SLcG/vxptfwZPqPp7B2rmTn7pbRukgjS2U
X-MS-Exchange-AntiSpam-MessageData: DdLz9F+++HP0TloU74Nl4+m2S6I4f5EuEzl4eXnyAWbGAJ7tBGoMhD2d2f4lbLi9wt8P93XRM61FXIUnxnjj6Ndh2wlhAMx2HzWJ1g/aCGPL8zFvJmC+JIg+p6ZXR23NgCZnicxrhwdC80YhhzRvzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c597d4-8b0c-42a8-1f37-08d7cad0ce77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 00:10:46.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5j0QBprgE8V+r2fzX7VWDPq/r6/VYfBZ689hyciIrqkzjlMsV934t/MWGhYUGKXIK9tAZO1ZEwHCQQz888mHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3606
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_09:2020-03-17,2020-03-17 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 17.03.20 22:53:09, Kani, Toshi wrote:
> > On Tue, Mar 17, 2020 at 10:14:46PM +0000, Kani, Toshi wrote:
> > > > > This is all fine and good but that change affects the one x86
> > > > > platform we support so the whole patchset should be tested there
> > > > > too. Adding Toshi.
> > >
> > > Thanks for the heads-up.  I do not have an access to a test system at
> > > the moment, but am checking my colleague to do the test.
> > 
> > Thx but hold that off for now - Robert is reworking the set.

It would still be good to have a test run as the general concept wont
change and we will then early see potential issues, especially wrt
SMBIOS/DMI.

It would esp. be interesting to see how the node mapping reflects the
memory topology:

# grep . /sys/devices/system/edac/mc/mc*/dimm*/dimm_label
/sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
/sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
/sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
/sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
/sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
/sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
/sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
/sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
/sys/devices/system/edac/mc/mc1/dimm0/dimm_label:N1 DIMM_I0
/sys/devices/system/edac/mc/mc1/dimm1/dimm_label:N1 DIMM_J0
/sys/devices/system/edac/mc/mc1/dimm2/dimm_label:N1 DIMM_K0
/sys/devices/system/edac/mc/mc1/dimm3/dimm_label:N1 DIMM_L0
/sys/devices/system/edac/mc/mc1/dimm4/dimm_label:N1 DIMM_M0
/sys/devices/system/edac/mc/mc1/dimm5/dimm_label:N1 DIMM_N0
/sys/devices/system/edac/mc/mc1/dimm6/dimm_label:N1 DIMM_O0
/sys/devices/system/edac/mc/mc1/dimm7/dimm_label:N1 DIMM_P0


Thanks,

-Robert
