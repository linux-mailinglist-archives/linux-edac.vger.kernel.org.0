Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D53336E5
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 09:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCJIFr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Mar 2021 03:05:47 -0500
Received: from mail-eopbgr1320089.outbound.protection.outlook.com ([40.107.132.89]:40064
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232176AbhCJIFX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 10 Mar 2021 03:05:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmJQNg+s7RNYMlelmud2vN1UpBG9JOYb7oSr84HrwPYmyiV8sk+m0DVKJaywiG1qRAwzHx+ypF5hC/s0oWpamc1e9XSHoUhW6CWfFbk9Gh1HbyeIAf8d9t215l5uEFmQObYVb3n1jQ6Y8ai8tjQrKp/nELrcjU+s1Y/dJ0Nt6E6oItqSoZwYE3sJT+aJe7juTcwgFS+vPXfqz5/FAhGYP9nXpgKKhm4lPjw680a7VWICBXgenGHyea5F8nzRmOUNCobGzW/IKI5U16jV6jWEybCIgoHhtsInNIqey2sue4Zho4oKU+1tHqXUOIVexw2LUpdRn7W4lC7UDJ1vkQSwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csoiTHZkG+2ajTV3DKYtNTnsNmN37E/Ohj8oYz/ZRSk=;
 b=dR/tv2EzPktMi4sQxqdVpKLQt/B0K7uvA4OgcnizCCep+f2HqPgyfF9SRj18p8ghGZAD6B2RDB1aLT+OfOnMs2c5/eml0m7exhqztApwJxdcJDRmqG3i4WzAWmgXG9BRNO1hj83gX/dtIAN38A1MGVLFgmdezmFxNnnCoL75+EVJLm/bj3subdJMU2+eZDTOVThIvMzHDwMDCwCF+KlhqHAAYPjnkCUeDjMX7ALpN8cCH2FdAc3Hkj46a4HNIjEV7HHu/1QhRxgXpcU1jPeDmuMVihijxLTBsSfWgVh9y0D6nmCU+7tOug94zpmtJ9NuZfMUCardmPY9hVR+YG3TIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csoiTHZkG+2ajTV3DKYtNTnsNmN37E/Ohj8oYz/ZRSk=;
 b=QRA9WZHVtgaqYQQvHUCb14NibSOSvS9p7OHs0hmHFXDwJFlG3ZUHoj1UHi9vEBSgiiOfAp06JgIsohpIqp+c6yp11xDnydk8+3Yqsywu647RY/AaF52PUfxJ9+zHem1HzEWIjXSk7ERI/bpfXeEMCasV0RrM5Ny/IgeTNc5GRsQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB5116.jpnprd01.prod.outlook.com (2603:1096:404:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Wed, 10 Mar
 2021 08:05:16 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3912.026; Wed, 10 Mar 2021
 08:05:16 +0000
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
Subject: Re: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXFK5tQmxPuwvfpUmmzR/9gXeI5Kp7UvoAgADBsgCAAMorgA==
Date:   Wed, 10 Mar 2021 08:05:16 +0000
Message-ID: <20210310080515.GA23187@hori.linux.bs1.fc.nec.co.jp>
References: <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
 <20210309100421.3d09b6b1@alex-virtual-machine>
 <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
 <20210309143534.6c1a8ec5@alex-virtual-machine>
 <20210309082824.GA1793@hori.linux.bs1.fc.nec.co.jp>
 <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0269c6c8-dfec-493e-eefb-08d8e39b3d82
x-ms-traffictypediagnostic: TY2PR01MB5116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB5116FC17BF698A46973A3616E7919@TY2PR01MB5116.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tysq+hnsE8zwQ3qsfqhChkL5cJ6UEKtVOfX14S6VpSQN3xROaTXESvMbTOi5LAKr5e8NIvQW8mvNR8TibnakWcWGwwwKlgqP4jUO4b28VhYN/0o4SFjzVPQc2T8Bnhc7/AvEQafKPt72VVlCI2ThL9g7nj+r6NPs/WD/DSBKv1UDJDDBB41WV3OUVFHjwrGhlNYk6hUaOAEUIi/2nRLxYbzBNk5GmxzAS4/9g8weuQRyGkRUGNOiTY3s0TLLz23QRVM3DOGzgKAFQ0g9q5OvZY0ckh5KR1PyDIhEKKvSfpv5+4kxjop8nT58P56wYGwQR6wgp6RaTVX3lIaenNrO+FL5eKBqMWr8G6qByx4TgIaz8/MVVlTX7whCAAUV3x+BeYWGNTMsb1BiX8oBl9sDmqi6Pp50NXSE3BjLxuHnEqc0dARTJOlIjsAymKbqWKiYrHimuZnwaJUk5AXDGrwVx1ndMpMa8Hp34A5h1Lw5/hXu4eQsaxx8BynIXSLg+dx415Oqmixgf6E71tj8MiwYYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(26005)(6486002)(7416002)(83380400001)(8936002)(64756008)(66446008)(66476007)(85182001)(186003)(478600001)(66946007)(66556008)(55236004)(6506007)(76116006)(6916009)(71200400001)(1076003)(8676002)(54906003)(4326008)(86362001)(33656002)(316002)(9686003)(6512007)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?RHpZcFR4TTcvNm5tcWJ2ZFB1engwNUlZQkxKSWdBOWo1RkRFQlAxam1Y?=
 =?iso-2022-jp?B?UUdQLy81TEMyQVlNaTVML3prRDNjdjNndFUvMXNObmZGWWhKTHpxSUtQ?=
 =?iso-2022-jp?B?SUVoSXFpODRHTU5IT2xTRnNmVGxCZTRMcnJzMWZ3M1laelc1WWZiTC9o?=
 =?iso-2022-jp?B?dnB6U2lDalNzY01MRllneHhONEtUMlpvR1FvTHBEVFJZbHkvMTd3UEJh?=
 =?iso-2022-jp?B?WFRScEJOVVBhWXZpWE1yaUpZV3RHTnIvWUwrTHRDUnZ4NDRNRmZXWU5O?=
 =?iso-2022-jp?B?YUZGQUFDQ2NvdHd0dHhibTAzNzdxK1IrellhTm9HOWNFOEsvZFZXTjlp?=
 =?iso-2022-jp?B?djg1a2hXb0pkclNuZm5HNytjSWF6K2VqRTBDeE9raW5POWkrWXRlN1pt?=
 =?iso-2022-jp?B?b1FVdnhBek14dFJsa0hLQnVQS0U2bnJybTU0dStJRUQwRWR1Mkl0aTdN?=
 =?iso-2022-jp?B?bWl3ZUNRbVJuSjMxQXVubVJLVGkrbjRGQ0tGcytCZ3h4b0Vqa3ZldHNJ?=
 =?iso-2022-jp?B?UUVhUXMxSTNzY3IrWWNGcElzQ08vak9KSnN1YXdCYnJKalo0SVFEandl?=
 =?iso-2022-jp?B?eVFJMmJMMVU5Vnc3QThSazcrUVdsRE1XTlpuTzNaRmFFOVlFNC84ZmUy?=
 =?iso-2022-jp?B?SlNXMEdEbXlDM3lVZitNcUtNVVdaVmptRXo5czg3NVhXQ3FUWEY0NG1M?=
 =?iso-2022-jp?B?TkR2SlMvNlFDRkR4NWJkbHR4MWJFSWdhVE9sbkNhaWhib0h4bktoOUhZ?=
 =?iso-2022-jp?B?SEFkcU5iQ0xGdWpoaUNLV1B4WFV1SGhWUzRLTEFHMlNuTkk0VGt3TmhX?=
 =?iso-2022-jp?B?YmMrYkxmWmdoQjBlS3BwNDFUd1ZGejVDYkh2cERaT0h5UTFmY20wdTJQ?=
 =?iso-2022-jp?B?OFROeml3ZFJreTg1ek5tRlNuMk0rSjVCMm9ZVzc5S3lPT1ZrNmtZWUtU?=
 =?iso-2022-jp?B?bE05aFlDU1NDb0luNEdiZmRCR0xGVWk4RDBoM1hEbWtQVDFJZ3YxSGJY?=
 =?iso-2022-jp?B?bXlxQm1UVUtBUnBoWE04cnVKYkFqbmZvSDNhaGRaN1JSKzVRUnZOTHdQ?=
 =?iso-2022-jp?B?TGhhQzhpNHVmY0xPNlMycVBoTWJtb3JnWjVSNEFRajdNelgzcFJNYk50?=
 =?iso-2022-jp?B?Yk1FbXV5MDhkQzIrM1NVd3BVLzIvakIza1ZTWEloMi9TaG05OTFJVHVk?=
 =?iso-2022-jp?B?aEdoQkg3ZGQ5ODJkZGltZko1YVgrVHZ5MmgwL1pheUxEbkl2MndXL01o?=
 =?iso-2022-jp?B?MyszY2ZVVzR5dEYyVjJhSHhEZVVYVWp2ek96VVRaOUFzZldZRGVJVEdm?=
 =?iso-2022-jp?B?dC9vSlJWK1A4MjVRMGhkYzZmeTYwQ2RVZHNrd3UvQU50TjZTWVR0YUI3?=
 =?iso-2022-jp?B?QmdRUUd5UUFYQzVPSlNzWlVsSTYyV1duak5VRzZqSTdNSmIyOFFxTlgw?=
 =?iso-2022-jp?B?eXlRVVErUWF1ME9vT3UzQnQ5VVhpV0lUYXRtNTdrQWRzMHU5eEI4Z2NW?=
 =?iso-2022-jp?B?K2FGdmhBc0Q2dlNSbkFKUWxId3BrRjMrMnpLWjdJc1h4V1hUV0ovdWZq?=
 =?iso-2022-jp?B?MkZ2Y3p5VjV5SXJqNEU3SVNuK3oxNWlzeXRnR1dwMktXZEp5QmVvMXBM?=
 =?iso-2022-jp?B?emVISURFc2pkMXZlblFIQ0g2Ky94NVA5Y0pyM01iR2dERlgraythK2Ey?=
 =?iso-2022-jp?B?dXZuU3M2YWpwa1h6OEEvUTlCaGRsOU45MmRPa25Oa2FSYnQvakhWVzQ5?=
 =?iso-2022-jp?B?My85UzYvOXk1czlTUDhFaDg0R2hPazBOWGRCb3d0QUtkN0xEVTAwV3gy?=
 =?iso-2022-jp?B?MlZ0Nm5kR3l6SmV3aVB2TWYwT3N6TmozWjNONEZZMWtMYlJyK1JCdTVa?=
 =?iso-2022-jp?B?cmUxSW45bHRpZVRYUTdCOElzT01uRWdqV3E5VkU3Z3pBNGNvM243aXJv?=
 =?iso-2022-jp?B?QUdsRm1mNHVYOWJBNXNlMWdZWjBPdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <44B86F9C5E54F44FA075A48234B95D1E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0269c6c8-dfec-493e-eefb-08d8e39b3d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:05:16.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKf77zFArGhRizgVhIzdeJFkoWc4PMBmZe01R0ueKHt8rr6CIbkwibPHWLAV+lDCf1InQYeQu72JhPxtbZuotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5116
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 09, 2021 at 12:01:40PM -0800, Luck, Tony wrote:
> On Tue, Mar 09, 2021 at 08:28:24AM +0000, HORIGUCHI NAOYA(=1B$BKY8}=1B(B =
=1B$BD>Li=1B(B) wrote:
> > On Tue, Mar 09, 2021 at 02:35:34PM +0800, Aili Yao wrote:
> > > When the page is already poisoned, another memory_failure() call in t=
he
> > > same page now return 0, meaning OK. For nested memory mce handling, t=
his
> > > behavior may lead to mce looping, Example:
> > >=20
> > > 1.When LCME is enabled, and there are two processes A && B running on
> > > different core X && Y separately, which will access one same page, th=
en
> > > the page corrupted when process A access it, a MCE will be rasied to
> > > core X and the error process is just underway.
> > >=20
> > > 2.Then B access the page and trigger another MCE to core Y, it will a=
lso
> > > do error process, it will see TestSetPageHWPoison be true, and 0 is
> > > returned.
> > >=20
> > > 3.The kill_me_maybe will check the return:
> > >=20
> > > 1244 static void kill_me_maybe(struct callback_head *cb)
> > > 1245 {
> > >=20
> > > 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > > 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > > 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> > > p->mce_whole_page);
> > > 1257                 sync_core();
> > > 1258                 return;
> > > 1259         }
> > >=20
> > > 1267 }
> > >=20
> > > 4. The error process for B will end, and may nothing happened if
> > > kill-early is not set, The process B will re-excute instruction and g=
et
> > > into mce again and then loop happens. And also the set_mce_nospec()
> > > here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
> > > mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").
> > >=20
> > > For other cases which care the return value of memory_failure() shoul=
d
> > > check why they want to process a memory error which have already been
> > > processed. This behavior seems reasonable.
> >=20
> > Other reviewers shared ideas about the returned value, but actually
> > I'm not sure which the best one is (EBUSY is not that bad).
> > What we need to fix the reported issue is to return non-zero value
> > for "already poisoned" case (the value itself is not so important).=20
> >=20
> > Other callers of memory_failure() (mostly test programs) could see
> > the change of return value, but they can already see EBUSY now and
> > anyway they should check dmesg for more detail about why failed,
> > so the impact of the change is not so big.
> >=20
> > >=20
> > > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> >=20
> > Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>=20
> I think that both this and my "add a mutex" patch are both
> too simplistic for this complex problem :-(
>=20
> When multiple CPUs race to call memory_failure() for the same
> page we need the following results:
>=20
> 1) Poison page should be marked not-present in all tasks
> 	I think the mutex patch achieves this as long as
> 	memory_failure() doesn't hit an error[1].

My assumption is that reserved kernel pages is not supposed to be mapped to=
 any
process, so once memory_failure() judges a page as such, we never mark any =
page
table entry to hwpoison entry, is that correct?  So my question is why some
user-mapped page was judged as "reserved kernel page".  Futex allows such a=
 situation?

I personally tried some testcase crossing futex and hwpoison, but I can't
reproduced "reserved kernel page" case.  If possible, could you provide me
with a little more detail about your testcase?

>=20
> 2) All tasks that were executing an instruction that was accessing
>    the poison location should see a SIGBUS with virtual address and
>    BUS_MCEERR_AR signature in siginfo.
> 	Neither solution achieves this. The -EBUSY return ensures
> 	that there is a SIGBUS for the tasks that get the -EBUSY
> 	return, but no siginfo details.

Yes, that's not yet perfect but avoiding MCE loop is a progress.

> 	Just the mutex patch *might* have BUS_MCEERR_AO signature
> 	to the race losing tasks, but only if they have PF_MCE_EARLY
> 	set (so says the comment in kill_proc() ... but I don't
> 	see the code checking for that bit).

commit 30c9cf49270 might explain this, task_early_kill() got to call
find_early_kill_thread() (checking PF_MCE_EARLY) in this case.

>=20
> #2 seems hard to achieve ... there are inherent races that mean the
> AO SIGBUS could have been queued to the task before it even hits
> the poison.

So I feel that we might want some change on memory_failure() to send
SIGBUS(BUS_MCEERR_AR) to "race losing tasks" within the new mutex.
I agree that how we find the error address it also a problem.
For now, I still have no better idea than page table walk.

>=20
> Maybe should include a non-action:
>=20
> 3) A task should only see one SIGBUS per poison?
> 	Not sure if this is achievable either ... what if the task
> 	has the same page mapped multiple times?

My thought is that hwpoison-aware applications could have dedlicated thread
for SIGBUS handling, so it's better to be prepared for multiple signals for
the same error event.

Thanks,
Naoya Horiguchi=
