Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95076331B15
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCHXnK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 18:43:10 -0500
Received: from mail-eopbgr1320043.outbound.protection.outlook.com ([40.107.132.43]:26208
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231307AbhCHXmw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Mar 2021 18:42:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsUM1fNj2MI834AtvzdhRCb+2qL3f9UnWRPzWR29W44BT+YmOOiRwwZjKOYegYgfHU6L37ULrU6NMYRPSauL7HH8WfsemqAxk5A8X8kEcpDZKcP8o557VZyA+fH4ftgwNWgKie9ujnk29MZeI8K2zUm7w7xREyV0Un0L3mOi7JH+PNo8Eu/A3SBySGVY5P2yQWhdDRcnsFEoiC4QQ3nwwawEp9POc7VKzomOaeCBvIabcMwTBeiMUM0Oce1N1BYGOdPPKQgZ2nqx5xj3GijGK5ZWmmAX4W4Vs2CGqzHQrplwDZg1gp2z2JB+MczY9VMB52Ac/pOsmcz1EyTHXdVZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sbeVvZPvOxX8VhFrUAp6OySwB9TM4k5Rfud+FFWsK8=;
 b=G6H7lnKW2rQKKpJrsvzYQulqwU7PDSpC5QB7dOpqguNBfffVIKAQVrVOcTNhILzmEDeLBT0N99ADPUx5P2kjCM/HuIzM3Ap3b/13i5084XVKZzRkFnNrR5r9eU7Ah8V2Y1vtjAvNNraxUOVdZ0fpyAnsi5gXHewhUQZj+36QCCJzBSsJ+GZOU58BhkeVUooLMjqyytbHtCX2gq/hFFbugAEpAnET2XlKNmZdPgo3L3gdMNvH7Xhvze0YAwNdDKMxd8v64lg5EauNW+G1fxg/gymfEFKPf3kUVpQFhN2GvvG0RCTVE0SRFiqbkc1BHC6x7GBHB7HzuPRkgIV85A7Anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sbeVvZPvOxX8VhFrUAp6OySwB9TM4k5Rfud+FFWsK8=;
 b=ebN8DtBckeJa90H8ADg8NaD3ks65a6V6q+qPzxjO+DEvVvPwE0GaJhQPHCGiPfsmuoLIdcKCQMy4t6QeYuE9CqkKmGMAJgZnYIzLz58cNj7j3l5ZlBEcV8l6UAThzki5rjwIia07w9MUPv7qZZtjUFp+DMrYfRs3spL/N5QjdZg=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB2091.jpnprd01.prod.outlook.com (2603:1096:404:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 23:42:41 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3912.026; Mon, 8 Mar 2021
 23:42:41 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Aili Yao <yaoaili@kingsoft.com>,
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
Thread-Index: AQHXFG4a6KBUueS0DE2O2dOaNXi1CKp6wJiA
Date:   Mon, 8 Mar 2021 23:42:41 +0000
Message-ID: <20210308234240.GA23822@hori.linux.bs1.fc.nec.co.jp>
References: <20210304121941.667047c3@alex-virtual-machine>
 <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91b83d85-00c0-4a4a-622a-08d8e28bdd68
x-ms-traffictypediagnostic: TY2PR01MB2091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB209102BDF7321BC655666695E7939@TY2PR01MB2091.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUeepDzDlLdevqLYkFkqya5YOKENVvHK7zZI5TCVCb0KGw8QyPikcBeCBC//2vI0youxKkF3jDMow1IkPER0w15Yit3fkEjs38rtKSn4UP7lTImzJdBJaeadyCsDZuZPO+xd8W/hnpM1HClsGOvhuxz5vyXGkeAwIeF5UiMqwRUBqt4fHggY3UnmyM/SCCLFzxwoQZGlOYMG4mPHX1gQF+qUONI12udjWIgYvkVZR8kkDNvi6oyCWNOHXDqTHDv9CAVf87Ft9XPJGzohm+6UBOXdzgqIn5/jYRaG8K1s9dX+cmFti3uCQgBe+6sVG9zElyFV7uVca67DMo9X6t5FBbU7GpNtDeXFNPM7HZHqYOdm89XpUhPVJasCzo318GgNneTLXkmDehcueo5SDIVUQ/hikc5kDCGqZRw+KhweX3Y2gnrzO8aUq2nVuDi4f9T+cdqhtSjI4iiAQQCKEigfnX5FzI52JYI/kQ8el4tVXsZrtGzcwVKbhvB1PKusPwosO91H3p7PeVOdWT9AXUXkXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(33656002)(6512007)(54906003)(8676002)(8936002)(83380400001)(86362001)(76116006)(186003)(66476007)(55236004)(6506007)(9686003)(4744005)(316002)(85182001)(71200400001)(6916009)(4326008)(478600001)(66556008)(1076003)(2906002)(6486002)(7416002)(66446008)(26005)(5660300002)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?UjgrTFJaNytLRVlsWTZrV3VPalhtb3JVQWVNYi80eXJUREVDdnZmVzBE?=
 =?iso-2022-jp?B?OGhMRHZhdUxpMGlJY3M2ZWlqNkNRMk1jaTREdHMzTXJ0UDRRV3NvSExn?=
 =?iso-2022-jp?B?QXViZlZnaGpTUnBUSjNveEhNMGNaSUpSZ0JMNFFBZnFsbWpLdkFRVDFy?=
 =?iso-2022-jp?B?cjBxR3BCZld2SU5USGt2TVIvQzVQUWI4STZNeE1tQTllU3lzTnZrOUhp?=
 =?iso-2022-jp?B?R3lZRUlJSDB4b1dnM2p2cWgwUFlTUSs0dGUzL1IvaHNoWmRvKzgzNi9z?=
 =?iso-2022-jp?B?Wm9QWGZjTE53NUlmc3pMU0U0NkhPUWZDUmZxRlJhUmRVT2Zib0plWGlh?=
 =?iso-2022-jp?B?bHVWWDU3T2k1U1l6N1o0OG1YQ3NCd2lZV1dPd1NtdWMxdm1wajRuRGh0?=
 =?iso-2022-jp?B?UElacjRDNjhmU3IzdVpzYzI1R0FqTVBwRTZRYTFwZUtYUUx4Ry8vK1dP?=
 =?iso-2022-jp?B?cHRibkNpRkRKdVh4dWMvbFlObUVmR3FEOUdQK0txYU53TGRPWlluY1Q4?=
 =?iso-2022-jp?B?cTJUejg2S0drcDJsWk5yQXRSYjRkaTJWdkovOWN4Z215ZjNNUHl3ZWxZ?=
 =?iso-2022-jp?B?WU9sR1lHV1Rtd01FUWFjV1g1L3Y4ZnpKSTQvaFlhT3hINU44eVRmZHgz?=
 =?iso-2022-jp?B?ZmM0MW1zUk42cWNtOEhzaFhSVVRpMGxIaUFmU0lKM0hCbzBVN0xDNTQ2?=
 =?iso-2022-jp?B?VTFXbHo4SGJsV21PbzBvdXArSGtYVDBiM0NySExOR0FKcDVmMEYra1A5?=
 =?iso-2022-jp?B?LzFUNW5YRzlwYjRJQ2NuNVdtaVBUSWp6ekJZM25BZHorSllDVU5GTFQx?=
 =?iso-2022-jp?B?NUlQSW9EcjNvWUxqWXlDS21aV3YxYTk3eW1TNDh1a0IwQjVDK05CTytE?=
 =?iso-2022-jp?B?Zm5Dc05GcnVremYwT2Z0L2JkdndUajU2NjdtL25Ha2FPVVlFSnEybTBD?=
 =?iso-2022-jp?B?cnpoQWNGTUt2cVR1MUlBWkp0YnphWU5qaHZJaG9USStlMXp3bGxlYWxz?=
 =?iso-2022-jp?B?S1hGdEZVM1BPb0E4Z2hWb2R4dndPdlJwdnl6L3VtNDV2a0tKb0xRQXA1?=
 =?iso-2022-jp?B?cG9lY3FZQkpDWUJGMUFqK3RaemIxOEhJU0NJY1dQVmZwMW9xR016R0s2?=
 =?iso-2022-jp?B?aUV6V09qbG1RUFJlR3hLT0E1ZG9teE5WZk9kOGs0V0Y5dFFvSWFsbFNi?=
 =?iso-2022-jp?B?ZnluWjhYazFVbGwzVXFRcGE2RHdPVnU1RFdFTFFUU2c0cGVHc3ZveU85?=
 =?iso-2022-jp?B?cS94VytoR3oveFgwMHEwbktZL2RhWm9SOHU3bCtpZ3ZDM3g2TVJpRjNx?=
 =?iso-2022-jp?B?MlJQUE05R3lXaWhOczc3bXp6d3F3WU02ZWpmQi9oZHI0ajhKRlMvL2xk?=
 =?iso-2022-jp?B?L1BwMlJXb2ZwM2VyV1NPdDA0UjMwOEVWNUkzK2U2RVplOHpsZ2JjNTVq?=
 =?iso-2022-jp?B?RVNIdzE5NkM3bkhHdVc0SlV3REZnOTZoNjF4U2NWWGV1Y2NTT3VOQVhy?=
 =?iso-2022-jp?B?YUdrcW1mcllWNDJIbHU4bUlGQUQ4cnVUZFlRdGNBMGt5SFdrQ25Gc0Ez?=
 =?iso-2022-jp?B?NGVGeUpza1Jvd2NPSGJlbFMxWm92VnRpUnBKOFZTTk42cjgrWXBLaXJv?=
 =?iso-2022-jp?B?WmVSMndNMmNOQjNxb1dnY0luRVlkaHJkaEFBZitYZUN3b1ZaeGxVV3lV?=
 =?iso-2022-jp?B?ZmgxekpWQzRwTUdxdHIrRGNuY0JjTGpHK0VLY0tnb2I0WUVUYWFtNmlZ?=
 =?iso-2022-jp?B?aUE3YjFaWjVIVWZaRHhDZDNjWHVkMW9reHJuSy9vMDJlMDNWTlVGYWlM?=
 =?iso-2022-jp?B?L1B0OHVxUStlZVdvRDMxc1k2bzQrRTcrYm5ma2NsZ2VqTEVYUjNtdE5q?=
 =?iso-2022-jp?B?UUNqeEVPRlNQNlNJRlB3emdVY243VzlKcHVNb2RycUJTN01JbW40YVhZ?=
 =?iso-2022-jp?B?V0lzdjZBdEUvVVFuTUV3eWM2WlBDZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <9378190265DF474F9AAA164143487F83@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b83d85-00c0-4a4a-622a-08d8e28bdd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 23:42:41.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQ9XrKS4AyGNfIZIxq/F8IS+Taw5Q1IodK2JQteABoxud/L2EZkN3nJIaw9dEEg/FqJLEEFbshub41B2uNdqdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2091
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 08, 2021 at 02:55:04PM -0800, Luck, Tony wrote:
> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
>=20
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
>=20
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Thanks!

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
