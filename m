Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDEBAEF8
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405902AbfIWIL6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 04:11:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26348 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405750AbfIWIL6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 04:11:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N88dYB027711;
        Mon, 23 Sep 2019 01:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Js1cpUUnfAQKu899RHMa4h608qpo/NFfrREbzry4AGo=;
 b=BxtazAu5fDQFn7XfFL+fzOtCReXjV23dOqKtL3U05zo+zgtU3/tvlnb7XtBHkgPSuRYX
 t3XbRoObDq9kdgnOUiJPv7bEfv3uu5TOTN7MDNtEayD+SUM5uITL3A0isNu5zSoDKeII
 O534ociPab2cRCBtgZPfFYs4ehFvJoV82gZNAioqAcVOtBqoS6ikEJoxgqXC26uk+YzA
 tMiQhjgMUeQJZkRz0B++C4cjrciBVuZtx/Uu6qypoQ5tpQ9uCZvfr8AFnTs9RyGAgo2J
 DuFow4ymHea/Y4SYdBmGXgUBPWxSMIA/7Hfer6Dd571gw8jNypqKs6J0HvqYxQABpqk6 Hg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v5kckmxk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 01:11:31 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 01:11:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 01:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9RP/KZc8SnQ7n38Ux9qmn3WkFR8I/Zf9otcUJMgzmR2/jgb/x7JNE4r2pIKIcUyFLhaNQr/g5r5D93sbDia3khhPZ6j03Y3P0MvGAHe0Tg6zk1YlGifHIePc2iA38cXxOinTJaiCZ/mExYg7NJnjKsNAoJQ9fbBx/gJnX3eBmVdG4AipU4Qsu2ggs9eQu899jMKoy3ThHGEiY9lMW1US7k4B2WkOV1T55mq0ND+sjwc4D6vxQzDGYt8Ncq7WS5xyeDQv4EojtmyoGTKk8CAc/iw4I+ryRPbzJWRyRiEU+YGCHePXRRCuT2xfqcHpkW8xYGzqLnPGKTcqfIuwupu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js1cpUUnfAQKu899RHMa4h608qpo/NFfrREbzry4AGo=;
 b=SallUi6VQZ5+J3gDpXoZDek6Ut1frIptIOzKBz86uTDvs67UZ/GkjGJwwnZ9In5HWZvAZc7zed8N83cxj2UUb6T7Sa6kbYbOz4IrTTlABIABHiQcj1HqkdpPWD+enIkxgv9vMCixVDQghIe4t+73OTGzWa9hGO1rUm8SjLbMhm9wHo22nHE9s2QTts3GtFYD6w01LAtjHO7jI693Wc3W81Bf3RBhVqHFzjgtxCOlIT/3HU9serf75LN9dzw6SX5yykokX6n9FaeOAht+i5hydvDQRGynaC2e6NW3CnnRybqYXDUJ2crufZfNmNc+jKhg6a+4sTJNS2zETqrSMpDCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js1cpUUnfAQKu899RHMa4h608qpo/NFfrREbzry4AGo=;
 b=ijIPWL3vXwHkBUpijOvDU61fTGmrTco/Mp4y9fnPeCz/qxOh2hnF2/EDI9eiiT1c45ACE+5kfJ4LC2ReXUQ7TStzJz/l2XLRp6owA9WpDRTdGrJMiMqzMUQfeLbgYKCXTDxeNiXMt6n8cRLnHERBv0opC7+3pmuFH6gx54iTKng=
