Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21873DAACC
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jul 2021 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhG2SNi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jul 2021 14:13:38 -0400
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:10241
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229807AbhG2SNi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Jul 2021 14:13:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FScfFM5BwuJeTKIKpBFOzZ5a+e5Sf/N8kjVGUKErYzkoe7hTboi0/+YbMlPk+vzovkILCdvPBeF7PJvDg9hainai1/ogxJxPN5QwFATmyBpTUky3fhptv88nVNCAetfqmg+hDFEikBMmj/QSiOTCdKcl5QzeRvw4lFC+/OKlwgyB/x2wAOJl5Kyh5c0wP8TNQ8LMMl8aK+8mQL5x+qUst6cPNytItXdSeRftFPWJ0LdihUSbSbOyZrcBXoxJS83xI8ykavQO+ixSPxl4giiASmfCH8eCRdMnbCqsP0Xnc6KkhTUxVTdN5k2aRb4FMRkLsOzBT4WS08XDpGELuWSqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QOn636FVM/DmiTVP/9tpF2D7rUWFr5iYd9Ufb/elV0=;
 b=PbUuNlIP9us/lhEyo6uhzWkZEsBHt2tnXgZmM6D5OPI+aSUyhbPT2fbSroHblcGIEg5dOJGlKc7hFfE04bmzkndsJSEWDUt1X6cVlfc+hOfmT+sbnmHZYNLPwpMPBiAak/Hm1g5uXofaoQm3DijNEFaLNksWVVXWrVgX91FHrwQEQi3jgQnequRkLxPLf7ZKo13K/S/OteO0GVPnr0YCpLo6GLUAJU9f9LfDk2Sj+xGG7JCfX03cDJb8ptqpiSh7dZ6BByO9oQgVUWd+5Wpc3dKF/HH1mwWcAQqLNwgv73gut7rLMxGVI6DU2k0LYXsSX2P9FfMNR4Iy0/k2bZAf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QOn636FVM/DmiTVP/9tpF2D7rUWFr5iYd9Ufb/elV0=;
 b=v+gS+BuYf6n3toBUt4659Rf+NY9bkJagr+dLRCetiXfR23MvHgdzO0S4/ZssSq633tGLfe0nk/bPbMKgAJan9AKhjIk9E2k8+q57hAfAb44sinvY2eYZhtlv7L8RVfL1SI6yT4PumioB5EXYePboo+UaokKnI/PegieKbhuSDio=
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 18:13:33 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%6]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 18:13:33 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 6/7] EDAC/amd64: Add address translation support for DF3.5
Thread-Topic: [PATCH 6/7] EDAC/amd64: Add address translation support for
 DF3.5
Thread-Index: AQHXbb9ZrcOYJ0CFyUuZyJ8JOLC9s6taa38AgAADi3A=
Date:   Thu, 29 Jul 2021 18:13:32 +0000
Message-ID: <BL1PR12MB52868ED1E309F7C6249827E8E8EB9@BL1PR12MB5286.namprd12.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-7-nchatrad@amd.com>
 <20210729175938.GC4318@aus-x-yghannam.amd.com>
