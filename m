Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862D6F126A
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfKFJdZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:25 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24478 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731154AbfKFJdY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:24 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69VJ5D027210;
        Wed, 6 Nov 2019 01:33:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=rWDNtmMdklU6ahCZAyuCBWkr0fS+qTPeqOEUYDH+iEU=;
 b=HHET2Mb9iRbExRD3Kf6FuZJC7hsaid46YbHlHEFJb09FVBJNkEG6L1N82mRY5EN0ptzl
 oZrGhQp1IYdHz3KF3P/OyKcWkFiBPtTQqQhE2Fh3GJZrlk5Mt2y91w23S4+JDI3sgw84
 ynTsdPqD1L7fu0ezL5ifI0wpAVFKA0YS7mE4fukW0SgaZt8ovsS7lrTiATz89w/atyz8
 5euVpUlVyOXN1GkL4nI21RnJQM7jg9sDD2nF2lmQFQ6kemHYQW3AswwJgpa66+rCw1KE
 S3ZFlk89NuYrMT+Q+2xc24YB5tCQ5HNu05iFIPq0h+hs109Cc+3bDO574lG92J7xnREq qQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyajp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:15 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:13 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhP5upTJQc80XXhfSWoyWJ/Vkg+YkeYD8irBE48aEHUI6c1MvJo6vHk4Hj58aIxNGeutdFNn1sD8Z4QoRs6efPn2TGxiW7TnDxWeRuwApFuLkitbAW145ABg89hChCg0mqsqzeN3Asq0i5Fs8YCPw9fIzsuz7BD6lVY4EcVRFXw5Lwbg30kO/E12uO3UkHxQShGBC85TUR4O/J9Zxdrb5+bTC+S/voyIobUhQW70t4fHeLpIhjYiTznd/TYTqROrrHydXqFTgcLRggVuVQ5fHnzxEUN2JKQPLAncN5Y7Oaw9WCLTuXdlBQbrgAqh58ybhBaoLAHAzed1N05ILzoFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWDNtmMdklU6ahCZAyuCBWkr0fS+qTPeqOEUYDH+iEU=;
 b=UrHYBG0p2ZuGegRkjmNGoGvQ3tCRO9CP2rCL8mjjXtcAHX0a1+VDazfLE4L30F2h6fiZMbjGMpCoPsO6Lbbkr6wQ0GPGpHKsFHH71brJdy0/FBww3wPLIeHUg2V4bB3MmvDgqaWEwKYPR86/mIH/R/KnlOH97eZ2jf3CP61X9oodvJXmCvEildUUcumyEPb54TpwtO7EiUWe7pONWNYLEPTkpunIv0FDRRA1Tr1nf0hRD47TsLCuxrGhG/kSJkJbo+Q/FiiVt1odEmShnv5Jlt5MzZ3MLuRYaXwj5CNAMMxZKM9Tpl4GpdVKo6+CLNW6/ICtGmpCSy+t8um4nQxHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWDNtmMdklU6ahCZAyuCBWkr0fS+qTPeqOEUYDH+iEU=;
 b=PcieYLGXZx8QJZDfURqVBHu6SCxKrjRB3b74zI73IeNL09LdxBlNC5v/H/rerch3GxK5tp4j0Dal84oKqQO5XoS4hIwuRJnTZKm6tuCkl56gSfzVZz+x/F8/Z6CTNXDvc2t2/Kwv92WKVET58C6LPln0PW6P2E0vHwD72xx0c6g=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:12 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:11 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 05/20] EDAC, mc: Remove needless zero string termination
Thread-Topic: [PATCH v2 05/20] EDAC, mc: Remove needless zero string
 termination
Thread-Index: AQHVlIU0JPYgrRN4PUabZYpzEbCP9Q==
Date:   Wed, 6 Nov 2019 09:33:11 +0000
Message-ID: <20191106093239.25517-6-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a68bd89a-4dd1-4f50-022b-08d7629c573e
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB316549D603B073C6B4361030D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(4744005)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqkMX2APnI8EuNmTE2Jj7bw8WoVzcKyBWLyVjwNOJ6Y2ZgvJZXRnZNfyz8OrzIzdJ8aPqAIid3xrvNGU2mFnl/uuwt803uBkLjP/3qZsJ4cOU/w8Z1nSrBzBSpjPqbvaq/S06eO54Q0Ck4BLoKix8zF6sPMxau/6FUKZPgzxW0HkeuI7+3jRawtTFEmzFyh7D9OABSMe3f2iDQjzUcSVpUAMFgyA9sgQUipXAkYK3Lg2B+/9bBA60C5MWw1fP912l1wvXpznHTGU/mh9DRNX1w31ZVmonfdLfd7FbRhGZhitTwxR2nM2j7l4D/jk3LgyL18b1YKX72ijD0GozgM47MV/LUvexgeIcyFFrPwyuRO+FeBDrz2BvZgLCCBpI+p0kNg2U8xdKYjBf0YGiG7j9dMhKQHvpiuXRLIc0gwB8MhtkJL61uThGHBG0t5WIPvI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a68bd89a-4dd1-4f50-022b-08d7629c573e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:11.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oa59cp5ACBPTJsweWoQsY0ROCM0S65qIE3V2Nd/ZEwUKxVWCqGeV8wFchjeg0aVeluikZWSrLJmCgL7aCZQyLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since this is a string already and strlen() has been used to advance
the pointer, the end of the buffer is already zero terminated. Remove
the needless zero string termination.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f2cbca77bc50..8bfe76d1bdf1 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1183,7 +1183,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			}
 			strcpy(p, dimm->label);
 			p +=3D strlen(p);
-			*p =3D '\0';
=20
 			/*
 			 * get csrow/channel of the DIMM, in order to allow
--=20
2.20.1

