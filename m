Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32426D39A5
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfJKGvC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 02:51:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:11200 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbfJKGvC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Oct 2019 02:51:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9B6oes0019548;
        Thu, 10 Oct 2019 23:50:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=MGQcYHfSIQApuo3rLLKHfJaeyJ3EOXIKpAj8qT7EXto=;
 b=unGk2LSs61625INBynAPHJJH1hjBu0miobMgjj2hPv79tsOM3iquRsne778+skWO9Xu/
 /7V5spHYXTg/F8VV0u7M0Rob1Wyj3QJ2SKzAbcJas3fjBQU7+KiCBzmN3dsszCD392fk
 FNOp/6RUoW7svlgat41x0fDl9t8aWxJ5wmxqkB/RLU3f0pZFZZCJVDSKP5Wr6woLmAni
 pKHTlUTkOlmAtKUGOEdSPxNSbSq4SPxOfmmFdGTD1rqqEC2ulWJec3xT8TCYcFekyVan
 fDvHZoq3pq3BE9wkU1FCfFSIvBhYK6EsVrv7U++4yZ+SrklHY8ambOAMCxbT/o4tCh/s /g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxc0j1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 23:50:40 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 23:50:38 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 23:50:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDaKANdqcygYhKx4j6K7QSdWQiV89icdUjJtwM7f40G2R3SXA1sJtzUPCLQr3OU8IhL1d7MTqJHTDinN5Zi4vWlCS1zt51qbdAhMcHnt0M/2qwnJFAr2gxbr4aO9kvojlWQKfTXqU4lPjTbOPdpwdhly6dffk7uZQ/CfNDStHKdru3kSwLiz05rETrICliqhG55aJpPcSWH+PI974RndSvSniomaiVJDanVxYva3YlH+x9M8HzBHQ6IuOrqhyKOyqiAcbxZUw2ybQNujCV+n3BGN9o/yXbHhoNrj7My2m6mVM4LjxE1pWZfr6ESshM9cZrVW1IuWiTqBGlMqKokTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGQcYHfSIQApuo3rLLKHfJaeyJ3EOXIKpAj8qT7EXto=;
 b=ihK2MW7WtHhQu524E3QCf/gBH+h9Jes3mzA48RHmoaRbrgw6kWytzWINOKFWzRgULIuZH+jvLiuCf5TVzIz9q9eBN8ZCdEKkGclqXfuAKmyPDQJUD/Ttd3kuNTNW43rmDvHnAlvxEhR9QyazN2p+IS1mA4z9T56ASv5RJaYAb1pNKl4tapyn6SEir1TZumxHNSxXWhDtRnVwylQm+9SNRfyT6Xtz59r8oqtV6aLemSwa1NPwADr0VPZJRWfYzxgxPVz9NEXPg1FY2LYkC+FwKs0ENAztX7Jcu4Uzm5CEYDK1oCviEfv1iDktwbcoXdfKy0b86SK+7gZB97YeWiHZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGQcYHfSIQApuo3rLLKHfJaeyJ3EOXIKpAj8qT7EXto=;
 b=S5o8UbLS5eS+CqQenZFEo2JsEhmmyHfYCMmS8EuSnRfPd+ihjtXgO+m2MLyiTMXaouELs55QQcuFzemfs1HBmQZNkT+6ZTOe10f31g9vXXkcS9Wjkg9ZQORgHapHnz3GrGehKAS1guzDodbttHdTkzqVE62F7Vrx4WLTHGMSC5w=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3439.namprd18.prod.outlook.com (10.255.236.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 06:50:36 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Fri, 11 Oct 2019
 06:50:36 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Joe Perches <joe@perches.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Topic: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Index: AQHVgAAvFlgoLlgFxEOHNrk1mFE8Kg==
Date:   Fri, 11 Oct 2019 06:50:36 +0000
Message-ID: <20191011065027.dfdr3a26k24r26ag@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-6-rrichter@marvell.com>
 <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
In-Reply-To: <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::25) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43ab7a49-e2ec-451a-c192-08d74e1751c7
x-ms-traffictypediagnostic: MN2PR18MB3439:
x-microsoft-antispam-prvs: <MN2PR18MB3439D9C9E127B61DC518E828D9970@MN2PR18MB3439.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(99286004)(316002)(8676002)(6916009)(4326008)(71190400001)(53546011)(6506007)(52116002)(386003)(256004)(76176011)(71200400001)(305945005)(2906002)(7736002)(102836004)(478600001)(25786009)(186003)(26005)(14454004)(66066001)(446003)(11346002)(86362001)(9686003)(6436002)(486006)(6512007)(8936002)(4744005)(4001150100001)(5660300002)(81166006)(81156014)(54906003)(6486002)(6116002)(3846002)(1076003)(229853002)(476003)(66946007)(64756008)(66446008)(66556008)(6246003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3439;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E34IGFKGTgo/iAFu4Viky3KKV/R90Ro5Zv8nWcn5jRUEynfdBOsTDHwXnvox9svJoBnljqa29VrtahmyRaaDmerAiOWpXf5+8pPNAhl76V+qf1JduDVHhw/rA1lKZc24LBY7FO+U3m+WZTyaXDixyEXE4bY0GvRezT1V6/jS6MKhN1k+C/Te26j4AZq6x66pfRpH3ECZ9hUCPaPlN2QdIZM6a+w92ebhi1Pkon7MGEPoW4IEWr1KFrXG/Xn2WhrMlLOH4eI4gJgrg1/K71LzOMA6bHO056iZ5AFKmjxwOXoGI0g9nthtg+yIU4OkSqdOPrx+YQgUZ9Nd18DVW1c88GZS4B5gHjOwKJ6U6goPWXP9erzZqv2npIV6ywjKXWNG6DAdKdckBNkInOW+hXq7a7+PVa0t21kyLpZfStBuNJk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C2CB04970140347A92212D3CCF230B4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ab7a49-e2ec-451a-c192-08d74e1751c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 06:50:36.1293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0I6dkvj8HnVEdlZHgi39bVxQNIy+I4i4Cdpx8LNU/4dOc3HoqkvpqW70b/4Oi9w8NsLIUpJogEcu5pfsdxzvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3439
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_04:2019-10-10,2019-10-11 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10.10.19 15:10:53, Joe Perches wrote:
> On Thu, 2019-10-10 at 20:25 +0000, Robert Richter wrote:
> > Reduce the indentation level in edac_mc_handle_error() a bit by using
> > continue. No functional changes.
>=20
> Seems fine, but trivially below:
>=20
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> []
> > @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_m=
c_err_type type,
> []
> > +		strcpy(p, dimm->label);
> > +		p +=3D strlen(p);
> > +		*p =3D '\0';
>=20
> This *p =3D '\0' is unnecessary as the strcpy already did that.

Other changes than the indentation are not the aim of this patch.
However, on the occasion and if there won't be any objections I could
include this trivial change in the patch in my next version of the
series.

Thanks for review.

-Robert
