Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0229A12485F
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfLRN3J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 08:29:09 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33472 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726723AbfLRN3J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 08:29:09 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIDLqR9017251;
        Wed, 18 Dec 2019 05:28:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=naORtEvBGHcqbEK6DkTkzI5BY6HMGIPFE8I8y1XpvbE=;
 b=tb/oxfC+oFJFoZg7q0ATQwtpOVbuZfj4xYPLIsAY2qURv1Tius8CooFSVJorySOzMddT
 A/8Z2D5YoiTAzOqe4xA6+B4CJHrzYdLKc98MtYAoBj5NyW8y0bSD/c228gjjUvNjs96a
 8RBaKOBwaKAsGkdIFnR6ryAenosgm1gDtMQneWaij2ochp+jCaxba44vf4rXz1hidzLI
 ug6p/wrgbS7ENr/ksAh1N3NRZTaAFXGKA3LoS26qLtvAxu07QEjHKDiIjPQrk637hhmJ
 owzTvioduAdVmXTf4aLzLg+Eb2XX5d/+vJhllsS7cDSKM9T7Bhg29+1DExkJvMHzIVuu nA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wxneaxnmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 05:28:55 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 18 Dec
 2019 05:28:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 18 Dec 2019 05:28:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfjERmtuNHQf9qFuIqV6gRMLkaYtXbCCCqo2gBqsEkHYH/ZLbJ0K5G6eHwdiXlkJsH14TMvfuuCRe+JvhliSUt8JhOFwR5DVyRRItL6Ijh2kPV9TCJsr9K4COqvRZBVPjVqG0u5T4770vTeaYZu0JhI12RqnKsvACfL1PtXKKXyoMj2ZXI3I7IpuvH1Ppopo0iJWg7EosSHCG5ywtgclh7N3xti2d/xP3GI+U/qG2NIOt8nBkpHMPADnwKuTelH7boIivEGcHyi65DP7qrQBoOBICj9uWaqLavwhQcLTxf6s6vqnfIZjielgHrUtDarU911kBcyVOqc+8opBG4thmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naORtEvBGHcqbEK6DkTkzI5BY6HMGIPFE8I8y1XpvbE=;
 b=V9EaKVElkdeJ48ktUaeVn68InK+9XPMhjC2x//gaNgvbQuwCnViNdsvHUZ33pxvt6X3uUgOl6SQxjPEVp0qL8BKIxDXO4V8K4VLHB4F4HF5103W9UzFjzX6IVg6fxXQNgHPn2wYxJemnmhU9HsEpX7o/gegM7RjLHcpoQEB9z3rqTnM+dNAiAL5wqPL+VucvI9rDufbEwl2u8rJip1tLuem8Q512FdB4O11HIKGleKjkkLNeC6wlJqzGMq7hvgwRzGnLXOfsYzWUkK9xpBUAZ7RFbpDALL+7AGKQsCgdoUgF0Ugh2hoqJqgl/dnXFm8KrEspaXuXaQCcwUpYphRUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naORtEvBGHcqbEK6DkTkzI5BY6HMGIPFE8I8y1XpvbE=;
 b=dY+4lznCXX9h4qpmMbccU9HgekhNKd3GxdBVpfkogxz7j0Jgbod2h1JeeQfFCaeXqgpTH9+EpF0pZmctbdg5MtAenNJ95+Dn2FKXdsg0eoM17GsiFWTju3H0uW/VD8ZlfoLRpz83V8F2wc5n5kU/Hc+p4PZ+a+Yzw1z2WVOTYuI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3262.namprd18.prod.outlook.com (10.255.237.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 13:28:52 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 13:28:52 +0000
Received: from rric.localdomain (31.208.96.227) by HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 18 Dec 2019 13:28:51 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     John Garry <john.garry@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Topic: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Index: AQHVtacW0zDMOaJVDESmbh/QpxTcEw==
Date:   Wed, 18 Dec 2019 13:28:52 +0000
Message-ID: <20191218132843.vur4tpviv2alpaaq@rric.localdomain>
References: <20191218062129.7400-1-rrichter@marvell.com>
 <0c7da2d7-1cab-f518-2309-f740d7ef36fa@huawei.com>
 <20191218125456.kkqfuq7crshwwc7q@rric.localdomain>
 <20191218130510.GF24886@zn.tnic>
In-Reply-To: <20191218130510.GF24886@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9ad0928-2da9-4d25-07e6-08d783be392e
x-ms-traffictypediagnostic: MN2PR18MB3262:
x-microsoft-antispam-prvs: <MN2PR18MB32623A0C2364A913DB4B4E8CD9530@MN2PR18MB3262.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(8936002)(71200400001)(81166006)(81156014)(9686003)(956004)(8676002)(66446008)(64756008)(66556008)(7696005)(16526019)(5660300002)(478600001)(6916009)(86362001)(54906003)(26005)(316002)(66476007)(52116002)(4326008)(2906002)(186003)(66946007)(53546011)(1076003)(55016002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3262;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbfiI135etGCP5wI7vPeU6GDq6ae+ONc9buT9gbAnNk3++6E1oEJDnxRyrzw5xIcgP1z3IeADhNGEe6iNTd3aCP0YcX9FI0HnL25DzOS4PLDJb2jfUGTCLOPSwuZh9Rm4hzB4euSt8kPpSMlOuuCc4iuPN/FnFeXnLCXxSsUY0G+K4tVQJ+1rFV5yXwTIsYYbU/SqXlfQPmvy3Zj5K4JaWapWL9Lzjn8N1ESc2mkzvBvliS9yyVCVXby3RuAa3plbg6yU9JT3+xFw4kXNhfkQAzsVXkC/Zzeuse34Cl3SH9Fs5PEwM15LYuBVPGJQ6uaUJc+J7m4IRPHDr1JUgZEaf6F676BKOksIpe1RKKVssABtnmVipZTjkPj+zPL3nchDVNnVbTQZHNa85CrmcKfFzduE0hLIxmEd/Dcehn1tt3eOjHLfifl2ROIgyNW17VU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2F3732333932347BB59E60684656B2A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ad0928-2da9-4d25-07e6-08d783be392e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 13:28:52.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUkzma+zkbc/l5Yl00sTSbFocMU5zPZQ/9AOTyY6hMwFxjeC0BI0yIKTSxkvh6AKx7CmzZBHktQt7uxs84t6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3262
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_03:2019-12-17,2019-12-18 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 18.12.19 14:05:10, Borislav Petkov wrote:
> On Wed, Dec 18, 2019 at 12:55:04PM +0000, Robert Richter wrote:
> > I leave that to the maintainer as he is editing the SOB chain anyway.
> > The patch would be sent to the stable list already which may cause
> > confusion.
>=20
> I haven't looked at it yet but I'd prefer if this patch went the normal
> way and landed in stable only eventually so that it gets some testing by
> people in linux-next first.
>=20
> It is not a trivial patch and we did break EDAC with recent rework so
> I'd prefer if we take it slowly here and do more extensive testing
> before we expose it to the world.

I am fine with taking the time. Once it hits upstream it can be
backported to stable. There is a small conflict with 5.4, so it will
need some manual tweaking anyway.

>=20
> Also, how does this patch play with your cleanup? I'm guessing this
> patch goes first and then the cleanup...

Right, the fix will be first. I have already a rebase of the cleanup
series and can send a v3 as soon as this fix is applied to a tree.

-Robert
