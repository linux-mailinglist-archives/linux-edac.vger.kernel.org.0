Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF845D619F
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfJNLra (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 07:47:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42106 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730369AbfJNLr3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 07:47:29 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EBjbou009798;
        Mon, 14 Oct 2019 04:47:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=b0NFujwhevrP/Ucvmvv251g66t2yaWYt79pkDoVbMwU=;
 b=dl8szzvkDJU8gngTDBSBuF/n8Ib8XRKqBveJ/K+hzoSEzcwSmoowmbAiX87XtRktW6Zk
 DRWNyCyJYEkfJyabAtsMnnuIFYELsg7XHvFcmlZuYi3cMtp34AFoFjlRWle2DvezVE+I
 pU9I+YANq4QiZtpW80CQmv+5qIx+12CcnBrMZBWGM5Os3To/tZ8d0Nyx61ZJMUVA+YSt
 3M0ILKy0DvFjz12pHShQG+MrJ+Jn1T6WTwY3GJJ0uGvF5YEnjbsN2M1YLneDAnETRL2v
 ObICSXUvl06ZXEcX5KLJAHwTdM4in1LlbroR+6oP+uOo+PwgCqtnZ3RqBTqe4ZHqfFhK 6g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vkc6r69mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 04:47:14 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 14 Oct
 2019 04:47:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Oct 2019 04:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g845S+sbfHBSX6OtgjJx0pzGj4tXMdJSHVW36j+7KjZoBennkTIfQfoO/4kpXFr5ivQejwiOB7wOlL5AQCboy3cQ+0lJmgC+ETnO5phJVGD8viZQBBhOuFvfPl2iWzlUZt8es+HYf6joE6MGXLKi8YqFM/jcuw+JHk3hxp4nMHwUNMUz6Tjugq+zIlqCSMGsFH2L8jpgSYoIiPrxAPPBMDp9LMKJtZ6nZQhWggoM++3+UWcHeRn+wFDcsXWE4eGDLAD5jFeMfZfI9I8qOQZS9/is8nCqRBrYS3vm+xTb259xGDDMjH+oJf/cAi3SfMSvPUZCaCWHQohNi/mYo0appg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0NFujwhevrP/Ucvmvv251g66t2yaWYt79pkDoVbMwU=;
 b=XFoNNaafIldnCM81/fpFX8SA8eP5OwxUHq4rmKaj6PTI5dUPlFwgoaZ5TbuCejWEQnAQSxCA2Qj6siCvgn+W/MpLDrLCLakXwHpy+e7V4FmXD1Bjt1Nv/R5bQ0O8NGhjlGyJlq/mRawCikq+OexNrI4tO6AHc+C2lwu5IpCdFHKllfAwQwCbwWZWNnd1GWUqm6Z1ux+ERDG7YKs6J0RTi8h9j5peL7xG1Gw5HQhpGchVlndJ1AZfpX+3o7XCwh071mSnx39xpoqZ6jMD7YRf+YCehcqx7TaJBa8YoVWKmzrglfrBCzWg0O6mRLu9emo5giFdsdmcxI4q7MpkYrlBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0NFujwhevrP/Ucvmvv251g66t2yaWYt79pkDoVbMwU=;
 b=efm0i56kOFwykGEA70BNLTMJqYIZxDyj5BlYVkP9OUtFjClY5Z5MZKVxwC2jyNI834EhE9PPbiaKlSAldJq+M4y0428eJ4mCXPPdGY6loKpy36aWD9UUJOkTxw0JIiL8rj9qnZnmF0qvWqXHbSXXXvLd22Py2TzkROmzXU8QozM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2573.namprd18.prod.outlook.com (20.179.84.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 11:47:12 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 11:47:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/19] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Topic: [PATCH 12/19] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Index: AQHVf6jbve5vRxDO20qtSKMm5w5VjadVRSSAgATFvAA=
Date:   Mon, 14 Oct 2019 11:47:12 +0000
Message-ID: <20191014114704.yyemipcregxghrox@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-13-rrichter@marvell.com>
 <20191011075412.03458c3e@coco.lan>
In-Reply-To: <20191011075412.03458c3e@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0236.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::12) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f17d8f9-9e77-4168-07c9-08d7509c4049
x-ms-traffictypediagnostic: MN2PR18MB2573:
x-microsoft-antispam-prvs: <MN2PR18MB25731D1819FB52889BA30213D9900@MN2PR18MB2573.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(199004)(189003)(6246003)(66946007)(6486002)(71190400001)(6512007)(86362001)(9686003)(66476007)(3846002)(256004)(6116002)(66556008)(3716004)(76176011)(71200400001)(7736002)(8936002)(81156014)(14454004)(8676002)(52116002)(81166006)(4326008)(305945005)(25786009)(64756008)(99286004)(66446008)(6436002)(186003)(1076003)(2906002)(66066001)(229853002)(5660300002)(476003)(11346002)(446003)(4744005)(486006)(478600001)(316002)(102836004)(6506007)(386003)(54906003)(53546011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2573;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePDyTIpDGMKnRHWXoi+m+Jz954bfkwLKz0lejF4SSp3XC1BLJkVQjc4Q7SAM9puKiG7631Ou+wW0AEaOp4QLg9YEzBk7Bm4GOV/EfZgiklNalr1aG9cmquq2gPGMv6xd2ajNpjPdWBc9M+zyOAMgRz8o86kn6a6FgrAjq5Omk73Sd0jnHP5KMFQ8y5cTBkbnsHAKimGJuu1y4tMsM/lSO0cAXLMNzjdZb6KTqUu1U5g4+IzmxGfdb/N9RMlUCI3ua0cq9MJYtuXarlS2W3sVTc2k5EnXzCnH+AHVB+zNUtuVDyp3hKU8y28hTkXPBhMvJNyug0iPgQfRvkWZD1UN+uh618DHhuTy5vmdDk7jiLEhcryfmR8akVKYT2jJJnSO7VivPbUg0DTYv0TPfeu2PHZKQ6qxb2/uooXDQUdjy3I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4137A5AE7585544B9A91F32F1BBACFF3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f17d8f9-9e77-4168-07c9-08d7509c4049
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 11:47:12.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9ZNsYpjzysRwKLBIJIvlAqs0NR68DuPbVmy4U/OqB90Y3jTFKt41RD4/u6p3AaLLUG9ls79HRhW+oWQhy0YFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2573
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_07:2019-10-11,2019-10-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.10.19 07:54:19, Mauro Carvalho Chehab wrote:
> Em Thu, 10 Oct 2019 20:25:29 +0000
> Robert Richter <rrichter@marvell.com> escreveu:
>=20
> > Store the error type in struct edac_raw_error_desc. This makes the
> > type parameter of edac_raw_mc_handle_error() obsolete.
>=20
> I don't see much gain on this change, but whatever works best for
> ghes.

The error type clearly describes the error. It makes sense to keep it
in struct edac_raw_error_desc as the function interface of
edac_raw_mc_handle_error() becomes easier. There is no reason to have
a function argument for the type while all other error data is in
edac_raw_error_desc.

This change might look trivial, but this series contains many small
changes like this and in the end there is a reasonable change of the
function that describes it much better:

void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
                          struct dimm_info *dimm);

... that reads as handle error described in e that affects this dimm.

-Robert