In-Reply-To: <20210729175938.GC4318@aus-x-yghannam.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-29T18:13:30Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f04822a6-f519-4fd7-91f0-bed819d940e9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 530d3697-1973-489e-004e-08d952bc936c
x-ms-traffictypediagnostic: BL1PR12MB5272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52720E7B12A045C5E7464E4FE8EB9@BL1PR12MB5272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8cKkb5GSngzfxaunVV7f1k/1wOYcB4nI4YcHOeudiZNJoNU4KGTqN3Ao9uuL/8hS9ERYmqLFOt0/3cQpylSVpwjJda1m6VOMFs+kQta5hHJCQCJRLDFnpikYcRNAoVZRijjTz4kIzYDmDDWSq1B+y/yo5bFRuTECV79mobUSyMEAL0UooHjk4JoxuWUH0I6qM087+nCujV2U/ChQQfKrUCuuDfvytIDqBiDPnCHU7/uNyeS8owOqs5A88ZV2ESVNctWBOR498ykwL2PU4vK5k6iVoLemLhs9ZDrv8MhnjAJ32ZxTguW3a4eKlUi7lqEct7H5swpxOK3ZWm29zA5Dciv5U3+9h3tuX7P3yyME9FVpPa3gy6L5zzOvSyTxTv0ZCcSNrxj7I/FHKI1mU3ixApAaJOqpbwtzKHZzh6H5zuP7d87vuBC0FSOFfkDy/fVbck5uq4zg0XItc9/5TXPyFnvi63GP/h6BLqsJR+zH0ruXfUg8aD5kf1swBS3qNiYWa8eBQWDX0QGp7xp5JSJVX0sq0OGu/Mb9B/awWQOQbfVP6oEqoqdUFNYB3XUSCxa15xJ+odRvs5jWvVYdhHVlX/hECCjm8YQVk4XDoPR2Jf4TkGPtQQsRcZqp8VnRcgw0QonoK4QLKnjGgTWR8R+kLauXSybHgZuQ17uPdr2pnIwpjECRDo7PiwC1YbpCwPivQtSMebKe5IG7iTE4AEdzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6636002)(4326008)(8936002)(186003)(66946007)(38100700002)(26005)(38070700005)(76116006)(52536014)(122000001)(2906002)(6506007)(55236004)(9686003)(33656002)(53546011)(54906003)(316002)(508600001)(7696005)(6862004)(66476007)(71200400001)(64756008)(66446008)(66556008)(83380400001)(86362001)(8676002)(5660300002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K8YvfAQwUOOjWcoUB/EdaX1mgVsvzzCQilSMdsgOqLg2B/cc4wN0QrQhUk9X?=
 =?us-ascii?Q?8I8fGJyYa0XOVqh1U2rcyrZq5YptGPWF6mrOe1mxU/NbtyZ/OP9mev9R75Rp?=
 =?us-ascii?Q?DNY0Q6YR9erWi2bXDaQMFyXmX3IaX6432Bsh9yw7abPejxfMTDCmVRuqVFhm?=
 =?us-ascii?Q?qI+8j1ALusgSYousc2Ma3Okw4zlo8ZJy41bsea4/GPa4rRu06Lj1HsTNu0pU?=
 =?us-ascii?Q?6OP4KlvysthGZNfMp9uE7tFiulb2GycHugM7HV8lgL1/xii9DaijHXL8nO5M?=
 =?us-ascii?Q?Zdk72BpLAqz15D5M2bIia+Im3fhVlarHbFkyUSf26SCSiifUym5Fbryg7rBi?=
 =?us-ascii?Q?Tk/uB+Ok1OhYtpwpHXPu97Hs0T8xwVvklT4/PNxaUA9GkZGoPogWbeA2IMRV?=
 =?us-ascii?Q?m46vcAlHcOKRJhZMhFI8xzUvJmCzU0qffjZSuKvbklWbBJqcBd8bQRkJyX8K?=
 =?us-ascii?Q?wtOktinA78Ed1wL3Y5CRDImhswVI+NKYLu9fOVQu/Ekb6hmkaxVHp+LX7XJI?=
 =?us-ascii?Q?P3NylV0Ke2UcKwFJNGUJdCP7xkAk0yikxuqiTv0lGqRr79lzr2YNASSO02pk?=
 =?us-ascii?Q?xuIKQUEwvYiqSiH6m3vRmcgSdbi17gCj/SA9MRkIbm3GTiRio/Dlx94DoONi?=
 =?us-ascii?Q?DPEA9NmYgXXKM4ChL6RW50nwwJTRMtpTyBs0M8NE55C+9sFjdeVtSpCvlrEl?=
 =?us-ascii?Q?0YDS1PKdHPH0dgvC0n3CtE53JGGT9xZYDqgxtQ5D5WFYMGxBT6dSULvjwZF0?=
 =?us-ascii?Q?IZGNgBmO0iG8W40oqXLUm722H92Y96+dPXmwp4jzQ+mgdiAYOMX6A9XGwWG8?=
 =?us-ascii?Q?QNLslN4hGzvVSzzMxLiONmZCZdA4aOg4zMJ8kTmJsa4HQGNiipxTOVbkeV6x?=
 =?us-ascii?Q?hm965dX1OqgvDaayCin06MfXVtX43sWbfT9hKfwYfJBj+/BvoRsAbT0kmAjk?=
 =?us-ascii?Q?6MvjQFehFzz0BQj9U0lQgl/wO0cGECjhgSBoNYpUiT/+e/pehs5aKwxb3Lq6?=
 =?us-ascii?Q?Ic2F3a31HTnFLi0It0C25c0w41p/hPaeX79lbVf0dMwtLEYdxhueb5v4MMJT?=
 =?us-ascii?Q?vypd85MoPm2DNo+hozTNTA2rHAjPrwnK2RKK3lMfiCCb9zpnYIF1D+4wAefQ?=
 =?us-ascii?Q?UnqJQso1GGJKQCXQHdNp0ktRNmsZSfoTMM3hep0UE+hG+B3eQ3Tj9v0uKKgC?=
 =?us-ascii?Q?ibBoIZCtMQ5BujwuDv8ADvs9Aqbfqstg//7xPcPzXhgMxYwjUlJaUv2EDRpP?=
 =?us-ascii?Q?vAXZ+8gEI/lauqzMnMS/mX8c3d4wYUVqt42LAaEat6L22zHasdIkjUYiifKy?=
 =?us-ascii?Q?wzEvIAcLf7EOyxncOWcQDN5B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530d3697-1973-489e-004e-08d952bc936c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 18:13:32.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsW7IsAQnGgigv/g1WWe18/xq1LVgCAz2n/Sw+UcCvhvIcCOYzESoqV46wWJ5ItiObXRF6vmFkOn2GMn+5Pnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Public]

Hi Yazen,

Regards,
Naveenk

-----Original Message-----
From: Ghannam, Yazen <Yazen.Ghannam@amd.com>=20
Sent: Thursday, July 29, 2021 11:30 PM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; bp@alien8.de; mingo@redhat.com; mchehab@kernel.org
Subject: Re: [PATCH 6/7] EDAC/amd64: Add address translation support for DF=
3.5

On Wed, Jun 30, 2021 at 08:58:27PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
>=20
> Add support for address translation on Data Fabric version 3.5.
>=20
> Add new data fabric ops and interleaving modes. Also, adjust how the=20
> DRAM address maps are found early in the translation for certain cases.
>=20
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---

I think this patch and the following one may need to be reworked based on t=
he changes in the other "address translation" patchset. I can take these tw=
o patches, rework them, and include them with next revision of the other se=
t. What do you think?
[naveenk:] Sure thanks.

Thanks,
Yazen
