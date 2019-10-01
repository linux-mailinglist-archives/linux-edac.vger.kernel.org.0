Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A213C2DB1
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 09:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJAG5R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 02:57:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13524 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbfJAG5Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Oct 2019 02:57:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x916t10U027120;
        Mon, 30 Sep 2019 23:57:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=rZNopNoLcgasFI6lL0PAoEtgFQtWa50/GZ4LA99iRNs=;
 b=y+MmzCmF1glk8P5zSGJOe7FHpDPkmc8ckCy4JNRBD/UM1bx359Uy9s4SYc59RGyLwCRc
 QDoqDAqGdC8XwxPKLJnUORUXGzCkGjDwsWbKp1OL8fdwcgDhlkY9tFze1K072W05zrh4
 p9CjTsRBgEsnS3xyhIOTZ/cp3rQxVBc9RPfYDVSrheQxVX+USJMlgrlESrwznGNuvJAJ
 BSVIGp8RwJdupYdPh0qsi1+F6IyFNUwPUP23NyQe/RfAW44VGdbrAx6LWvfWANZ7hsRG
 gWWTXyqZxD7dgcPEebdGmZmuI6WK+aDfgnv80kv1broOoEbQzvdchgaG+P9BuWt9fUSJ wQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vbur192df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 23:57:03 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 30 Sep
 2019 23:57:01 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Sep 2019 23:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd76CDoWOny27Mn68RNtFoVDzrgAa3DDofoxoaLFluS+9rJb6fifceRkxbO220NG+QmiOJBaeyy+Q9aad1ueepi/dmmfJaaIouRhIFfa6XZpR6jRn36tDVtKbbya6XrRytdmZ1LizFaPnFqO/FKZcm2jfIfmna6hfev+y5hPqNNAcjigh3wKbo4x62HT182r4QHg+uOBYoMsbGN6xZasr6Na0iHnfMBvK47mKaIQyZe6yiquSQBsGxOhtQnqXknOMtsQvp+zhehKcnUI4jwMv3LXIBxmYozGTVUUBh7fX//4O7LVtRmn9HsQsliaI5YnIvAOMmJJexfh0Mg2+0l8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZNopNoLcgasFI6lL0PAoEtgFQtWa50/GZ4LA99iRNs=;
 b=bSv9EOLbwbFc1GAJa8F/27N+03eS6OLYrYeOosKklRbCZy93cyZl2JvLvdT6B6ZFFAtxCDmqCyBbnoN07Ai9ke2UCMLdN9Q6NxoDvHsbsz0mbexHcdNpq+Jz872WwUAe5+brg06gAALaJzSjeLBRlzNE2FWk9w0DcnArxa5iEjamavkRnoSGPZTR6vz8J5up93VzgMtNTT6GHQQasJdSC2BRcPFW2GfOwDaIfKtyTSOzT+g5szP5HJK0q9Lb/YSAPNY+wLdXtR9ukupqlRve9qJRC+T1AWkO5XIz+iQBKaDBo89Yz/0Gifho3qC4zvzZs0haWCPsXnKown0B27+2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZNopNoLcgasFI6lL0PAoEtgFQtWa50/GZ4LA99iRNs=;
 b=ZPNkgjjv5OlmFZJhbNwD0lc/BncUoi2brxNCIsIXlFJM8kZJH/pALcCvIPNg2HUrVEk8s+YEin0l4LrCozQFiZsAhKYgNfGjNU1Ms/AVPGeM1vRa9n82HbCDTZrPsH2qkeei/mxEfJEkTbbNTjlL1iIovcze60AgrML6kZDaspw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2414.namprd18.prod.outlook.com (20.179.81.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 06:56:59 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36%3]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 06:56:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Hanna Hawa <hhhawa@amazon.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVeCVrgaUXL1IS7EiUioDc+15NJQ==
Date:   Tue, 1 Oct 2019 06:56:58 +0000
Message-ID: <20191001065649.a6454bh4ncgdpigf@rric.localdomain>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com> <20190930145046.GH29694@zn.tnic>
In-Reply-To: <20190930145046.GH29694@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::28) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0cf36b6-83a9-4466-de7a-08d7463c8dca
x-ms-traffictypediagnostic: MN2PR18MB2414:
x-microsoft-antispam-prvs: <MN2PR18MB241457A9A4BEC4AF95A87168D99D0@MN2PR18MB2414.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(4326008)(64756008)(66946007)(66476007)(66556008)(66446008)(66066001)(305945005)(71200400001)(71190400001)(256004)(6916009)(7736002)(7416002)(6246003)(3846002)(9686003)(1076003)(102836004)(6116002)(99286004)(8676002)(8936002)(2906002)(6512007)(6436002)(53546011)(76176011)(81156014)(386003)(81166006)(52116002)(25786009)(11346002)(316002)(26005)(54906003)(478600001)(14454004)(6506007)(476003)(86362001)(5660300002)(186003)(229853002)(6486002)(446003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2414;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KFVQ8AV9AGyccUioWfX2NgeFLMI0VUeHnGJ3NrgjxlCW4nhzOEie9Eskb8qM+7wz+UY4BpJjmj/HmvFeHdAk84PKNw+Zda2PDSNk7QRRzKSPX2lFTknVY9N5WuVKeCBaLNcZUT0/6mtCDaFGPUKREwy+4a8gAJGs6c8e4BssfWmcMzQFmKlJgiQngwlRe/njwGg2Ucbv8sZXyCFVqy2xaAnwnHVue5ERY2xS0Jbcl2L7gN2NWZLX07ocy/HBCWi8TyQmL+Ay4d1z9qOjJgFe/Q3hDupVE9HwwoowR//h5tUorihEnHa/yWrlOmr2svSxdUGCX+34QOyYls2ZXdzLRWiKONIzxPM+vi5Xw35eeHPLQtwzl2bNiUJXYVgD/mhfxr8bO7bQtsWY98GnN11sObCww5pHoUk7wUCRh8/yF4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B011E369A5477F4098887569C9292363@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cf36b6-83a9-4466-de7a-08d7463c8dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 06:56:59.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnHasRR1L1wnmXDUHIhCaxHaJ0IwZgJjp94xpTlyTtyGE8Tm+HkQumUnt7liPh0EKh9xSpuWaQOD0M+gEDCEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2414
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_03:2019-09-30,2019-10-01 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 30.09.19 16:50:46, Borislav Petkov wrote:
> ----------------------------------------------------------------------
> On Mon, Sep 23, 2019 at 08:17:40PM +0100, Hanna Hawa wrote:
> > +void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> > +			int inst_nr, int block_nr, const char *msg)
> > +{
> > +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
> > +}
> > +EXPORT_SYMBOL_GPL(edac_device_handle_ce);
>=20
> Eww, I don't like that: exporting the function *and* the __ counterpart.
> The user will get confused and that is unnecessary.

It is *not* the counterpart. The __* version already has the
additional count argument in. There are 2 patches:

1) introduce new function __edac_device_handle_ce/ue() including the
   *_count() inline functions, but keep the old symbols (note the
   count=3D1 parameter).

2) remove old symbol edac_device_handle_ce/ue() and replace it with an
   inline function to use the counterpart symbol too.

The first patch only adds functionality but keeps the abi. Thus it
makes a backport easier. The 2nd switches completely to the new
function.

-Robert

