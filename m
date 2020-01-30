Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7914E21F
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2020 19:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgA3SuM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Jan 2020 13:50:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:2148 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731595AbgA3SuL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Jan 2020 13:50:11 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UIjuuO026545;
        Thu, 30 Jan 2020 10:49:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+Yt21OdYIWf5YAuMwdaVEhzhRm91McuIiUGBOeID8SA=;
 b=rDgtTmDH07U1zLS6QUDc8waFZSOf9Ky8C8/lXwOMizW8ffYgSt+Ko/OAyQKlO+je/LNz
 b0I2qgEpbyeN41h/bAayg2wP8sh4D2hFLbMYSEGXBDqlyCxLHeQhlrHg5JgBvT4agTsM
 jiNKvUheoPCpbgOznlcLNdxXHX+Pqfm0roEU1YOsjlfPI1wBBSzt2os7YQSzHIJBZ8SU
 IrJdIp2obVOtMP5bYV6gP3yWTDHhun0Rez+FK53XjXS8gvmHP43nksGF9z3gx1+EKOeB
 nTwU0aBUzgvsifFxL01vGqQwFv73M6++NmwYZEKJWPdn/Zy+1tuSYI43YH/LmZDx2/et Sw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xrp2tfqcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 10:49:49 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Jan
 2020 10:49:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 30 Jan 2020 10:49:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stz1wxtPZ85f9USggPGPU8+84WHYqVe4h6lYetEVBnX/LTakVh65g+ojwd5dVX0TKkzjrfBVUgqcyVBOQGOSD6BhLIg9qzBAP3rGkkeSIUu9ja96SY1cZrNDup5ClxRAlGk565jyFPUrbI0/0h1x6+LYkvJt7srLvhPHpYB44ninutje2FexSsH1wbbPLpY3rSCq8st0H3trLxn07oh1nMO3FR9AJfsoVHdUVn0lg4jZP/s61UVptwDfNEtg96xJ6BMRP8cbQWueaWso7myMvMbvMW/3OdNESDu2AqTsAQZOHCibf5lMuh/G+mlqbmaSiNngl8npoLaKo7nwuFCtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yt21OdYIWf5YAuMwdaVEhzhRm91McuIiUGBOeID8SA=;
 b=B3pEo6Z2D+SBFSXpCbWxcwP2LOt8iKAY2LZszamXsczA2vD/n+gTGTSFLPWiIXH86TZORNt/MC1HoAv10DGzgtELrE90685JPBle2EXJx9SJZ5t1f05HRUoq2CfRI3wLBfgJ7x66lqnp0WzheTnWQgGz7FiJMRU04XcR2LG+0xpBa3IpdDoSlz89dJS8nKG0pjz4ISh0p8z8ODk8bp6IKUo7NS15vXsizpu8PDs7aDcXum6Yqvf5L5WDStAKJPgX2rs0KtOvnjhM++epY3j+rhzEI9JM96pxVbOvx7ikgCq2/4m31Dgy6oZWnHoM+ZGOiAr5qd7N/GG+rpAslZTJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yt21OdYIWf5YAuMwdaVEhzhRm91McuIiUGBOeID8SA=;
 b=PmT4eU5iOMgxy/SXiOxC01KHYQhSSSClIEmIiUWY0Vedf3EBm0+xkoHYMdBSd8z8pn5W2jB0PEj3UA17Nim0/A2BW5jv18RpIaiZfyJLFRvWI85zdXXObXtb8iluKGaZQZ9W/isADS21yEwgT3DVIxXDG58vE/XcwqmwVwWNO7o=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3167.namprd18.prod.outlook.com (10.255.236.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 18:49:45 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 18:49:45 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0191.eurprd05.prod.outlook.com (2603:10a6:3:f9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 18:49:43 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Matthias Brugger <mbrugger@suse.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v3 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Topic: [PATCH v3 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Index: AQHV154Ks6Q1ygfxD0miMcSSOV5mJQ==
Date:   Thu, 30 Jan 2020 18:49:45 +0000
Message-ID: <20200130184938.4epgnbnqlc4fkjll@rric.localdomain>
References: <20200123090210.26933-1-rrichter@marvell.com>
 <20200123090210.26933-3-rrichter@marvell.com>
 <45ce6d35-6e07-8ff4-5f67-84adfcb44f14@suse.com>
In-Reply-To: <45ce6d35-6e07-8ff4-5f67-84adfcb44f14@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0191.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::15) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59eb7026-790c-4f43-1d27-08d7a5b52ca1
x-ms-traffictypediagnostic: MN2PR18MB3167:
x-microsoft-antispam-prvs: <MN2PR18MB3167640E770DC40976222D51D9040@MN2PR18MB3167.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(1076003)(54906003)(956004)(4326008)(7696005)(186003)(26005)(8936002)(81156014)(66446008)(64756008)(66556008)(66476007)(66946007)(16526019)(86362001)(498600001)(8676002)(81166006)(6916009)(2906002)(4744005)(52116002)(966005)(5660300002)(6506007)(53546011)(71200400001)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3167;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhaxdKGsBinDUX/PK0RJPcmIhqEQlAXe6um3QaE2n8Af1svn0jW+CAOr8DuSabgYGzmJJZa02oX6WhEXIOe+/dMDAha7BmWUO/SaJK5+N8QUGfj7Xeq66sRCBlwPjSJwBS9oYyOijjqVT60ZDpiiUiIVCzfSQ1zJqzfef9aMjR/yayHD0jGV361DX52n+5cCAi0LGfNbFZMHC1JMj5wPfQO+gi76b4MjEryqCPd87NicOLCw1daKKHAiXmUWBUUDPDLNIeFe1ViBqAfjW/QX0tKd93BiEcTKP/BDQOBIzyZ+tVhDOufd5DA1XHbQxCgHlSId9yATRk1DFcEYj6r6XcIOMCiNC4ljtrVD+OtD7TIDvbWGZpHuGPQJ1u9m2N5PHyqJkAEtKemV14Ibafn1LGU/8xhhyChPBNpC1RV4FL7Ma9QPVAE2h75VeJnOKKeHBaGLWgxxDKY64b6MEXsd0ehmwxnymVg9I2gwJ+GE5Pn/CYEzoRWolaOF0RWsnQj3Ms7qXMa2TYZXhUvtMrryWg==
x-ms-exchange-antispam-messagedata: T8JtmCFwvwA9DZk5uupqcxzUjyv8zAa6UxxipQ7OPc2ooynEccS0hu+T7yEqdTWlttLbcP9wDNCeCCXtAkg8T4xv333YPhiaWBqo4rjKsmKF4nZH5xADCnzhaUXg0SlLkpw5p8pyZgRlvmh+eCbt3w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DBE63BA33A5234D8E44054D38C172E9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eb7026-790c-4f43-1d27-08d7a5b52ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 18:49:45.5604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wxdZKBooIFq8bbq7TLd0TIHlUv9yPVQimOzFsdH/CZ6Vuv2YwDANtQyOqQBTr8ShtzX+fFf18Gfw4Yk42A98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3167
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_06:2020-01-30,2020-01-30 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Matthias,

On 23.01.20 20:02:00, Matthias Brugger wrote:
> On 23/01/2020 10:02, Robert Richter wrote:
> > Reorder the new created functions edac_mc_alloc_csrows() and
> > edac_mc_alloc_dimms() and move them before edac_mc_alloc(). No further
> > code changes.
> >=20
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Acked-by: Aristeu Rozanski <aris@redhat.com>
> > ---
> >  drivers/edac/edac_mc.c | 209 ++++++++++++++++++++---------------------
> >  1 file changed, 103 insertions(+), 106 deletions(-)
> >=20
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index d71006a4f07b..1e227e69e216 100644

Sorry, I missed that mail.

I have rebased v3 series on top of edac-for-next *plus* use-after-
free-fix, see here:

 https://lore.kernel.org/patchwork/patch/1169444/

So the patch above must be applied before the series.

Sorry for the confusion and not being more clear here.

-Robert
