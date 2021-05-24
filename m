Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375538F1AE
	for <lists+linux-edac@lfdr.de>; Mon, 24 May 2021 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhEXQoq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 May 2021 12:44:46 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:29984
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232900AbhEXQnO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 May 2021 12:43:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDo10s5/s97ePxlGKODymT588o5gNfAjY+UW6iq/FuX/e5yMPXopJjgJfo8iy4aS44xCKvyh/KsGF8S/i7q7+MbphD8yyKymyl5tCrpNt/XlnZ7LYWu5K9QXMs57mhOEaZd89jaDdHIlpvAK4bpZlc2LZfM+VNxK9xmtBI0ihUOx2GjTQMHgssBIZ+7gh8C4xPfwbbFHt/RBhp+AQQjnOpQoxd0rPph3nXDrxCttVogt93SfuXQZbz9pNf2kXkQT37ckUB0h7V40Xujxwje0l8WLsOSa0bus6PYPKg5clnp6NZjXY3vMY1fSzvgPVd7NKRA4zy5CGGSv+kYn9a8w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ecy0jDmuP1IaQ2SlBDUkln3R5rm5iORDa6WMv2+HKs=;
 b=hqW3fPRVRqSUPkeZMKe4jTKEc+BSbDoX44TJ1bGa+FIXJowpXDJv/sQGxcBDTaGZMvpE4hKGYJyrvWuFN27lj9oHwYGb0L5ljOYffB1mU7j6aGtkO1v7uBIzbII3H+v0EVAefZLQPQG8GrhimMWCQO75/o5c45uf3mEZad0+f8jW7DCyf6CXEOhb0e0K019I/e1wOwKvPnqS5Anwy9GZHd406ZHOjgfvSVYN2b8/ErIvvKUx4oPVb77htrqPkg3wr/vVmwRA/kevJ3DfqPAj4cVtNMKDCjjMEvCcdeZHV0jVoYVedKlXTnUZi7sBx7swfkc3Ndf6liSEwKBBSqoxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ecy0jDmuP1IaQ2SlBDUkln3R5rm5iORDa6WMv2+HKs=;
 b=e6A5YQf1h7XQgnwY81c/Jrru91WTKS9L26h6n/Pj5Iol3JYNNgMO6lEBe8m1CCDnB/IDVebZ3GKwV2cs+3hAd/uc+UHbaNvngsq82KOzJTN1yRgWW+n6TD2i2kSyBivgouz86mnTlGTseGqdK4KgSt58D4LI9GQAThCi2h8JHCs=
