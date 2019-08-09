Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B2B87AD5
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406856AbfHINJm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Aug 2019 09:09:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49598 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbfHINJl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Aug 2019 09:09:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x79D0EcC029185;
        Fri, 9 Aug 2019 06:09:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fxX4Tsn6LVutoNTKFtMDUBvTa6O/M8Ax7D8Tbf0dUvY=;
 b=kvq0Dm6ceY/ampMFrTYJDmyl1fXSMugZhPhCfMY+5ZBMlMcils1c7v+tHzm4QYx5laKX
 FVagN67QTH7PeqLIcQdXLulSUdhzqxGqCX/lhD0wLMLEwgdInEsG7YdUaDKWasnFhxyP
 TmtLGvI+GCHtI/leb+G1K/mGMnoQF+pcfjjYSHdfoG6Xp6eDXBKtcg4Y49poA0Wdd8FO
 4n2D9Nx8XhY3IoelkZRssC8NnETH++Pn7hefA5MutyBFwhfTF8WGxPVvtD6068PZrgOt
 Q+gciiJmVKVuoamcp34N90MlCt4pADPJg4qZ66nlgVtHlz9aK5ow1Sk1K/Hc2ZragFhY 4g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2u59sm8283-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 06:09:25 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 9 Aug
 2019 06:09:23 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 9 Aug 2019 06:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAPAhOgLevyG+yxAETXVjRUj6FMvxnSUM5gC9E2oV/33bhimf/zy3pDi6xAhotBzjwy98o+/9qLmY72QN+rnmSzqpKpOMQ3Ubtop8gNgRe8LGBM0qwN53IiWuUj1l2m2uYngN+9jEZWL2I65PsiYh40x0zzHYnzw7ghE9dS3zMtuiM3NG9I7ZwvPu0gTpuaVcU0lld3mUMz4FyoaDRNDwo7AoG8Z0c1uk+RbJlmEbSP4vbMT2eSbHKe10MBMIcAiT90Irivgree0oRRTSe2VDIzTLaxk5qoBqVTUsjKDuP4xg96qoheH/4bIocHESILj8GLNkw/SPkwF35kqLVZOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxX4Tsn6LVutoNTKFtMDUBvTa6O/M8Ax7D8Tbf0dUvY=;
 b=SNlTUs0HxD2cjYTPhuDzu96p8ErUFYIuDvUQo8Dzq9HE7jJTntO7xlwN/BFWLzdrTymU3v/vsl55GW1Rq1o3BpNeWGIh7N4AZePt/oFOG1OaXCJCQeE3CEjUGE5t4Hidgdktp9lqeVk/gLCDqjhqcVMSub3zvc0jLW5cXQ2c5ieKGBaVkWks+o1IfhNJKcAXNJXk13pMoVZqeEjs8IDA+9IUW8vNL/6xmEaRB587JNq4/rq3i5iIv8a/vD9J1p5M/hKxz3dyhA1pLlivrG2Fl1CE43qiNyLn2Dwag9ficbSpM/kY06vY02pDMHPbNLdCLs7nOwhPW1MDunx/vcILVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxX4Tsn6LVutoNTKFtMDUBvTa6O/M8Ax7D8Tbf0dUvY=;
 b=yGf8mb0Y2Tk8w5XbxSZDaDw5GP6BFDReZifVkqpqvszAp5DoJLYLiQ+20hdn0Aw9pYXz915RhBPRWzn8vW++0sG72TM+lgadBGPB6CfaI9Y8WVg/Jg9w+8oX9RBggCIl7vKZHOFl/wbIN0OJJBZUAFN493N3lUNoHEmOeqT+Nm0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3007.namprd18.prod.outlook.com (20.179.84.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 13:09:18 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2%6]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 13:09:18 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/24] EDAC, ghes: Extract numa node information for
 each dimm
Thread-Topic: [PATCH v2 15/24] EDAC, ghes: Extract numa node information for
 each dimm
Thread-Index: AQHVTrOm854iEL00CEyw4GqX+x+zlA==
Date:   Fri, 9 Aug 2019 13:09:18 +0000
Message-ID: <20190809130911.bkflwxbeslhmdxu5@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-16-rrichter@marvell.com>
 <f878201f-f8fd-0f2a-5072-ba60c64eefaf@arm.com>
