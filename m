Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80833208A
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCII2z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Mar 2021 03:28:55 -0500
Received: from mail-eopbgr1410044.outbound.protection.outlook.com ([40.107.141.44]:52881
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229515AbhCII21 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Mar 2021 03:28:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjbTk5Y4181Beuzw/Xz6lDd8z61CUCRIxmtMz99RtoCiP9roLtAlQqGuJ07UvYKy5AQUwAvqhuxlif+QX4ZyCLxGa8/n2G0eVU9OFOuGwtgO05vJYA5euNtKsLCcHO7W+n++ffRN9PeknrYHm1dPuOX57wllouZPYhLd664Cz08CNMiQChtvq1yv0Uvm3ujXHrw2FGND4GiIhTMZWRa4ghXOjJSoWtDkNEeJH5hEdosmRVG0PwntEvTQmJ/Mf54xrat5Hc/+5pyeWhODl8GWGygI966chqIxAo8v6jKEzHFotEXaDNVJDGdfCQOneZ1RpAZvbwfvXSSoe3E9YYCsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVJ+mB2tV8cfAwv6Lv1elWjVb6dyxPTyJFm1sp2bsLQ=;
 b=M5T3HBN99tuKLm0Z3luBrnp6wOgbnutMoHBlhz2HsY6N8f1V3fEbY3ghtW1f4Wuh/NqrBPZBboapin7es5sFMxsQLxUsxD2GBpAjKE+k3x9pw69VZvltm75N3pxLIMMw9dQgMwVwMr7ct4JlDOWLcF+3ZkUfRltedaPZw3Qv3E5+CAjXAeAQSmBCWnyr5C0/YEticNJmTRNQorq+PCN+tcn1fIj71r9X4TBg/7U+w1p5Mjq/NNOUkX3D22k55Tb1XkfzoaikKLCHlUd7yWh0kcN867hE4htW96KLbGcl4P5grhVNdG7LuSjFKshAQFyxGINvKpldHBs93clfIMvNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVJ+mB2tV8cfAwv6Lv1elWjVb6dyxPTyJFm1sp2bsLQ=;
 b=AmYtzwKzoOaIznEK2clUpxFTFyF/Jx07umA1W5Ecb3sMRHE8kUaKy6lYqJb9E1jY+CzMwMxwibHvSVa06o2B03ePHD8Y9bjzBY8gSDIVGi2y9lkDMyiJsZQhsUXYoWHp3QxmWq91fxK7pobrpMSqRTVhy8G7NbPg2mAlKYeG/kk=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 9 Mar
 2021 08:28:25 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3912.026; Tue, 9 Mar 2021
 08:28:24 +0000
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
Subject: Re: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXFK5tQmxPuwvfpUmmzR/9gXeI5Kp7UvoA
Date:   Tue, 9 Mar 2021 08:28:24 +0000
Message-ID: <20210309082824.GA1793@hori.linux.bs1.fc.nec.co.jp>
References: <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
 <20210309100421.3d09b6b1@alex-virtual-machine>
 <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
 <20210309143534.6c1a8ec5@alex-virtual-machine>
In-Reply-To: <20210309143534.6c1a8ec5@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0b87540-69ec-4d98-7fad-08d8e2d54ebb
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB39653E9BDC1CA225EBA00DEAE7929@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kBQBZGOc/Am/6hjFr6/fETxUtfEsETO1VW2ag50HqsSLxL168ng4ZbIwWvcYIHzff5ib7s7Er3PY6/8msnV0TqqgDMGLysOwjZ/nxokmrKN5qIVzEpJFzh1GGTqbdB0m6e4p7KN47j51EDf1/mc/Rl6SEhp/4jlw7qh6qVGbXZqI5uaYMSZefJKBDSgjsDeZkS6pirKRyJWViQp6QrTW7gsZ6ldmq+rE3Tr2nHCCU7Vtzy9i3srvR4jDZh/BBvmc76eHMvsTLTUc+SexGjbcaD0cW2tRbymFgLqNfWLoD6xzLMMihi3umzCxBo1Dcj/l01lvrN0Eeb0DAM6Frf08amYu/c38P75yiKHoYfxeJ2fyJA7whAa6oo3SD/OOBDDLTjNJT1eihXg8ySgdjXkfLb3tvyn3HZBVWOb0Pn8vsxE5j/OxUetpTOMVe5/CbnLb4cuBaN0E8DHUF4MA9O3f9f9SistvneRshkT7djqIG/KWVF5X7lk3dBApf0SV4/5adDGqISjE/VASrkApBi/JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(6916009)(5660300002)(2906002)(478600001)(66476007)(6506007)(71200400001)(66446008)(6486002)(33656002)(85182001)(4326008)(54906003)(64756008)(86362001)(8676002)(1076003)(66946007)(76116006)(8936002)(7416002)(26005)(6512007)(66556008)(83380400001)(316002)(55236004)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?ZG4xeFdvelM4WnZpYVdHT2xaSnNEV2NkM21uejFiV0J5L3hZQndSRGZT?=
 =?iso-2022-jp?B?Z0phMmhkeHFIVGRPWUtjbUtCNElDQURUN3RJR0QvWno4b1dTdHpybldO?=
 =?iso-2022-jp?B?dkVRanFoZlNGbzkxZDltSS8zUFR2UGUvbmtBRU1uRkx6cnlFUVFMdkVk?=
 =?iso-2022-jp?B?enQ2NFRvQ1Jma2xrR2FZUzNmUVd3cU9iZW9YTXRjeHhPRDFuSUhZTjRV?=
 =?iso-2022-jp?B?UFRoVHpTRmhHcVR1RFlYZUNZVW1mNVVsQnB2dE9uVlpqQnpvNjIrRmNQ?=
 =?iso-2022-jp?B?Tld3dG1pK1pBS2NGcGJCQkJPbWZPakFKL21ubHhVdEhNSFhmdWRiV09y?=
 =?iso-2022-jp?B?ZUN6b3FBTWlXWXBtaTB3emM4MENHYkpIckFNUjFBUzhwUlU0YVVXb0Iy?=
 =?iso-2022-jp?B?UUpEQTlzRHY4eXBsb01FT2JFa3pkN0toVnp3WDlXellLT0FPN29LSGc4?=
 =?iso-2022-jp?B?Y040ZXIzMndBQXBrNlFqZVlWNWQ2TWVJVHNZNDF0aWdranRFbjIwNWMr?=
 =?iso-2022-jp?B?NndsZGtSdUIxQkE4QVVpOWUraVVBRGFsdlIyZDZLMTUzMjRpMzNYQm1K?=
 =?iso-2022-jp?B?SENwMTNYT0xUdFNqZGoyTGtzQlNqa0ZpTnNlREd0bnM3emRUd21GQWdv?=
 =?iso-2022-jp?B?SnZYM3A4NisrWkFpTDZkc1RBS09MOGlnMHNJNUhyVERpR05tdjlrMVJX?=
 =?iso-2022-jp?B?b3ZGeWFjZFB4MXJxQUNqUUFxby9BVGFxSnZjRHhBTmhNTkNzYjJZWnZZ?=
 =?iso-2022-jp?B?dGxvNHJKZ0t6dDdueGpnNFhaUVdGMElUa0ZmSGl6ekFzdTRIeU1haUU0?=
 =?iso-2022-jp?B?bzUwRkZVRWNYR0crNG05cEF1QmRXRDRnSWN0SS92S0Y5eFRLWVJoYlQz?=
 =?iso-2022-jp?B?Rjl0aUIyYU96LzRISE8xNWxGMVFCYkozMUdudzNvN0hJT1F1QTE0NzU5?=
 =?iso-2022-jp?B?QktkREpoRWV2RVp0RG5xQUZGTk84ekFrSXEyOW42U1ljZUFYOWpJMnJH?=
 =?iso-2022-jp?B?N0pFcm5YazVhRlpGcjJGdHdadzZvK29LSFhjYVNEV1NQSG9rdEU5Y1Jx?=
 =?iso-2022-jp?B?ZitpUGtsRlc4Y0ZPeGJZUFMrZGw4TkhyaW1Sc2NRcmwrUkhsOU4rRGk3?=
 =?iso-2022-jp?B?YXU5OWRJNEsraVF3WlRZMW5uT3NIbnlLcTYrNlkvR2ZXbjk1M2FkYVJE?=
 =?iso-2022-jp?B?NVE4SG5IOWw3YXY0VXRRRkdhM3Z1K1NOWlJqekM4WVdDWGJUY2k4V2xZ?=
 =?iso-2022-jp?B?SEZ2KzdXVC9GN1JDNjgvU3pHTzdHaVp6K25tM2xPcGJtbnIzTTRUK2RR?=
 =?iso-2022-jp?B?WEdSU09sRFZOUG4vRzFMWFpXcm1FWkh4WEZiaEh4eXI4cGd4enNLRHBX?=
 =?iso-2022-jp?B?anh0SHJ2alhob1JTbFpINWFvMWhDS1VKd2k3eXVEU2tJTUpTSHppU21D?=
 =?iso-2022-jp?B?YWtVL2x4c0ZmWXpnUXlQWnlvbldscDhGK20vc2locGlodVd2M2E2OWlP?=
 =?iso-2022-jp?B?akJZMXl0TkQ1TW5tSkN1blVIM3Rzd3dKc1pOdFMyazk1VUNnOFZwZmpK?=
 =?iso-2022-jp?B?RzF0TFdva1pCV0g0TnVqOXBWL0dBV2JNZWIyV1pNSUpTU1NpeHFlS1FB?=
 =?iso-2022-jp?B?c1hBUUhFbFJkS1NSYkh1eG12RGZjakxEU3lBRUd1d1A4ajFQK25DNmla?=
 =?iso-2022-jp?B?a2wrOWx4VWk3RWkrdjJTRVNQZ3pza21TNlA4RXM3UStpdTNoMzdwck9Q?=
 =?iso-2022-jp?B?UW1tNlVCVGdjYmFRSE9kWEYxV1hsbkw2YlBSMVZIeUNCWmVRdTY5MURH?=
 =?iso-2022-jp?B?ejE0Y0U1eEJsd1FoTnVaNHRYdDhiUUY0Nm1ZeEY0Z2NQY3FYQjhFQ3pY?=
 =?iso-2022-jp?B?OWN5OVVFOEpFbUtWWXd6aVY4RzVaWEx5SVp0bkEwTzY2cDhaMFlZbVVI?=
 =?iso-2022-jp?B?b2VPdXZmWGJPWkFYTUJnTDZOamRMZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BFF0B9C4A97A484B99054446D5804AC6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b87540-69ec-4d98-7fad-08d8e2d54ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 08:28:24.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fm3L5elFxjgJAjKER58373U/H3t1FV7x755xfiLA7TtF8YZkXHD8MQGPw4Yy3Ko1maCaY5lC7Pr2oORD5tlRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 09, 2021 at 02:35:34PM +0800, Aili Yao wrote:
> When the page is already poisoned, another memory_failure() call in the
> same page now return 0, meaning OK. For nested memory mce handling, this
> behavior may lead to mce looping, Example:
>=20
> 1.When LCME is enabled, and there are two processes A && B running on
> different core X && Y separately, which will access one same page, then
> the page corrupted when process A access it, a MCE will be rasied to
> core X and the error process is just underway.
>=20
> 2.Then B access the page and trigger another MCE to core Y, it will also
> do error process, it will see TestSetPageHWPoison be true, and 0 is
> returned.
>=20
> 3.The kill_me_maybe will check the return:
>=20
> 1244 static void kill_me_maybe(struct callback_head *cb)
> 1245 {
>=20
> 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> p->mce_whole_page);
> 1257                 sync_core();
> 1258                 return;
> 1259         }
>=20
> 1267 }
>=20
> 4. The error process for B will end, and may nothing happened if
> kill-early is not set, The process B will re-excute instruction and get
> into mce again and then loop happens. And also the set_mce_nospec()
> here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
> mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").
>=20
> For other cases which care the return value of memory_failure() should
> check why they want to process a memory error which have already been
> processed. This behavior seems reasonable.

Other reviewers shared ideas about the returned value, but actually
I'm not sure which the best one is (EBUSY is not that bad).
What we need to fix the reported issue is to return non-zero value
for "already poisoned" case (the value itself is not so important).=20

Other callers of memory_failure() (mostly test programs) could see
the change of return value, but they can already see EBUSY now and
anyway they should check dmesg for more detail about why failed,
so the impact of the change is not so big.

>=20
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks,
Naoya Horiguchi=