Received: from DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 16:41:25 +0000
Received: from DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961]) by DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 16:41:25 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "M K, Muralidhara" <Muralidhara.MK@amd.com>
Subject: RE: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Thread-Topic: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Thread-Index: AQHXRnnw9g8yPYrHUUaGhhu5UZ7hSqreiM6AgBRgQbA=
Date:   Mon, 24 May 2021 16:41:25 +0000
Message-ID: <DM6PR12MB4388D2F749166A72974718C6E8269@DM6PR12MB4388.namprd12.prod.outlook.com>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <YJq+ca+kJ4cRl5B8@zn.tnic>
In-Reply-To: <YJq+ca+kJ4cRl5B8@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-24T16:41:22Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=451af675-94c4-4a23-96dd-617c42d9a45c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.218.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64231ff0-511a-4e30-1eb4-08d91ed2c561
x-ms-traffictypediagnostic: DM6PR12MB3833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38339522433BE2CD31ADE141E8269@DM6PR12MB3833.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzn3JrTDpqEKkagvnszdwPrUT9/dE8W6J7tSrBzyUSjKIfYh2FJNmfs3MH4slwkGDi8ZxBF0og1gXWJv0xSRsC9xgN9sU50GlrnlmAkUGk8qtztSEpsh3wT4Ggu7OFEvxvxod/GzHvm45GtjVK4HePJLmncSWq0WLo1fypPSiA5omIhZvUKXvq0I+PVO2aznDP2PvCIBNh6+uxewk0QPJeO8eZG+hhIxzwfdeqoZ5Ylur4QqvuApzFyiiem67+6mCjDX7UgKIdXCSGsP5UQ9wcVvcgrFrg1FKZeRXQIapbj6bIrAvve+/5eoNEeMfilENwxl3h/lJunKU+n11Y+Sudbp24BDSHr2llzWrN+PkM5oGivPfKFznXqSkxWdWpFM/qTFNMIlmJ1HRvrOBsEl4S31P/f91/z/biHBzPhRrB3SvlX32u5HczV6xyNYjV2QttB7lKJ4AhWHfq5BXNO25tgJf6aZF3D9fYup8sZSlh4JUK3Aoz15MXrZP82ZwGkB+kkrdwjnH0uFS8zt50Ymqm8UtM3jz8bK+Awx/d+IWTEBM2IVV3/UzdSC7x9l9od2imHLnNiDA2EvJ5L12jmFIIhsTZvgcd1V0iHz8L05GruFJJcKZ9n4Z+gsxpvlO2U8fqf+AoSXnNydsFspdztRedwYLMhzqXMr9oRdR5e1+OSADvPRVnJUCSYPBNDIBwdv+dYl3yssApfWoDKiWeb8Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(122000001)(38100700002)(76116006)(83380400001)(55016002)(52536014)(8936002)(6916009)(15650500001)(26005)(8676002)(45080400002)(5660300002)(66446008)(66476007)(966005)(9686003)(64756008)(54906003)(4326008)(53546011)(478600001)(2906002)(71200400001)(86362001)(66946007)(7696005)(6506007)(55236004)(33656002)(316002)(66556008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?asBP+YdVwcngw6ECj00HRo/z4oTzI6mrbwzN4RyKfGcVjqGk4yXH06z6dJNN?=
 =?us-ascii?Q?hVCAuVlyd7m4m3y1ICs/GpSiVnH5oKtHcs+JDMloxQ0wQ3tyTS7vQ+rcCIwb?=
 =?us-ascii?Q?BHuBqDAi1mUSarx9dcmS3CJruSBtW75Lno+z4+oSm2IY1lv0bnQ4OdCmF6/I?=
 =?us-ascii?Q?iWD3q8CcJZdF4i4HM8VWgRP5FsndvZE8SIyFUt9GyM0F3qKi2Bjmzwhv7pJD?=
 =?us-ascii?Q?1ua8b4KYx/463HjkmcwL5C97Wbp98gZ4Vdo666ZdZZwRFtbYqg4uxoC9PmtE?=
 =?us-ascii?Q?rOImmxaHnmOMjopaaHG0MWLdaJWxbene4aRciHvOl9yoQbej07jCpfVRO9hi?=
 =?us-ascii?Q?9314KtCur7gSVexKokFoDauyPscxZl0IWV3Z3l6LtrJ9APXpYCOenJrVGNHs?=
 =?us-ascii?Q?0fsmwgebGwyO89+zrSdQyRlZ60dWyV6a8LqfqqQrbsGtkxoEqTRKokQam3b7?=
 =?us-ascii?Q?+2oFezoaMNXMAWmtR0Y9+PMikVmz2N1yy2Z1D1KssZoS2RCONQeSzmjwZ/HY?=
 =?us-ascii?Q?yOP79IxlmqVjLHTJc2Ni+sxvzJoLqF0BvMqSfsIMzmIy3E6xd1KClp5LLzIa?=
 =?us-ascii?Q?noUKdj1WE/5u6+dALmaB4LEnDS/+SBOUplCappQlVDVpNs70x19ED+K/QzdG?=
 =?us-ascii?Q?vJf1S1DaL9DnSStLX0REYk0SIJnC0/hYtikJy/8gcskdd4vBryqEuXp/AGWl?=
 =?us-ascii?Q?LOcdzTDcF2K1Mvq9y0aakWjY29wwDP/yG14fx/RCFGVa6A2elln4GdyYEvVZ?=
 =?us-ascii?Q?pE4s/8PJNL9/5c0NeSYHS0LIsJQOvgZ5R3vay970UsqJyrHPKmWFHT/CXB29?=
 =?us-ascii?Q?wbjT5sdg5JHB2mNUJgOd5OPs8IMcXTUOVRpz1roHrsE0tUeX/s2VEdlsa9C5?=
 =?us-ascii?Q?ezA78ZR5F64iJBDrt4LZQwKFmV5pztqhLrknbVlHgtF0PZaJaLvUOw/TIrIw?=
 =?us-ascii?Q?VsHspHy5RBC8bqrurYJCq9nocC5in05qcaNcfqQIWR9YSNo2OvvUQCVtqr6B?=
 =?us-ascii?Q?vLOiFbxSbHvWYAEL63C930N3iyxJ5DW3yJO9upFdGbln+tVAmDmD0DzHogYF?=
 =?us-ascii?Q?6qzPkNnTm37sGC5QtRCw4+aNoOxdgHfn2Nqlnej47GoGLN3/eMDvzQv1++H4?=
 =?us-ascii?Q?ZWBSUsggmL7Gf408qFzeUO8ObdZml15so7F8Dd8QBdojY7hB5AUhWDwdba/y?=
 =?us-ascii?Q?b49tScXBJZWHl/FvIvYTPYsvaj++yLaToLgAxsRBzVfVSn0JzD58peP9vvDy?=
 =?us-ascii?Q?iPthWbtet16I+DwoDr1lpQcxblZpNfWTHFsANsBF3mcAETmbXodfyntwj8mT?=
 =?us-ascii?Q?8+zMRCeUGGMm/shWmXhzLGSO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64231ff0-511a-4e30-1eb4-08d91ed2c561
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 16:41:25.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHYU5VvyyvhycC+Tv0lVuSfnhZocV9iKqbMm0nDJ7Jg64i1pMNYZOmm92cL1kMcL2EHaIQb1iInQ9i3r3LXb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only]

