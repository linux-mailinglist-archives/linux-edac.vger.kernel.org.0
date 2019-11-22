Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B09107159
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2019 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfKVL3M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Nov 2019 06:29:12 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:22254 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726975AbfKVL3L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 22 Nov 2019 06:29:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMBQ2RQ003272;
        Fri, 22 Nov 2019 03:28:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=J6jCyHPvaGj+4A5JLeYs4EPwNJjxC2g2agg27mDlKMs=;
 b=f75DHlbtJIEiiMFA6BD0rveuM4XxfD+oNdZsDiyerzHL3Tm/YNnegmwTEtIX+OqdsPrS
 DmAdZ1F7V7Lswd8Z28Jdo7G/ii+bycJ6OR3UdVFcaaeBGpSsFPgsgQCeluxz5loxCmXI
 +GXBabCcs1Fdt4emuDgWDMhqy48Qnnoz8hc8rF0e9OQvRAXl/jOMwTT3ezD3fMvVyw/7
 bwti/LB0Z/tOhitRNiaiAWMfRM+oKhKD2rtAbAC6dyCA1U5EnGIYhPjoucgf0Yc0N2Gx
 exmkCG2cTfzVOS6jOrqttr7KDpwLoBH0FGWMxegbrPGLSXEWfP+Yj641CjY1LWsgx5lB tw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2weafb94fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 03:28:54 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 22 Nov
 2019 03:28:53 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Nov 2019 03:28:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcgy0/n5VAmgpa7LuIa69rSWIme830M8s1rimQuV3Co7GoWEVW97xTXYP6I1XjnTQdr+/iBeUfxScG15StN/irVKes1T2TVE/CVuSqGQ5gUQt91NqgUp4/W3GktyAyAHFtpW5DrzbwOaaYDRk4aLh/liaIpyuVD22qnNn/Q12P+G01vjr7TERlAYhUImwPJUANYkslCQy21zQ48T2ncTlhwOKCvSkvxHGWnHhR9s0S8zqVIH+9RFzVhz03wEcr4JNDduB96hnxjVJIXotnsExnVoNwnM/5HajftO/NwTf83PAOzDPnuFphzEg/EC8JR+YBL1xAUpLXPkaXu7y4NIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6jCyHPvaGj+4A5JLeYs4EPwNJjxC2g2agg27mDlKMs=;
 b=GuWeWUZw6M00rVhaB8UNfrTf/sFdGFRkX20VGLEeuMto0x8pI5wsoKJq5VjTTcWkTCACkttMwZczuMSNG7oBIcO6L+++OZh1jS5d19Yj8UAKChdnXE8qJmSfM6+/tjjHska14IE95bdJMnvmAdF0tNXT14x4LWSlEYNiGWUBihRNSf5Kfau6APGqiSpAdNZ0Y/ICX9439a5zJPtg2+gPV2uY5k3U9LgaXU1gAPaMtg8symkSj1h1UvyrqVOlU0Yd/No81wjwELIpFmSQ698rsnw/VtaU/KhYiwokrn18QZ4Wgg0iom1KWrnz5ztjWU/fYjJ8uk5NdwPR0F0CGm4Mxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6jCyHPvaGj+4A5JLeYs4EPwNJjxC2g2agg27mDlKMs=;
 b=iaz5vLw+a8ApXADfPxmZfInQZFl1xXDtN1h20NRAcKK9qcc+goBSOQOcW3ZAwvef5kJOg+WwQoDOHPZXEPkOqLE2mvOSNMuc3lszpLxAdklBOxgEnsX6N/lAoG5xl7ar0NJHYYgDr73JZcr3Qs181QMrc9APXNAvZpXrVaA8CSM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2575.namprd18.prod.outlook.com (20.179.82.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 22 Nov 2019 11:28:51 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 11:28:51 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     John Garry <john.garry@huawei.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Huangming (Mark)" <huangming23@huawei.com>
Subject: Re: linuxnext-2019119 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Topic: linuxnext-2019119 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Index: AQHVoSgDZLrxCc1zPkWOGGwtnIkgYA==
Date:   Fri, 22 Nov 2019 11:28:50 +0000
Message-ID: <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
 <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
In-Reply-To: <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0304.eurprd05.prod.outlook.com
 (2603:10a6:7:93::35) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc1e841e-e277-4d65-3281-08d76f3f25e9
x-ms-traffictypediagnostic: MN2PR18MB2575:
x-microsoft-antispam-prvs: <MN2PR18MB2575AD6C209BBCD3435F354DD9490@MN2PR18MB2575.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(102836004)(7416002)(52116002)(8936002)(64756008)(66446008)(66556008)(66476007)(66946007)(316002)(3846002)(6116002)(8676002)(4326008)(229853002)(305945005)(7736002)(71190400001)(6512007)(9686003)(2906002)(81166006)(81156014)(54906003)(386003)(6506007)(53546011)(71200400001)(256004)(76176011)(6436002)(99286004)(6916009)(66066001)(508600001)(6486002)(86362001)(446003)(11346002)(25786009)(1076003)(5660300002)(26005)(6246003)(186003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2575;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?QDNnY9Vqsr8sNw9WiTtTxN1ImXvM//odnjkrKL3S1t7Yfgd4KulDZnIIKRSb?=
 =?us-ascii?Q?vnoQmJnirqC9O3Q6L5xUYOyIAPsoNAYcfMuhVQLVZ30RUJiY08mcZnS2SWZL?=
 =?us-ascii?Q?XPzoUhkl+cmvFrPHUBGmEakuNsAAK6N+gv2HCS7GkIL+igvIltFIXfcff1Q0?=
 =?us-ascii?Q?H5HorNDEEcxEPwXqBy0+pXvrcSq/X8sjVqkL+GjtFiOCLwo3fGNwiUHbW1V+?=
 =?us-ascii?Q?+XMEG7cavfA3P+zSQffjDja8WeJ7gdRn9t8CQoDZ0YSfFvqtXlRMV3TdAuzk?=
 =?us-ascii?Q?USc0VtZzi7ZHsNjVzFTlIKU7WiY7YTiUertmf68gi22n4bLUkX6bGcBbsHS1?=
 =?us-ascii?Q?tyLXghrbpdW2krFCmOPT8Nl93dnsYD7fm5glFStkjR/GU+Rgw88/vkrsJ00g?=
 =?us-ascii?Q?3npOrH3RHmms7jkeMpplq/qUWQC9RiTpdUsuo3kHCBVoVFv5mdO7mBUv+kGg?=
 =?us-ascii?Q?KfRO0tRCsdQ4b3k/wB2IyxeJhGkUci5gsBH326twUXi+3IkETddo/z7Z0tr0?=
 =?us-ascii?Q?W+G1n9pfVya4ARas5F/Itv1S0KQh7xql0Yeq/IRJ9DIGlDzsoNWaK2n9pjYS?=
 =?us-ascii?Q?jendncNy08nMsrR3U6wm4lTIcN5sERUHozHGLRxYZrpG3VJajJM45D/qbgnq?=
 =?us-ascii?Q?KazpvD6EHiOojdzlLYuYoldyUzLa8NwTsPvfY19/G2RtUdhOYx2oBwMbpyhJ?=
 =?us-ascii?Q?x5Zl8zSCJKuexDTC0OkTzK11nQpCYHHnDb0AiqOT3vCCwZtd/4qCPfy6Yr5r?=
 =?us-ascii?Q?Ds6BElSf6WEmqN44zkf2GzE71d14qpWRDq/Bd0D/M90jSFA9Bsp0OOoBcb0A?=
 =?us-ascii?Q?ZiI5cvwnYcuQ3HD2DdbpLjnSJEk5jAoL0N5kJ/0PcbStg2VCAIPP6O3qvKKG?=
 =?us-ascii?Q?8iX8N5wf09E6/QGLFQaYOD5clz1rQHGSUSu5B9FyPB9I4NQHRFYH2MZonZ21?=
 =?us-ascii?Q?JbtFLd4FVsgiN3cwmp8bwn9XV7NVBxrEzCoEEoYc8CUOA/Y1D6Bur8h4hHOZ?=
 =?us-ascii?Q?YiXrAhnE9Hrbhhf3Q5x6nppz92CLDLZFr4bdEPTfWJCN1Phrw/SVFgKszntC?=
 =?us-ascii?Q?f6HgmaUhes6v1JZpreXe8f/4YFbvznJh7+nblWLi2YHFHqXTqljHyPJ6SDZ+?=
 =?us-ascii?Q?YPHlEtChLUp8/jKpSYYcUN/hfHIi7xx9gyYQ3l6g/x+C2Ka9g8n1N8j0jUCG?=
 =?us-ascii?Q?HcR4EMCU27s51clE31GaPs5Dlmjzld+Anjw1xKID86tsuNFAzTdv2U21JSrL?=
 =?us-ascii?Q?fF6PbBwQucAEIw3cvQy2nUvwbRfFPpw9CjhODRTsDUMGsWwzlk3RJsrT7vVe?=
 =?us-ascii?Q?lF0C79ie8wyQBtU+PZCdbUHpmI3ActkjmROoXojjnUfR5IeWSh/RGFAowfmc?=
 =?us-ascii?Q?RHsItoMnehlz6krFHww5tR3V+lzr9VCVrl7uUCT8bx0ULKcy1Ly+0/g1MRaY?=
 =?us-ascii?Q?TImK5bMZmxpfmfateFzy72Tn13qKNsLUUnp6SHNh30qyhbRUUcjqpWPmrHMM?=
 =?us-ascii?Q?R2zTgi71fIRpL4CZ0DTw0UdLfJXyLoDCUgoPMVNMzBGiiMD0im543gOkIbmF?=
 =?us-ascii?Q?a6KNnMhpB3qF8OqSOZ/Is7GMp+FevYkSDUvk5j9VMEBNcQ3GPBjsyZHnnJaY?=
 =?us-ascii?Q?v7xNAgyoMemhzCuXSi0BOcksvcYi9YkwGt4wkKn24VwOBWl/Opi00oLmWKvs?=
 =?us-ascii?Q?EQ5ssqHB6XzwfciDdiJMvBXOPPWkr0Zo+FdpWLK3Yi6Lis0V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F5FF74244E9F442967D6CA075EBEB59@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e841e-e277-4d65-3281-08d76f3f25e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 11:28:50.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jyze51Ybnyb9LS2rZhKHYxtHb8o17/8UbBXOX9/DNKqApJyYYwN28+xFOcMxbKAcYQ+VdHGRh+MbCBkkAvpUAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2575
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 21.11.19 15:23:42, John Garry wrote:
> On 21/11/2019 14:23, Robert Richter wrote:
> > On 21.11.19 12:34:22, John Garry wrote:

> > > [   22.046666] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.046666]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.058311] ghes_edac: Can't register at EDAC core
> > > [   22.065402] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.065402]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.077080] ghes_edac: Can't register at EDAC core
> > > [   22.084140] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.084140]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.095789] ghes_edac: Can't register at EDAC core
> > > [   22.102873] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.102873]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.115442] ghes_edac: Can't register at EDAC core
> > > [   22.122536] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.122536]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.134344] ghes_edac: Can't register at EDAC core
> > > [   22.141441] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.141441]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.153089] ghes_edac: Can't register at EDAC core
> > > [   22.160161] EDAC MC: bug in low-level driver: attempt to assign
> > > [   22.160161]     duplicate mc_idx 0 in add_mc_to_global_list()
> > > [   22.171810] ghes_edac: Can't register at EDAC core
> >=20
> > What I am more concerned is this here. In total this implies 8 ghes
> > users that all try to register a (single-instance) ghes mc device. For
> > non-x86 only one instance is allowed (see ghes_edac_register(), idx =3D
> > 0).

I also looked into this: With refcount_inc_checked() enabled, the
refcount is *not* increased from 0 to 1. Under the hood only
refcount_inc_not_zero() is called instead of refcount_inc(). So the
refcount is still zero after an edac mc device was registered. Instead
of sharing the edac mc device, the driver tries to allocate another mc
device for each GHESv2 entry in the HEST table. This causes the
'duplicate mc_idx' message. Also, it is ok to have multiple GHESv2
entries (your system seems to have 8 entries), e.g. to serve different
kind of errors in the system.

Thanks,

-Robert
