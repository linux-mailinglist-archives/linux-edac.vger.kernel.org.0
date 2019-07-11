Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF495650C1
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jul 2019 06:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfGKEOw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 00:14:52 -0400
Received: from mail-eopbgr800123.outbound.protection.outlook.com ([40.107.80.123]:49024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfGKEOw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Jul 2019 00:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA3sKgbQ+k41jBzSGwUGMMBaITX7KG1WOE4CXiFL330=;
 b=iNlhZhw6eoxgnvOyOW+qE/K29FEwP/u3iAdqifASyjp8GSw1+jx9eqA8Wvld/d5VKg7SX/xGNdwnPA+rdc63KKYl0LkrQg6m8+rpkRRIPChIZ8PIYJ/92T+9wOEvgoi3A6X3wIkGcRxNJ/dc9eOwxd0XFZB18ZTU9AqMLVOEXHw=
Received: from BYAPR01MB3975.prod.exchangelabs.com (52.135.201.14) by
 BYAPR01MB4055.prod.exchangelabs.com (52.135.236.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 04:14:45 +0000
Received: from BYAPR01MB3975.prod.exchangelabs.com
 ([fe80::a81b:f1e7:a31f:d464]) by BYAPR01MB3975.prod.exchangelabs.com
 ([fe80::a81b:f1e7:a31f:d464%6]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 04:14:45 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     James Morse <james.morse@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "Andrew.Murray@arm.com" <Andrew.Murray@arm.com>,
        Open Source Submission <patches@amperecomputing.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH RFC 2/4] arm64: mm: Add RAS extension system register
 check to SEA handling
Thread-Topic: [PATCH RFC 2/4] arm64: mm: Add RAS extension system register
 check to SEA handling
Thread-Index: AQHVMPZvV84yhcAYOk+DNBn1Cdw2C6bAhfiAgAKLP66AAcNd4A==
Date:   Thu, 11 Jul 2019 04:14:45 +0000
Message-ID: <BYAPR01MB3975FB635454503D3BFBBD53E3F30@BYAPR01MB3975.prod.exchangelabs.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-3-git-send-email-baicar@os.amperecomputing.com>,
 <df262b97-eda2-0556-d6ef-532a0d697131@arm.com>,<BYAPR01MB39754DFAF8130743448FDEC6E3F00@BYAPR01MB3975.prod.exchangelabs.com>
In-Reply-To: <BYAPR01MB39754DFAF8130743448FDEC6E3F00@BYAPR01MB3975.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-originating-ip: [174.109.142.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b1db25-433e-4007-7f84-08d705b64e9a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR01MB4055;
x-ms-traffictypediagnostic: BYAPR01MB4055:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR01MB4055A29CA9895A7CE785F1B4E3F30@BYAPR01MB4055.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(189003)(199004)(966005)(76176011)(3846002)(478600001)(71190400001)(71200400001)(66446008)(76116006)(186003)(64756008)(66476007)(66556008)(66946007)(8936002)(99286004)(91956017)(14454004)(68736007)(6506007)(53546011)(14444005)(26005)(66066001)(86362001)(102836004)(25786009)(7696005)(6116002)(4326008)(256004)(55016002)(486006)(7736002)(7416002)(52536014)(229853002)(5660300002)(476003)(6436002)(446003)(2501003)(54906003)(110136005)(11346002)(316002)(2906002)(81166006)(81156014)(8676002)(305945005)(74316002)(6246003)(9686003)(6306002)(53936002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB4055;H:BYAPR01MB3975.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KL+oScjiwncfzVQjXVLRwBmFA8lKFJN7qbVGMlqt9K4QQuxb/n/yk9G4c5QWHTkDybDyofbBi7lEZyBcB7yG4J9V3Zl0dz7iKamvW7W51V/ITvu6as6A9q3KRJS/awKJ+Bf5xt/4Zhmi90sobkrFWy0sKipydAaZ6twD9ZtdyM58G89tM8MEl0icH2xSa+h6nyY9VVMnCG8INIbd+J1vT+WtaRknlCGPUIFQC3ChEXpTq8yawy0dw4fS2MXOSOqEiACluoUAL8k/Fx4ClD0c/LLmiENDhKXDF2VNIpIdVhJbdmHDE6HtRgC7FmzsQZFdo2d3lbFDl6ekjXA2kFur5kaL299ZLk6aOlepBDDL5JG7rEkprKCz93o+xsqXiGJ0SzMxqFWx3QAsCaeCIhMI+6dopov0wUm3ki/H2jmmczw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b1db25-433e-4007-7f84-08d705b64e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 04:14:45.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4055
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James, Mark,

On Tue, Jul 9, 2019 at 8:52 PM Tyler Baicar OS <baicar@os.amperecomputing.c=
om> wrote:
> On Mon, Jul 8, 2019 at 10:10 AM James Morse <james.morse@arm.com> wrote:
> > On 02/07/2019 17:51, Tyler Baicar OS wrote:
> > > @@ -632,6 +633,8 @@ static int do_sea(unsigned long addr, unsigned in=
t esr, struct pt_regs *regs)
> > >
> > >       inf =3D esr_to_fault_info(esr);
> > >
> > > +     arch_arm_ras_report_error();
> > > +
> > >       /*
> > >        * Return value ignored as we rely on signal merging.
> > >        * Future patches will make this more robust.
> > >
> >
> > If we interrupted a preemptible context, do_sea() is preemptible too...=
 This means we
> > can't know if we're still running on the same CPU as the one that took =
the external-abort.
> > (until this series, it hasn't mattered).
> >
> > Fixing this means cramming something into entry.S's el1_da, as this may=
 unmask interrupts
> > before calling do_mem_abort(). But its going to be ugly because some of=
 do_mem_abort()s
> > ESR values need to be preemptible because they sleep, e.g. page-faults =
calling
> > handle_mm_fault().
> > For do_sea(), do_exit() will 'fix' the preempt count if we kill the thr=
ead, but if we
> > don't, it still needs to be balanced. Doing all this in assembly is goi=
ng to be unreadable!
> >
> > Mark Rutland has a series to move the entry assembly into C [0]. Based =
on that that it
> > should be possible for the new el1_abort() to spot a Synchronous-Extern=
al-Abort ESR, and
> > wrap the do_mem_abort() with preempt enable/disable, before inheriting =
the flags. (which
> > for synchronous exceptions, I think we should always do)
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/=
?h=3Darm64/entry-deasm
>
> Hey James,
>
> Good catch! I didn't think the synchronous route was preemptible.
>
> I wasn't seeing this issue when testing this on emulation, but I was able=
 to
> test and prove the issue on a Neoverse N1 SDP:
>
> root@genericarmv8:~# echo 0x100000000 > /proc/cached_read
> [   42.985622] Reading from address 0x100000000
> [   42.989893] WARNING: CPU: 0 PID: 2812 at /home/tyler/neoverse/arm-refe=
rence-
> platforms/linux/arch/arm64/kernel/cpufeature.c:1940 this_cpu_has_cap+0x68=
/0x78
> [..]
> [   43.119083] Call trace:
> [   43.121515]  this_cpu_has_cap+0x68/0x78
> [   43.125338]  do_sea+0x34/0x70
> [   43.128292]  do_mem_abort+0x3c/0x98
> [   43.131765]  el1_da+0x20/0x94
> [   43.134722]  cached_read+0x30/0x68
> [   43.138112]  simple_attr_write+0xbc/0x128
> [   43.142109]  proc_reg_write+0x60/0xa8
> [   43.145757]  __vfs_write+0x18/0x40
> [   43.149145]  vfs_write+0xa4/0x1b8
> [   43.152445]  ksys_write+0x64/0xe0
> [   43.155746]  __arm64_sys_write+0x14/0x20
> [   43.159654]  el0_svc_common.constprop.0+0xa8/0x100
> [   43.164430]  el0_svc_handler+0x28/0x78
> [   43.168165]  el0_svc+0x8/0xc
> [   43.171031] ---[ end trace 2c27619659261a1d ]---
> [   43.175647] Internal error: synchronous external abort: 96000410 [#1]
> PREEMPT SMP
> [..]
>
> That warning is because it's preemptible:
>
> if (!WARN_ON(preemptible()) && n < ARM64_NCAPS) {
>
> I'll pull Mark's series in and add the preempt enable/disable around the =
call
> to do_mem_abort() in el1_abort() and test that out!

I was able to pull in the series mentioned [0] and add a patch to wrap
do_mem_abort with preempt disable/enable and the warning has gone away.

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index 43aa78331e72..26cdf7db511a 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -118,7 +118,25 @@ static void el1_abort(struct pt_regs *regs, unsigned l=
ong esr)
 	unsigned long far =3D read_sysreg(far_el1);
 	local_daif_inherit(regs);
 	far =3D untagged_addr(far);
-	do_mem_abort(far, esr, regs);
+
+	switch (esr & ESR_ELx_FSC) {
+	case ESR_ELx_FSC_EXTABT:	// Synchronous External Abort
+	case 0x14:			// SEA level 0 translation table walk
+	case 0x15:			// SEA level 1 translation table walk
+	case 0x16:			// SEA level 2 translation table walk
+	case 0x17:			// SEA level 3 translation table walk
+	case 0x18:			// Synchronous ECC error
+	case 0x1c:			// SECC level 0 translation table walk
+	case 0x1d:			// SECC level 1 translation table walk
+	case 0x1e:			// SECC level 2 translation table walk
+	case 0x1f:			// SECC level 3 translation table walk
+		preempt_disable();
+		do_mem_abort(far, esr, regs);
+		preempt_enable();
+		break;
+	default:
+		do_mem_abort(far, esr, regs);
+	};
 }
=20
 /* Stack or PC alignment exception handling */
--=20


Is that what you had in mind James?

Has this series [0] been accepted and is just waiting to be pulled now?
Do you want me to add tested-by?

Thanks,
Tyler

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Darm64/entry-deasm=