In-Reply-To: <f878201f-f8fd-0f2a-5072-ba60c64eefaf@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:7:28::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 352d2d3f-7162-48a6-6669-08d71ccac948
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3007;
x-ms-traffictypediagnostic: MN2PR18MB3007:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR18MB30077816CBEC3A71E5F76E68D9D60@MN2PR18MB3007.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(136003)(366004)(396003)(346002)(51914003)(199004)(189003)(8676002)(6306002)(53936002)(66066001)(316002)(14454004)(7736002)(26005)(6116002)(3846002)(54906003)(6486002)(6436002)(229853002)(6512007)(9686003)(102836004)(66946007)(52116002)(5660300002)(6506007)(386003)(478600001)(66476007)(66556008)(53546011)(64756008)(66446008)(1076003)(99286004)(186003)(76176011)(86362001)(966005)(305945005)(8936002)(2906002)(6916009)(81156014)(81166006)(25786009)(6246003)(4326008)(71200400001)(71190400001)(14444005)(256004)(486006)(476003)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3007;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ANFJ5LvhZWWWMkdIbCRMYR58ohCU4+V9JVGLbViGqvioOub8cO5pO+JQQ0FI9hAvI1VmoNQx/3Bov3QazJO3hHOH7/QGom37+5CzPleEjY1gmcBjEMSmw2ohPReGzJJpzldPHDV4PXLOBHZJWZEEx2BOKMLjrIqI11BD1mEU5CMRO7lvj85mPxIam39faBb6S6rqzLG8f15Wc4Yy2naFZTwEfgev+Uq9dAxvD0kni8bog30DE08DMOqhErhgByzIebprB3PttyMaVJq5usCpByHA0BJYd3O21dIYd1/NF6/zEpBYsU3gD11pzZh++aC8bFMyruT/a0A8ekRGEnwawYUCf4kB9EXu7NnJ8t3/O6CDxH+yBfbANP8eqYhjX7WGpa0B6Dx4f9X8k/ovEw6JoB6GCAz01gLGYmjCJVLb2L0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAFA02575F54F74CA1B6FA1F6122027A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 352d2d3f-7162-48a6-6669-08d71ccac948
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 13:09:18.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeIjwkozRbh8Dsvgo1AyuUE0V1WVNKd1tV0KujVAw89Ndn3kFyj+7X5nwT4Pgfqb21bdYDwmyAU67msIBORTQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3007
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-09_03:2019-08-09,2019-08-09 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

On 02.08.19 18:05:07, James Morse wrote:
> On 24/06/2019 16:09, Robert Richter wrote:
> > In a later patch we want to have one mc device per node. This patch
> > extracts the numa node information for each dimm. This is done by
> > collecting the physical address ranges from the DMI table (Memory
> > Array Mapped Address - Type 19 of SMBIOS spec). The node information
> > for a physical address is already know to a numa aware system (e.g. by
> > using the ACPI _PXM method or the ACPI SRAT table), so based on the PA
> > we can assign the node id to the dimms.
>=20
> I really don't like the way this depends on the rest of the kernel's NUMA=
 support.
> mm's policies around the placement of data change with these settings, th=
at shouldn't
> matter here. Reporting physical errors shouldn't be influenced by mm's pl=
acement policy.
>=20
> pfn_valid() is a sore subject on arm64, it will return false for random p=
ages that the
> firmware is using, or wrote data to with unusual memory attributes. Depen=
ding on it makes
> this code fragile...
>=20
>=20
> > A fallback that disables numa is implemented in case the node
> > information is inconsistent.
>=20
> ... which is why you need a fallback.

I don't agree here. pfn_valid() and page_to_nid() are reliable used in
numa systems to identify the node of a physical address. Same is used
here. If firmware does not provide consistent topology data, numa
would not work either and a non-numa fallback is in place. You say
this code is fragile, which would mean numa code is fragile too, but
it isn't.

Node information and the 1:1 mapping between node and an edac mc
device are essential for error handling. All other drivers have one mc
device per node. If you don't follow this topology layout you will
have significant differences in the ghes error handling compared to
other drivers. But this driver (and arm64 systems) should provide a
similar functionality.

> All this makes it difficult to explain why this things view of memory is =
as it is.
> Making the RAS/edac code unpredictable like this is a hard sell.
>=20
> You need to squint through Kconfig, SRAT and the UEFI memory map.
> (due to pfn_valid(): the behaviour here can change over a reboot)
>=20
>=20
> Can we 'just' use the type-16 handle to group the DIMMs?
>=20
> As an illustration:
> http://www.linux-arm.org/git?p=3Dlinux-jm.git;a=3Dshortlog;h=3Drefs/heads=
/edac_ghes_2level_dimms/v0

I have looked into your code. You group all dimms under md0 and have
an additional layer for the phys mem arrays. This ignores the cper
layers (node, card, module). The way you add the layer may cause the
creation of dimm entries under md0 that even do not exist in the dmi
table. But dimms and their labels created by edac should reflect the
system as described in the dmi table.

My code creates one mdX device per node and groups the dimms under
them according to the dmi table. For this it further parses the
physical address range of the memory arrays and extracts the numa node
from it. I don't see what is wrong with that. The only added
dependency is the node lookup which is used somewhere else in the
kernel anyway on numa systems. But it provides a much better grouping
of hardware errors, which is then similar to other drivers.

I think your concern is more about code complexity, so I will go
through my code and keep it as simple as possible.

> This reflects the SMBIOS tables on my NUMA desktop, and doesn't depend on=
 any of the
> above. I'd be interested to know what is missing from this approach.
>=20
> (which numa node? I don't think we need to know the mapping of mcX<->nid =
up front. We can
> find it from the faulting physical address when we get an error report).
>=20
>=20
> N.B, your mail is still arriving base64 encoded. It looks like this:
> https://lore.kernel.org/linux-edac/20190624150758.6695-16-rrichter@marvel=
l.com/raw
>=20
> Lei Wang found:
> > Ah I found if without explicit "--transfer-encoding=3D7bit" when do "gi=
t
> > send-mail", my ubuntu box sent out base64 by default.
>=20
> (but his mail didn't get archived for some reason)

Thanks for the note, I will check the encoding.

Thank you for review.

-Robert
