Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D66BC1CC
	for <lists+linux-edac@lfdr.de>; Tue, 24 Sep 2019 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407760AbfIXGdc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Sep 2019 02:33:32 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:1518 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387676AbfIXGdc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 24 Sep 2019 02:33:32 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8O6TgpC011480;
        Mon, 23 Sep 2019 23:33:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8NtpP0UiEEn4hisTz6nmqXoEeVNsm7Yu7Vnck5sbtRk=;
 b=xS0CgLJS7l6IMypkUh7spc7H+M32ibewIJ/TnNI3q3EHActmD4YqCk/gfUHnMpGGggbP
 lI4NBQ2vSmELVNoqA7aSfWVjYp+yQMcTnOCoqVcYV89uAeFGXfaFKU9vie7dMSpVsBf8
 3DN5XJouVufIyDFAoaxWibiXJTdaSMrEBtR6OqvIHQ9mPj+OHoGp/oEFoMj4jwvRrzKa
 UPufbF9TG28LRKIlfI398MbNI/jOAGnAKSXN4XpEDsJ5n59m5Hq7b7lWoOswGywU105a
 0O4Xc8IlZY8+iIPyrSGo0MO1F9hH8ZWbvHhm9MnO1d2ocxd/dMj+IAmkWe7JU7DvKt+L fg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v5h7qhhk5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 23:33:19 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 23:33:18 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 23:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjQ7PtPanjjasq+gu7tv+4wnD7pjT6RS5bLGGXTu60wZy1QDn2cNCOl1DGnuHhN4WNhLwWuD7Ts1GlfI9JCKMbZTvUKU1rDqXLbXV/xBl1qSws5KYLsR64VRBvjFJcWJ8SGyNHURoM9OliZc3rVky285Ld0QOQ9GpqYzWBYk3EK3hq4Fad4PjwR0E01C+r2C/SDaBAz4aj6QLYjp15lnTSEfe6A/HJa/OK528VDqmiXJkoiHryryNbV+e0p6HxVI9Q6iBQMf2/Q3qB07mPsuY+kCb40jJrMaUC1VDofj6WZ3N8zUJkknEFHhP4J5/lQjXBsjJIJNrvH5lP4siY5TIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NtpP0UiEEn4hisTz6nmqXoEeVNsm7Yu7Vnck5sbtRk=;
 b=R3vfFjQSoCO+hNqTDUTjlq4Ul0zIv55cFRXdXk0MkLft9la51BSinTUJYUOftiYrxRGlZUhLGKdD3ysr9PHL9wvb5XdJQqFPs6L1RzLOh0GnO7GpEUmx/YUDPYFLgokvDvTUjQ2dIDKmBlEvDmOIdy2AAfwJRADXslLpuseOCKX3MXeHUTwd/4DTjUXBydllaWklGp3gLpGbSwrMrVQci01dpNox/fnZzbmFgbn3kBOB5BH7ZKBf1jW1bxeXsVNvjE2sAaG5yx4DMQn7oo8hssI5jJyie38WrhCtOjcMayWALJFqQPZSvviSK9tY8mUpO7cwDLs4RLUWFKAZDdr/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NtpP0UiEEn4hisTz6nmqXoEeVNsm7Yu7Vnck5sbtRk=;
 b=gjJa53h3sNXkJF+wMUqn6rJDRd7jro+UKy5OwbpMhLECxeNPAzta1QAR29jNi0mlzHEa621GeJCwLTDDES2jToiwABhmIlmmfGaLrPLFGcK0kor2c9An8Hc5C9XzM7R156pqvz6JEca7pAd5XIfqspg4nlYyB/kbCeGxvpzxD6A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2686.namprd18.prod.outlook.com (20.179.81.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Tue, 24 Sep 2019 06:33:17 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36%3]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 06:33:17 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Hanna Hawa <hhhawa@amazon.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
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
Subject: Re: [PATCH v4 0/2] Add an API for edac device, for mulriple errors
Thread-Topic: [PATCH v4 0/2] Add an API for edac device, for mulriple errors
Thread-Index: AQHVcqHy57OjUKyRXka9ziiq0AtdhA==
Date:   Tue, 24 Sep 2019 06:33:17 +0000
Message-ID: <20190924063302.iayqlj7m7v3fou4r@rric.localdomain>
References: <20190923191741.29322-1-hhhawa@amazon.com>
In-Reply-To: <20190923191741.29322-1-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0044.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 436217cc-a5e0-4dc9-c47d-08d740b91554
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2686;
x-ms-traffictypediagnostic: MN2PR18MB2686:
x-microsoft-antispam-prvs: <MN2PR18MB268638A41B4A37869E76417DD9840@MN2PR18MB2686.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(4744005)(66946007)(3846002)(66066001)(66476007)(66556008)(54906003)(14454004)(1076003)(64756008)(478600001)(5660300002)(316002)(66446008)(2906002)(6116002)(256004)(76176011)(476003)(52116002)(6246003)(6436002)(446003)(71190400001)(229853002)(99286004)(102836004)(9686003)(486006)(4326008)(6512007)(25786009)(86362001)(81166006)(186003)(11346002)(6506007)(305945005)(71200400001)(8676002)(26005)(386003)(7736002)(53546011)(81156014)(8936002)(6486002)(7416002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2686;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FTC8mUOAFAV2x3EV/lkuC14Na1NkDe+NjL38okTdCxqy0M09pRz+eQEIw+4wz+CaGihIik4xSDDViat5WGocQZINolI94ADbsofiyVSZPhOoqcpUwTKja6n714Hd1rsa+qYFPc8UGQGWWl4JStK2Mr7f/3UFA5pVYIy+ey3YsKM7hv8I51tGf/ECToS2pgSv4g094vhMk3yjQXWEzcXJyYun7rqBYpn4jT44M1PqCwTCdnEFSJCqm0+ZL6U6uRQIyhAfNrHUPrYUqPNEjlDk/te8tu2Wm+iDtI8jvgip4i1jsxqHKAMYwPl4YVRaWzjAPKMuTpknaUIhv9GA/0Rs/oI3zP2OpBddIUDJfK8fZc+fEx22aArmviP2RXiIpDnUbDAJBRTTtWACZQ2BBj+Dk4cTCseF+67pXE29UQf2zZc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0214B6230156F4B8CCC29457C683BE8@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 436217cc-a5e0-4dc9-c47d-08d740b91554
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 06:33:17.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PttR7ZKnxg35M5BikqrmwVfCgs7im7eDmjxW+LYeYL1tR7UlR8AXhDUjyyrcsUk91dwu3+4zWA6HFr8/DiOixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2686
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_03:2019-09-23,2019-09-24 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23.09.19 20:17:39, Hanna Hawa wrote:
> Add an API for EDAC device to report for multiple errors, and move the
> old report function to use the new API.
>=20
> Changes from v3:
> ----------------
> - Move count check to inline function
> - Fix count variable describtion
>   (Reported-by: kbuild test robot <lkp@intel.com>)

Looks good to me. If another respin happens, please fix the 80 char
limitation for the static inline functions, you could line break after
the type definition.

Thanks,

-Robert
