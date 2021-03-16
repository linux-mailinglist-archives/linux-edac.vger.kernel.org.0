Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC61833CE0B
	for <lists+linux-edac@lfdr.de>; Tue, 16 Mar 2021 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhCPGmt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Mar 2021 02:42:49 -0400
Received: from mail-eopbgr1410044.outbound.protection.outlook.com ([40.107.141.44]:18862
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230020AbhCPGmV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 16 Mar 2021 02:42:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdB9iZzy3kHVJ+zry0D8/KYxuK7BkLqccij04HPMUNfcYcNS6UlTbiUVeY4caPNQ0PU2uDsJutJI1vk9LpYIim/oZNJOjppQnRt/fppZw2UtEexOfwylPYPcLwEwnl6bPdSmS25AnPkEOGOTtkt3rTW1HuYZ9MAdxil6qGLi0uVRzHepSyjEJVPmyK43T3YW4bMjIZtAaNFdiqk7Jl0m4i50aunhA5k2fi2LrS+WjemrPnhYconlsFtkGw77LUNzlpnEyNcC98q/3Rj0QOW79IL++45ihqZiCZoCQSiIWmg8Po/9S/u1Gbq1udzdTJkgv8CuXxevThFvSMWN3sIZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smsbBZaBrn5jPYirOjV4QzZmDv1FfZzCe/9q+rC/f6I=;
 b=BU1L3M9xS7PW8vRIkP92wks0WU+/S66ENr5ewH/3SdeO7LmJ9DLAOa87wjg8r2GapnNc4HtTCnUcgYUcceQBDcX8OAcXeZkwyKeVuM9CxCWzsrlxwrIC3vhP3E6C92jzvY+pHuc6MmVWNVFh/O8RwT4dbKe5irIcI4zVMYKbAuzA+r6uxF/Hjp1oxIlPOF7l+BTxgGEUjNbj9r8iD04+/6HJHQGEfjKIpqOZoqEi0eHAKJa/A6OPv2U2fB+eqxR9/XC5sPGjS79UD3HzgI0p0c4tvg11LpCmoO6M+pmRY2fGMFiXMndE5kYoILphFRtzwH9+rgL6cBJvSBtYC9FMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smsbBZaBrn5jPYirOjV4QzZmDv1FfZzCe/9q+rC/f6I=;
 b=HUKUES3v2RjfZ3aT8EhIXyi6zPfdohz8DW+emDfle5M+vw/QNe77P7pMhHIndFXvC+7eQJCbaUvIawms9+gnyQqNCnO3fQuKwjacX8HNg1fGW47/NLaFyzj5SDDMiZpmQmi9oBdCOvfUM/R75MK0rgz4JPwAVpIuHaDPy0Z8sZ4=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB4654.jpnprd01.prod.outlook.com (2603:1096:404:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 06:42:16 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 06:42:16 +0000
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
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCn0F5fAOAyGRl0mX4JfXYioGdapnG5GAgAEgN4CAAIHeAIAAAyEAgAAQYACAAF5TAIAAhxGAgAALNoCAB+cDgIAABNQAgABOzACAAHYEgIAAsYCAgAAiT4CAACi3AIABIFEAgAAZ9wCAAPG5gIAHOEoAgAHAYACAAIkDgIAA1wiAgACxK4CAAHqggIAFKpeA
Date:   Tue, 16 Mar 2021 06:42:16 +0000
Message-ID: <20210316064215.GA23401@hori.linux.bs1.fc.nec.co.jp>
References: <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
 <20210310141042.4db9ea29@alex-virtual-machine>
 <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
 <db80e98d2b264e988596d0d7d7c8a776@intel.com>
 <20210312135531.72e33b35@alex-virtual-machine>
 <3900f518d1324c388be52cf81f5220e4@intel.com>
 <af80221baed940d8bcc643e3e7d40036@intel.com>
In-Reply-To: <af80221baed940d8bcc643e3e7d40036@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f8d3459-fa40-4d7b-e9e9-08d8e846a3cb
x-ms-traffictypediagnostic: TYAPR01MB4654:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB465447AC6ECE15A7DBE3E08EE76B9@TYAPR01MB4654.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8C/36wTDtsoCNsa5xbClnLCISFb0eB6bS6Vp10zsXjB3L4xTlJFcH3NizXgrIIOSIAD1UuFOutgCyoBy1p8quDCyCouWNFY1dalGXcSVKbz46mrgmJ12MOpNF06fo28rkOjORQkt5zbqE26+dMrvgnAH1PT44KQ6kIOZnv5XYh+YZVraxMcL5yFLsojLPkt95q9Xoerbj2RRsmVZFjUnH6b21+Ml/GLCQLqau3wgBB/0+sKeQybGZMP9A4w24hjmoUt/xOqJl9D+9SLKVhbatsj4+Pz9zr46+GjeM23aPl+/DldYZnmC9UHaHmrjyQQ0POVN6t0ac1DIUkFL3MDWcvEaGzawMKq6O+6wGpr8K1aXx0GZKcDpJEv727+XiHgrp2nwEaMo6ERjA8hNdNp2h6uHDKrXljOTAkEnupZ95pcJURI08N3Wg6ijkaVMyTTGsRW2FUN/tMYGHU8j8lWXlcoQ6G1RsmF+3I151DqD9tDJsxvi+ooQxExttmr4BoISML75Ti1d8/LXwxhfEXgg5ZOVd7SJGTzNjYq352NWAukZnRQuIHYAGpILXqdztBow
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(76116006)(64756008)(5660300002)(66556008)(2906002)(186003)(66476007)(33656002)(66946007)(83380400001)(85182001)(54906003)(8676002)(9686003)(6506007)(53546011)(316002)(6486002)(6916009)(26005)(55236004)(66446008)(1076003)(6512007)(8936002)(4326008)(86362001)(478600001)(7416002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?Nmw5NDJUMk91YlpSanEvOTdtN3c3elc1eTZtSXI3NTZHM2tZcjRkWkx5?=
 =?iso-2022-jp?B?R0FnY0ltOTZwYU4wdW42Ulk1S2xqWHNDcEtVVXpxWlVRVEgvVkk5RnNF?=
 =?iso-2022-jp?B?L2NxOHA0bGZPSkZmVkgvRFEwTmNvMVlPTlVoZXZJNGxweVZzTnIzRmtF?=
 =?iso-2022-jp?B?VEtDM3RJQllFZU01dVk1N0pucDZuUy9GM0o2ZktZTTNXNHMwdzJOL2Iy?=
 =?iso-2022-jp?B?c2kxdXpLb3NLeUlEeUJaUGFpTjNzN2VVTStoSHkwUUVkR3N2RzlGSFJC?=
 =?iso-2022-jp?B?ZnpoSXZpK1hTZHRnL0Y1WHlrQzlENHUwT2h6K2ZzZ3pqa3I5aGUrVFdZ?=
 =?iso-2022-jp?B?TGZEMzZzSzFpMTA0VVZ3dno3Z0w2N2xJYm9vMmpCdkZpT0E1YmxRYnVl?=
 =?iso-2022-jp?B?Vmw5UWF6LzFrSXRkSWNCdmFRcVJhNFk1UEczSDd3WXRXTjlLUFRSWTYw?=
 =?iso-2022-jp?B?T25KMnpSdEExTUJ2MFlVcEdNazZlalBwTG16MzdJbWc4YnhWMHpIc3Fs?=
 =?iso-2022-jp?B?TmlVMFp2dHVMWVkzaTRJVjgwdE5USktWUmRicWZ3VE1reTdEVktuTHRu?=
 =?iso-2022-jp?B?anBPZXQ4bkhLQnBVSFVRMmk3WjIrclY3WlQ0b0JlQUhhT2NPU1RUTEdW?=
 =?iso-2022-jp?B?L2VoRk15eloxTFU1WERoVmdoTldyeEpjZzJBMUtzSnhqYUFjVUhLOE4w?=
 =?iso-2022-jp?B?amNlekNVSERJUVZxbnBnclBHZUZNVEtaSDhiY3dpSzQxdkFrMlpEL0Yr?=
 =?iso-2022-jp?B?ZWx6N0E5OUpTREhubGgwRU12YUtRd0lTeURWencxajlHM0J6TFJpei9B?=
 =?iso-2022-jp?B?NkJ2RnRYd0NGOXJ5VTZyNjhkdUxYZE9URVNyOVFmRXJkTVF1T1p3em1k?=
 =?iso-2022-jp?B?b0dhQ2d3a2MySVdSVmZnTFArSmg2SHo0MkU0Q01NNXBpOXVMaU1RSDdr?=
 =?iso-2022-jp?B?b1pOcVAyQ1ZxZTZsQngySGNtV0Y3NmJSVG03cEJzVHBrdC9NMHVaTTlI?=
 =?iso-2022-jp?B?L1c5WU15cUp6SDlPVDdSOXRCdDQxVVR6OGt3YlRRVVFTVTdDTGY0N2ZT?=
 =?iso-2022-jp?B?cCtrZTN0cTE5TkVEWk5NaEQxTVhmUDhzNm1CUHVmQ2dDUWYrb3l5ZHdR?=
 =?iso-2022-jp?B?c3krZHBIOWUwZzRST0t2aFkvNEVwOWRhZnprRWtNVi9hbk9ya0xkazZa?=
 =?iso-2022-jp?B?dWRDcldDUzREVmFCYWxmdjRQTDZaWCtSWjIzZDlIdThrNWV5UVdEUmlv?=
 =?iso-2022-jp?B?MTdVMERQZGlSdzNMS2x0VnNsNEEzQ3hQNFJlT05NY2hPNHF1dGF0MS9I?=
 =?iso-2022-jp?B?dG9Jd0VhNW5mOGoyYWt1K09iNGt6QWFzNWNvS3NuTWMvaWQ0ZGk0ZmpU?=
 =?iso-2022-jp?B?Qm9SWEY2VkkvRWFXRnJETWJUaUFBMFQ0M2pnWEZtSEJreUpmd1ZrWmFP?=
 =?iso-2022-jp?B?ZVBmQzMzR25TNHhicmdQdXhkTXRVM1JzaUswOEJEelNodjdnOGM3NmlN?=
 =?iso-2022-jp?B?ZTFQYk5wMGhIU3V6V0lvc1lMdEd4R241UU9BTkhMK1dKTUNnMFFSM3U0?=
 =?iso-2022-jp?B?QjcwOFlMWkRtdTVIVGEycDZPMmt4d0lqZm9wRnBxdWdCblQrSEp2dTNW?=
 =?iso-2022-jp?B?MkxuRG1LU3RkQWdsYmRLem9YcVJLdUFxc1ZOS21ZSUM5UGxhRHRER1dL?=
 =?iso-2022-jp?B?NDZpRUpLcjZYeEVYcnE1eEg1QncvS0tjSEJBSTlZUE05MFZ2L3U3OC9l?=
 =?iso-2022-jp?B?am4zNjhpbVFjUUx4SmJGd1VDbEUvWERpWVJ2WmY0cnkrdTRqclBoSXZ6?=
 =?iso-2022-jp?B?S0tSZEh6a0VEMVlrS21vTUFYY2g2WXZkRzJqQ2FiRzJCcis2SXEvUHJG?=
 =?iso-2022-jp?B?aDBnNWtOYnVZQmx3R1BYakthYm5TOFFONFV6endTeEtVNzhmcThReWds?=
 =?iso-2022-jp?B?cVRyV0FZd0FXSlpKK01CelIwN0wzZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <472DD7338FE0E44BB9635B0A660F59EC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8d3459-fa40-4d7b-e9e9-08d8e846a3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 06:42:16.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSRk1gxvp3psELy4inQWo2Pnx6bPfOAhew/0EYuw8fD5D9Sb86vdRRd7xxzKOgGyBiNuhLLFmJURmFNBVZbqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4654
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 12, 2021 at 11:48:31PM +0000, Luck, Tony wrote:
> >> will memory_failure() find it and unmap it? if succeed, then the curre=
nt will be
> >> signaled with correct vaddr and shift?
> >
> > That's a very good question.  I didn't see a SIGBUS when I first wrote =
this code,
> > hence all the p->mce_vaddr.  But now I'm
> > a) not sure why there wasn't a signal

We have a recent change around this behavior, which might be an answer for =
you.
See commit 30c9cf492704 ("mm,hwpoison: send SIGBUS to PF_MCE_EARLY processe=
s on action required events").

> > b) if we are to fix the problems noted by AndyL, need to make sure that=
 there isn't a SIGBUS
>=20
> Tests on upstream kernel today show that memory_failure() is both unmappi=
ng the page
> and sending a SIGBUS.

Sorry if I misunderstood the exact problem, but if the point is to allow
user processes to find poisoned virtual address without SIGBUS, one possibl=
e
way is to expose hwpoison entry via /proc/pid/pagemap (attached a draft pat=
ch below).
With this patch, processes easily find hwpoison entries without any new int=
erface.

>=20
> My biggest issue with the KERNEL_COPYIN recovery path is that we don't ha=
ve code
> to mark the page not present while we are still in do_machine_check().=20

It sounds to me that even if we have such code, it just narrows down the ra=
ce window
between multiple MCEs on different CPUs. Or does it completely prevent the =
race?
(Another thread could touch the poisoned page just before the first thread =
marks
the page non-present?)

> That's resulted
> in recovery working for simple cases where there is a single get_user() c=
all followed by
> an error return if that failed. But more complex cases require more machi=
ne checks and
> a touching faith that the kernel will eventually give up trying (spoiler:=
 it sometimes doesn't).
>=20
> Thanks to the decode of the instruction we do have the virtual address. S=
o we just need
> a safe walk of pgd->p4d->pud->pmd->pte (truncated if we hit a huge page) =
with a write
> of a "not-present" value. Maybe a different poison type from the one we g=
et from
> memory_failure() so that the #PF code can recognize this as a special cas=
e and do any
> other work that we avoided because we were in #MC context.

As you answered in another email, p->mce_vaddr is set only on KERNEL_COPYIN=
 case,
then if p->mce_vaddr is available also for generic SRAR MCE (I'm assuming t=
hat we are
talking about issues on race between generic SRAR MCE not only for KERNEL_C=
OPYIN case),
that might be helpful, although it might be hard to implement.
And I'm afraid that walking page table could find the wrong virtual address=
 if a process
have multiple entries to the single page. We could send multiple SIGBUSs fo=
r such case,
but maybe that's not an optimal solution.

Thanks,
Naoya Horiguchi

----
From 147449a97e2ea3420ac3523f13523f5d30a13614 Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Tue, 16 Mar 2021 14:22:21 +0900
Subject: [PATCH] pagemap: expose hwpoison entry

not-signed-off-by-yet: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 fs/proc/task_mmu.c      |  6 ++++++
 include/linux/swapops.h | 12 ++++++++++++
 tools/vm/page-types.c   |  5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 602e3a52884d..08cea209bae7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1300,6 +1300,7 @@ struct pagemapread {
 #define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
+#define PM_HWPOISON	       	BIT_ULL(60)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1385,6 +1386,11 @@ static pagemap_entry_t pte_to_pagemap_entry(struct p=
agemapread *pm,
 		if (is_migration_entry(entry))
 			page =3D migration_entry_to_page(entry);
=20
+		if (is_hwpoison_entry(entry)) {
+			page =3D hwpoison_entry_to_page(entry);
+			flags |=3D PM_HWPOISON;
+		}
+
 		if (is_device_private_entry(entry))
 			page =3D device_private_entry_to_page(entry);
 	}
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d9b7c9132c2f..1b9dedbd06ab 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -323,6 +323,13 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
 	return swp_type(entry) =3D=3D SWP_HWPOISON;
 }
=20
+static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
+{
+	struct page *p =3D pfn_to_page(swp_offset(entry));
+	WARN_ON(!PageHWPoison(p));
+	return p;
+}
+
 static inline void num_poisoned_pages_inc(void)
 {
 	atomic_long_inc(&num_poisoned_pages);
@@ -345,6 +352,11 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
 	return 0;
 }
=20
+static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
+{
+	return NULL;
+}
+
 static inline void num_poisoned_pages_inc(void)
 {
 }
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 0517c744b04e..1160d5a14955 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -53,6 +53,7 @@
 #define PM_SWAP_OFFSET(x)	(((x) & PM_PFRAME_MASK) >> MAX_SWAPFILES_SHIFT)
 #define PM_SOFT_DIRTY		(1ULL << 55)
 #define PM_MMAP_EXCLUSIVE	(1ULL << 56)
+#define PM_HWPOISON		(1ULL << 60)
 #define PM_FILE			(1ULL << 61)
 #define PM_SWAP			(1ULL << 62)
 #define PM_PRESENT		(1ULL << 63)
@@ -311,6 +312,8 @@ static unsigned long pagemap_pfn(uint64_t val)
=20
 	if (val & PM_PRESENT)
 		pfn =3D PM_PFRAME(val);
+	else if (val & PM_HWPOISON)
+		pfn =3D PM_SWAP_OFFSET(val);
 	else
 		pfn =3D 0;
=20
@@ -742,7 +745,7 @@ static void walk_vma(unsigned long index, unsigned long=
 count)
 			pfn =3D pagemap_pfn(buf[i]);
 			if (pfn)
 				walk_pfn(index + i, pfn, 1, buf[i]);
-			if (buf[i] & PM_SWAP)
+			else if (buf[i] & PM_SWAP)
 				walk_swap(index + i, buf[i]);
 		}
=20
--=20
2.25.1
