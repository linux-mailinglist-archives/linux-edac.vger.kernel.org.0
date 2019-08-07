Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1875D848E6
	for <lists+linux-edac@lfdr.de>; Wed,  7 Aug 2019 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfHGJwR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 05:52:17 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:19446 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbfHGJwR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Aug 2019 05:52:17 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x779jtTw015044;
        Wed, 7 Aug 2019 02:52:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fwDuQli/1VpsGS1ckZ99iE1vStjLbC9MBlavSfYwrbw=;
 b=tauRe91WdE0nNWQolF4QsG+glqQvVIRBIWeZBFADk8Zj0T6Wh0zjQ/6sS2mUjLgR2mLh
 oCzd3BC/bNxqgmfm3oHYVuIgfjarIu5Muu2FubZaACexe3mPMv7U40l6gdh6gM4HWbdW
 wvL8DaCWmwS42ahDG6qG3yIOErAlp0KEaGlZ8QzKkWqjnAw9DW0ByzbfOxahEWyiPsN2
 1JAEBrFRX1cpuRIVz3y4Tl3LUM4C0OMzJbne5+orQJ8mCgVT5NUG4ElIViIePMX5ErlM
 QwKx7bwzVc0BAAQajNPhPUIkFXidRhOhHRNKWSPnuW1NtjjxQSP6jfh/3q97Ww9UMLC6 Tw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2u59skxmhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 02:52:06 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 7 Aug
 2019 02:52:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 7 Aug 2019 02:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQVCkOSbAntRe+p3eV+ouZO1FcGHL5TxqSgHlhk4uaZ7PWJTsLgputeKk3Q11Hbs9/NWHYXfsM+y9udFzALaaDIZcyh9Cvq2BBtHGVVnm7rIslfoBOi7Cf2YhpIOSh+K0vsWiNSXvzJB0OpISUdqNbi62nyrj1zerEnuM/APiTWf7vzOQw60kTHx6V/8h8UMWBGZl7WFSVyLpK8pdQOpqLl2FTf8OUTFLHqcYsddQQ/7ap/gxCUTqfK4ohg4wxQUN65eC7BQ02GABp941B1JcobERlTlh7nfY5KXDL7q/hSXMeM/bzGgLhxzJVF7/xZKbOURqqDIYWYOqcXbcz7z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwDuQli/1VpsGS1ckZ99iE1vStjLbC9MBlavSfYwrbw=;
 b=jUz9f9xfseG2dpg41dY7k0yUNJ628n/NW9gpoJBwweTBdBhFvngups6EGSWRPSdM8PcAkfr0AWzOliEmZBoVbsdorZNoCuQyhWOlYCnDhlmybYkUQOB213lHz7UJTypO5qCH/rQz9vfCfiknw7ikRi+UZ6lTS40MTmEruOlrUjDU8eX/k6ypOqsO5eMAFZ0ddhbwFRVHYBXkqiDSpeOAkuS/zcZswVGdEZx05hu6r6C4y4yoIa+h4s5DOOybHvWHWXO1mJ3001d4lzz5xyZa+uylS9PWbXO0ewe+DIfr438RCy5KQLciw8CzwaOLg5zCIbboo6qjQnZNBhReCWFqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwDuQli/1VpsGS1ckZ99iE1vStjLbC9MBlavSfYwrbw=;
 b=g9WKOD7j36edeV71UEU7y2Lmbqf6dK1bb4rbYQN+kNqIOvSSLLJhWwWgwrpy3lyjYWZcFNVwd4G0io314kp1M/cVcIVhzCOSXtW3FLVDc2amHOjuHeQ427wNkREytD/8l3oeHiSzMNWTD38iLk5vCYAhTOv1Ip7Sz1fzNxnXwHQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2958.namprd18.prod.outlook.com (20.179.23.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 09:52:03 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 09:52:03 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/24] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Topic: [PATCH v2 12/24] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Index: AQHVTQXD2Y1l0ShDGEyChOwpU1qxVg==
Date:   Wed, 7 Aug 2019 09:52:03 +0000
Message-ID: <20190807095154.26zaz4ywyuegemdz@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-13-rrichter@marvell.com>
 <ffd8ec87-74fd-3d8e-1c8e-eed7f425df48@arm.com>
In-Reply-To: <ffd8ec87-74fd-3d8e-1c8e-eed7f425df48@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0267.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::19) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e1d5de6-e1d7-4020-135b-08d71b1ce610
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2958;
x-ms-traffictypediagnostic: MN2PR18MB2958:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB2958966579A6734FCC6889E8D9D40@MN2PR18MB2958.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(102836004)(71200400001)(6916009)(316002)(54906003)(66446008)(64756008)(66556008)(66946007)(66476007)(53546011)(14454004)(71190400001)(81166006)(386003)(6506007)(86362001)(256004)(6486002)(76176011)(8936002)(81156014)(6436002)(966005)(3846002)(25786009)(53936002)(4744005)(476003)(486006)(9686003)(478600001)(6116002)(52116002)(66066001)(6306002)(1076003)(4326008)(6246003)(5660300002)(229853002)(99286004)(2906002)(68736007)(305945005)(446003)(186003)(11346002)(26005)(8676002)(7736002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2958;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0uHILzQz+uplXve7ePN98zw46IEp7balQoc9zZhxtjXdQDvUqQfIS08NYAwysHhv1xYd3oR7MKXH0l12KatMpqeofHllAmcIK+m0LFsdWZg3orpBWpv6LBpJaf2u1QUruxkjXO7l0gil1853Pb2ICMNQInBKZHxftbpW7NkevwYjJm+Kg4yGMxQhb5nAQs4/Y2aVXNtDse+8I81knKpsWYBl4eHD8Dv0184ZWXTV2iKvZFeA0eysOlSFNSFPJWs9zUUKQ2posgi03hNmV+WRk/oaS+nDWsoYxVZtUP1ZnPL8gQYO/16gtgtxyQ/sJTnM5GxWtW3DpnW5YP6zOO27JU2xJr726e4YkAl9pMSbOhYiCbYFbULOFe/Y6cZ85igIWookXgXm64tz1xsynNFyGY8ihZyBGUCR/1WB4vM11u0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <739721D7EB9D414280EE8BD99B0BD32B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1d5de6-e1d7-4020-135b-08d71b1ce610
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 09:52:03.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+uhMLZJv4FLCNiHJmSdy748/aCjbe8zeTyykL0mK88ImcvK/0a1SUQnttD0v5hZQaVM3Lwjsgvmz9o6YFed5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2958
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-07_02:2019-08-05,2019-08-07 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.08.19 18:04:54, James Morse wrote:
> After a shorter game of spot-the-difference:
> Reviewed-by: James Morse <james.morse@arm.com>
>=20
> Previously here:
> https://lore.kernel.org/linux-edac/e566fe1d-ed06-53bc-6827-f6dfa32ee485@a=
rm.com/
>=20
>=20
> Please pick up tags when posting a new version.
> If you don't do this, its very difficult to convince people to spend time=
 reviewing your
> series.

I already asked it in my other email, but I think you mean adding the
Reviewed-by: tag. Sorry for not adding it, I will do that in the
future.

-Robert
