Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03880331EF3
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 07:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCIGFN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Mar 2021 01:05:13 -0500
Received: from mail-eopbgr1310047.outbound.protection.outlook.com ([40.107.131.47]:33760
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229520AbhCIGEp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Mar 2021 01:04:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvexhkPgkwariD7BXMT5kr2tCMdt/HVvrh1/2HAW8vQAsxGPOaWxbPTauifndRkDWt1+ZzvCr+3ZVQP405ZgnvsplQlCDdlHOyVixwTxcfWI1owJTJeNm1/0hApMGnmsiNu2kKJ+YpL49Qz8NdnVAGI2mcp+1JXSI0cLy2o8SVA62nj7M2a80YnPXXoOOxfEcNwf/IY6WYK6OEYR7yP8aeiaT59YtpL939T7xOsFDh5+yLKKmI5Dl//nkRU5vZ0/JUmOuKprPfVEymDGtc+f7uCjPoAM7/xcXbYjVsuc8sOESWQon1HC6PyqSKn0o0k80b238VgSr1UOViC/m2x3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOnkZyWm282YAI4axzVVtLmmDv6onHaFYQXpgiS8PRk=;
 b=P2ArBFhy8M+gJnccOfoKVWZHL3cr6F4jBn098Un0R4AHNvoUs8BJyLNkpi4r4RCT7zMqo7UgBG0gsGT0m4KMvLaoCTz1YFdrkApPYlYaSFlb01Pr4gTQoUzNmPvDoWHzyXHli8F8HqpUXgab61v3XxQL8wzEcd/mhVUOBDa05sTFkw7xMbHJMXoF+JFnPcm5tsfk/oCw6cSuO0+kj/ccq73kFVqNyM4d7/4feMfelvzW3iBz13rnBTD2NL9md6NLmlvKEgly/7YxwIYKWl+ylpo75FWnAzFxnHLV76Sgv4KU72UG47yNd5sRR2sRAWZZDcaHJJ/tf64IMVr1lOj0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOnkZyWm282YAI4axzVVtLmmDv6onHaFYQXpgiS8PRk=;
 b=OTxHKnbQunhWVKZ2VBam6GV1fqOc4Lnx1+eYUaMFGUpJ5QTmCqwkSByH22KNy6YTSxVXE3WtOafagW5YtUupLXUhDCVwAhIvNp4SBy39uGT8SmzEE/Tslzk/gp5UTTjugxNu5vC12EtNUh9hwqYQOQbssFxA9akI85pybl3suoE=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4970.jpnprd01.prod.outlook.com (2603:1096:404:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 06:04:41 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3912.026; Tue, 9 Mar 2021
 06:04:41 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm/memory-failure: Use a mutex to avoid memory_failure()
 races
Thread-Topic: [PATCH] mm/memory-failure: Use a mutex to avoid memory_failure()
 races
Thread-Index: AQHXFG4a6KBUueS0DE2O2dOaNXi1CKp66C2AgABDJQA=
Date:   Tue, 9 Mar 2021 06:04:41 +0000
Message-ID: <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
References: <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
 <20210309100421.3d09b6b1@alex-virtual-machine>
In-Reply-To: <20210309100421.3d09b6b1@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e59a9632-0012-468a-5251-08d8e2c13ac0
x-ms-traffictypediagnostic: TY2PR01MB4970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4970D98BBCF38E6CF4E4A52CE7929@TY2PR01MB4970.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmZsqWo1sRyRoqnwIuQbheV/7TqTsTbsulcExeKkiwXpsW+roDQnOpN48l2YaqQk5FjFKwNkJTYr3elrB1ls1GXD6/cSou1ZVCS4rdnxbA9RLwFw9NPx6kaYXt+hbBouGnEMiwEZSB75R9X/5zMQbd+VNtjtvuq+ZaUGOqIeDQlkJQsuvQnHjKH3gSm+iwvRQqxovayTNTOTZeHr5H6rCnGj/gQZOBqUfWzX4koasJ+GgW45hg/C7Pd008c1sx+Mm5vZXO+rl1V0h1Ud/gSWydWFDU2aQMBgZsNmsWPk0nLc8axVhxB1aCUegh3KRPExHK1/6/IhPfrv2D9fRe5rZCQbYzYF85iKHtQA//HTI3IX6K5dTjnWQIXZrGql0tKY9aDHMMWzF4Xr2UF+nzg6E0948pBkgE/aRgDHf8R0OezDi1oFcqu9s4hOIdHy0YSWfiDnCmSbYuesT1pFQRkNXFDdjQenjX6XTbTqApZ+yfGnI0SCxB+ccpbuJXCaGUtkhzuKYntP8Oc30X1biCZfgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(85182001)(66946007)(316002)(7416002)(478600001)(71200400001)(8936002)(8676002)(33656002)(6506007)(26005)(76116006)(66446008)(5660300002)(64756008)(66476007)(66556008)(6486002)(186003)(86362001)(2906002)(55236004)(6512007)(4326008)(1076003)(54906003)(6916009)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?Z3pQNFZpV2FiTlpaUUtIWDltZUFyaXZrQm43b1pLZmRqMUorMzkwVmo0?=
 =?iso-2022-jp?B?YVNwN2c3eGxFUTU2bGxOWVhRSkc2SnY0RFB5b0hNNDk4WDdtZGZuRy9Y?=
 =?iso-2022-jp?B?ZmRaRklKWmtpUEk4b2t4UzU4SDhTbWpNSVJwbTM4Q3RDTTU5WVdWT1pB?=
 =?iso-2022-jp?B?MXNhd05ucHQwU3BRcjEvZXMzS0NUTGRJRHAwckw4TXNtdDN2SHBYVW1W?=
 =?iso-2022-jp?B?VGM4VG8rdkhsNURROWtubkVVSmd3SUZPdER3UDZPcWgvYjNCQ3RFd0Ux?=
 =?iso-2022-jp?B?TnY5NzROQUJGQTBnT1pieHZZNmxidUZCTkduUndwdlhNZEtwS3cybGV6?=
 =?iso-2022-jp?B?eE9XNi9PNFVWam9uV0lRd0VrV2M5OVNIS0dEam9nVXhIZmlsTDF3N2NM?=
 =?iso-2022-jp?B?NTcvVG1rZmdHQjhxejRxWEpkWHlqZEE1RXFGU0NiUmF6alQzS1JUanc0?=
 =?iso-2022-jp?B?cXpGKys1bkEyTW5QZEJxTDlRek1oWll0V3g2aTVzRG8wVmw2cU4wVE8r?=
 =?iso-2022-jp?B?QnVCeitMM2tMNmNhTWtlQkM5cm9zTG9Wbkl4L240TXBneEFuK1Zxc3Jz?=
 =?iso-2022-jp?B?Rk1TWFlBVnAvT2w4SUhUMXJqQ3BoZFpXb1N2TG1zNC83ZDcxcnczckNQ?=
 =?iso-2022-jp?B?L2Fqc25hRE5SVUhITytwRVpmc1JpWE5SQ1lqNk1XMUZpTGQzbmxZYll3?=
 =?iso-2022-jp?B?YzdmdU5WWnFKcmErU3dGM0RRZUN1a0lidUtoWHBGall4Q1NZK0Z5b00x?=
 =?iso-2022-jp?B?bkFnaFVlNTU0V2REb2tZTFJ3NEd0UXZ5SjlCKzlKZW0wczRtY2hpaEFC?=
 =?iso-2022-jp?B?WEcxc1hLTHpDNWV0cDZ0Um5ibklaZlpUT0UwUVBIektVVFdISnZPakhw?=
 =?iso-2022-jp?B?QWI1QjlyMXJMaUtTaUsxM1UwY0R6cmRCRHFFald2YzFYa3ljZ0ZzUitY?=
 =?iso-2022-jp?B?NGY3ZHUvYTFkQUdOMFJVSUpJWElhbGdRVUR4am52cWtHTGlMOUZWVGJF?=
 =?iso-2022-jp?B?VjNDOWxQRENxL1ZnMUlaaEN2dTNMZkhHWC9nbDF6MDFVS0dvVW1heWNP?=
 =?iso-2022-jp?B?S2VqTHhMY0JXdUJMMDlXTk5LM21oellpNnlyTzM1eTh2a2RCM1hCMUt4?=
 =?iso-2022-jp?B?U0ZTS0VTYzhveDBmSkdkWFdPV29vZ3MwNWMxQlErQzBLc1pTcTE0bXlO?=
 =?iso-2022-jp?B?RW5aUzd0MG95anpZVUQwY2cyZ1pmZzhVdFIyaWt5Qkh5aVhFeXVpMGhW?=
 =?iso-2022-jp?B?ZWtWWFBBZW1IUHcxcjhyOXZ5UGYvdXkyOFEzck93OHhWSnN6M3QrSHMw?=
 =?iso-2022-jp?B?Z0Q5T3U2Q2ZRYThmVzkrcTU4VVlwVFozMm1VeUkvS2k1SEdnY0lzaWlD?=
 =?iso-2022-jp?B?cjdoRjFYNHNtT2laNDFpUUhwTTFYVWowWTdEK1JwUzhxcEV2QTRac0hJ?=
 =?iso-2022-jp?B?emFDV01nTmhuWHlVN3RkREFlZWZvb1ZwSnRMRGZCU2hyaUZqaG1ueGYz?=
 =?iso-2022-jp?B?T1M3ZFczUjQ2RjBmY2wzYUVLZDUxM0JjYjdKYmFVTXR6anJVSk9SbVV0?=
 =?iso-2022-jp?B?QUNCWURVRXJlUHlXM3A2L1R4cDkvREVueWc3T2hxNmQzMytxNzhXOHFQ?=
 =?iso-2022-jp?B?TzNVbHZ6VTFjQisweWxmRG4rdFZjY0taMFMybWtYTU54Sng0VWxDZUtS?=
 =?iso-2022-jp?B?cEkwd2ZMOTFEQWZCUG5Id0oxUzI1SzRPcHUya09NRGRydFJ5dmY5QldV?=
 =?iso-2022-jp?B?S0FvK0JBdENpaDlrSm9idlZDNGJhTFNhR0ZWOU5TT252SndiTjB1NGYr?=
 =?iso-2022-jp?B?RnUvbkNWWkRxQVBqVkkrZ0FNemt2ZUw5MC9DNGlvZ2o4bUtzai9UMkxO?=
 =?iso-2022-jp?B?ME04YmpKOEhzakJpamwyVkZNdFBvSGxuVi80UWR0cld0WUJTTUEvT3Fx?=
 =?iso-2022-jp?B?Q09VdUplalN6VEtqUWxWd3pmRnQ3dz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <80A5152386199044B2FE867603F339F9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a9632-0012-468a-5251-08d8e2c13ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 06:04:41.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dez4vAA8alZzRAV4ruBA5KHvEngZXQYGrkuDwG8R7FnN7jE03NBZkGjNIsMgxwiF8QZYLbwQ6G20mgl4EewLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4970
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 09, 2021 at 10:04:21AM +0800, Aili Yao wrote:
> On Mon, 8 Mar 2021 14:55:04 -0800
> "Luck, Tony" <tony.luck@intel.com> wrote:
>=20
> > There can be races when multiple CPUs consume poison from the same
> > page. The first into memory_failure() atomically sets the HWPoison
> > page flag and begins hunting for tasks that map this page. Eventually
> > it invalidates those mappings and may send a SIGBUS to the affected
> > tasks.
> >=20
> > But while all that work is going on, other CPUs see a "success"
> > return code from memory_failure() and so they believe the error
> > has been handled and continue executing.
> >=20
> > Fix by wrapping most of the internal parts of memory_failure() in
> > a mutex.
> >=20
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
...
>=20
> If others are OK with this method, then I am OK too.
> But I have two concerns, May you take into account:
>=20
> 1. The memory_failure with 0 return code for race condition, then the kil=
l_me_maybe() goes into branch:
> 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> 	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> 		sync_core();
> 		return;
> 	}
>=20
> while we place set_mce_nospec() here is for a reason, please see commit f=
d0e786d9d09024f67b.
>=20
> 2. When memory_failure return 0 and maybe return to user process, and it =
may re-execute the instruction triggering previous fault, this behavior
> assume an implicit dependence that the related pte has been correctly set=
. or if not correctlily set, it will lead to infinite loop again.

These seem to be separate issues from memory_failure()'s concurrency issue,
so I'm still expecting that your patch is to be merged. Maybe do you want
to update it based on the discussion (if it's concluded)?

Thanks,
Naoya Horiguchi=
