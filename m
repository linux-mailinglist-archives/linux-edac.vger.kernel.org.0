Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A210E9C3
	for <lists+linux-edac@lfdr.de>; Mon,  2 Dec 2019 12:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBLrN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Dec 2019 06:47:13 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50596 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbfLBLrN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Dec 2019 06:47:13 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2BkgHq018374;
        Mon, 2 Dec 2019 03:46:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+Jp0J9nkN6CNRKPZgFa1+dcpjGL6x5CkHinntinLqj0=;
 b=PHhZ8jWhMxkl8sX4uVrauz4DxHQ9qPYBPiwm7DdXS68e9vyRV1xfiPBsosxPeVcnIhjS
 MBe13gzh8o/hNeVz2ZtUS7cSMwGoIX7HZ+miXXZ3BzAgbpbpTScIa5sm6wLaRT7nlXpP
 PkrIz1xCy+tMghk5NqpyZPskUtO8TqBx5SNHhLAiQkt2rEHwozSJ7pijTJljKBpisKeO
 wqdBh7fk2Xh3pmkDHD38XJmglbfc4m5o1eizpbrpxiHRX60VWSFTRieGxP5/957teTod
 C7k+zcAwvFuFnj+21Fvt1NT80DBJus7LJyIj+X00HZ0OVOmfN+KUQZSHtzisbRH2uE2u /Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wkpnw6dx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 03:46:42 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Dec
 2019 03:46:41 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Dec 2019 03:46:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG0iUPP/2bNiDxgqKcLZFNArbD8CkjFYTL2pWeNQAjj+1E7qtBYiPrvqPV2IaiWYcgHeX/Q+/qrEeE1cD9I5HHcpObKjIDUDqdCYXKD7RKQYQHOtpJ8SEKF32M5QAZ5ZkkasTxLArrc+2+aMqJcrz42BflN0EPdXytBiOmDATJxzYHNpNu322RndjBRSnO8Ibx2yL4lwRoPJGq6agYbqtP8SabmleR9Wi0F5bCVv5Nf5jVLRkSUS89b9MDRaliHFSODwv+pfuWYkltvyJWNLALSo/3S0G8p8MHXzn+I1KeeENbgBroXAmgYBmAcVtN2BCj+OypeogynGXNsU06h55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jp0J9nkN6CNRKPZgFa1+dcpjGL6x5CkHinntinLqj0=;
 b=kV+crNgxuwvoVYWZnU78D7qN30Qbnh+5B+ZKXADZI5bwzJcqV3fiKKbJBsQQ2vAFuqKLahwDzjAyFm7n1Q30aSxYT55C2GONlqsw/ztaiLkbw7heRmAczZSj3sz9iQqAYsMdQvGIp4yueKgoWAq+F8CaW84FWzeXvYjrUJAH0iooEXKRbnSubGaClqH14lbHbf9DPhGqKwbXQ6vuroWYexq0jljxsRvLSN06oJEoPRrOXoSxyWSEDCVO6xNpMaupM7nw8bhmSjW28h0HZzi2nuYQv+/9d2fUA3extzsZ8TfgKOpu5DM7RtLUd/gpApBBWHsVtVO2ueJ5D0/GqG1iJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jp0J9nkN6CNRKPZgFa1+dcpjGL6x5CkHinntinLqj0=;
 b=Mp7naJ2KffMZ2Db/xgPpigFeoIxm6qUim1UgAB9B23RMoZubajAG3CzFYvlIgNYf4b8OqUCwekIkINZJqKqzdWaia3dtsXgX2xQRZBWqhLZifJU7lze9h9yYgtE6cSLEmPXuunlzdC1SDkGR4P1A0o3SMbPCYSo1u6iy4keY2tE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3421.namprd18.prod.outlook.com (10.255.238.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 11:46:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 11:46:39 +0000
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
Subject: Re: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Topic: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Index: AQHVqQYo+UA6d90sU0GZ0auiVPBpmw==
Date:   Mon, 2 Dec 2019 11:46:39 +0000
Message-ID: <20191202114630.qejem3irhz4yv66p@rric.localdomain>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
 <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
 <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
 <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
 <20191128211240.yuuhf4xkzhl2jvfw@rric.localdomain>
 <49bb86d8-a7ad-e66d-9796-799ee0bdd605@huawei.com>
In-Reply-To: <49bb86d8-a7ad-e66d-9796-799ee0bdd605@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0202.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eef060a-14f5-4d19-1d3c-08d7771d4aca
x-ms-traffictypediagnostic: MN2PR18MB3421:
x-microsoft-antispam-prvs: <MN2PR18MB342143CBF0AEE1A6056CDD5CD9430@MN2PR18MB3421.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39850400004)(366004)(376002)(346002)(199004)(189003)(2906002)(14454004)(305945005)(9686003)(54906003)(6512007)(4326008)(1076003)(316002)(6246003)(229853002)(71190400001)(71200400001)(6436002)(5660300002)(6486002)(256004)(76176011)(11346002)(386003)(6506007)(53546011)(446003)(102836004)(52116002)(186003)(26005)(81166006)(7416002)(6916009)(7736002)(81156014)(8936002)(86362001)(8676002)(25786009)(6116002)(66556008)(66476007)(66946007)(64756008)(66446008)(99286004)(66066001)(478600001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3421;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFMxJDR4NwMFKsDMnP9h0KwMYI3HEC7LRKtjUherEVOUAlT+rkEaJukyfHafQfD+o4themhh4Nm8VLEpHF/WGWL4lGQjU36th+liCL2Itx9BVfG0oQ1o/qSgU5PhEYrw09kNNCRb15AzOTi7RWAlSFWzjXpbVI17ouPy0RHhWfw41jFe5+lWyn/t0mx+vWcKjaD2/HkhUQX9jrHH9H2zXbvbpRJsMwEuRC5Vm9CSo4X1xvZdKUA6qc8SWtvfUpQfjfYgHKdeex5CuetA+/NPLeRrp8jzPdcoz4b2VIkKv5nTn0BD+F7spGI642te4/3a7IfoeQhRpvkE276pt+nh8V2pgdd1VUc/KyzZpluPt+mfwTS++HbPDIqn7ujb01mWkxcHbf2+ZcFIzMtctfgPYUt5P/jhVQSZmAh3wp5KIpP1Ga6b0Wl/I1VLxJUwqiZj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25DCDE6B3A19C642AC21C445E5C3244D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eef060a-14f5-4d19-1d3c-08d7771d4aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 11:46:39.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvRSIr1w9hk53voxh7XdgqZePl64EonSb2C+PynjX5PI1jlLcWQ0TOd9csg9rMY/fWvWhbPWOMc/063wMr/CZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3421
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.12.19 10:23:29, John Garry wrote:
> On 28/11/2019 21:12, Robert Richter wrote:
> > On 27.11.19 17:07:33, John Garry wrote:
> > > [   22.104498] BUG: KASAN: use-after-free in
> > > edac_remove_sysfs_mci_device+0x148/0x180
> >=20
> > It is triggered in edac_remove_sysfs_mci_device().
> >=20
> > device_unregister(&dimm->dev) not only removes the sysfs entry, it
> > also frees the dimm struct in dimm_attr_release(). When incrementing
> > the loop in mci_for_each_dimm(), the dimm struct is accessed again
> > which causes the use-after-free. But, the dimm struct shouln'd be
> > released here already.
> >=20
> > edac_remove_sysfs_mci_device() should not release the devices at this
> > point. We need clean release functions for mci and dimm_info and
> > refcounts to protect pdev/dev mappings. And mci_for_each_dimm() must
> > be checked how it handles device removals and if it is safe.
> >=20
> > Let's see how this can be fixed.
> >=20
> > Thanks for reporting the issue.
>=20
> Fine, and would any fix also deal with the v5.4 mem leak which I mentione=
d
> also?

Yes, I have identified the leaks:

# grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
      1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0	# mci->csrows
     16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0	# csr->channels
     16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0	# csr->channels[=
chn]
      1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0	# mci->dimms
     34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8	# see edac_=
mc_alloc()

Thanks,

-Robert
