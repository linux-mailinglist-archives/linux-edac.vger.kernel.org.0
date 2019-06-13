Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71044F0B
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfFMWXb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 18:23:31 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54468 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbfFMWXb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 18:23:31 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DMKVqS012983;
        Thu, 13 Jun 2019 15:23:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=N1TR0KnC5w+RYIaE8eNLEoCsZsVeIaa6RPXdptKDg+o=;
 b=I2hlvrBilJjzzhFYa1KujCez9uafLDS+QJCq9UFcUrccqXSzRmkc9RPtK7ZkGCfLm3Tm
 48+dXoD8WXp6nvBBGLK4lI+oqGKT2s1MhuB7elv1SDo94Q2MsrBpYAv+ui10Ih+yBrwN
 1/N+kAOYnFfM0hm35pWe3m9s83En87cRsKFzPrCKHS9n22Rfb9igo5Q6wPCSgjU7vL/X
 iwKSk4vOcN+LeLS5SMsk3a+dXFHrMU5R7npqynTKMyQn6JMQWgfdT0WSWKEwMCBow1dp
 wAAl/NzVJ0bSgP0LwjcwsbCCm6tmp3ax3U5OcfonUTP1ZVSeQA4smjL+Yrwb/FLTUrtl 7A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t3j8239xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:23:22 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 13 Jun
 2019 15:23:21 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 15:23:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1TR0KnC5w+RYIaE8eNLEoCsZsVeIaa6RPXdptKDg+o=;
 b=PX9jEIk5a5IlfmPnDuEolvBbRTpkQCk4HLtszKTeGVQZDL6xhQYLhQnOf7/blJL0RfYw9EQOZ7kVM6PCikWJ2Lnbffn37zVN0Bh9yvwEZR6CUaPHXXNka2EI+jrUiDvSxF3IvOZlXam9zjOcmZtSYMECWTDO1zqs52VVXCwD6/g=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2414.namprd18.prod.outlook.com (20.179.81.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 22:23:19 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 22:23:19 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Topic: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Index: AQHVIjaakgBofopjtEaC8Krw4A3kQQ==
Date:   Thu, 13 Jun 2019 22:23:18 +0000
Message-ID: <20190613222305.eqvpom2bgcavq5it@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-12-rrichter@marvell.com>
 <37d47356-a40b-2739-10df-f5ab83fa2b36@arm.com>
 <20190603131005.e23lovwyvii53vzo@rric.localdomain>
 <1fac170a-f461-a779-9e82-5b4a0fa2c154@arm.com>
In-Reply-To: <1fac170a-f461-a779-9e82-5b4a0fa2c154@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0060.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9a2453d-20d3-409e-a4c0-08d6f04dbc73
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2414;
x-ms-traffictypediagnostic: MN2PR18MB2414:
x-microsoft-antispam-prvs: <MN2PR18MB24140610C8A4EA0FE6D0F992D9EF0@MN2PR18MB2414.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(1076003)(53936002)(81156014)(81166006)(102836004)(86362001)(8676002)(26005)(486006)(6246003)(11346002)(25786009)(316002)(66946007)(8936002)(4326008)(256004)(54906003)(3846002)(68736007)(2906002)(6116002)(5660300002)(66556008)(446003)(66446008)(6512007)(14454004)(99286004)(476003)(73956011)(76176011)(52116002)(9686003)(66476007)(64756008)(6436002)(71190400001)(6486002)(53546011)(478600001)(7736002)(186003)(386003)(71200400001)(6916009)(305945005)(229853002)(6506007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2414;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jygBdEma5m1pr3ZpSA8Fi5tjJteI8QsdXgj61zCBbow6ChE6eXQ6Gp1GAkvBNF62s7hVs7xQpQkFMHsRO61ON4TPuPwJwqTM0sDN8yNWy4OjU6qXeaollKPl1Dcp3u6wfsJGvMjXUToISSkIFf1JPUZeM5gnSt/En0t5fALnVXAP7bowah4wfp1CzxXn5sECdWI6dT9hooQPCon/QQaFhmHWA5WdVykdPToZY7LwatiNQahIhlwT3XmMPFFhTdp0Myr5j+qy7rv/eJ8kFt1m2aFexn8Vg9wBxIbHnxG9hHtMnzwShR25FSjXHEsRG0hD6NVvuYIH8QQZ+pBgPlg5USSTXtpaq/AqGylxamp7tRybR51bg1hjjnLni/jAtUXx9XZ/QxcbdeyeegOYHQkDmiv3xxd/0Z9DZI0lQ6d+1vU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4D1646E809A11418C8C5A3D268BC854@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a2453d-20d3-409e-a4c0-08d6f04dbc73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 22:23:18.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2414
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_13:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 04.06.19 18:15:50, James Morse wrote:
> On 03/06/2019 14:10, Robert Richter wrote:
> > The +1 looks odd to me also for the edac_mc driver, but I need to take
> > a closer look here as well as some logs suggest the grain is
> > calculated correctly.
>=20
> My theory on this is that ghes_edac.c is generating a grain like 0x1000, =
fls() does the
> right thing. Other edac drivers are generating a grain like 0xfff to desc=
ribe the same
> size, fls() is now off-by-one, hence the addition.
> I don't have a platform where I can trigger any other edac driver to test=
 this though.
>=20
> The way round this would be to put the grain_bits in struct edac_raw_erro=
r_desc so that
> ghes_edac.c can calculate it directly.

I think the grain calculation in edac_mc is broken from the beginning:

 53f2d0289875 RAS: Add a tracepoint for reporting memory controller events

The log we see in the patch desc is:

 mc_event: 1 Corrected error:memory read on memory stick DIMM_1A (mc:0 loca=
tion:0:0:0 page:0x586b6e offset:0xa66 grain:32 syndrome:0x0 area:DMA)

The grain reported in mc_event there is probably 8 (quad word,
granularity in bytes) and calculates as follows:

 dimm->grain =3D 8
 e->grain =3D dimm->grain
 grain_bits =3D fls_long(e->grain) + 1 =3D 4 + 1 =3D 5
 __entry->grain_bits =3D grain_bits
 TP_printk() =3D 1 << __entry->grain_bits =3D 2 << 5 =3D 32

So the reported grain of 32 should actually be 8.

I think the following is correct:

 grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);

This also handles the case if e->grain is not a power of 2.

Thoughts?

-Robert