Received: from DM6PR18MB3403.namprd18.prod.outlook.com (10.255.174.220) by
 DM6PR18MB2474.namprd18.prod.outlook.com (20.179.104.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 08:11:28 +0000
Received: from DM6PR18MB3403.namprd18.prod.outlook.com
 ([fe80::7d7c:efb2:9dd8:fd96]) by DM6PR18MB3403.namprd18.prod.outlook.com
 ([fe80::7d7c:efb2:9dd8:fd96%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 08:11:28 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        =?iso-8859-1?Q?Jan_L=FCbbe?= <jlu@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] EDAC: Armada XP: Use devm_platform_ioremap_resource() in
 two functions
Thread-Topic: [PATCH] EDAC: Armada XP: Use devm_platform_ioremap_resource() in
 two functions
Thread-Index: AQHVceZ/qmVc1mF5QEOLvvk2Um9yGg==
Date:   Mon, 23 Sep 2019 08:11:27 +0000
Message-ID: <20190923081117.4p4mwqz35fzavkeg@rric.localdomain>
References: <3cf2076e-6394-4997-613d-cbf5b6dbee1e@web.de>
In-Reply-To: <3cf2076e-6394-4997-613d-cbf5b6dbee1e@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::34) To DM6PR18MB3403.namprd18.prod.outlook.com
 (2603:10b6:5:1cc::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f78f7ebb-ab38-424a-fec6-08d73ffda1ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR18MB2474;
x-ms-traffictypediagnostic: DM6PR18MB2474:
x-microsoft-antispam-prvs: <DM6PR18MB2474EC9900B7610FD84B3E4FD9850@DM6PR18MB2474.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39850400004)(396003)(376002)(366004)(189003)(199004)(2906002)(99286004)(186003)(64756008)(66446008)(53546011)(6506007)(1076003)(14454004)(76176011)(26005)(66476007)(66556008)(66946007)(86362001)(229853002)(4326008)(6246003)(52116002)(386003)(102836004)(478600001)(6436002)(6116002)(3846002)(25786009)(8676002)(81156014)(81166006)(8936002)(9686003)(6512007)(305945005)(7736002)(256004)(446003)(11346002)(6916009)(66066001)(6486002)(71200400001)(486006)(5660300002)(476003)(71190400001)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2474;H:DM6PR18MB3403.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V1wKxiEt1vr33VBO2/FarE/O83MevGNOaNoFQ78qeCoMCGSbhm2/4179mIOUqkXYvqFZXjaMjiSEJb3t7xpjwGZD7PuB326LW4vBEr0DJsnRB8qfkKGnTwwztEEdTs2DIcPhohWNd6RrqOiR2ILYCPiLr0s56se33BqZONIGgQqJvVm4SxBZPfaaHTZ5jq1ifjunphruIdtttmnnBgBXzn40h+eMsjUweYewS54wLldvOgqzHCMD6tIuQyHLUYi6BRT6sonnd9DaaaMIgRJC7Xm0i4AhOdXYDG74oeSLwPtoQwQgKGT89ylxYWiARqHz2Wnz5NzNiGeQFfHjsWMRw9RjlpGK33VvhY73MCLR4khuyglJ80sXPdEfnZWuKHza3v4Oiy/e2mDG9wUCeEgVKv7V/8lEGK4h1v7o4fSwgE4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <274FD53589159A488D36422E47CC29B8@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f78f7ebb-ab38-424a-fec6-08d73ffda1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 08:11:27.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ovy2XyxA+v7i0kO4n4+6abvCcRVvqN4V9XrrbHsTgHChIMPyS1SkjT2Swl0Wfr2A6ag7IhGA5bIwL5TQHRQvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2474
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_03:2019-09-23,2019-09-23 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Markus,

On 21.09.19 17:57:24, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2019 17:50:17 +0200
>=20
> Simplify these function implementations by using a known function.
>=20
> This issue was detected by using the Coccinelle software.

Which semantic patch did you use here?

The kernel's spatch for this pattern only found and fixed the
following:

 $ make coccicheck COCCI=3Dscripts/coccinelle/api/devm_platform_ioremap_res=
ource.cocci MODE=3Dpatch M=3Ddrivers/edac | patch -p1
 patching file drivers/edac/ti_edac.c
 patching file drivers/edac/xgene_edac.c
 patching file drivers/edac/synopsys_edac.c

There are probably more drivers to fix than the above and the one you
fixed:

 $ git grep -l platform_get_resource drivers/edac/
 drivers/edac/altera_edac.c
 drivers/edac/armada_xp_edac.c
 drivers/edac/aspeed_edac.c
 drivers/edac/bluefield_edac.c
 drivers/edac/cpc925_edac.c
 drivers/edac/highbank_l2_edac.c
 drivers/edac/highbank_mc_edac.c
 drivers/edac/mv64x60_edac.c
 drivers/edac/synopsys_edac.c
 drivers/edac/ti_edac.c
 drivers/edac/xgene_edac.c

So while at it, how about fixing the .cocci patch in scripts/ and run
it for drivers/edac? There should be one patch only for all edac
drivers.

Thanks,

-Robert