Hi Boris

My apologies for delayed response. Thanks for your review comments, will su=
bmit a v2 shortly.

Regards,
Naveenk

-----Original Message-----
From: Borislav Petkov <bp@alien8.de>=20
Sent: Tuesday, May 11, 2021 10:57 PM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; mingo@redhat.com; mchehab@kernel.org; M K, Muralidhara <Muralidhara.MK@a=
md.com>
Subject: Re: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types=
.

[CAUTION: External Email]

On Tue, May 11, 2021 at 08:55:36PM +0530, Naveen Krishna Chatradhi wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c=20
> b/arch/x86/kernel/cpu/mce/amd.c index e486f96b3cb3..055f3a0acf5e=20
> 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -90,6 +90,7 @@ static struct smca_bank_name smca_names[] =3D {
>       [SMCA_CS_V2]    =3D { "coherent_slave",   "Coherent Slave" },
>       [SMCA_PIE]      =3D { "pie",              "Power, Interrupts, etc."=
 },
>       [SMCA_UMC]      =3D { "umc",              "Unified Memory Controlle=
r" },
> +     [SMCA_UMC_V2]   =3D { "umc_v2",           "Unified Memory Controlle=
r" },

So this is called "umc_v2" but the other V2 FUs's strings are the same.
Why?
[naveenk:] There is a possibility for a heterogenous system with both the S=
MCA_UMC and SMCA_UMC_V2 variant of controllers to exist.
I will update the long name to describe accordingly.

Also, if you're going to repeat strings, you can just as well group all tho=
se which are the same this way:

        [ SMCA_UMC ... SMCA_UMC_V2 ]    =3D { "umc",              "Unified =
Memory Controller" },

and do that for all which have V1 and V2.

I mean, gcc is smart enough to do that behind the scenes for identical stri=
ngs but you should do that in C too.
[naveenk:] thanks for the suggestion, I can do this for the other units.

> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c index=20
> 5dd905a3f30c..5515fd9336b1 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -323,6 +323,21 @@ static const char * const smca_umc_mce_desc[] =3D {
>       "AES SRAM ECC error",
>  };
>
> +static const char * const smca_umc2_mce_desc[] =3D {

Ok, gcc reuses the identical string pointers from smca_umc_mce_desc[] so we=
 should be ok wrt duplication.

> +     "DRAM ECC error",
> +     "Data poison error",
> +     "SDP parity error",
> +     "Reserved",
> +     "Address/Command parity error",
> +     "Write data parity error",
> +     "DCQ SRAM ECC error",
> +     "Reserved",
> +     "Read data parity error",
> +     "Rdb SRAM ECC error",
> +     "RdRsp SRAM ECC error",
> +     "LM32 MP errors",
> +};

...


> +static const char * const smca_xgmipcs_mce_desc[] =3D {
> +     "DataLossErr",
> +     "TrainingErr",
> +     "FlowCtrlAckErr",
> +     "RxFifoUnderflowErr",
> +     "RxFifoOverflowErr",
> +     "CRCErr",
> +     "BERExceededErr",
> +     "TxVcidDataErr",
> +     "ReplayBufParityErr",
> +     "DataParityErr",
> +     "ReplayFifoOverflowErr",
> +     "ReplayFIfoUnderflowErr",
> +     "ElasticFifoOverflowErr",
> +     "DeskewErr",
> +     "FlowCtrlCRCErr",
> +     "DataStartupLimitErr",
> +     "FCInitTimeoutErr",
> +     "RecoveryTimeoutErr",
> +     "ReadySerialTimeoutErr",
> +     "ReadySerialAttemptErr",
> +     "RecoveryAttemptErr",
> +     "RecoveryRelockAttemptErr",
> +     "ReplayAttemptErr",
> +     "SyncHdrErr",
> +     "TxReplayTimeoutErr",
> +     "RxReplayTimeoutErr",
> +     "LinkSubTxTimeoutErr",
> +     "LinkSubRxTimeoutErr",
> +     "RxCMDPktErr",

What happened to those and why aren't they proper words like the other erro=
r descriptions?
[naveenk:] Will change these into proper words.

Thx.

--
Regards/Gruss,
    Boris.

https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeople.=
kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CNaveenKrish=
na.Chatradhi%40amd.com%7C9159e5c1aebd47969c2508d914a20789%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637563508427766424%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3D%2FiHUZDkg99NnGdDrOCK%2FQWsui2yA1dADCfG%2F4xFr%2B7I%3D&amp;reserved=
=3D0
