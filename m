Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEAD320E
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJJU0S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:26:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:10560 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbfJJUZg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:36 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKKEgG030136;
        Thu, 10 Oct 2019 13:25:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=PrN+D2+F/4T4BJ7uzHGTcMzHiMC+SlavYnnXoNJrkY8=;
 b=jU0XyTVLL8Ak+FErGBahWbhjQSv0k+tLRxSGeuoXv1pjsWhjFwHahBl3E9TWjB0NrII3
 mXAT8cyqd4AvyCPWhAFf77gIq3JsMnDoiuEbKvU4h3TfU5D0E6nHWGANiHDAzT9Gq/GD
 bHfphLcY7BWP6fih03SADmIQ0XpGLKIuVurf11qdaVyMGdxenfW2PRZ77x+Bn52MxDz7
 o7RLl7oOYyDtrZnq98wwcPHedij0l9dnEiWRP0ztGLRufjiATu7WpkwBk/ux7i/6LBbJ
 RI6B+PTLfdfnGvAlHOb+fQg7DioaEBxCW2ouiJgXgMziVul8D6O8D6l28gax9XxGsY0C VA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:29 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVW5Te3AX+DfPa3akhzz2F9pQTdOISsLIsTZoVp5/xNimlHHwVRxx4RR40LUC7XQDIpUyRAIFwXrdCX7cV5j4rqoZ0H5gzUbiXgE0HjDKvwvP2QcuwST4nvH11qw7blA3XEHQ9izJAkGhWAr3XuYTbDAhVK8GQHSzTbuxdILDE2bjtbidttTBDOhLszkdTZVkvtqLFqp5/PtE9FjwDEeOm2+89/xrPc+WD/cPVRm/k3cxRQxCSP2mQY4OKm35H5NmxaXRiQlkr10lVxWMYm/mg0Ut8HKgHWfvRSUVmXMWptdLFi+kxWOrZKq4hin7d/UrL0peFPUIe1WLthvC+50Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrN+D2+F/4T4BJ7uzHGTcMzHiMC+SlavYnnXoNJrkY8=;
 b=CxU/QdhmoaJViNT+js8D9weMSl4gaHnbbeuYOA73SRE8jcn+fMQEXmSHmJHBWapYKtAzLuOAyQhDElflfz+iDH7zDaOTHW5a1h2/p4gREYJkR9edUIaP2KVz33IebXZpDTCJZt4X8wObEBsGVvVGyWVtMjAqXRQU0RGqqlbMMC3e4izkvwyO+wKWHdo/6DZH48JXxljkhyP/2MeUsum9QtcSoeEGadO3daiwBrrO5cS4Up6bFrXoVHhsuJv9seiatQS8n6VZpm11W6u2ycD/7nd8cE+Y84j/4jvkLhTS/M8orHI9A1q7O2H6QRX7SGmxhskNZurEWtJIFFhgriuz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrN+D2+F/4T4BJ7uzHGTcMzHiMC+SlavYnnXoNJrkY8=;
 b=ZewkXz4xcOM8CA/f4tCIbh/SapN+asY174Ovo3X1Xc2V2m237GNhI8/QWOVjvKCdErAA074ANwZkV97wHb1w3FQKNEX8inrCRsucUaAWu9TWgIp/jtV+0B/F25B89yxCMBPONLUUulSQQlExs1yhTJrez7jzQqRrcBxQq+I1sog=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:26 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:26 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/19] EDAC: Remove misleading comment in struct
 edac_raw_error_desc
Thread-Topic: [PATCH 11/19] EDAC: Remove misleading comment in struct
 edac_raw_error_desc
Thread-Index: AQHVf6jaSuN9AMMEgU+SnA/9oznElQ==
Date:   Thu, 10 Oct 2019 20:25:26 +0000
Message-ID: <20191010202418.25098-12-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:7:92::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 474db723-2abf-4e6e-3118-08d74dbffc6b
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2447D266E9F1FFD390E2D674D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4744005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqQ7PJr7+ZAiE5LtSWu8jmR0VC9kw0paCutKNxZJAbId7gE9Pn4CFkluB4iHOtIgsw1iY3LEpblS6uLbNTnVNUy4PShRh37JCpl2ik60FgZOvYRumNhph2B3n7hUogzSZvZSYki6GuQs4EfTnWEUGsVD9VnWuc5///bVvwZ9wzWFcMRifYll9IRy5AJ4DRToW2y+CJMGGNHsGRNzc9vgTuuyJIApR9zVXU3md14O2ykSOApOUBFjRmEu3DzedYcrM92IDvmP5A9t8MRhNlZcdYr5uh67baPkvXetd4J00mYnXIY4a0ENr+d/8Ts0z3v5UMIAUpR94vIugTlFIdMvwiryCvZ7Lp5fft3r9pqFG1k9EPQP2pMwC8TkP3dQKqhhAKyWXqGL9L6dJKndZtn44vT9By9vFhS96egc6mUxOR8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 474db723-2abf-4e6e-3118-08d74dbffc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:26.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Dce57m+ct7EZZzRebfptItd8t847PfuLHwl7bKAMvG67m55ZR/IS59H2InCWioWxJkTz5WUod+e7mgUB87eVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There never has been such function edac_raw_error_desc_clean() and in
function ghes_edac_report_mem_error() the whole struct is zero'ed
including the string arrays. Remove that comment.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 include/linux/edac.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index 8e72222e50b0..4d9673954856 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -458,15 +458,10 @@ struct errcount_attribute_data {
  * @other_detail:		other driver-specific detail about the error
  */
 struct edac_raw_error_desc {
-	/*
-	 * NOTE: everything before grain won't be cleaned by
-	 * edac_raw_error_desc_clean()
-	 */
 	char location[LOCATION_SIZE];
 	char label[(EDAC_MC_LABEL_LEN + 1 + sizeof(OTHER_LABEL)) * EDAC_MAX_LABEL=
S];
 	long grain;
=20
-	/* the vars below and grain will be cleaned on every new error report */
 	u16 error_count;
 	int top_layer;
 	int mid_layer;
--=20
2.20.1

