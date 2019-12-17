Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC512215C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2019 02:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLQBTd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 20:19:33 -0500
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:23545
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfLQBTc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 20:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu4rUyHTdFZ+/KYaxfMTf2Lg8kr2EMvhyy+vJfqorPaT+S3lszFPZ2vQz5oBdJLpwHgwDIqWh8PvpzFPqZff7rdHyf/7KvF53wyAEjNWtdXSAOJ/X/WOr42YD/hG6E3QOM7YQB5Z9+k39s+4ew4buWlEz5UoLUOE5RTGsrfxipl9W8YI3k6XDJDOA2tkFrYSZNk9VOoptVrv5kQAivi31HUyUxHPxA2SYwB+xINEEOBV4SG7to7jpU9vUiTzeTG9Q0Y9Z6xA/+Aq+qJMIhJQiu5BoCcp0XKDNWi8UdrKbPSmKE7Xt4QmxpF+Tuu1nOsUxlyuexkAIj/R3ChqDyYuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2B1u3bIn38z2Fw/txSHm5VSuE02GiRmKXkGJJW70ns=;
 b=NvU0ABlQAZsMs2gx0XBXKmKDNzbqtTsXBrzHKaIUHlx14sQbkJl7R0PagJBuoCoa2o2sfpWrN/7jabZruvK77DQEDuE9qVNNsdceUU0RfanpuCtYeiuHK1+4G1gi9afehKo9oesHxpWTJyaBWSuQiJzAjcDLgay4Sz6zibHCFX9w2R1XvDkKBwCxI9f1X2KVytQixYtQPICUl0G5kH+ojKiiRjvYfYC3/TG2YWWq2B4N0NWUin5r0ug+nCVu0NLTC8gW5NrC5bhBQTC9/Qj42TH9P1JatUrmxHcuPFEKk76GEX8i4+yQYSIKoJVNxAyqLjlfSLv4H38XMOtFbNi0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2B1u3bIn38z2Fw/txSHm5VSuE02GiRmKXkGJJW70ns=;
 b=EXfE4cZlLNHo0+N4yuQxps/AcjLaYSaglNpUr3L2wXTC5783skI8n293+ayZaq4ZEQ+jn21zw7xjXFYQMaz+aiLk1zLQus9RxXMpujtCtSLnkv+q/gFWvnTfMCI/psfU3euwGlY6b8pzfK57ujQat4abOF8DqjWpc/E1kT2ZweQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.106.25) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 01:19:30 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::137:38a3:4901:29eb]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::137:38a3:4901:29eb%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 01:19:30 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     =?iso-8859-1?Q?Jan_H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
Thread-Topic: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
Thread-Index: AQHVtDEtbm/G/FA26E+Wxr4IXFt1lKe9T8UAgAAAzlA=
Date:   Tue, 17 Dec 2019 01:19:30 +0000
Message-ID: <SN6PR12MB26391C83526286B4127E40E8F8500@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191211002519.GA30513@agluck-desk2.amr.corp.intel.com>
 <d8e11387-c84a-f333-7ea5-f9043af6375e@amazon.de>
 <20191216165207.GC17380@zn.tnic>
 <20191216215924.GA27474@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20191216215924.GA27474@agluck-desk2.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [142.196.148.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7866ee36-f349-4a68-cb8d-08d7828f2ac4
x-ms-traffictypediagnostic: SN6PR12MB2605:
x-microsoft-antispam-prvs: <SN6PR12MB2605F5A29B5A9A4BA9C8EB27F8500@SN6PR12MB2605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(13464003)(199004)(189003)(33656002)(71200400001)(4326008)(66946007)(5660300002)(66574012)(186003)(316002)(66476007)(8936002)(52536014)(66556008)(66446008)(64756008)(55016002)(9686003)(53546011)(8676002)(81166006)(76116006)(81156014)(7696005)(6506007)(54906003)(86362001)(110136005)(26005)(2906002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2605;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvtsKlZA7eZjbdCshto5ca2yfC6uGmDJJseITG9P8B/6Q0ixZNSnCqnKHgPkJxlRStF5Xq9EKFBWcYDVeLV6n1jId79t9g70Qx0V1FW4YVtiRpXCPVcKXALHCIVvULaZWCugsvQterwL39+Q5MOJLfODdtiLJOSoxX+VLICurPXud3paDyZm46gisy+HNnAEhti7Jn0B3ub6GDqpKFq1qpDbZ6Tgn0M0uV8dlvbVkotsSHiMs5ZIA1ndps9sRkqvMYyqpwishFMKs0NRaWNaBvgZG0Ssx6cUta960w7t5xWTx8a2DDMCaPd/99rdEigV29WyM+YBlJ14UDkWwQ3I1KLymBtdvjcEi4ssz2ZSVhGMrR+AJo1vitRCrFL8Dz+0QMusN7OvX/lmclMI6ERqGrZihVQnTWN8ZHipo6EmcXZJTUh1rdDbux+AE7DVbRahlE/JaYTcJejWwyq3YlMMk9lWUuafcGAnrVGL4VNinDgD6L4m6T5q2qLlGn2g36Qk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7866ee36-f349-4a68-cb8d-08d7828f2ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 01:19:30.3770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haHFpfK+Ct7SRYzkWamdI2R4xrFvyuWBzPAr2dhUNVgwUYvfnifWx7F9X8FLH2XUXS4mPXDMl3krNTpdyheLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Monday, December 16, 2019 4:59 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Jan H. Sch=F6nherr <jschoenh@amazon.de>; Ghannam, Yazen <Yazen.Ghanna=
m@amd.com>; linux-edac@vger.kernel.org; Thomas
> Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; H. Peter A=
nvin <hpa@zytor.com>; x86@kernel.org
> Subject: Re: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE hand=
ling
>=20
> On Mon, Dec 16, 2019 at 05:52:07PM +0100, Borislav Petkov wrote:
> > On Thu, Dec 12, 2019 at 01:25:31PM +0100, Jan H. Sch=F6nherr wrote:
> > > This and names like "uncorrected_memory_error_notifier()" seem to imp=
ly
> > > a wider scope than the function actually has. That brings me to anoth=
er
> > > question: should the scope be wider?
> > >
> > > Instead of filtering for usable addresses and specific severities, we
> > > could for example filter for (similar to cec_add_mce()):
> > >
> > >   mce_is_memory_error(m) &&
> > >   !mce_is_correctable(m) &&
> > >   mce_usable_address(m)
> >
> > There's a comment above that code which says what that function wants:
> >
> > 	/* We eat only correctable DRAM errors with usable addresses. */
> >
> > > Would that make sense? Or does that violate anything, that I'm not aw=
are of?
> >
> > So this should be a decision of the two CPU vendors basically answering
> > the question: for which error severities you want the kernel to poison
> > pages?
> >
> > Basically a question for Tony and Yazen. CCed.
>=20
> Using Intel naming, I'd like the SRAO and UCNA severity uncorrected
> errors to take the soft offline path to stop using pages.
>=20

For AMD, I'd like that no errors are handled in the SRAO notifier for now.

The DEFERRED severity could be used, but I'd like to do more testing before=
hand.

Thanks,
Yazen


